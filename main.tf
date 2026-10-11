data "aws_networkmanager_core_network_policy_document" "networkmanager_core_network_policy_document_lookup" {
  for_each = var.networkmanager_core_network_policy_document_lookup

  version = each.value.version

  dynamic "core_network_configuration" {
    for_each = each.value.core_network_configuration
    content {
      asn_ranges  = core_network_configuration.value.asn_ranges
      dns_support = core_network_configuration.value.dns_support
      dynamic "edge_locations" {
        for_each = core_network_configuration.value.edge_locations
        content {
          asn                = edge_locations.value.asn
          inside_cidr_blocks = edge_locations.value.inside_cidr_blocks
          location           = edge_locations.value.location
        }
      }
      inside_cidr_blocks                 = core_network_configuration.value.inside_cidr_blocks
      security_group_referencing_support = core_network_configuration.value.security_group_referencing_support
      vpn_ecmp_support                   = core_network_configuration.value.vpn_ecmp_support
    }
  }

  dynamic "segments" {
    for_each = each.value.segments
    content {
      allow_filter                  = segments.value.allow_filter
      deny_filter                   = segments.value.deny_filter
      description                   = segments.value.description
      edge_locations                = segments.value.edge_locations
      isolate_attachments           = segments.value.isolate_attachments
      name                          = segments.value.name
      require_attachment_acceptance = segments.value.require_attachment_acceptance
    }
  }

  dynamic "attachment_policies" {
    for_each = each.value.attachment_policies != null ? each.value.attachment_policies : []
    content {
      action {
        add_to_network_function_group = attachment_policies.value.action.add_to_network_function_group
        association_method            = attachment_policies.value.action.association_method
        require_acceptance            = attachment_policies.value.action.require_acceptance
        segment                       = attachment_policies.value.action.segment
        tag_value_of_key              = attachment_policies.value.action.tag_value_of_key
      }
      condition_logic = attachment_policies.value.condition_logic
      dynamic "conditions" {
        for_each = attachment_policies.value.conditions
        content {
          key      = conditions.value.key
          operator = conditions.value.operator
          type     = conditions.value.type
          value    = conditions.value.value
        }
      }
      description = attachment_policies.value.description
      rule_number = attachment_policies.value.rule_number
    }
  }

  dynamic "attachment_routing_policy_rules" {
    for_each = each.value.attachment_routing_policy_rules != null ? each.value.attachment_routing_policy_rules : []
    content {
      action {
        associate_routing_policies = attachment_routing_policy_rules.value.action.associate_routing_policies
      }
      dynamic "conditions" {
        for_each = attachment_routing_policy_rules.value.conditions
        content {
          type  = conditions.value.type
          value = conditions.value.value
        }
      }
      description    = attachment_routing_policy_rules.value.description
      edge_locations = attachment_routing_policy_rules.value.edge_locations
      rule_number    = attachment_routing_policy_rules.value.rule_number
    }
  }

  dynamic "network_function_groups" {
    for_each = each.value.network_function_groups != null ? each.value.network_function_groups : []
    content {
      description                   = network_function_groups.value.description
      name                          = network_function_groups.value.name
      require_attachment_acceptance = network_function_groups.value.require_attachment_acceptance
    }
  }

  dynamic "routing_policies" {
    for_each = each.value.routing_policies != null ? each.value.routing_policies : []
    content {
      routing_policy_description = routing_policies.value.routing_policy_description
      routing_policy_direction   = routing_policies.value.routing_policy_direction
      routing_policy_name        = routing_policies.value.routing_policy_name
      routing_policy_number      = routing_policies.value.routing_policy_number
      dynamic "routing_policy_rules" {
        for_each = routing_policies.value.routing_policy_rules
        content {
          rule_definition {
            action {
              type  = routing_policy_rules.value.rule_definition.action.type
              value = routing_policy_rules.value.rule_definition.action.value
            }
            condition_logic = routing_policy_rules.value.rule_definition.condition_logic
            dynamic "match_conditions" {
              for_each = routing_policy_rules.value.rule_definition.match_conditions != null ? routing_policy_rules.value.rule_definition.match_conditions : []
              content {
                type  = match_conditions.value.type
                value = match_conditions.value.value
              }
            }
          }
          rule_number = routing_policy_rules.value.rule_number
        }
      }
    }
  }

  dynamic "segment_actions" {
    for_each = each.value.segment_actions != null ? each.value.segment_actions : []
    content {
      action                  = segment_actions.value.action
      description             = segment_actions.value.description
      destination_cidr_blocks = segment_actions.value.destination_cidr_blocks
      destinations            = segment_actions.value.destinations
      dynamic "edge_location_association" {
        for_each = segment_actions.value.edge_location_association != null ? [segment_actions.value.edge_location_association] : []
        content {
          edge_location        = edge_location_association.value.edge_location
          peer_edge_location   = edge_location_association.value.peer_edge_location
          routing_policy_names = edge_location_association.value.routing_policy_names
        }
      }
      mode                 = segment_actions.value.mode
      routing_policy_names = segment_actions.value.routing_policy_names
      segment              = segment_actions.value.segment
      share_with           = segment_actions.value.share_with
      share_with_except    = segment_actions.value.share_with_except
      dynamic "via" {
        for_each = segment_actions.value.via != null ? [segment_actions.value.via] : []
        content {
          network_function_groups = via.value.network_function_groups
          dynamic "with_edge_override" {
            for_each = via.value.with_edge_override != null ? via.value.with_edge_override : []
            content {
              edge_sets         = with_edge_override.value.edge_sets
              use_edge          = with_edge_override.value.use_edge
              use_edge_location = with_edge_override.value.use_edge_location
            }
          }
        }
      }
      dynamic "when_sent_to" {
        for_each = segment_actions.value.when_sent_to != null ? [segment_actions.value.when_sent_to] : []
        content {
          segments = when_sent_to.value.segments
        }
      }
    }
  }
}

