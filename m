Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36135F1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhDNKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhDNKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:53:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:53:27 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7FA4022236;
        Wed, 14 Apr 2021 12:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618397605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L12OIt8faTtdsv0KBp9p7wm1ybDfWS+RvgRsDf4XGCM=;
        b=RqzM4M2eO8ZJhmk441yK9ehFa5PBvQCO0zSg1P6d3psTOFaqN9v6xN4pHz7YFiVt7mrGTG
        i4pPm1E3KXa7KM0PYbnZyZywco0iy+/rytm8IaXnOjE7M6ODqZuk+6pePPSrcbRKU+QDh2
        m90ct6flthNBhnjSlCvL18I9D7dPF8I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Apr 2021 12:53:24 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add block protection support to
 mx25u6435f
In-Reply-To: <CAATdQgCYoeEKfvQPNUxzMA+o4Xwtt80SoMmfweTAB1MCijyC6A@mail.gmail.com>
References: <20210413120210.3671536-1-ikjn@chromium.org>
 <51761f1db840c51bad17f5f275b4ce1a@walle.cc>
 <CAATdQgCYoeEKfvQPNUxzMA+o4Xwtt80SoMmfweTAB1MCijyC6A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a74478aa6fa248f6b6243366055ddd52@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-04-14 08:53, schrieb Ikjoon Jang:
> On Tue, Apr 13, 2021 at 8:26 PM Michael Walle <michael@walle.cc> wrote:
>> Am 2021-04-13 14:02, schrieb Ikjoon Jang:
>> > This patch adds block protection support to Macronix mx25u6432f and
>> > mx25u6435f. Two different chips share the same JEDEC ID while only
>> > mx25u6423f support section protections. And two chips have slightly
>> > different definitions of BP bits than generic (ST Micro)
>> > implementation.
>> 
>> What is different compared to the current implementation? Could you 
>> give
>> an example?
> 
> Two chips have different definitions on BP and  T/B bits.
> - 35f has 4 BPs without T/B, BP3 behaves like T/B bit.

See below.

> - 32f has 4 BPs plus T/B on CR.

Ok, so this scheme looks like what we have right now, only that the
TB bit is OTP and at a different place, right?

> 
> # MX25U6435F
> 
>  BPs | BP3=0 | BP3=1
> ---------------------
>  000 | None  | 1/2
>  001 | 1/128 | 3/4
>  010 | 1/64  | 7/8
>  011 | 1/32  | 15/16
>  100 | 1/16  | 31/32
>  101 | 1/8   | 63/64
>  110 | 1/4   | 127/128
>  111 | 1/2   | All
> 
> # MX25U6432F
> 
>   BPs | T/B=0 | T/B=1
> ---------------------
>  0000 | None  | None
>  0001 | 1/128 | 1/128
>  0010 | 1/64  | 1/64
>  0011 | 1/32  | 1/32
>  0100 | 1/16  | 1/16
>  0101 | 1/8   | 1/8
>  0110 | 1/4   | 1/4
>  0111 | 1/2   | 1/2
>  1xxx | All   | All
> 
> It seems that 35f has a unique definition on bottom protections than 
> others.

Oh my.. That looks more like an invert and the top protection is also
different. That is, if you'd treat BP3 as T/B, then BP[2:0] = 111
should be "lock all", but it is rather lock half.. I just looked at
the mx25u3235f back then. There it looked correct. But now it looks
like the top protection scheme clips on the lower end (i.e. always
starts with 1 block), where on the current supported scheme, we clip
on the upper end (i.e. we start with protect all and walk backwards).

> Assuming there's no way to distinguish between mx25u6435f and 32f,
> This patch simply takes the common parts only - BP[2:0]
> without using T/B or BP3 at all.

You could look for differences in the SFDP and then distiguish them
during probe and set the corresponding flags. Where the flags would
need to be implemented first. I wouldn't have a problem with saying
we just support top protection for the MX25U6435F but then we'd need
to make sure the BP3 is set to 0.

If you want to read out the SFDP, see here:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=235475

> But the current swp implementation implies that "BP with all ones"
> is to be 'all' protection while in this approach it's 1/2,
> A hidden BP3 should be involved for 'all' protection.

Yes, so the MX25U6432F needs to have the 4bit BP flag set and the
MX25U6435F seems to be completely different. Doh..

>> > So this patch defines a new spi_nor_locking_ops only for macronix
>> > until this could be merged into a generic swp implementation.
>> 
>> TBH, I don't really like the code duplication and I'd presume that it
>> won't ever be merged with the generic code.
> 
> Agree, I hope I could make a more generalized version into swp.c.
> 
> Honestly I expected that I just needed to add one line of 
> SPI_NOR_HAS_LOCK
> to flash_info to support mx256432f (this was the main purpose of my 
> patch)
> before I read the datasheets. :)
> 
>> 
>> You also assume that both the WPSEL and T/B bit are 0, which might not
>> be true. Please note that both are write-once, thus should only be 
>> read.
> 
> yep, that also should be considered,
> I'm thinking just not to support WPSEL=1 case for now.

which is ok, but we should make sure it is not set at all. Now the
question is what do we do if it is set? I'd say just don't register the
locking ops and log a message.

-michael
