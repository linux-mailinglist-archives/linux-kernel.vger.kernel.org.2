Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2213FC579
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhHaKNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbhHaKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:12:58 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:12:03 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id p14so944439vsm.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUx9AilQ+AUyPyHc5fO1JUyPo2HU3YLKNAizhA+/8FE=;
        b=sOPJJ7n2Tmx2ziD+UDZjtQj/gs/Ps8snP6q1z0XiyW3jwkSZxRo8HulkCVR/mftPx0
         irPAqcrIjWATVUmClr36hJnwZbxmoeXKQWEaHMAeB6gw/ULMtNagd43WIxvrWh2G9PGY
         D/6A+W/ZqHSUvdsWXuVfCLz7iMjy1MU257lak/fzt3j7zP4jhz2pDB5G3/9F5YESyjEK
         KOoFc7hA7xfywJC49fnx8N79qbdZ76805Bd7O/wpfwYT1I1EBuO20WMfn3Q8PAMVYc06
         rpRREhRswcsE0NvYAltP/Acix/MAt+5qOvocD+LUP68sAYmx0XsP/CvbuN6ZJn30kd7j
         2Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUx9AilQ+AUyPyHc5fO1JUyPo2HU3YLKNAizhA+/8FE=;
        b=lGQHuRQlA3GphVDDBKX1vr4xJmOuX1GwqyS3TEJo8H76QwakW83sNNPOHJIz58Oq2u
         qI46+uKuvt65pq2pKaChQh3bBpIGC1lwz0uvQjWYuqEt5cZFvjVljrBT8/3FwP3XrQKK
         NfXp+piuQMglNeAPsckbCP6EshneEGHNRXda/gM4omhkxbhNKbpBcZBoJo38eM0WKv5N
         1WYNMUnZdu0h0OYjNXCFu3og6hAcs7XfK0SnEOQQ+KmlL+E4ftS8ohgPCmMrF20IDWg0
         wZWhMYLVFmL/yVx1uQI9nLTDG4WWm1IiHieWT1bieaML4BDt+amahJ2rItNkX10BWyhV
         a+eA==
X-Gm-Message-State: AOAM533CUG5BADCc/hJhDcZHdhN1K3JW1MkuXHQdeJSaz2+f+j3Mkxq6
        JMqwKOCUE4g11tt/ZmwhmR0vw11pdJs3mPGlDN4=
X-Google-Smtp-Source: ABdhPJye8rMX0HxgK/KxqQ6iMBZgBafrJ/5gFkBOep8PQRFiWZSzYG77BfW3DEQAHUpctBSnWFRoOlkFrmNSSVzDLUk=
X-Received: by 2002:a67:ee19:: with SMTP id f25mr12491527vsp.30.1630404722238;
 Tue, 31 Aug 2021 03:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
 <3462300528bbe71207ef2164411e34d2@walle.cc> <CAGiusB1JvHkX7GSvD2JsqKWwC5xBePX_ruWk9nU9gugoroLnKA@mail.gmail.com>
In-Reply-To: <CAGiusB1JvHkX7GSvD2JsqKWwC5xBePX_ruWk9nU9gugoroLnKA@mail.gmail.com>
From:   Andrea Zanotti <andreazanottifo@gmail.com>
Date:   Tue, 31 Aug 2021 12:11:51 +0200
Message-ID: <CAGiusB0B5dN_K+bW1xudmT6UNmVOL=voBOuSVJeiYo3v6ywO8w@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: added support for np8p128ax60
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mar 31 ago 2021 alle ore 11:09 Andrea Zanotti
<andreazanottifo@gmail.com> ha scritto:
>
> Hi Michael,
>
> Il giorno mar 31 ago 2021 alle ore 10:39 Michael Walle <michael@walle.cc> ha scritto:
>>
>> Hi Andrea,
>>
>> Am 2021-08-31 10:13, schrieb Andrea Zanotti:
>> > From: Andrea Zanotti <andreazanottifo@gmail.com>
>> >
>> > Added support for P8P Parallel Phase Change Memory.
>>
>> Please use present tense, eg "add support..."
>>
>> Is there a public datasheet? If so, please include it above
>> your SoB like so:
>> Datasheet: https://...
>>
>
> I will format the header as per your suggestions. I used the same datasheet
> linked by you at the end of the email
>
>>
>> > Added memory information (page size and sector size) as per data-
>> > sheet information, after typos corrections.
>>
>> After typos corrections?
>>
>
> The one specified in the following paragraph. I'll better write this. (What I meant
> is that there are some typos in the datasheet itself)
>
>>
>> > At page 37, paragraph 'SPI Memory Organization', it is written
>> > down that the memory is organized as:
>> >  * 16.772.216 bytes (typo here, there 16.777.216 bytes)
>> >  * 128 sectors of 128 Kbytes each (correct)
>> >  * 131.072 pages of 64 bytes each (typo here, as the total would be
>> >    64Mbit, but the total memory is actually 128Mbit, correct value
>> >    is 262.144 pages)
>> >
>> > Patch tested against the aforementioned PCM memory.
>>
>> What SPI host controller was used?
>>
>
> I used an AT91SAM9G20 processor, SPI controller "atmel,at91rm9200-spi" (spi-atmel.c)
>
>>
>> > No known regressions inserted, as the patch only adds the possibility
>> > to recognize said PCM memory inside the common spi-nor driver.
>>
>> Please drop this. If there were any regressions, the patch wouldn't
>> be picked up anyway.
>>
>
> It will be dropped.
>
>> >
>> > Signed-off-by: Andrea Zanotti <andreazanottifo@gmail.com>
>> > ---
>> >  drivers/mtd/spi-nor/micron-st.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/mtd/spi-nor/micron-st.c
>> > b/drivers/mtd/spi-nor/micron-st.c
>> > index c224e59820a1..c78331451082 100644
>> > --- a/drivers/mtd/spi-nor/micron-st.c
>> > +++ b/drivers/mtd/spi-nor/micron-st.c
>> > @@ -128,6 +128,7 @@ static const struct flash_info micron_parts[] = {
>> >       { "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
>> >                           SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
>> >                           SPI_NOR_4B_OPCODES) },
>> > +     { "np8p128ax60", {0x89, 0xda, 0x18}, 3, 128 * 1024, 128, 64, 0, 0 },
>>
>> Eh? Please use INFO(). And why isn't this 0x20 for micron.
>>
>
> With INFO() macro I am locked in with .page_size = 256 (I would need 64), or am I missing something?
>
>>
>> I found this datasheet:
>> https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/NP8P128Ax60E_Rev_K.pdf
>>
>> According to that datasheet, the manuf id is 0x20. And the device id
>> should be either 0x88e1 or 0x8821.
>>
>
> You are right, checking it right now.
>

- As per datasheet, table 10 on page 18, Manufacturer code is 0x89
(column "data" for parameter "Manufacturer Code").
- On the datasheet, I agree with you that the device code is
advertised as either 0x88e1 or 0x8821. I changed the byte array
to something wrong in order to have the debug warning on the JEDEC id
bytes, and this is the log:

spi-nor spi0.0: unrecognized JEDEC id bytes: 89 da 18 00 00 00

Second and third byte are "0xda" and "0x18". I am not an expert in the
spi-nor driver, but from my understanding
(if it's wrong, please correct me) the spi-nor driver tries to match
the the read bytes from the memory with the ones
in the tables. I don't know if the datasheet is wrong also in that
cell of the table, or if I am interpreting the data wrongly.


>>
>> >  };
>> >
>> >  static const struct flash_info st_parts[] = {
>>
>> --
>> -michael
