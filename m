Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21241345271
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCVWcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:31:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:31:43 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CF6EC22235;
        Mon, 22 Mar 2021 23:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616452300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJoG/u8MI2x4uSTu5HQetJN+bIf3Y0nqyeCj3d2bX50=;
        b=OwNc03RxyOQAsGLwGlJHYhQjmOWeSzExvBTZ2CiikQTSjsySaVaRwudgUFkTQIBzv+s62H
        vuUbi4ZBI9DLuFjsHK10/WPOL5nsEKUDQysTC/ihrd51qTP+EmsWlBd3yI6HtFhp5Vj6of
        kru7ZcSqIJFgVNMQXQ2ITmS1xPUiYDI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Mar 2021 23:31:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
In-Reply-To: <20210322184214.ernzjfwfle6dfhpv@ti.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <20210322142141.pd7ondg6l76idz7d@ti.com>
 <0efba47de8737059b4f3c593c26297bf@walle.cc>
 <20210322184214.ernzjfwfle6dfhpv@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <7e00a5fc05a186d5b34916e5a9f45a48@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-22 19:42, schrieb Pratyush Yadav:
> On 22/03/21 04:32PM, Michael Walle wrote:
>> Am 2021-03-22 15:21, schrieb Pratyush Yadav:
>> > On 18/03/21 10:24AM, Michael Walle wrote:
>> > > +
>> > > +	sfdp->num_dwords = DIV_ROUND_UP(sfdp_size, sizeof(*sfdp->dwords));
>> >
>> > The SFDP spec says that Parameter Table Pointer should be DWORD aligned
>> > and Parameter Table length is specified in number of DWORDs. So,
>> > sfdp_size should always be a multiple of 4. Any SFDP table where this is
>> > not true is an invalid one.
>> >
>> > Also, the spec says "Device behavior when the Read SFDP command crosses
>> > the SFDP structure boundary is not defined".
>> >
>> > So I think this should be a check for alignment instead of a round-up.
>> 
>> Well, that woundn't help for debugging. I.e. you also want the SFDP 
>> data
>> in cases like this. IMHO we should try hard enough to actually get a
>> reasonable dump.
>> 
>> OTOH we also rely on the header and the pointers in the header. Any
>> other ideas, but just to chicken out?
> 
> Honestly, I don't think reading past the SFDP boundary would be too 
> bad.
> It probably will just be some garbage data. But if you want to avoid
> that, you can always round down instead of up.

Like I said, while the storage will be rounded up to a multiple of
DWORDs, only sfdp_size is transferred. Thus it case a pointer is not
DWORD aligned, we end up with zeros at the end.

I'll add a comment.

> This way you will only
> miss the last DWORD at most. In either case, a warning should be 
> printed
> so this problem can be brought to the user's attention.

I was about to add a warning/debug message. But its the wrong place.
It should really be checked in the for loop which iterates over the
headers before parsing them. You could check sfdp_size but then two
unaligned param pointers might cancel each other out.

This can be a seperate patch, besides adding a warning, should there
be any other things to do, e.g. stop parsing and error out?

..

>> > > +		goto exit;
>> > > +	}
>> > > +
>> > > +	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sfdp_size, sfdp->dwords);

Btw, this can be spi_nor_read_sfdp(). But I'm not sure, what this
whole dma capable buffer should be. Is kmalloc(GFP_KERNEL)
considered DMA safe?

The buffer ends in spi_nor_read_data(), which is also called from
mtdcore:

spi_nor_read_sfdp()
   spi_nor_read_raw()
     spi_nor_read_data()

mtd_read()
   mtd_read_oob()
     mtd_read_oob_std()
       spi_nor_read()
         spi_nor_read_data()

Is the buffer passed from mtd_read() also DMA-safe? Doesn't the SPI
drivers allocate DMA safe buffers if they need them?

-michael
