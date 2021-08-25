Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562093F727B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhHYKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbhHYKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:01:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:00:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso3881098wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=t1Fxyis5VyGmJ28Q6mHHWuWqL/LfgK4tUw1UlmoXIy4=;
        b=N5KuOH68gGgamALSiXAw9kpRRby+Lo7oec2oseaOCeZD17MuGC7V/2taZQqmhnRrrw
         llWa01fwlfzXt2LvD2u6iM88oLcXN7KdEXYiWqFVBSdPwCXGg+npZDPL7LGN8uu0/BsL
         IKteQNg2ZoACgemT2X7DYthtTxs6ZM0RI3k8/M4JzNaeMklGbKqkRdio3CepznulmMU/
         tKIaIAjwBaRY9E4toUvZzBWb6F4G7AcacllOwFah8pWqa9AKGVmGtG4Yi8Wm502v3CAo
         muY11dljK0DZ6LtlV+egTQJa623Vgv4GbK68v0lQEQQCJ7C4uhOlLvUViK95ECS0euI0
         H4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t1Fxyis5VyGmJ28Q6mHHWuWqL/LfgK4tUw1UlmoXIy4=;
        b=fgH9IhyRRXZ9t8IY3e44y6sIlrWawH087soL8YXBjMX0vBPfFNU3wxnrqvVmXSTpKN
         /KYhm3ml+vZDFqBM1NPAlMRGlZRuD7nGwsF40amVJysPyzch5uTv2lt4GcJ/UoPGeC3F
         PjL9tbJ+juEYKmf66osVJ8ILMOEEurbKgCQcWkYTgXYmIdSaUg7V8ql4lMU8ATeFm7Xj
         suQ6L0a9u1f+zdoAoP4/BV3sbd4OUaH/HIWUHhGVPm/liZkusjzyWy79eDHGWCTfpiZZ
         cxWuK0BXJmXAdKJ+xPs0KZ3C1CCbnFJ9clLUNWSoH+AEhLrF9sj14Y1CygWGRtX2zv26
         Oemg==
X-Gm-Message-State: AOAM5337da03JrqK/XTGRDRHqtwUtjEgzD0ADNhI4TH+UIIRnOrYBtWX
        sI+0vVNlozUhrQs9UmAxWQ==
X-Google-Smtp-Source: ABdhPJyK5pTAs+6faoY0ktiJjBdAA1GjMHLL4vMzg4mwYCD8skOjQ301m9pKh5f5wND2KvyHDP7ilg==
X-Received: by 2002:a1c:1bce:: with SMTP id b197mr8108729wmb.43.1629885653723;
        Wed, 25 Aug 2021 03:00:53 -0700 (PDT)
Received: from [192.168.200.23] (ip5b434083.dynamic.kabel-deutschland.de. [91.67.64.131])
        by smtp.gmail.com with ESMTPSA id f20sm657674wmb.32.2021.08.25.03.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:00:53 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
 <b37fc109-06d3-0c86-a3c8-e5d7f21f296b@gmail.com>
 <YSXJZBKeka5U7VN+@kernel.org>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <3bc0c465-475d-78e8-b742-ef093ebaf47c@gmail.com>
