Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24643F7429
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhHYLN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236784AbhHYLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629889960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlZrdwxyxNGVrCxVZHW8/Pp6CcGFK5pPfiHHHiWvgYs=;
        b=Mxg/VdKwcUtXCnWKz3B/0y/m2OSIWiTt8VlK2Lm5vZs/nVXrFWUJA6zo6HjZudD7BNxuiI
        ow5s5cmW0T8FlHTpa5Ee4KAAH60jvQZBnLKC1ZTLx7GVJfAqlinI0t9nqpHeJvZ8Ag3ygc
        qKcI1O4bVa+zNjlE9/x2k5Q55oy+lgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-FDXCLHWSOSKGA9MgOpnNRg-1; Wed, 25 Aug 2021 07:12:39 -0400
X-MC-Unique: FDXCLHWSOSKGA9MgOpnNRg-1
Received: by mail-wm1-f70.google.com with SMTP id j33-20020a05600c48a100b002e879427915so1676402wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mlZrdwxyxNGVrCxVZHW8/Pp6CcGFK5pPfiHHHiWvgYs=;
        b=bd9uM9FDJ9D219FwJYZdtRwSDEZglnK6Uu8hdJXi0ItrLxZbqFjVPjVIVm8Ov7mAmt
         F+NVcT5sZ+3mfRR6TqXhMxkyTnN48MaimxzVL4L11fTxlj1gGM986bdel3l8mBiGuNUr
         5ZMufF1WEjgZ6TrmQ6SDNIwbu/SSoUvvG4nRIlGVrgwgjLGaag+YHqLD2TAyYDMvCTFi
         yR+OHo8USlmfwPKkuISFnJmgIBYFgIeSaXojGVDbz7l0wCdh0cSLcIsl8Qhu3RvUgkG0
         6Kw3QcJ1Otw8zEKgK2BYd3ONyefUHpVCkNDVbsJUuXbZC7M37DPvv2R9J7MsypoF2g+h
         pTcg==
X-Gm-Message-State: AOAM530KYp2KofCJgooY78/sQKWLW7adPw06zBF9qZe4UCuFwK2yZLhN
        mjWDNw+fEZHZRTbVg0yrrSkkexyaAkF0dIPXguTtjYCYpXvCYyIAvbTK/cR4kZVzLlMwf0QnxXo
        N/nf7/CYyETNuSf6abfwf/EJF
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr8673061wme.77.1629889958425;
        Wed, 25 Aug 2021 04:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPYsoqyixurCYV2/i4Ak4XtssI6+XlDP4VkKl4oAoJCywccuN7PduZAQrM/yipMWB60N8Lrw==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr8673042wme.77.1629889958223;
        Wed, 25 Aug 2021 04:12:38 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id b12sm25073911wrx.72.2021.08.25.04.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 04:12:37 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
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
 <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
 <20210825105510.GB3420@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <547785ff-e02f-df28-7f9c-9ad4f5b3cc77@redhat.com>
Date:   Wed, 25 Aug 2021 13:12:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825105510.GB3420@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.21 12:55, Catalin Marinas wrote:
> On Wed, Aug 25, 2021 at 12:38:31PM +0200, David Hildenbrand wrote:
>> On 25.08.21 12:20, Catalin Marinas wrote:
>>> On Tue, Aug 24, 2021 at 08:59:22PM +0200, David Hildenbrand wrote:
>>>> On 24.08.21 20:46, Robin Murphy wrote:
>>>>> On 2021-08-24 19:28, Mike Rapoport wrote:
>>>>>> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>>>>>>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>>>>>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>>>>>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>>>>>>
>>>>>>>>    ------------[ cut here ]------------
>>>>>>>>    WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>>>>>>>    Modules linked in: spi_rockchip(+) fuse
>>>>>>>>    CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>>>>>>>    Hardware name: Pine64 Rock64 (DT)
>>>>>>>>    pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>>>>>>    pc : dma_map_resource+0x68/0xc0
>>>>>>>>    lr : pl330_prep_slave_fifo+0x78/0xd0
>>>>>>>>    sp : ffff800012102ae0
>>>>>>>>    x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>>>>>>>    x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>>>>>>>    x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>>>>>>>    x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>>>>>>>    x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>>>>>    x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>>>>>>>    x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>>>>>>>    x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>>>>>>>    x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>>>>>>>    x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>>>>>>>    Call trace:
>>>>>>>>      dma_map_resource+0x68/0xc0
>>>>>>>>      pl330_prep_slave_sg+0x58/0x220
>>>>>>>>      rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>>>>>>>      rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>>>>>>> [...]
>>>>>>>> Note: This does not relate to the spi driver - when disabling this device in
>>>>>>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>>>>>>> Commenting out the failing check at [1], however, helps and the mapping
>>>>>>>> works again.
>>>>>>
>>>>>>> Do you know which address dma_map_resource() is trying to map (maybe
>>>>>>> add some printk())? It's not supposed to map RAM, hence the warning.
>>>>>>> Random guess, the address is 0xff190800 (based on the x1 above but the
>>>>>>> regs might as well be mangled).
>>>>>>
>>>>>> 0xff190800 will cause this warning for sure. It has a memory map, but it is
>>>>>> not RAM so old version of pfn_valid() would return 0 and the new one
>>>>>> returns 1.
>>>>>
>>>>> How does that happen, though? It's not a memory address, and it's not
>>>>> even within the bounds of anywhere there should or could be memory. This
>>>>> SoC has a simple memory map - everything from 0 to 0xfeffffff goes to
>>>>> the DRAM controller (which may not all be populated, and may have pieces
>>>>> carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. Why
>>>>> do we have pages (or at least the assumption of pages) for somewhere
>>>>> which by all rights should not have them?
>>>>
>>>> Simple: we allocate the vmemmap for whole sections (e.g., 128 MiB) to avoid
>>>> any such hacks. If there is a memory hole, it gets a memmap as well.
>>>>
>>>> Tricking pfn_valid() into returning "false" where we actually have a memmap
>>>> only makes it look like there is no memmap; but there is one, and
>>>> it's PG_reserved.
>>>
>>> I can see the documentation for pfn_valid() does not claim anything more
>>> than the presence of an memmap entry. But I wonder whether the confusion
>>> is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
>>> assumes __va() can be used on pfn_valid(), though I suspect it relies on
>>> the calling function to check that the resource was RAM. The arm64
>>> kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
>>> standard memcpy on it, which wouldn't work for I/O (should we change
>>> this check to pfn_is_map_memory() for arm64?).
>>
>> kern_addr_valid() checks that there is a direct map entry, and that the
>> mapped address has a valid mmap. (copied from x86-64)
> 
> It checks that there is a va->pa mapping, not necessarily in the linear
> map as it walks the page tables. So for some I/O range that happens to
> be mapped but which was in close proximity to RAM so that pfn_valid() is
> true, kern_addr_valid() would return true. I don't thin that was the
> intention.
> 
>> Would you expect to have a direct map for memory holes and similar (IOW,
>> !System RAM)?
> 
> No, but we with the generic pfn_valid(), it may return true for mapped
> MMIO (with different attributes than the direct map).

Ah, right. But can we actually run into that via kcore?

kcore builds the RAM list via walk_system_ram_range(), IOW the resource 
tree. And we end up calling kern_addr_valid() only on KCORE_RAM, 
KCORE_VMEMMAP and KCORE_TEXT.

Not saying that kern_addr_valid() shouldn't be improved.

-- 
Thanks,

David / dhildenb

