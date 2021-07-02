Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718C33BA11B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhGBNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhGBNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:20:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC8C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:17:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so16097389ejg.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LnNGuurTFcfXm5aa2EG6X8kagXccnixUpuxFIcjTuz0=;
        b=edP3fyfaFDARH/bC6v6yR9Ik3v1NUo8K3ML3aozcZE1Tv9cxfAo+XRdQI3hfcZWQHY
         Iqso1SM4UFryefV1FfQkkEJngAetM3B3/ZX7j/hrVgO3Kmz7TI9wEhHAexx/eioBnljQ
         d3KwfAS5LsdPUmjTbnuElXdHKK6enm/ZA/eJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnNGuurTFcfXm5aa2EG6X8kagXccnixUpuxFIcjTuz0=;
        b=Ek6EYpeDik2em9cFnuw9d/Jsb9T3mBPRrChHbyd6D8nDNcP+wU57fpZDBwjU8H9IpH
         YQWtpCiMo+sts7R/MiQ1UvRfwiTkJz4y0ze8VR9iuVHCHEMmKc7rI62GoC4K/ijW/un4
         68O6MpJAu2CSL+VFYmM1ZSdJMKMCWjDY6esMTXQtvNuFLEyEiMJdk4QcGWl+jpC/MBfq
         j1XHq33w9rkLEa/egvmTmMZMIwPBlFXcsl3P/e8ELFBF8atdeBeuC6Islcv8f59H9Ghk
         rKuCBNZ1yoA1n1EN14R0Mn3SuAGH8QHbfxwr0YrYMt6nC593ymwTQBPiFlOFzvpNOpRV
         uOBw==
X-Gm-Message-State: AOAM532mBCeUhzqxz5+UYBv2Oesw+cR2kF6Ld02sxcp2L1MVMxbzQfQ+
        M6OGwvbnpudzXbUnwu5DzS+cvw==
X-Google-Smtp-Source: ABdhPJzzd/ACmxPyjfnwAm8N8fL+x7GirV8yudNkjWzN6q3+dLWU7CtEEzo7TTobHL8NWQ33Cw8LNA==
X-Received: by 2002:a17:906:25d5:: with SMTP id n21mr5368482ejb.156.1625231869483;
        Fri, 02 Jul 2021 06:17:49 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id md14sm1053651ejb.125.2021.07.02.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:17:48 -0700 (PDT)
Subject: Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
To:     Tudor.Ambarus@microchip.com, michael@walle.cc
Cc:     linux-mtd@lists.infradead.org, frieder.schrempf@kontron.de,
        bbrezillon@kernel.org, p.yadav@ti.com,
        linux-kernel@vger.kernel.org, esben@geanix.com,
        zhengxunli@mxic.com.tw, jaimeliao@mxic.com.tw,
        masonccyang@mxic.com.tw, ycllin@mxic.com.tw
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
 <d43f021d-8f95-7857-b70b-91e22b0a8e2a@rasmusvillemoes.dk>
 <d1473b12-daea-e5e8-b8d5-64084bfbe11c@microchip.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <63c61200-2387-6f92-32a0-38baf7317cdf@rasmusvillemoes.dk>
Date:   Fri, 2 Jul 2021 15:17:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d1473b12-daea-e5e8-b8d5-64084bfbe11c@microchip.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2021 08.46, Tudor.Ambarus@microchip.com wrote:
> Hi,
> 
> On 6/22/21 11:58 PM, Rasmus Villemoes wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 22/06/2021 13.57, Michael Walle wrote:
>>> [+ some people from MXIC as they are ones who posted to the ML
>>> lately. Feel free to forward this mail to the corresponding people.]
>>>
>>> Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
>>>> Macronix engineers, in their infinite wisdom, have a habit of reusing
>>>> JEDEC ids for different chips. There's already one
>>>> workaround (MX25L25635F v MX25L25635E), but the same problem exists
>>>> for MX25L3205D v MX25L3233F, the latter of which is not currently
>>>> supported by linux.
>>>>
>>>> AFAICT, that case cannot really be handled with any of the ->fixup
>>>> machinery: The correct entry for the MX25L3233F would read
>>>>
>>>>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
>>>> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
>>>>
>>>> while the existing one is
>>>>
>>>>     { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>>>
>>>> So in spi_nor_init_params(), we won't even try reading the sfdp
>>>> info (i.e. call spi_nor_sfdp_init_params), and hence
>>>> spi_nor_post_sfdp_fixups() has no way of distinguishing the
>>>> chips.
>>>>
>>>> Replacing the existing entry with the mx25l3233f one to coerce the
>>>> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
>>>> because the data sheet for the mx25l3205d explicitly says not to issue
>>>> any commands not listed ("It is not recommended to adopt any other
>>>> code not in the command definition table, which will potentially enter
>>>> the hidden mode.", whatever that means).
>>>
>>> Maybe we should ask Macronix if it is safe to send the RDSFDP command.
>>> Can anyone from MXIC comment this?
>>
>> Yeah, that would be useful to know, but I don't have any hopes
>> whatsoever of Macronix engineers being able to help sort out the mess
>> they've created by reusing IDs in the first place. They don't seem to
>> understand how that can possibly be a problem.
>>
>> I, and my client, have contacted them on several occasions to ask how
>> we're supposed to deal with that. At one point, the answer was
>> "MX25L3233F support Serial Flash Discoverable Parameters (SFDP) mode,
>> MX25L3205D does not support.", but when I asked the obvious follow-up
>> ("but the MX25L3205D datasheet warns against doing RDSFDP or any other
>> not explicitly allowed command"), I got no response.
>>
>> Another response was
>>
>> "I can only comment on Linux 4.4, as that is the only version that I
>> have supporting material for. Basically we have a patch for MTD/SPI-NOR
>> (see attached). This is to allow allow the MTD subsystem to cope with
>> devices that have the same ID (see below first paragraph of application
>> note attached). Please note that the MX25L3205D had an EOL notification
>> on 14th May 2010."
>>
>> and that attached patch is a 173KB .patch file that made me taste my
>> breakfast again.
>>
>> And they keep repeating the argument that when a chip is EOL, it's OK to
>> reuse its ID (because obviously nobody have used that chip in a product
>> that would receive OS updates, so any OS released later than that EOL
>> date can just include support for the newer chip and drop the old one...).
>>
>>>> In order to support such cases, extend the logic in spi_nor_read_id()
>>>> a little so that if we already have a struct flash_info* from the name
>>>> in device tree, check the JEDEC bytes against that, and if it is a
>>>> match, accept that (device tree compatible + matching JEDEC bytes) is
>>>> stronger than merely matching JEDEC bytes.
>>>
>>> This won't help much without a proper dt schema. No in-tree devicetree
>>> could use is because the DT validation would complain.
>>
>> I can certainly extend the regexp in jedec,spi-nor.yaml to match this
>> new one. DT is supposed to describe the hardware, so I can't see how
>> that could possibly be controversial.
> 
> No, please don't go that path yet.
> 
>>
>>  So if this will
>>> go in (and the maintainers are rather hesitant to add it, I tried
>>> it myself [1]), you'd also need to add it to jedec,spi-nor.yaml and
>>> get an ack from Rob.
> 
> I'm not hesitant, I'm keeping my NACK until we're sure there isn't any other way
> to differentiate at run-time. 

It seems that we have established that by now, right?

Rasmus
