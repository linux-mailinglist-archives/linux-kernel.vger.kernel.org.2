Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E563F6962
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhHXTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233791AbhHXTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629831566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPwWpNthpZ403/8gfxfxEAu75PwoWMuxmw+b7PTl2R4=;
        b=YzTXyPt3igrn7vyesz0ecmPoZ9/3HxVD6vABDG6MToZa2Bkm2e73NGZMeKLc8U7nRymGgx
        hXYp8f8e3gEVRZJwugd4jKLpTZiuFvc3AxnnNGzs0R1OGKJTt76+MjJ7X0gU5RkYxaZkab
        BJCfr6t+qAoAC47bxxr5nsxP9dPEN5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-OT7HILRqO2e9R-9pHMzIpw-1; Tue, 24 Aug 2021 14:59:25 -0400
X-MC-Unique: OT7HILRqO2e9R-9pHMzIpw-1
Received: by mail-wm1-f70.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so1864883wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jPwWpNthpZ403/8gfxfxEAu75PwoWMuxmw+b7PTl2R4=;
        b=AKHtmiEQSE8Xo5N729d1xMrnAVI1fjIcaCJy7GOpDUBLkjfQG43+AokT+tON7D2Lrq
         cPps84sHjBuZcQ097I06DsZ+QEKNWYFqIXVkaiKNKhguC2gfqNfgEsDJBPpiLFeUyiIL
         FEID7sEjMNTeMFjcyNzWrP7eL1FVhoS49ab6T3DxxZDmCj2B9Vi7ogeDvcv/ijfBMN1C
         Ja8aLCi8M5J4ETZJsbIdTRz3i110h+U8jJnDWsvMII7AH4A5DKFbyyZTib0Jh2pYTu77
         6q+eLCImsnnUjkmq3YhIqv1hjZRSjA3w5jezz540z3jtcyEoRTtGPN6dZmqOA3//xniT
         3E/w==
X-Gm-Message-State: AOAM533EFmmUA1RAOZ5h/LW5eLDgOMESz3mxXzkO8rnQI5wfk8SCAKgQ
        V2+QCst7nbSY96Tle1oDhqZGqw745rLKwscck4SiEwpVw7QMdXoXxhvLisSSAtmDv3oO+X0dHyy
        /6r4fOSra9pRm2Csr1Ify1Jxb
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr10821288wrw.403.1629831563795;
        Tue, 24 Aug 2021 11:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyUUsO3aM/Aw8JKywUQlqQx+NxbxwYJB/N2X7y2N6F418U2YWeqhz0sdmAI60nhne1xFmJKg==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr10821263wrw.403.1629831563543;
        Tue, 24 Aug 2021 11:59:23 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c4d.dip0.t-ipconnect.de. [79.242.60.77])
        by smtp.gmail.com with ESMTPSA id y6sm8969058wrm.54.2021.08.24.11.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:59:23 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
Date:   Tue, 24 Aug 2021 20:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.21 20:46, Robin Murphy wrote:
> On 2021-08-24 19:28, Mike Rapoport wrote:
>> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>>> Hi Alex,
>>>
>>> Thanks for the report.
>>>
>>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>>
>>>> [ï¿½ï¿½ï¿½ 8.921909] ------------[ cut here ]------------
>>>> [ï¿½ï¿½ï¿½ 8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>>> [ï¿½ï¿½ï¿½ 8.921973] Modules linked in: spi_rockchip(+) fuse
>>>> [ï¿½ï¿½ï¿½ 8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>>> [ï¿½ï¿½ï¿½ 8.922004] Hardware name: Pine64 Rock64 (DT)
>>>> [ï¿½ï¿½ï¿½ 8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>> [ï¿½ï¿½ï¿½ 8.922018] pc : dma_map_resource+0x68/0xc0
>>>> [ï¿½ï¿½ï¿½ 8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>>>> [ï¿½ï¿½ï¿½ 8.922040] sp : ffff800012102ae0
>>>> [ï¿½ï¿½ï¿½ 8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>>> [ï¿½ï¿½ï¿½ 8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>>> [ï¿½ï¿½ï¿½ 8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>>> [ï¿½ï¿½ï¿½ 8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>>> [ï¿½ï¿½ï¿½ 8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>> [ï¿½ï¿½ï¿½ 8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>>> [ï¿½ï¿½ï¿½ 8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>>> [ï¿½ï¿½ï¿½ 8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>>> [ï¿½ï¿½ï¿½ 8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>>> [ï¿½ï¿½ï¿½ 8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>>> [ï¿½ï¿½ï¿½ 8.922158] Call trace:
>>>> [ï¿½ï¿½ï¿½ 8.922163]ï¿½ dma_map_resource+0x68/0xc0
>>>> [ï¿½ï¿½ï¿½ 8.922173]ï¿½ pl330_prep_slave_sg+0x58/0x220
>>>> [ï¿½ï¿½ï¿½ 8.922181]ï¿½ rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>>> [ï¿½ï¿½ï¿½ 8.922208]ï¿½ rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>>> [...]
>>>> Note: This does not relate to the spi driver - when disabling this device in
>>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>>> Commenting out the failing check at [1], however, helps and the mapping
>>>> works again.
>>
>>> Do you know which address dma_map_resource() is trying to map (maybe
>>> add some printk())? It's not supposed to map RAM, hence the warning.
>>> Random guess, the address is 0xff190800 (based on the x1 above but the
>>> regs might as well be mangled).
>>
>> 0xff190800 will cause this warning for sure. It has a memory map, but it is
>> not RAM so old version of pfn_valid() would return 0 and the new one
>> returns 1.
> 
> How does that happen, though? It's not a memory address, and it's not
> even within the bounds of anywhere there should or could be memory. This
> SoC has a simple memory map - everything from 0 to 0xfeffffff goes to
> the DRAM controller (which may not all be populated, and may have pieces
> carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. Why
> do we have pages (or at least the assumption of pages) for somewhere
> which by all rights should not have them?

Simple: we allocate the vmemmap for whole sections (e.g., 128 MiB) to 
avoid any such hacks. If there is a memory hole, it gets a memmap as well.

Tricking pfn_valid() into returning "false" where we actually have a 
memmap only makes it look like there is no memmap; but there is one, and
it's PG_reserved.

[...]

>>> Either pfn_valid() gets confused in 5.14 or something is wrong with the
>>> DT. I have a suspicion it's the former since reverting the above commit
>>> makes it disappear.
>>
>> I think pfn_valid() actually behaves as expected but the caller is wrong
>> because pfn_valid != RAM (this applies btw to !arm64 as well).
>>
>> 	/* Don't allow RAM to be mapped */
>> 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>> 		return DMA_MAPPING_ERROR;
>>
>> Alex, can you please try this patch:
> 
> That will certainly paper over the issue, but it's avoiding the question
> of what went wrong with the memory map in the first place. The comment
> is indeed a bit inaccurate, but ultimately dma_map_resource() exists for
> addresses that would be wrong to pass to dma_map_page(), so I believe
> pfn_valid() is still the correct check.

If we want to check for RAM, pfn_valid() would be wrong. If we want to 
check for "is there a memmap, for whatever lives or does not live 
there", pfn_valid() is the right check.


-- 
Thanks,

David / dhildenb

