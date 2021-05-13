Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AA37FA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhEMPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbhEMPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEE8261176;
        Thu, 13 May 2021 15:22:00 +0000 (UTC)
Date:   Thu, 13 May 2021 16:21:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v11 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210513152158.GB6801@arm.com>
References: <20210416154309.22129-3-steven.price@arm.com>
 <20210428170705.GB4022@arm.com>
 <c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com>
 <YJGHApOCXl811VK3@arm.com>
 <329286e8-a8f3-ea1a-1802-58813255a4a5@arm.com>
 <20210507182538.GF26528@arm.com>
 <20210510183506.GA10910@arm.com>
 <c891d4eb-b388-1658-8c8a-e76477062463@arm.com>
 <20210512174502.GC12391@arm.com>
 <7c1cb7c8-6ab4-62bd-fa17-2fb7be6d7f09@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1cb7c8-6ab4-62bd-fa17-2fb7be6d7f09@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:57:39AM +0100, Steven Price wrote:
> On 12/05/2021 18:45, Catalin Marinas wrote:
> > On Wed, May 12, 2021 at 04:46:48PM +0100, Steven Price wrote:
> >> On 10/05/2021 19:35, Catalin Marinas wrote:
> >>>> On Thu, May 06, 2021 at 05:15:25PM +0100, Steven Price wrote:
> >>>>>> On Thu, Apr 29, 2021 at 05:06:41PM +0100, Steven Price wrote:
> >>>>>>> Given the changes to set_pte_at() which means that tags are restored from
> >>>>>>> swap even if !PROT_MTE, the only race I can see remaining is the creation of
> >>>>>>> new PROT_MTE mappings. As you mention an attempt to change mappings in the
> >>>>>>> VMM memory space should involve a mmu notifier call which I think serialises
> >>>>>>> this. So the remaining issue is doing this in a separate address space.
> >>>>>>>
> >>>>>>> So I guess the potential problem is:
> >>>>>>>
> >>>>>>>    * allocate memory MAP_SHARED but !PROT_MTE
> >>>>>>>    * fork()
> >>>>>>>    * VM causes a fault in parent address space
> >>>>>>>    * child does a mprotect(PROT_MTE)
> >>>>>>>
> >>>>>>> With the last two potentially racing. Sadly I can't see a good way of
> >>>>>>> handling that.
> > [...]
> >>> Options:
> >>>
> >>> 1. Change the mte_sync_tags() code path to set the flag after clearing
> >>>     and avoid reading stale tags. We document that mprotect() on
> >>>     MAP_SHARED may lead to tag loss. Maybe we can intercept this in the
> >>>     arch code and return an error.
> >>
> >> This is the best option I've come up with so far - but it's not a good
> >> one! We can replace the set_bit() with a test_and_set_bit() to catch the
> >> race after it has occurred - but I'm not sure what we can do about it
> >> then (we've already wiped the data). Returning an error doesn't seem
> >> particularly useful at that point, a message in dmesg is about the best
> >> I can come up with.
> > 
> > What I meant about intercepting is on something like
> > arch_validate_flags() to prevent VM_SHARED and VM_MTE together but only
> > for mprotect(), not mmap(). However, arch_validate_flags() is currently
> > called on both mmap() and mprotect() paths.
> 
> I think even if we were to restrict mprotect() there would be corner
> cases around swapping in. For example if a page mapped VM_SHARED|VM_MTE
> is faulted simultaneously in both processes then we have the same situation:
> 
>  * with test_and_set_bit() one process could potentially see the tags
> before they have been restored - i.e. a data leak.
> 
>  * with separated test and set then one process could write to the tags
> before the second restore has completed causing a lost update.

I don't think this can happen. We have shmem_swapin_page() which I think
would be called on any faulting pte that was sharing such page. It takes
the page lock around arch_swap_restore().

-- 
Catalin
