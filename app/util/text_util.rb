module HBFav2
  class TextUtil
    def self.text(text, sizeWithFont:font, constrainedToSize:size, lineBreakMode:lineBreakMode)
      if UIDevice.currentDevice.ios7_or_later?
        frame = text.boundingRectWithSize(
          size,
          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading,
          attributes:self.attributesWithFont(font, color:nil, lineBreakMode:lineBreakMode),
          context:nil
        )
        return CGSizeMake(frame.size.width.ceil, frame.size.height.ceil)
      else
        return text.sizeWithFont(font, constrainedToSize:size, lineBreakMode:lineBreakMode)
      end
    end

    def self.text(text, drawInRect:rect, withFont:font, color:color, lineBreakMode:lineBreakMode)
      if UIDevice.currentDevice.ios7_or_later?
        context = NSStringDrawingContext.alloc.init
        text.drawWithRect(
          rect,
          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading,
          attributes:self.attributesWithFont(font, color:color, lineBreakMode:lineBreakMode),
          context:context
        )
      else
        text.drawInRect(rect, withFont:font)
      end
    end

    def self.attributesWithFont(font, color:color, lineBreakMode:lineBreakMode)
      paragraph = NSMutableParagraphStyle.new
      paragraph.lineBreakMode = lineBreakMode
      return {
        NSFontAttributeName            => font,
        NSForegroundColorAttributeName => color,
        NSParagraphStyleAttributeName  => paragraph,
      }
    end
  end
end
