variable "networkmanager_core_network_policy_document_lookup" {
  description = <<EOT
Map of networkmanager_core_network_policy_document_lookup, attributes below
Required:
    - core_network_configuration (block):
        - asn_ranges (required)
        - dns_support (optional)
        - edge_locations (required, block):
            - asn (optional)
            - inside_cidr_blocks (optional)
            - location (required)
        - inside_cidr_blocks (optional)
        - security_group_referencing_support (optional)
        - vpn_ecmp_support (optional)
    - segments (block):
        - allow_filter (optional)
        - deny_filter (optional)
        - description (optional)
        - edge_locations (optional)
        - isolate_attachments (optional)
        - name (required)
        - require_attachment_acceptance (optional)
Optional:
    - version
    - attachment_policies (block):
        - action (required, block):
            - add_to_network_function_group (optional)
            - association_method (optional)
            - require_acceptance (optional)
            - segment (optional)
            - tag_value_of_key (optional)
        - condition_logic (optional)
        - conditions (required, block):
            - key (optional)
            - operator (optional)
            - type (required)
            - value (optional)
        - description (optional)
        - rule_number (required)
    - attachment_routing_policy_rules (block):
        - action (required, block):
            - associate_routing_policies (required)
        - conditions (required, block):
            - type (required)
            - value (required)
        - description (optional)
        - edge_locations (optional)
        - rule_number (required)
    - network_function_groups (block):
        - description (optional)
        - name (required)
        - require_attachment_acceptance (required)
    - routing_policies (block):
        - routing_policy_description (optional)
        - routing_policy_direction (required)
        - routing_policy_name (required)
        - routing_policy_number (required)
        - routing_policy_rules (required, block):
            - rule_definition (required, block):
                - action (required, block):
                    - type (required)
                    - value (optional)
                - condition_logic (optional)
                - match_conditions (optional, block):
                    - type (required)
                    - value (required)
            - rule_number (required)
    - segment_actions (block):
        - action (required)
        - description (optional)
        - destination_cidr_blocks (optional)
        - destinations (optional)
        - edge_location_association (optional, block):
            - edge_location (required)
            - peer_edge_location (required)
            - routing_policy_names (required)
        - mode (optional)
        - routing_policy_names (optional)
        - segment (required)
        - share_with (optional)
        - share_with_except (optional)
        - via (optional, block):
            - network_function_groups (optional)
            - with_edge_override (optional, block):
                - edge_sets (optional)
                - use_edge (optional)
                - use_edge_location (optional)
        - when_sent_to (optional, block):
            - segments (optional)
EOT

  type = map(object({
    version = optional(string)
    core_network_configuration = list(object({
      asn_ranges  = set(string)
      dns_support = optional(bool)
      edge_locations = list(object({
        asn                = optional(string)
        inside_cidr_blocks = optional(list(string))
        location           = string
      }))
      inside_cidr_blocks                 = optional(set(string))
      security_group_referencing_support = optional(bool)
      vpn_ecmp_support                   = optional(bool)
    }))
    segments = list(object({
      allow_filter                  = optional(set(string))
      deny_filter                   = optional(set(string))
      description                   = optional(string)
      edge_locations                = optional(set(string))
      isolate_attachments           = optional(bool)
      name                          = string
      require_attachment_acceptance = optional(bool)
    }))
    attachment_policies = optional(list(object({
      action = object({
        add_to_network_function_group = optional(string)
        association_method            = optional(string)
        require_acceptance            = optional(bool)
        segment                       = optional(string)
        tag_value_of_key              = optional(string)
      })
      condition_logic = optional(string)
      conditions = list(object({
        key      = optional(string)
        operator = optional(string)
        type     = string
        value    = optional(string)
      }))
      description = optional(string)
      rule_number = number
    })))
    attachment_routing_policy_rules = optional(list(object({
      action = object({
        associate_routing_policies = set(string)
      })
      conditions = list(object({
        type  = string
        value = string
      }))
      description    = optional(string)
      edge_locations = optional(set(string))
      rule_number    = number
    })))
    network_function_groups = optional(list(object({
      description                   = optional(string)
      name                          = string
      require_attachment_acceptance = bool
    })))
    routing_policies = optional(list(object({
      routing_policy_description = optional(string)
      routing_policy_direction   = string
      routing_policy_name        = string
      routing_policy_number      = number
      routing_policy_rules = list(object({
        rule_definition = object({
          action = object({
            type  = string
            value = optional(string)
          })
          condition_logic = optional(string)
          match_conditions = optional(list(object({
            type  = string
            value = string
          })))
        })
        rule_number = number
      }))
    })))
    segment_actions = optional(list(object({
      action                  = string
      description             = optional(string)
      destination_cidr_blocks = optional(set(string))
      destinations            = optional(set(string))
      edge_location_association = optional(object({
        edge_location        = string
        peer_edge_location   = string
        routing_policy_names = set(string)
      }))
      mode                 = optional(string)
      routing_policy_names = optional(set(string))
      segment              = string
      share_with           = optional(set(string))
      share_with_except    = optional(set(string))
      via = optional(object({
        network_function_groups = optional(set(string))
        with_edge_override = optional(list(object({
          edge_sets         = optional(set(any))
          use_edge          = optional(string)
          use_edge_location = optional(string)
        })))
      }))
      when_sent_to = optional(object({
        segments = optional(set(string))
      }))
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        length(v.core_network_configuration) >= 1
      )
    ])
    error_message = "Each core_network_configuration list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        alltrue([for item in v.core_network_configuration : (length(item.edge_locations) >= 1)])
      )
    ])
    error_message = "Each edge_locations list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        length(v.segments) >= 1
      )
    ])
    error_message = "Each segments list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_policies == null || alltrue([for item in v.attachment_policies : (length(item.conditions) >= 1)])
      )
    ])
    error_message = "Each conditions list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_routing_policy_rules == null || alltrue([for item in v.attachment_routing_policy_rules : (length(item.conditions) >= 1)])
      )
    ])
    error_message = "Each conditions list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : (length(item.routing_policy_rules) >= 1)])
      )
    ])
    error_message = "Each routing_policy_rules list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        alltrue([for item in v.segments : (item.deny_filter == null || (alltrue([for x in item.deny_filter : can(regex("^[A-Za-z][0-9A-Za-z]{0,63}$", x))])))])
      )
    ])
    error_message = "must begin with a letter and contain only alphanumeric characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        alltrue([for item in v.segments : (item.allow_filter == null || (alltrue([for x in item.allow_filter : can(regex("^[A-Za-z][0-9A-Za-z]{0,63}$", x))])))])
      )
    ])
    error_message = "must begin with a letter and contain only alphanumeric characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.segment_actions == null || alltrue([for item in v.segment_actions : (can(regex("^[A-Za-z][0-9A-Za-z]{0,63}$", item.segment)))])
      )
    ])
    error_message = "must begin with a letter and contain only alphanumeric characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.segment_actions == null || alltrue([for item in v.segment_actions : (item.destinations == null || (alltrue([for x in item.destinations : (contains(["blackhole"], x)) || (can(regex("^attachment-[0-9a-f]{17}$", x)))])))])
      )
    ])
    error_message = "any of: must be one of: blackhole; must be a list of valid attachment ids or a list with only the word \"blackhole\"."
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_policies == null || alltrue([for item in v.attachment_policies : (item.rule_number >= 1 && item.rule_number <= 65535)])
      )
    ])
    error_message = "must be between 1 and 65535"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_policies == null || alltrue([for item in v.attachment_policies : (item.condition_logic == null || (contains(["and", "or"], item.condition_logic)))])
      )
    ])
    error_message = "must be one of: and, or"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_policies == null || alltrue([for item in v.attachment_policies : (alltrue([for item in item.conditions : (item.operator == null || (contains(["equals", "not-equals", "contains", "begins-with"], item.operator)))]))])
      )
    ])
    error_message = "must be one of: equals, not-equals, contains, begins-with"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.attachment_routing_policy_rules == null || alltrue([for item in v.attachment_routing_policy_rules : (item.rule_number >= 1 && item.rule_number <= 65535)])
      )
    ])
    error_message = "must be between 1 and 65535"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : ((length(item.routing_policy_name) >= 1 && length(item.routing_policy_name) <= 100) && (can(regex("^[0-9A-Za-z]+$", item.routing_policy_name))))])
      )
    ])
    error_message = "all of: must be between 1 and 100 characters; must contain only alphanumeric characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : (contains(["inbound", "outbound"], item.routing_policy_direction))])
      )
    ])
    error_message = "must be one of: inbound, outbound"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : (item.routing_policy_number >= 1 && item.routing_policy_number <= 9999)])
      )
    ])
    error_message = "must be between 1 and 9999"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : (alltrue([for item in item.routing_policy_rules : (item.rule_number >= 1 && item.rule_number <= 9999)]))])
      )
    ])
    error_message = "must be between 1 and 9999"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_core_network_policy_document_lookup : (
        v.routing_policies == null || alltrue([for item in v.routing_policies : (alltrue([for item in item.routing_policy_rules : (item.rule_definition.condition_logic == null || (contains(["and", "or"], item.rule_definition.condition_logic)))]))])
      )
    ])
    error_message = "must be one of: and, or"
  }
  # Note: 18 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

