{%- set meta_columns_query -%}

    select distinct
        meta_columns.key::string as column_name

    from {{ ref('dim_dbt__sources') }},
    lateral flatten (input => source_meta[0]) meta_columns

{%- endset -%}
{%- set meta_columns_results = run_query(meta_columns_query) -%}

{%- if execute -%}

    {%- set meta_columns = meta_columns_results.rows -%}

{%- endif -%}

with

sources as (

    select * from {{ ref('dim_dbt__sources') }}
    where node_id ilike 'source.fishtown%'

),

expanded as (

    select distinct
        source_name,
        source_description,
        loader,
        loaded_at_field,
        array_agg(distinct name) over (partition by source_name) as source_tables,
        {% for meta_column in meta_columns -%}
            {%- set column_name = meta_column[0] -%}

                source_meta[0]:{{ column_name }}::string as {{ column_name }},
                    {# {%- set column_name = meta_column[0] -%}

                    meta_columns.value:"{{ column_name }}"::string as {{ column_name }} #}


        {%- endfor -%}
        count(distinct node_id) over (partition by source_name) as count_of_tables

    from sources

)

select * from expanded