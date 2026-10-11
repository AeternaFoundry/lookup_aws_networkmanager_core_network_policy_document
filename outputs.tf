output "networkmanager_core_network_policy_document_lookup_id" {
  description = "Map of id values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.id if v.id != null && length(v.id) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_attachment_policies" {
  description = "Map of attachment_policies values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.attachment_policies if v.attachment_policies != null && length(v.attachment_policies) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_attachment_routing_policy_rules" {
  description = "Map of attachment_routing_policy_rules values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.attachment_routing_policy_rules if v.attachment_routing_policy_rules != null && length(v.attachment_routing_policy_rules) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_core_network_configuration" {
  description = "Map of core_network_configuration values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.core_network_configuration if v.core_network_configuration != null && length(v.core_network_configuration) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_json" {
  description = "Map of json values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.json if v.json != null && length(v.json) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_network_function_groups" {
  description = "Map of network_function_groups values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.network_function_groups if v.network_function_groups != null && length(v.network_function_groups) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_routing_policies" {
  description = "Map of routing_policies values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.routing_policies if v.routing_policies != null && length(v.routing_policies) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_segment_actions" {
  description = "Map of segment_actions values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.segment_actions if v.segment_actions != null && length(v.segment_actions) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_segments" {
  description = "Map of segments values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.segments if v.segments != null && length(v.segments) > 0 }
}
output "networkmanager_core_network_policy_document_lookup_version" {
  description = "Map of version values across all networkmanager_core_network_policy_document_lookup, keyed the same as var.networkmanager_core_network_policy_document_lookup"
  value       = { for k, v in data.aws_networkmanager_core_network_policy_document.networkmanager_core_network_policy_document_lookup : k => v.version if v.version != null && length(v.version) > 0 }
}

