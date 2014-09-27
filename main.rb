require_relative 'allelic_variant_list'
require_relative 'allelic_variant_lists_parser'

class Main
  API_KEY = ""
  mim_numbers = []
  allelic_variant_hash = AllelicVariantList.new(API_KEY, mim_numbers: mim_numbers).call
  AllelicVariantListsParser.new(allelic_variant_hash).parse_hash
end
