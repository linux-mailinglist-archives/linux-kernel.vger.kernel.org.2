Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FB3586FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhDHOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhDHOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B87866024A;
        Thu,  8 Apr 2021 14:18:57 +0000 (UTC)
Date:   Thu, 8 Apr 2021 15:18:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210408141853.GA7676@arm.com>
References: <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
 <20210331184311.GA10737@arm.com>
 <e2612bd8-b356-a9cd-cfdf-26f4aa813578@arm.com>
 <20210407151458.GC21451@arm.com>
 <5e5bf772-1e4d-ca59-a9d8-058a72dfad4f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5bf772-1e4d-ca59-a9d8-058a72dfad4f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:52:54PM +0100, Steven Price wrote:
> On 07/04/2021 16:14, Catalin Marinas wrote:
> > On Wed, Apr 07, 2021 at 11:20:18AM +0100, Steven Price wrote:
> > > On 31/03/2021 19:43, Catalin Marinas wrote:
> > > > When a slot is added by the VMM, if it asked for MTE in guest (I guess
> > > > that's an opt-in by the VMM, haven't checked the other patches), can we
> > > > reject it if it's is going to be mapped as Normal Cacheable but it is a
> > > > ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
> > > > check for ZONE_DEVICE)? This way we don't need to do more expensive
> > > > checks in set_pte_at().
> > > 
> > > The problem is that KVM allows the VMM to change the memory backing a slot
> > > while the guest is running. This is obviously useful for the likes of
> > > migration, but ultimately means that even if you were to do checks at the
> > > time of slot creation, you would need to repeat the checks at set_pte_at()
> > > time to ensure a mischievous VMM didn't swap the page for a problematic one.
> > 
> > Does changing the slot require some KVM API call? Can we intercept it
> > and do the checks there?
> 
> As David has already replied - KVM uses MMU notifiers, so there's not really
> a good place to intercept this before the fault.
> 
> > Maybe a better alternative for the time being is to add a new
> > kvm_is_zone_device_pfn() and force KVM_PGTABLE_PROT_DEVICE if it returns
> > true _and_ the VMM asked for MTE in guest. We can then only set
> > PG_mte_tagged if !device.
> 
> KVM already has a kvm_is_device_pfn(), and yes I agree restricting the MTE
> checks to only !kvm_is_device_pfn() makes sense (I have the fix in my branch
> locally).

Indeed, you can skip it if kvm_is_device_pfn(). In addition, with MTE,
I'd also mark a pfn as 'device' in user_mem_abort() if
pfn_to_online_page() is NULL as we don't want to map it as Cacheable in
Stage 2. It's unlikely that we'll trip over this path but just in case.

(can we have a ZONE_DEVICE _online_ pfn or by definition they are
considered offline?)

> > BTW, after a page is restored from swap, how long do we keep the
> > metadata around? I think we can delete it as soon as it was restored and
> > PG_mte_tagged was set. Currently it looks like we only do this when the
> > actual page was freed or swapoff. I haven't convinced myself that it's
> > safe to do this for swapoff unless it guarantees that all the ptes
> > sharing a page have been restored.
> 
> My initial thought was to free the metadata immediately. However it turns
> out that the following sequence can happen:
> 
>  1. Swap out a page
>  2. Swap the page in *read only*
>  3. Discard the page
>  4. Swap the page in again
> 
> So there's no writing of the swap data again before (3). This works nicely
> with a swap device because after writing a page it stays there forever, so
> if you know it hasn't been modified it's pointless rewriting it. Sadly it's
> not quite so ideal with the MTE tags which are currently kept in RAM.

I missed this scenario. So we need to keep it around as long as the
corresponding swap storage is still valid.

-- 
Catalin
