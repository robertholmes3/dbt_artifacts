/* Bigquery won't let us `where` without `from` so we use this workaround */
with dummy_cte as (
    select 1 as foo
)

select
    cast(null as {{ type_string() }}) as command_invocation_id,
    cast(null as {{ type_string() }}) as node_id,
    cast(null as {{ type_timestamp() }}) as run_started_at,
    cast(null as {{ type_string() }}) as database,
    cast(null as {{ type_string() }}) as schema,
    cast(null as {{ type_string() }}) as source_name,
    cast(null as {{ type_string() }}) as source_description,
    cast(null as {{ type_string() }}) as loader,
    cast(null as {{ type_string() }}) as name,
    cast(null as {{ type_string() }}) as identifier,
    cast(null as {{ type_string() }}) as package_name,
    cast(null as {{ type_string() }}) as description,
    cast(null as {{ type_string() }}) as loaded_at_field,
    cast(null as {{ type_string() }}) as relation_name,
    {% if target.type == 'snowflake'%}
        cast(null as {{ type_array() }}) as freshness,
        cast(null as {{ type_array() }}) as source_meta
    {% else %}
        cast(null as {{ type_json() }}) as freshness,
        cast(null as {{ type_json() }}) as source_meta
    {% endif %}
from dummy_cte
where 1 = 0
