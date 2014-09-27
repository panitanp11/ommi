require 'csv'

class AllelicVariantListsParser

  FILENAME = 'output.txt'

  def initialize(allelic_variant_hash)
    if allelic_variant_hash.is_a?(Hash)
      @hash = allelic_variant_hash
      @csv = CSV.open(FILENAME, 'wb', { col_sep: "\t"})
    else
      raise ArgumentError, 'hash of mim number(key) and allelic variant lists(value) required!'
    end
  end

  def parse_hash
    @hash.each { |mim_number, lists| parse_lists mim_number, lists}
    @csv.close
  end

  def parse_lists(mim_number, lists)
    if lists['omim'] && lists['omim']['allelicVariantLists']
      if (variants = lists['omim']['allelicVariantLists']).any?
        raise ArgumentError if lists.count > 1
        variants.first['allelicVariantList'].each do |variant|
          output_row = [ mim_number,
                         variant['allelicVariant']['number'],
                         variant['allelicVariant']['name'],
                         variant['allelicVariant']['mutations'],
                         variant['allelicVariant']['dbSnps'] ]
          #p output_row.join

          @csv << output_row
        end
      else
        p 'else'
      end
    else
      p "[Warning] invalid list! : #{list}"
    end
  end

end