Date:   Wed, 25 Aug 2021 12:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSXJZBKeka5U7VN+@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 25.08.21 um 06:39 schrieb Mike Rapoport:
> On Tue, Aug 24, 2021 at 10:14:01PM +0200, Alex Bee wrote:
>> Hi Mike,
>>
>> thanks for your reply
>>
>> Am 24.08.21 um 20:28 schrieb Mike Rapoport:
>>> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>>>> Hi Alex,
>>>>
>>>> Thanks for the report.
>>>>
>>>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>>>
>>>>> [    8.921909] ------------[ cut here ]------------
>>>>> [    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>>>> [    8.921973] Modules linked in: spi_rockchip(+) fuse
>>>>> [    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>>>> [    8.922004] Hardware name: Pine64 Rock64 (DT)
>>>>> [    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>>> [    8.922018] pc : dma_map_resource+0x68/0xc0
>>>>> [    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>>>>> [    8.922040] sp : ffff800012102ae0
>>>>> [    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>>>> [    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>>>> [    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>>>> [    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>>>> [    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>> [    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>>>> [    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>>>> [    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>>>> [    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>>>> [    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>>>> [    8.922158] Call trace:
>>>>> [    8.922163]  dma_map_resource+0x68/0xc0
>>>>> [    8.922173]  pl330_prep_slave_sg+0x58/0x220
>>>>> [    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>>>> [    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>>>> [...]
>>>>> Note: This does not relate to the spi driver - when disabling this device in
>>>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>>>> Commenting out the failing check at [1], however, helps and the mapping
>>>>> works again.
>>>> Do you know which address dma_map_resource() is trying to map (maybe
>>>> add some printk())? It's not supposed to map RAM, hence the warning.
>>>> Random guess, the address is 0xff190800 (based on the x1 above but the
>>>> regs might as well be mangled).
>>> 0xff190800 will cause this warning for sure. It has a memory map, but it is
>>> not RAM so old version of pfn_valid() would return 0 and the new one
>>> returns 1.
>>>>> I tried to follow the recent changes for arm64 mm which could relate to the
>>>>> check failing at [1] and reverting
>>>>>     commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>>>>> helps and makes it work again, but I'm 100% uncertain if that commit is
>>>>> really the culprit.
>>>>>
>>>>> Note, that the firmware (legacy u-boot) injects memory configuration in the
>>>>> device tree as follows:
>>>>>
>>>>> /memreserve/    0x00000000fcefc000 0x000000000000d000;
>>>>> / {
>>>>> ..
>>>>>       compatible = "pine64,rock64\0rockchip,rk3328";
>>>>> ..
>>>>>       memory {
>>>>>           reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
>>>>>           device_type = "memory";
>>>>>       };
>>>>>
>>>>> ..
>>>>> }
>>>> Either pfn_valid() gets confused in 5.14 or something is wrong with the
>>>> DT. I have a suspicion it's the former since reverting the above commit
>>>> makes it disappear.
>>> I think pfn_valid() actually behaves as expected but the caller is wrong
>>> because pfn_valid != RAM (this applies btw to !arm64 as well).
>>>
>>> 	/* Don't allow RAM to be mapped */
>>> 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>>> 		return DMA_MAPPING_ERROR;
>>>
>>> Alex, can you please try this patch:
>>>
>>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>>> index 2b06a809d0b9..4715e9641a29 100644
>>> --- a/kernel/dma/mapping.c
>>> +++ b/kernel/dma/mapping.c
>>> @@ -232,7 +232,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>>>    		return DMA_MAPPING_ERROR;
>>>    	/* Don't allow RAM to be mapped */
>>> -	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>>> +	if (WARN_ON_ONCE(!memblock_is_memory(phys_addr)))
>>>    		return DMA_MAPPING_ERROR;
>>>    	if (dma_map_direct(dev, ops))
>> Nope, doesn't help:
>>
>> [    8.353879] dma_map_resource Failed to map address 0xff190800
>> [    8.353886] dma_map_resource pfn_valid(PHYS_PFN(0xff190800)): 1
>> [    8.353892] dma_map_resource memblock_is_memory(0xff190800): 0
>>
>> If understand the comment for that check correct, that we _don't_ want RAM
>> to be mapped - shoudn't that be:
>>
>> +	if (WARN_ON_ONCE(memblock_is_memory(phys_addr)))
>>
>> ?
> Right, we don't want RAM to be mapped, the negation was wrong and it should
> be
>
> 	if (WARN_ON_ONCE(memblock_is_memory(phys_addr)))
>   

OK, great: that helps with no other complaints - at least on this 
(arm64) SoC.

Since this affects all other archs, I doubt this will be in 5.14 - but 
it would be great if there could be fix for that in 5.14 since at system 
breaking bug. I'm not sure why it wasn't reported yet - is there any 
chance that at least

   commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")

can be reverted in 5.14?

Alex

