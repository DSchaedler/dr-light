# frozen_string_literal: true

$gtk.reset

def tick(args)
  mouse_x = args.inputs.mouse.x
  mouse_y = args.inputs.mouse.y

  block = { x: 100, y: 100, w: 100, h: 100 }

  args.outputs.lines << { x: 0, y: 0, x2: mouse_x, y2: mouse_y }
  args.outputs.lines << { x: 1280, y: 0, x2: mouse_x, y2: mouse_y }
  args.outputs.lines << { x: 0, y: 720, x2: mouse_x, y2: mouse_y }
  args.outputs.lines << { x: 1280, y: 720, x2: mouse_x, y2: mouse_y }

  #args.outputs.solids << block
  #args.outputs.lines << deconstruct_rect_lines(block)
  #args.outputs.lines << deconstruct_rect_points(block)
  rect_points = deconstruct_rect_points(block)
  lines = rect_points.map do |point|
    { x: point.x, y: point.y, x2: mouse_x, y2: mouse_y }
  end
  args.outputs.lines << lines
end

def deconstruct_rect_lines(rect)
  [
    { x: rect.x, y: rect.y, x2: rect.x + rect.w, y2: rect.y, r: 255 },
    { x: rect.x, y: rect.y, x2: rect.x, y2: rect.y + rect.h, r: 255 },
    { x: rect.x + rect.w, y: rect.y, x2: rect.x + rect.w, y2: rect.y + rect.h, r: 255 },
    { x: rect.x, y: rect.y + rect.h, x2: rect.x + rect.w, y2: rect.y + rect.h, r: 255 }
  ]
end

def deconstruct_rect_points(rect)
  [
    { x: rect.x, y: rect.y, b: 255 },
    { x: rect.x + rect.w, y: rect.y, b: 255 },
    { x: rect.x, y: rect.y + rect.h, g: 255 },
    { x: rect.x + rect.w, y: rect.y + rect.h, b: 255 },
  ]
end