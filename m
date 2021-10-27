Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01F43CF93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhJ0RVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:21:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243231AbhJ0RV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:21:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40864ED1;
        Wed, 27 Oct 2021 10:19:02 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB533F70D;
        Wed, 27 Oct 2021 10:19:00 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
 <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
Date:   Wed, 27 Oct 2021 18:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 5:45 pm, Paul Menzel wrote:
> Dear Robin,
> 
> 
> On 25.10.21 18:01, Robin Murphy wrote:
>> On 2021-10-25 12:23, Christian König wrote:
> 
>>> not sure how the IOMMU gives out addresses, but the printed ones look 
>>> suspicious to me. Something like we are using an invalid address like 
>>> -1 or similar.
>>
>> FWIW those look like believable DMA addresses to me, assuming that the 
>> DMA mapping APIs are being backed iommu_dma_ops and the device has a 
>> 40-bit DMA mask, since the IOVA allocator works top-down.
>>
>> Likely causes are either a race where the dma_unmap_*() call happens 
>> before the hardware has really stopped accessing the relevant 
>> addresses, or the device's DMA mask has been set larger than it should 
>> be, and thus the upper bits have been truncated in the round-trip 
>> through the hardware.
>>
>> Given the addresses involved, my suspicions would initially lean 
>> towards the latter case - the faults are in the very topmost pages 
>> which imply they're the first things mapped in that range. The other 
>> contributing factor being the trick that the IOVA allocator plays for 
>> PCI devices, where it tries to prefer 32-bit addresses. Thus you're 
>> only likely to see this happen once you already have ~3.5-4GB of live 
>> DMA-mapped memory to exhaust the 32-bit IOVA space (minus some 
>> reserved areas) and start allocating from the full DMA mask. You 
>> should be able to check that with a 5.13 or newer kernel by booting 
>> with "iommu.forcedac=1" and seeing if it breaks immediately 
>> (unfortunately with an older kernel you'd have to manually hack 
>> iommu_dma_alloc_iova() to the same effect).
> 
> I booted Linux 5.15-rc7 with `iommu.forcedac=1` and the system booted, 
> and I could log in remotely over SSH. Please find the Linux kernel 
> messages attached. (The system logs say lightdm failed to start, but it 
> might be some other issue due to a change in the operating system.)

OK, that looks like it's made the GPU blow up straight away, which is 
what I was hoping for (and also appears to reveal another bug where it's 
not handling probe failure very well - possibly trying to remove a 
non-existent audio device?). Lightdm presumably fails to start because 
it doesn't find any display devices, since amdgpu failed to probe.

If you can boot the same kernel without "iommu.forcedac" and get a 
successful probe and working display, that will imply that it is 
managing to work OK with 32-bit DMA addresses, at which point I'd have 
to leave it to Christian and Alex to figure out exactly where DMA 
addresses are getting mangled. The only thing that stands out to me is 
the reference to "gfx_v6_0", which makes me wonder whether it's related 
to gmc_v6_0_sw_init() where a 44-bit DMA mask gets set. If so, that 
would suggest that either this particular model of GPU is more limited 
than expected, or that SoC only has 40 bits of address wired up between 
the PCI host bridge and the IOMMU.

Cheers,
Robin.
