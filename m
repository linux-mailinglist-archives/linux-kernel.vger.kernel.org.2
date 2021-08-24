Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B73F6A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhHXUOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhHXUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:14:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5217C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:14:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so16466711wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wkAZmoc+zV9Oaok23kSwGMmh0db7JSUVeM2+ROd3syg=;
        b=ikmhZVza7ykOvV0hJTp8LyLD5gB8e2Og3cVaib2EIPoUeSNoaqp0DZJpCrQy+CJmt7
         3enmuS/P+d7LfwIfsjKo0RRZ/v8AOx0ZsLI1+mv9AYUaNBl8Kdcu6zvax6KS/PtuO3Dp
         YlxWbqAoq+6Om1ItswPxMmWzG/ubzTmkFA8LTL9EBfJ7+fBMy9es8n10wAmPOB9sHDM4
         tTEQbDVQ1TBV4XzVa8pw0fD3WU+Eg3C/k03flYID0r6jinc2IkiW/GQwGROhftY4eoLS
         La6Jm84IlItb86uHMGe2BEK+ssLWJ59mnOSIPISXc2HeaVIABB08GueVhT8fhQUfb94o
         ae/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wkAZmoc+zV9Oaok23kSwGMmh0db7JSUVeM2+ROd3syg=;
        b=rA+ubFsOQlin6IR4aA6Ki1HXmlwpA4TtR9/SLsqcNU/DSuCEYL03Zp8ClIPeYzhV/J
         Fe8636beP21CmU68NvIkJ2kaZ34YZ9RKc6Ql9kLgBH/a/Fud+kCB9XsFs+Mp9Z9SrHsN
         8iMOovp7BOgX1VNGz+Zzdb4KAt4z2rBZYVAr44uu777xr5bZ18yxK4CoVaScfyDnmrxa
         c1djgUhlWTCFZI/Jj3AiOEpBFT/j0D5TFwLhy9Bk0xc+D1z6gUWj7bGd1UcHQbHWPYkC
         Jyf9kAzWjKjbrbtYjKaEfuVMilLcijAAPUP+RDKaHHF7Pt1fgQGHqDvhRy40637WYEaa
         RnGw==
X-Gm-Message-State: AOAM5332l8sTl5Xo26iEVU2L5b0YCeFBaiiorSOytniuIKKZaXlY3Mco
        UTGbMYzNWr5V7UPX9WeLXQ==
X-Google-Smtp-Source: ABdhPJyVYvyYPiXcnQc3VTSF6kCktfMU8iLC1IK7JKxQNLuRQMGoZgx5mJQyLINb7OdCbzATY5vEOA==
X-Received: by 2002:a5d:4605:: with SMTP id t5mr20716776wrq.276.1629836042306;
        Tue, 24 Aug 2021 13:14:02 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:65a1:1952:1d23:2e04? ([2a02:810b:f40:4200:65a1:1952:1d23:2e04])
        by smtp.gmail.com with ESMTPSA id f20sm3147445wml.38.2021.08.24.13.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 13:14:01 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <b37fc109-06d3-0c86-a3c8-e5d7f21f296b@gmail.com>
Date:   Tue, 24 Aug 2021 22:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSU6NVZ3j0XCurWC@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

thanks for your reply

