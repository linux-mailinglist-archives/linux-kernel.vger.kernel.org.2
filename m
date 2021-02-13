Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69A731AD52
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBMRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 12:11:20 -0500
Received: from mail.figgyc.uk ([204.13.154.60]:54670 "EHLO mail.figgyc.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBMRLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 12:11:13 -0500
DKIM-Signature: a=rsa-sha256; bh=EQNqSxFYRRuv4POdqgDBR53PTavc6+dBtioe8gy9HYs=;
 c=relaxed/relaxed; d=figgyc.uk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@figgyc.uk; s=default; t=1613236217; v=1; x=1613668217;
 b=VjN5lupTj44xBGEJ+IbeWmyU9wH43JdJ41gveV/w16LmVglTNcT0sABczzvHxUeQAdJ07I6g
 5U/uI86G2tfS4DQVJFIGF+9Z+mxqFJZGyLermMI2AQaV3oNRrNhFk2NEcrZcywfEDjDtdPgRAqn
 CPhd72Mj4AyxJ/rwItp+REn5fnNLlEJqw3I6ZIKnRcX6QLxh6OQ5LT0LsXbCn3zCxOneZo3mKdx
 Sq0RmMLrKF3GrZB26PDQB58Nv2DYAWG4tOb34NgrJ672rfJyil/2+g8AegNYUs59uIkq3xdcM0T
 XToKnSSnUXG5Z9InOjyx3tOkgM8uWyJP0DIjNj1y10xdA==
Received: by mail.figgyc.uk (envelope-sender <figgyc@figgyc.uk>) with ESMTPS
 id 6b453a5e; Sat, 13 Feb 2021 12:10:17 -0500
References: <20210207123032.516207-1-figgyc@figgyc.uk>
 <0c5b8a0c-7bd2-a15e-ee25-0adec9430e8a@microchip.com>
User-agent: mu4e 1.4.14; emacs 27.1
From:   George Brooke <figgyc@figgyc.uk>
To:     Tudor.Ambarus@microchip.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spi-nor: boya: add support for boya by25q128as
In-reply-to: <0c5b8a0c-7bd2-a15e-ee25-0adec9430e8a@microchip.com>
Message-ID: <87eehj3nd5.fsf@figgyc.uk>
Date:   Sat, 13 Feb 2021 17:10:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tudor,

Tudor.Ambarus@microchip.com writes:

> Hi, George,
>
> On 2/7/21 2:30 PM, George Brooke wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless=20
>> you know the content is safe
>>
>> Adds support for the Boya Microelectronics BY25Q128AS 128 Mbit=20
>> flash.
>> I tested this on the Creality WB-01 embedded device which uses=20
>> this,
>> although that was with OpenWrt which is still using 5.4 so I=20
>> had to
>> do a bit of porting work. Don't see how that would make much of=20
>> a
>> difference though.
>>
>> Signed-off-by: George Brooke <figgyc@figgyc.uk>
>> ---
>>  drivers/mtd/spi-nor/Makefile |  1 +
>>  drivers/mtd/spi-nor/boya.c   | 23 +++++++++++++++++++++++
>>  drivers/mtd/spi-nor/core.c   |  1 +
>>  drivers/mtd/spi-nor/core.h   |  1 +
>>  4 files changed, 26 insertions(+)
>>  create mode 100644 drivers/mtd/spi-nor/boya.c
>>
>> diff --git a/drivers/mtd/spi-nor/Makefile=20
>> b/drivers/mtd/spi-nor/Makefile
>> index 653923896205..7d1551fbfbaa 100644
>> --- a/drivers/mtd/spi-nor/Makefile
>> +++ b/drivers/mtd/spi-nor/Makefile
>> @@ -2,6 +2,7 @@
>>
>>  spi-nor-objs                   :=3D core.o sfdp.o
>>  spi-nor-objs                   +=3D atmel.o
>> +spi-nor-objs                   +=3D boya.o
>>  spi-nor-objs                   +=3D catalyst.o
>>  spi-nor-objs                   +=3D eon.o
>>  spi-nor-objs                   +=3D esmt.o
>> diff --git a/drivers/mtd/spi-nor/boya.c=20
>> b/drivers/mtd/spi-nor/boya.c
>> new file mode 100644
>> index 000000000000..014b0087048a
>> --- /dev/null
>> +++ b/drivers/mtd/spi-nor/boya.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2005, Intec Automation Inc.
>> + * Copyright (C) 2014, Freescale Semiconductor, Inc.
>> + */
>> +
>> +#include <linux/mtd/spi-nor.h>
>> +
>> +#include "core.h"
>> +
>> +static const struct flash_info boya_parts[] =3D {
>> +       /* Boya */
>> +       { "by25q128as", INFO(0x684018, 0, 64 * 1024, 256,
>
> The manufacturer=E2=80=99s identification code is defined by one or more
> eight (8) bit fields each consisting of seven (7) data bits plus=20
> one (1)
> odd parity bit. It is a single field limiting the possible=20
> number of
> vendors to 126. To expand the maximum number of identification=20
> codes a
> continuation scheme has been defined.
>
> According to JEP106BA, the manufacturer ID for Boya should be=20
> preceded by
> eight continuation codes. So I would expect the manufacturer ID=20
> for this
> flash to be: 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,=20
> 0x68.
>
> Without the continuation codes, we will have collisions between
> manufacturer IDs, Convex Computer being an example.
>
> I see that the datasheet [1] for this flash doesn't specify=20
> anything
> about the continuation codes, so I suspect that Boya just got it=20
> wrong.

It appears you are right. I thought it would be the best idea to=20
actually
interact with the flash chip and read its responses, so I found a=20
tool
called spincl [2] to send some commands to it with a Raspberry Pi:

$ spincl -ib -m0 -c0 -s0 -p0 6 0x90
0x00 0x00 0x00 0x00 0x68 0x17
$ spincl -ib -m0 -c0 -s0 -p0 4 0x9F
0x00 0x68 0x40 0x18
and indeed there doesn't seem to be any continuation codes.

> We'll have to check other datasheets from Boya and see if they=20
> got
> their manufacturer ID wrong for all their flashes. We'll have to=20
> add

The BY25Q64AS [3] appears to be described similarly.

> some fixup mechanism for the manufacturers ID handling, in order=20
> to
> avoid collisions with other manufacturers IDs.

I looked into this a bit more, and what I'm realising is that I'm=20
not sure if
there even is any mechanism to deliver the continuation codes=20
within the
base SPI-NOR standard? Take esmt.c: the f25l32qa has a device id=20
0x8c4116.
JEP106BA attribytes 8c to Monolithic Memories in the first bank,=20
while
Elite Flash Storage (presumably an alias of ESMT) should be=20
identifying
as 0x7f, 0x7f, 0x7f, 0x8c. Its datasheet [4] appears to be equally=20
sparse on
detail. To my untrained eye, this seems to be the exact same=20
situation we
find ourselves in here. (You probably know a lot more about this=20
then I do -
if I'm wrong do point it out!)

That said I can't seem to find any formalised definition of what=20
the 0x90
"manufacturer and device ID" command is actually supposed to do in=20
the case of
a manufacturer ID that isn't in the first bank. Likewise with 0x9f=20
"JEDEC ID".
Do you know of any flashes made by companies not in the first bank=20
that
identify themselves correctly?

As far as I can tell the only proper method available is in SFDP,=20
where the
Parameter ID of a vendor specific table would be the bank number=20
in the MSB
and the actual manufacturer code in the LSB. However, this is a=20
very
over-engineered solution, wouldn't work on devices with no vendor=20
specific
tables, and in this case, I couldn't even get the SFDP table to=20
read out of
the by25q128as at all:
$ spincl -ib -m0 -c0 -s0 -p0 32 0x5A
0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff=20
0xff 0xff ...
(This may very well be a peculiarity of the way I'm accessing it,=20
but in any
case I don't think this fix would be a very good idea.)

I'm not sure what would actually make a good fixup in this=20
scenario. We'd need
something that could differentiate a Boya chip from any other=20
hypothetical
0x68 manufacturer flash.
Maybe even the missing SFDP output would make a good detection=20
routine, but
that would need testing with a better SPI inspection method and=20
across multiple
flash chips because I doubt that's intentional - surely if SFDP=20
didn't work it
would just not be described in the datasheet. Probably better to=20
think of
something other than that though.

Thanks,
figgyc

[2] https://github.com/CrosseyeJack/spincl
[3]=20
https://datasheet.lcsc.com/szlcsc/1904091402_BOYAMICRO-BY25Q64ASSIG_C383793=
.pdf
[4]=20
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F25L32QA.pdf

>
> Cheers,
> ta
>
> [1]=20
> https://datasheet.lcsc.com/szlcsc/1904091402_BOYAMICRO-BY25Q128ASSIG_C383=
794.pdf
>
>> +                       SECT_4K | SPI_NOR_DUAL_READ |=20
>> SPI_NOR_QUAD_READ |
>> +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +       },
>> +};
>> +
>> +const struct spi_nor_manufacturer spi_nor_boya =3D {
>> +       .name =3D "boya",
>> +       .parts =3D boya_parts,
>> +       .nparts =3D ARRAY_SIZE(boya_parts),
>> +};
>> diff --git a/drivers/mtd/spi-nor/core.c=20
>> b/drivers/mtd/spi-nor/core.c
>> index 20df44b753da..4d0d003e9c3f 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2160,6 +2160,7 @@ int spi_nor_sr2_bit7_quad_enable(struct=20
>> spi_nor *nor)
>>
>>  static const struct spi_nor_manufacturer *manufacturers[] =3D {
>>         &spi_nor_atmel,
>> +       &spi_nor_boya,
>>         &spi_nor_catalyst,
>>         &spi_nor_eon,
>>         &spi_nor_esmt,
>> diff --git a/drivers/mtd/spi-nor/core.h=20
>> b/drivers/mtd/spi-nor/core.h
>> index d631ee299de3..d5ed5217228b 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -409,6 +409,7 @@ struct spi_nor_manufacturer {
>>
>>  /* Manufacturer drivers. */
>>  extern const struct spi_nor_manufacturer spi_nor_atmel;
>> +extern const struct spi_nor_manufacturer spi_nor_boya;
>>  extern const struct spi_nor_manufacturer spi_nor_catalyst;
>>  extern const struct spi_nor_manufacturer spi_nor_eon;
>>  extern const struct spi_nor_manufacturer spi_nor_esmt;
>> --
>> 2.30.0
>>
