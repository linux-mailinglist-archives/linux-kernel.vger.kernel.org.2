Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE293B6EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhF2Hos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhF2Hor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:44:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE289C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 00:42:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a18so15595556lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FReXYEj5Ibwbff/u+KhknD1QWDTjlXsVnChFbqLOhzY=;
        b=JYxocqHRpwAlODdbmKohYKIbIbv71wQb1E1PD3TTEuDq7X6IDLfJhT38RIp2gfV3hJ
         +K9HtXpO1GVXxKvBaYBWotimOv0iH3VVdA6U5z7IMHXT9O36/aTZl8gkoVBuy4aK0+lf
         CogXeLJKTeMX4VnH1KJOgm/Qt949H69ANb//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FReXYEj5Ibwbff/u+KhknD1QWDTjlXsVnChFbqLOhzY=;
        b=p3cn9dOEyUnj6Hdo/kjfgFw1Q0t4F8CX4JMkC2NB2CFtdW+fdu/u2SKuI0F6CSgACf
         EwjC8HNNtONUkaLZpNKoDEPAGX0kYSr8ZyVNAy9WrzCEnAlW21cEOI4HfZH221cB8e5H
         T7UlpunIgVy0WHeMDhBQYnz258wj3B4NCq7oEGY+2BmkzpaH8TcbxmVlxHSCO64C7dRd
         Rpiueb6IAK+SX5TxlPz7Eash4AVpnUqaVmHMgBB/O73Aq+jNKdUVGdhCQY7rBV2D/o4z
         EunCFrOV/aEs6KZf1PhdYdWsLpjp/qzyldSE6T4MIo+3bR6JX1BC+syQKBJRXm+Tirwv
         qrow==
X-Gm-Message-State: AOAM531vT8jSzQe+sX9KOl12qkzmcpZmutAenbZyHZJ70eSiXbyXGwkB
        hdOTZ3D/CIjI3T5RJsNxQHsZPsUrGyT8AZ9n
X-Google-Smtp-Source: ABdhPJx4K79rey9K8oNZe5ijOraDJkthIobaetoIDQkQuUqCbAIcqDNzGnf4fli1hC8Ko7Ft6nZ9Pw==
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr22374104lfv.287.1624952538027;
        Tue, 29 Jun 2021 00:42:18 -0700 (PDT)
Received: from [172.17.20.254] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e20sm1735414ljk.67.2021.06.29.00.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 00:42:17 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuS/oTogUmU6IFtSRkMgMi8zXSBtdGQ6IHNwaS1ub3I6IGNv?=
 =?UTF-8?Q?re=3a_compare_JEDEC_bytes_to_already_found_flash=5finfo?=
To:     Tudor.Ambarus@microchip.com, jaimeliao@mxic.com.tw,
        michael@walle.cc
Cc:     bbrezillon@kernel.org, esben@geanix.com,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        p.yadav@ti.com, ycllin@mxic.com.tw, zhengxunli@mxic.com.tw
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
 <OF7CD5328D.D33B2BE2-ON482586FD.0027BCF2-482586FD.00280249@mxic.com.tw>
 <dcd4e64f-348c-fadd-1044-61c7b6fa93c8@microchip.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1767e220-b76f-a661-b274-7fec3e7dd8b5@rasmusvillemoes.dk>
Date:   Tue, 29 Jun 2021 09:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dcd4e64f-348c-fadd-1044-61c7b6fa93c8@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2021 10.33, Tudor.Ambarus@microchip.com wrote:
> On 6/23/21 10:17 AM, jaimeliao@mxic.com.tw wrote:
>> You don't often get email from jaimeliao@mxic.com.tw. Learn why this is important<http://aka.ms/LearnAboutSenderIdentification>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> Hi Michael and Rasmus
>>
>>
>>>
>>> Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
>>> found flash_info
>>>
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
>>>>    { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
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

> Do any of these flashed define an extended ID, i.e. more that 3 bytes of ID?
> Rasmus, would you please try to read more bytes of ID?
> 

No, neither mx25l3205d nor mx25l3233f do according to their data sheets.

And when actually reading more bytes, one gets as expected just the c2
20 16 repeating all over.

Rasmus