Am 24.08.21 um 20:28 schrieb Mike Rapoport:
> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>> Hi Alex,
>>
>> Thanks for the report.
>>
>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>
>>> [    8.921909] ------------[ cut here ]------------
>>> [    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>> [    8.921973] Modules linked in: spi_rockchip(+) fuse
>>> [    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>> [    8.922004] Hardware name: Pine64 Rock64 (DT)
>>> [    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>> [    8.922018] pc : dma_map_resource+0x68/0xc0
>>> [    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>>> [    8.922040] sp : ffff800012102ae0
>>> [    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>> [    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>> [    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>> [    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>> [    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> [    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>> [    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>> [    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>> [    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>> [    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>> [    8.922158] Call trace:
>>> [    8.922163]  dma_map_resource+0x68/0xc0
>>> [    8.922173]  pl330_prep_slave_sg+0x58/0x220
>>> [    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>> [    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>> [...]
>>> Note: This does not relate to the spi driver - when disabling this device in
>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>> Commenting out the failing check at [1], however, helps and the mapping
>>> works again.
>> Do you know which address dma_map_resource() is trying to map (maybe
>> add some printk())? It's not supposed to map RAM, hence the warning.
>> Random guess, the address is 0xff190800 (based on the x1 above but the
>> regs might as well be mangled).
> 0xff190800 will cause this warning for sure. It has a memory map, but it is
> not RAM so old version of pfn_valid() would return 0 and the new one
> returns 1.
>   
>>> I tried to follow the recent changes for arm64 mm which could relate to the
>>> check failing at [1] and reverting
>>>    commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>>> helps and makes it work again, but I'm 100% uncertain if that commit is
>>> really the culprit.
>>>
>>> Note, that the firmware (legacy u-boot) injects memory configuration in the
>>> device tree as follows:
>>>
>>> /memreserve/    0x00000000fcefc000 0x000000000000d000;
>>> / {
>>> ..
>>>      compatible = "pine64,rock64\0rockchip,rk3328";
>>> ..
>>>      memory {
>>>          reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
>>>          device_type = "memory";
>>>      };
>>>
>>> ..
>>> }
>> Either pfn_valid() gets confused in 5.14 or something is wrong with the
>> DT. I have a suspicion it's the former since reverting the above commit
>> makes it disappear.
> I think pfn_valid() actually behaves as expected but the caller is wrong
> because pfn_valid != RAM (this applies btw to !arm64 as well).
>
> 	/* Don't allow RAM to be mapped */
> 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> 		return DMA_MAPPING_ERROR;
>
> Alex, can you please try this patch:
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 2b06a809d0b9..4715e9641a29 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -232,7 +232,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   		return DMA_MAPPING_ERROR;
>   
>   	/* Don't allow RAM to be mapped */
> -	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> +	if (WARN_ON_ONCE(!memblock_is_memory(phys_addr)))
>   		return DMA_MAPPING_ERROR;
>   
>   	if (dma_map_direct(dev, ops))
>   

Nope, doesn't help:

[    8.353879] dma_map_resource Failed to map address 0xff190800
[    8.353886] dma_map_resource pfn_valid(PHYS_PFN(0xff190800)): 1
[    8.353892] dma_map_resource memblock_is_memory(0xff190800): 0

If understand the comment for that check correct, that we _don't_ want 
RAM to be mapped - shoudn't that be:

+	if (WARN_ON_ONCE(memblock_is_memory(phys_addr)))

?

Alex

>>> So: there is a "hole" in the mappable memory and reading the commit message
>>> of
>>>    commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify
>>> pfn_valid()")
>>> suggests, there was a change for that case recently.
>> I think the change from the arm64 pfn_valid() to the generic one is
>> avoiding the call to memblock_is_memory(). I wonder whether pfn_valid()
>> returns true just because we have a struct page available but the memory
>> may have been reserved.
>>
>> Cc'ing Mike R.
>>
>>> I also noticed there is a diff in the kernel log regarding memory init up
>>> until 5.13.12 it says
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   empty
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000] On node 0 totalpages: 1043968
>>> [    0.000000]   DMA zone: 16312 pages used for memmap
>>> [    0.000000]   DMA zone: 0 pages reserved
>>> [    0.000000]   DMA zone: 1043968 pages, LIFO batch:63
>>>
>>> In contrary in 5.14-rc7 it says:
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   empty
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>>> [    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>>>
>>> (note the "unavailable ranges")
>>> I'm uncertain again here, if that diff is expected behavior because of those
>>> recent mm changes for arm64.
>>>
>>> After reverting
>>>    commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>>> the log changes to
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   empty
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [    0.000000] Initmem setup node 0 [mem
>>> 0x0000000000200000-0x00000000feffffff]
>>>
>>> (no DMA zones here)
>>>
>>> As you might have noticed I have _zero_ clue about memory mapping and dma
>>> subsystem - so let me know if there is any more information needed for that
>>> and thanks for your help.
>> Adding Robin as well, he has a better clue than us on DMA ;).
>>
>>> Alex
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235
>> -- 
>> Catalin
