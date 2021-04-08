Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21A358C17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhDHSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232666AbhDHSVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:21:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B5F561130;
        Thu,  8 Apr 2021 18:21:15 +0000 (UTC)
Date:   Thu, 8 Apr 2021 19:21:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Steven Price <steven.price@arm.com>,
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
Message-ID: <20210408182112.GC7676@arm.com>
References: <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
 <20210331184311.GA10737@arm.com>
 <e2612bd8-b356-a9cd-cfdf-26f4aa813578@arm.com>
 <20210407151458.GC21451@arm.com>
 <5e5bf772-1e4d-ca59-a9d8-058a72dfad4f@arm.com>
 <20210408141853.GA7676@arm.com>
 <bfcd1c41-92fb-d4ee-34b1-7beb6b6c9fd8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcd1c41-92fb-d4ee-34b1-7beb6b6c9fd8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:16:17PM +0200, David Hildenbrand wrote:
> On 08.04.21 16:18, Catalin Marinas wrote:
> > On Wed, Apr 07, 2021 at 04:52:54PM +0100, Steven Price wrote:
> > > On 07/04/2021 16:14, Catalin Marinas wrote:
> > > > On Wed, Apr 07, 2021 at 11:20:18AM +0100, Steven Price wrote:
> > > > > On 31/03/2021 19:43, Catalin Marinas wrote:
> > > > > > When a slot is added by the VMM, if it asked for MTE in guest (I guess
> > > > > > that's an opt-in by the VMM, haven't checked the other patches), can we
> > > > > > reject it if it's is going to be mapped as Normal Cacheable but it is a
> > > > > > ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
> > > > > > check for ZONE_DEVICE)? This way we don't need to do more expensive
> > > > > > checks in set_pte_at().
> > > > > 
> > > > > The problem is that KVM allows the VMM to change the memory backing a slot
> > > > > while the guest is running. This is obviously useful for the likes of
> > > > > migration, but ultimately means that even if you were to do checks at the
> > > > > time of slot creation, you would need to repeat the checks at set_pte_at()
> > > > > time to ensure a mischievous VMM didn't swap the page for a problematic one.
> > > > 
> > > > Does changing the slot require some KVM API call? Can we intercept it
> > > > and do the checks there?
> > > 
> > > As David has already replied - KVM uses MMU notifiers, so there's not really
> > > a good place to intercept this before the fault.
> > > 
> > > > Maybe a better alternative for the time being is to add a new
> > > > kvm_is_zone_device_pfn() and force KVM_PGTABLE_PROT_DEVICE if it returns
> > > > true _and_ the VMM asked for MTE in guest. We can then only set
> > > > PG_mte_tagged if !device.
> > > 
> > > KVM already has a kvm_is_device_pfn(), and yes I agree restricting the MTE
> > > checks to only !kvm_is_device_pfn() makes sense (I have the fix in my branch
> > > locally).
> > 
> > Indeed, you can skip it if kvm_is_device_pfn(). In addition, with MTE,
> > I'd also mark a pfn as 'device' in user_mem_abort() if
> > pfn_to_online_page() is NULL as we don't want to map it as Cacheable in
> > Stage 2. It's unlikely that we'll trip over this path but just in case.
> > 
> > (can we have a ZONE_DEVICE _online_ pfn or by definition they are
> > considered offline?)
> 
> By definition (and implementation) offline. When you get a page =
> pfn_to_online_page() with page != NULL, that one should never be ZONE_DEVICE
> (otherwise it would be a BUG).
> 
> As I said, things are different when exposing dax memory via dax/kmem to the
> buddy. But then, we are no longer talking about ZONE_DEVICE.

Thanks David, it's clear now.

-- 
Catalin
