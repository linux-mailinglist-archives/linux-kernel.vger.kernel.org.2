Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EE3F7370
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhHYKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237638AbhHYKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629887915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPhLQzFs1IrHbkV/9CrSlj9c2Z4dRyx+Gb5Xtw/oGVE=;
        b=AZkF9MDPv4/qxwsfeacgnk/u/Oetx7ECP0CR/1lDZd7xYQLg51exHikeYL+mDG6cEGauNr
        BaveUlpXTpING8InthIdttM99EREuWfOmjyVFK//YPAVFMcuJHfvKJa2Z6N0oY7fxbU0PR
        iAgEvvbIPS/Z7nAnfShXCZD+5SfvD08=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-Dbki1Cq8MCipX9ngMYgKUQ-1; Wed, 25 Aug 2021 06:38:34 -0400
X-MC-Unique: Dbki1Cq8MCipX9ngMYgKUQ-1
Received: by mail-wr1-f72.google.com with SMTP id b8-20020a5d5508000000b001574e8e9237so2564906wrv.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hPhLQzFs1IrHbkV/9CrSlj9c2Z4dRyx+Gb5Xtw/oGVE=;
        b=uJixCBaIvCizYLDBwLWzODlGykd9OZ2lv/zAfHBo+/OExYcJ/P/5wLAwmC6Hqv3p71
         inXLO6yuKFKrdUFTWh2z55zFGS19XgS0E/5j7ifHu2uAeJGKLhxKOdJtT0orIuXnIwYK
         Z/sTOEqNInsbb6YyemQi6yCeT9d0mYVaeY095F0absg3vyLjV8E+o6pcPYGe8PwBzyTO
         eTK8QVJINi7Q7NUZl0xhH9JrkhzYBi610eaPNC+P9POaaewYdKpQGTuZN9fUhhzeYueI
         r3ZDR0RWLce3DLaESIMbiIuCTCa00CoCCJEJ9Ztp2lSb5E+XheULqcKCECGjHTuTnL+c
         Y8vA==
X-Gm-Message-State: AOAM532ilkYgAFyAhDHhIzm9gzSSLcKcqI9eT6oDSjw7VTYAsVYHAW7x
        /8zdjNP1yxsBIMP8a+OihAA0TE/IkIALvw0CDbiyDR3jf1K/tXmbZyYmLOYZSAILCbu1YXsP6r9
        i4z7UDSw5qI5XBkE/O4urbWvn
X-Received: by 2002:a5d:6108:: with SMTP id v8mr24181212wrt.96.1629887912981;
        Wed, 25 Aug 2021 03:38:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGNOFKS+R2HIyOFowqXEX/I3jbojh7R9LnbeYwTVlgB8OSRLh2dCFN9VvnwzOlVy2nSxv7/A==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr24181191wrt.96.1629887912721;
        Wed, 25 Aug 2021 03:38:32 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id 129sm4989801wmz.26.2021.08.25.03.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:38:32 -0700 (PDT)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
