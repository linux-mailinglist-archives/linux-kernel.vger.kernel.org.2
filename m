Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249E33A6A84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhFNPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhFNPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:36:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A4811D4;
        Mon, 14 Jun 2021 08:34:13 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA5A3F70D;
        Mon, 14 Jun 2021 08:34:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Dong Aisheng <dongas86@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
 <20210614083609.GA18701@willie-the-truck>
 <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
 <20210614145105.GC30667@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6f897830-301f-3eb4-785f-de446476e676@arm.com>
Date:   Mon, 14 Jun 2021 16:34:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614145105.GC30667@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 15:51, Catalin Marinas wrote:
> On Mon, Jun 14, 2021 at 06:07:04PM +0800, Dong Aisheng wrote:
>> On Mon, Jun 14, 2021 at 4:36 PM Will Deacon <will@kernel.org> wrote:
>>> On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
>>>> Coherent dma on ARM64 also can't work with mapped system ram,
>>>> that means 'no-map' property must be specified in dts.
>>>> Add the missing check for ARM64 platforms as well.
>>>> Besides 'no-map' checking, 'linux,dma-default' feature is also
>>>> enabled for ARM64 along with this patch.

Note that the "linux,dma-default" stuff is really only for NOMMU (with 
caches), so hardly relevant to arm64.

>>> Please can you explain _why_ it can't work? We don't need to tear down
>>> aliases from the linear map for the streaming DMA API, so why is this
>>> case different? Also, coherent devices wouldn't need this either way,
>>> would they? What problem are you solving here?
>>>
>>
>> Not sure if i get your point correctly. Here is my understanding. (fix
>> me if wrong)
>> In current implementation, the coherent dma memory will be remapped as
>> writecombine and uncached type which can't reuse the linear mapping.
>> The prerequisite to do this is the memory must not be mapped System RAM.
>> e.g. reserved memory with no-map property and invisible to the buddy system.
> 
> The architecture allows the system RAM to be mapped in the linear map
> while there's another writecombine alias, as long as there are no dirty
> cache lines that could be evicted randomly. This works fine with the DMA
> API (and we have some cache maintenance when the non-cacheable mapping
> is first created).
> 
> Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
> ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
> with system RAM regardless of the architecture. If the memory region is
> nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
> warn. But why is this specific only to arm (or arm64)?

Didn't some ARMv7 implementations permit unexpected cache hits for the 
non-cacheable address if the same PA has been speculatively fetched via 
the cacheable alias?

> Is the "shared-dma-pool" property only meant for Normal Non-cacheable
> memory (hence the MEMREMAP_WC flag)? If a system is fully cache
> coherent, does this check still make sense or the DT is not supposed to
> have such nodes?

I don't think "shared-dma-pool" carries any particular expectation 
itself of how things are mapped, especially since "reusable" effectively 
implies a cacheable mapping for 'normal' kernel usage.

Absent "reusable" to take things down the CMA path instead, "no-map" 
would currently be needed for coherent devices, since even when the CPU 
is guaranteed to bypass the cacheable alias the device can still 
inadvertently snoop it and see stale data. However if the device *is* 
coherent then it would seem more sensible to skip the remap entirely and 
just use the linear map address of the pool, unless of course it needs 
to be shared by multiple devices some of which are non-coherent... :/

>> This seems a little different from CMA which the memory is still
>> underlying managed by the buddy system in order to support migration.
>>
>> The patch here does not resolve a real issue but just open the sanity check for
>> ARM64 case as well as ARM  which reports the issue a little bit earlier at
>> rmem_dma_setup() time.
> 
> I think we first need to figure out what the real issue is and then try
> to solve it.

Agreed.

Robin.
