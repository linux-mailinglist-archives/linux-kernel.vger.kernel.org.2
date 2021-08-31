Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353E73FCA83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhHaPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhHaPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:06:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48524C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:05:28 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE12922234;
        Tue, 31 Aug 2021 17:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630422326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbEiTj8/FDUjs9gGlZ6P7LHVQpqyo+Y/3URkhMMwSeA=;
        b=fQQs3j3m+Ozg95af6j9KIKt5sJPG9GmQzu+Sb/0RIjrI71Jqqh9TE959tICYtcPKTi/SFG
        PrX47q3ORuNUNFkMolYXPlbmOoI5jSuCuXfPNyEBWDpRbDDB/sbHjN3XWLU1jIGOZodaVD
        dBIKGMdYGk/gf5P7Y1wKLFgxiBiYKMQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Aug 2021 17:05:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andrea Zanotti <andreazanottifo@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: micron-st: added support for np8p128ax60
In-Reply-To: <CAGiusB0B5dN_K+bW1xudmT6UNmVOL=voBOuSVJeiYo3v6ywO8w@mail.gmail.com>
References: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
 <3462300528bbe71207ef2164411e34d2@walle.cc>
 <CAGiusB1JvHkX7GSvD2JsqKWwC5xBePX_ruWk9nU9gugoroLnKA@mail.gmail.com>
 <CAGiusB0B5dN_K+bW1xudmT6UNmVOL=voBOuSVJeiYo3v6ywO8w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4bf9396505975e3fee2cc6396a6eeff7@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Am 2021-08-31 12:11, schrieb Andrea Zanotti:
> Il giorno mar 31 ago 2021 alle ore 11:09 Andrea Zanotti
> <andreazanottifo@gmail.com> ha scritto:
>> 
>> Hi Michael,
>> 
>> Il giorno mar 31 ago 2021 alle ore 10:39 Michael Walle 
>> <michael@walle.cc> ha scritto:
>>> 
>>> Hi Andrea,
>>> 
>>> Am 2021-08-31 10:13, schrieb Andrea Zanotti:
>>> > From: Andrea Zanotti <andreazanottifo@gmail.com>
>>> >
>>> > Added support for P8P Parallel Phase Change Memory.
>>> 
>>> Please use present tense, eg "add support..."
>>> 
>>> Is there a public datasheet? If so, please include it above
>>> your SoB like so:
>>> Datasheet: https://...
>>> 
>> 
>> I will format the header as per your suggestions. I used the same 
>> datasheet
>> linked by you at the end of the email
>> 
>>> 
>>> > Added memory information (page size and sector size) as per data-
>>> > sheet information, after typos corrections.
>>> 
>>> After typos corrections?
>>> 
>> 
>> The one specified in the following paragraph. I'll better write this. 
>> (What I meant
>> is that there are some typos in the datasheet itself)
>> 
>>> 
>>> > At page 37, paragraph 'SPI Memory Organization', it is written
>>> > down that the memory is organized as:
>>> >  * 16.772.216 bytes (typo here, there 16.777.216 bytes)
>>> >  * 128 sectors of 128 Kbytes each (correct)
>>> >  * 131.072 pages of 64 bytes each (typo here, as the total would be
>>> >    64Mbit, but the total memory is actually 128Mbit, correct value
>>> >    is 262.144 pages)
>>> >
>>> > Patch tested against the aforementioned PCM memory.
>>> 
>>> What SPI host controller was used?
>>> 
>> 
>> I used an AT91SAM9G20 processor, SPI controller "atmel,at91rm9200-spi" 
>> (spi-atmel.c)
>> 
>>> 
>>> > No known regressions inserted, as the patch only adds the possibility
>>> > to recognize said PCM memory inside the common spi-nor driver.
>>> 
>>> Please drop this. If there were any regressions, the patch wouldn't
>>> be picked up anyway.
>>> 
>> 
>> It will be dropped.
>> 
>>> >
>>> > Signed-off-by: Andrea Zanotti <andreazanottifo@gmail.com>
>>> > ---
>>> >  drivers/mtd/spi-nor/micron-st.c | 1 +
>>> >  1 file changed, 1 insertion(+)
>>> >
>>> > diff --git a/drivers/mtd/spi-nor/micron-st.c
>>> > b/drivers/mtd/spi-nor/micron-st.c
>>> > index c224e59820a1..c78331451082 100644
>>> > --- a/drivers/mtd/spi-nor/micron-st.c
>>> > +++ b/drivers/mtd/spi-nor/micron-st.c
>>> > @@ -128,6 +128,7 @@ static const struct flash_info micron_parts[] = {
>>> >       { "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
>>> >                           SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
>>> >                           SPI_NOR_4B_OPCODES) },
>>> > +     { "np8p128ax60", {0x89, 0xda, 0x18}, 3, 128 * 1024, 128, 64, 0, 0 },
>>> 
>>> Eh? Please use INFO(). And why isn't this 0x20 for micron.
>>> 
>> 
>> With INFO() macro I am locked in with .page_size = 256 (I would need 
>> 64), or am I missing something?

Ok I see. Mh, then maybe there should be a new macro where you can
set the page_size?

>>> 
>>> I found this datasheet:
>>> https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/NP8P128Ax60E_Rev_K.pdf
>>> 
>>> According to that datasheet, the manuf id is 0x20. And the device id
>>> should be either 0x88e1 or 0x8821.
>>> 
>> 
>> You are right, checking it right now.
>> 
> 
> - As per datasheet, table 10 on page 18, Manufacturer code is 0x89
> (column "data" for parameter "Manufacturer Code").

That is for the command 90h (which is for the parallel interface?). We
issue 9Fh and according to the "READ IDENTIFICATION (RDID)" chapter:

   The manufacturer identification is assigned by JEDEC and has the
   value 20h for Micron.

And in fact it is assigned by JEDEC, see below.

> - On the datasheet, I agree with you that the device code is
> advertised as either 0x88e1 or 0x8821. I changed the byte array
> to something wrong in order to have the debug warning on the JEDEC id
> bytes, and this is the log:
> 
> spi-nor spi0.0: unrecognized JEDEC id bytes: 89 da 18 00 00 00
> 
> Second and third byte are "0xda" and "0x18". I am not an expert in the
> spi-nor driver, but from my understanding
> (if it's wrong, please correct me) the spi-nor driver tries to match
> the the read bytes from the memory with the ones
> in the tables. I don't know if the datasheet is wrong also in that
> cell of the table, or if I am interpreting the data wrongly.

Looks like the datasheet is wrong or something is broken here. Yes
you are correct in assuming that these are in fact the ID bytes.

We'd need to check what vendor 0x89 is to avoid collisions with other
vendors/flashes.

Btw this "flash" has no need for an erase, just like the MRAM or an
SPI EEPROM. Could you have a look at drivers/misc/eeprom/at25.c if
that will work for you?

-michael