Date:   Wed, 25 Aug 2021 12:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825102044.GA3420@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.21 12:20, Catalin Marinas wrote:
> + hch
> 
> On Tue, Aug 24, 2021 at 08:59:22PM +0200, David Hildenbrand wrote:
>> On 24.08.21 20:46, Robin Murphy wrote:
>>> On 2021-08-24 19:28, Mike Rapoport wrote:
>>>> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>>>>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>>>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>>>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>>>>
>>>>>>   ------------[ cut here ]------------
>>>>>>   WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>>>>>   Modules linked in: spi_rockchip(+) fuse
>>>>>>   CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>>>>>   Hardware name: Pine64 Rock64 (DT)
>>>>>>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>>>>   pc : dma_map_resource+0x68/0xc0
>>>>>>   lr : pl330_prep_slave_fifo+0x78/0xd0
>>>>>>   sp : ffff800012102ae0
>>>>>>   x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>>>>>   x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>>>>>   x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>>>>>   x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>>>>>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>>>   x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>>>>>   x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>>>>>   x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>>>>>   x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>>>>>   x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>>>>>   Call trace:
>>>>>>     dma_map_resource+0x68/0xc0
>>>>>>     pl330_prep_slave_sg+0x58/0x220
>>>>>>     rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>>>>>     rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>>>>> [...]
>>>>>> Note: This does not relate to the spi driver - when disabling this device in
>>>>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>>>>> Commenting out the failing check at [1], however, helps and the mapping
>>>>>> works again.
>>>>
>>>>> Do you know which address dma_map_resource() is trying to map (maybe
>>>>> add some printk())? It's not supposed to map RAM, hence the warning.
>>>>> Random guess, the address is 0xff190800 (based on the x1 above but the
>>>>> regs might as well be mangled).
>>>>
>>>> 0xff190800 will cause this warning for sure. It has a memory map, but it is
>>>> not RAM so old version of pfn_valid() would return 0 and the new one
>>>> returns 1.
>>>
>>> How does that happen, though? It's not a memory address, and it's not
>>> even within the bounds of anywhere there should or could be memory. This
>>> SoC has a simple memory map - everything from 0 to 0xfeffffff goes to
>>> the DRAM controller (which may not all be populated, and may have pieces
>>> carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. Why
>>> do we have pages (or at least the assumption of pages) for somewhere
>>> which by all rights should not have them?
>>
>> Simple: we allocate the vmemmap for whole sections (e.g., 128 MiB) to avoid
>> any such hacks. If there is a memory hole, it gets a memmap as well.
>>
>> Tricking pfn_valid() into returning "false" where we actually have a memmap
>> only makes it look like there is no memmap; but there is one, and
>> it's PG_reserved.
> 
> I can see the documentation for pfn_valid() does not claim anything more
> than the presence of an memmap entry. But I wonder whether the confusion
> is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
> assumes __va() can be used on pfn_valid(), though I suspect it relies on
> the calling function to check that the resource was RAM. The arm64
> kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
> standard memcpy on it, which wouldn't work for I/O (should we change
> this check to pfn_is_map_memory() for arm64?).
> 

kern_addr_valid() checks that there is a direct map entry, and that the 
mapped address has a valid mmap. (copied from x86-64)

Would you expect to have a direct map for memory holes and similar (IOW, 
!System RAM)?


>>>>> Either pfn_valid() gets confused in 5.14 or something is wrong with the
>>>>> DT. I have a suspicion it's the former since reverting the above commit
>>>>> makes it disappear.
>>>>
>>>> I think pfn_valid() actually behaves as expected but the caller is wrong
>>>> because pfn_valid != RAM (this applies btw to !arm64 as well).
>>>>
>>>> 	/* Don't allow RAM to be mapped */
>>>> 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>>>> 		return DMA_MAPPING_ERROR;
>>>>
>>>> Alex, can you please try this patch:
>>>
>>> That will certainly paper over the issue, but it's avoiding the question
>>> of what went wrong with the memory map in the first place. The comment
>>> is indeed a bit inaccurate, but ultimately dma_map_resource() exists for
>>> addresses that would be wrong to pass to dma_map_page(), so I believe
>>> pfn_valid() is still the correct check.
>>
>> If we want to check for RAM, pfn_valid() would be wrong. If we want to check
>> for "is there a memmap, for whatever lives or does not live there",
>> pfn_valid() is the right check.
> 
> So what should the DMA code use instead? Last time we needed something
> similar, the recommendation was to use pfn_to_online_page(). Mike is
> suggesting memblock_is_memory().

We use pfn_to_online_page() when we want to know if it's system RAM and 
that the memmap actually contains something sane (-> memmap content has 
a well defined state).

You can have offline memory blocks where pfn_to_online_page() would 
return "false", memblock_is_memory() would return "true". IOW, there is 
a memmap, it's System RAM, but the memmap is stale and not trustworthy.

If you want to make sure no System RAM (online/offline/...) will get 
mapped, memblock_is_memory() should be the right thing to use. I recall 
that x86 traverse the resource tree instead to exclude system ram 
regions similarly.

> 
> Given how later we are in the -rc cycle, I suggest we revert Anshuman's
> commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID") and try to
> assess the implications in 5.15 (the patch doesn't seem to have the
> arm64 maintainers' ack anyway ;)).

-- 
Thanks,

David / dhildenb

