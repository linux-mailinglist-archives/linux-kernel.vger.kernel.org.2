Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF223B0F12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFVVAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:00:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:58:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l1so488867ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XbZaI8K20oT3k/49PtUoFjFtDiZq/0PLWOxESWu6WS0=;
        b=Yw4rkA9CknhtZPlC6ZZGq6GHOjihftbzh2lICXfrXc5PkLwB5XmYuGKUF7Ftez5dsn
         yWCfLV5OPnQTgn065SFBujchcziRF1BFcHPzUTg9cMFsJwEOC8ZSACv0HIGRSt5An/4w
         OYY2z9vGS8KinILH7o7AdnpXBowqeWE1Tpwew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbZaI8K20oT3k/49PtUoFjFtDiZq/0PLWOxESWu6WS0=;
        b=IrJsjg4W1WHbUi/VexX9pafPJdvk/P2M8UvpeebVdCfng2Pc1axFVq5HDgxp5ovhWa
         CO7uIqQ/icaJbx23UFYmSym6FvP8lIUUTN009AG40NdpTe9UHH3ciTYPJOTCcjMk9J2/
         E4C53yWmWy2a2w3yUcqyk1CVRwlO5tRa3SeS5UOYA+YBG4yty+yrMNZPepXZ9o4q8G5s
         O4aV6yisxQcq8cmCd9shibpJs4Taf9T6BjgiOpiVEumZtb1w5nCBcRXP6EwE1HS3jHNN
         6XXDKJaSyBt77Mb7sJqlXRYEkTauRNVtOATARr/nXmV8AGWoLqMUp0voKcbUSUz0crrp
         bKFA==
X-Gm-Message-State: AOAM530nsQFUZsWqZgF6FqMUQo53xGEtcMqFnoTCSOf9DHXlVtq+ZKMW
        GBSu3XVXnHlaGeclKaNpgBjs+Q==
X-Google-Smtp-Source: ABdhPJxIxsxt8wgHeE9e1bSbY9BLozd91OTHWWutrT/ACm/4YzWSp+I2xS4Cy2fMkZQdD/6IZJxFjw==
X-Received: by 2002:a17:906:3ed4:: with SMTP id d20mr5137636ejj.515.1624395482859;
        Tue, 22 Jun 2021 13:58:02 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id jz12sm2745310ejc.94.2021.06.22.13.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 13:58:02 -0700 (PDT)
Subject: Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Zhengxun Li <zhengxunli@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>, masonccyang@mxic.com.tw,
        ycllin@mxic.com.tw
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d43f021d-8f95-7857-b70b-91e22b0a8e2a@rasmusvillemoes.dk>
Date:   Tue, 22 Jun 2021 22:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <223232ecd0865e819477f17cd464ab08@walle.cc>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 13.57, Michael Walle wrote:
> [+ some people from MXIC as they are ones who posted to the ML
> lately. Feel free to forward this mail to the corresponding people.]
> 
> Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
>> Macronix engineers, in their infinite wisdom, have a habit of reusing
>> JEDEC ids for different chips. There's already one
>> workaround (MX25L25635F v MX25L25635E), but the same problem exists
>> for MX25L3205D v MX25L3233F, the latter of which is not currently
>> supported by linux.
>>
>> AFAICT, that case cannot really be handled with any of the ->fixup
>> machinery: The correct entry for the MX25L3233F would read
>>
>>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
>> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
>>
>> while the existing one is
>>
>>     { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>
>> So in spi_nor_init_params(), we won't even try reading the sfdp
>> info (i.e. call spi_nor_sfdp_init_params), and hence
>> spi_nor_post_sfdp_fixups() has no way of distinguishing the
>> chips.
>>
>> Replacing the existing entry with the mx25l3233f one to coerce the
>> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
>> because the data sheet for the mx25l3205d explicitly says not to issue
>> any commands not listed ("It is not recommended to adopt any other
>> code not in the command definition table, which will potentially enter
>> the hidden mode.", whatever that means).
> 
> Maybe we should ask Macronix if it is safe to send the RDSFDP command.
> Can anyone from MXIC comment this?

Yeah, that would be useful to know, but I don't have any hopes
whatsoever of Macronix engineers being able to help sort out the mess
they've created by reusing IDs in the first place. They don't seem to
understand how that can possibly be a problem.

I, and my client, have contacted them on several occasions to ask how
we're supposed to deal with that. At one point, the answer was
"MX25L3233F support Serial Flash Discoverable Parameters (SFDP) mode,
MX25L3205D does not support.", but when I asked the obvious follow-up
("but the MX25L3205D datasheet warns against doing RDSFDP or any other
not explicitly allowed command"), I got no response.

Another response was

"I can only comment on Linux 4.4, as that is the only version that I
have supporting material for. Basically we have a patch for MTD/SPI-NOR
(see attached). This is to allow allow the MTD subsystem to cope with
devices that have the same ID (see below first paragraph of application
note attached). Please note that the MX25L3205D had an EOL notification
on 14th May 2010."

and that attached patch is a 173KB .patch file that made me taste my
breakfast again.

And they keep repeating the argument that when a chip is EOL, it's OK to
reuse its ID (because obviously nobody have used that chip in a product
that would receive OS updates, so any OS released later than that EOL
date can just include support for the newer chip and drop the old one...).

>> In order to support such cases, extend the logic in spi_nor_read_id()
>> a little so that if we already have a struct flash_info* from the name
>> in device tree, check the JEDEC bytes against that, and if it is a
>> match, accept that (device tree compatible + matching JEDEC bytes) is
>> stronger than merely matching JEDEC bytes.
> 
> This won't help much without a proper dt schema. No in-tree devicetree
> could use is because the DT validation would complain.

I can certainly extend the regexp in jedec,spi-nor.yaml to match this
new one. DT is supposed to describe the hardware, so I can't see how
that could possibly be controversial.

 So if this will
> go in (and the maintainers are rather hesitant to add it, I tried
> it myself [1]), you'd also need to add it to jedec,spi-nor.yaml and
> get an ack from Rob.

Thanks for that link. So it seems this isn't the first time recycled IDs
have come up, and not just for Macronix.

Yes, vendors shouldn't recycle IDs. They do. They should be punished by
people not using those chips in new designs. Doesn't work, hardware
designers do use them. Auto-detection is preferred over using hard-coded
values from DT. Sure, absolutely, and when the ID is known to be
ambiguous, by all means throw in all the heuristics and chip-specific
quirks one can think of to disambiguate. But at the end of the day,
there are chips out there which cannot be distinguished without help
from DT, and as DT is supposed to describe the hardware, why is that
such a big problem?

And I'm not suggesting any change whatsoever as to how a compatible
string of merely "jedec,spi-nor" would be handled - it would just take
the first chip with the read JEDEC id, then apply any appropriate quirks
and fixups.

Rasmus
