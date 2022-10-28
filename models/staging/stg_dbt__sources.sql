with base as (

    select *
    from {{ ref('sources') }}

),

enhanced as (

    select
        {{ dbt_artifacts.surrogate_key(['command_invocation_id', 'node_id']) }} as source_execution_id,
        command_invocation_id,
        node_id,
        run_started_at,
        database,
        schema,
        source_name,
        source_description,
        loader,
        name,
        identifier,
        package_name,
        description,
        loaded_at_field,
        relation_name,
        freshness,
        source_meta
    from base

)

select * from enhanced
