import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { ReferencesService } from './references.service';
import { CreateReferenceDto } from './dto/create-reference.dto';
import { UpdateReferenceDto } from './dto/update-reference.dto';
import { CheckLinkByReferenceDto } from './dto/check-link-by-reference.dto';

@Controller('references')
export class ReferencesController {
  constructor(private readonly referenceService: ReferencesService) {}

  @Post()
  create(@Body() createReferenceDto: CreateReferenceDto) {
    return this.referenceService.create(createReferenceDto);
  }

  @Get()
  findAll() {
    return this.referenceService.findAll();
  }

  @Post('/get-link-by-reference')
  getLinkByReference(@Body() checkLinkByReferenceDto: CheckLinkByReferenceDto) {
    return this.referenceService.getLinkByReference(
      checkLinkByReferenceDto.reference,
    );
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.referenceService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateReferenceDto: UpdateReferenceDto,
  ) {
    return this.referenceService.update(id, updateReferenceDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.referenceService.remove(id);
  }
}
