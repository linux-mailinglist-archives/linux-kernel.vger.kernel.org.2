Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAD350692
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhCaSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhCaSnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1FED606A5;
        Wed, 31 Mar 2021 18:43:14 +0000 (UTC)
Date:   Wed, 31 Mar 2021 19:43:12 +0100
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
Message-ID: <20210331184311.GA10737@arm.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-3-steven.price@arm.com>
 <20210327152324.GA28167@arm.com>
 <20210328122131.GB17535@arm.com>
 <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:41:20AM +0100, Steven Price wrote:
> On 31/03/2021 10:32, David Hildenbrand wrote:
> > On 31.03.21 11:21, Catalin Marinas wrote:
> > > On Wed, Mar 31, 2021 at 09:34:44AM +0200, David Hildenbrand wrote:
> > > > On 30.03.21 12:30, Catalin Marinas wrote:
> > > > > On Mon, Mar 29, 2021 at 05:06:51PM +0100, Steven Price wrote:
> > > > > > On 28/03/2021 13:21, Catalin Marinas wrote:
> > > > > > > However, the bigger issue is that Stage 2 cannot disable
> > > > > > > tagging for Stage 1 unless the memory is Non-cacheable or
> > > > > > > Device at S2. Is there a way to detect what gets mapped in
> > > > > > > the guest as Normal Cacheable memory and make sure it's
> > > > > > > only early memory or hotplug but no ZONE_DEVICE (or
> > > > > > > something else like on-chip memory)?  If we can't
> > > > > > > guarantee that all Cacheable memory given to a guest
> > > > > > > supports tags, we should disable the feature altogether.
> > > > > > 
> > > > > > In stage 2 I believe we only have two types of mapping -
> > > > > > 'normal' or DEVICE_nGnRE (see stage2_map_set_prot_attr()).
> > > > > > Filtering out the latter is a case of checking the 'device'
> > > > > > variable, and makes sense to avoid the overhead you
> > > > > > describe.
> > > > > > 
> > > > > > This should also guarantee that all stage-2 cacheable
> > > > > > memory supports tags,
> > > > > > as kvm_is_device_pfn() is simply !pfn_valid(), and
> > > > > > pfn_valid() should only
> > > > > > be true for memory that Linux considers "normal".
> > > > 
> > > > If you think "normal" == "normal System RAM", that's wrong; see
> > > > below.
> > > 
> > > By "normal" I think both Steven and I meant the Normal Cacheable memory
> > > attribute (another being the Device memory attribute).
> 
> Sadly there's no good standardised terminology here. Aarch64 provides the
> "normal (cacheable)" definition. Memory which is mapped as "Normal
> Cacheable" is implicitly MTE capable when shared with a guest (because the
> stage 2 mappings don't allow restricting MTE other than mapping it as Device
> memory).
> 
> So MTE also forces us to have a definition of memory which is "bog standard
> memory"[1] separate from the mapping attributes. This is the main memory
> which fully supports MTE.
> 
> Separate from the "bog standard" we have the "special"[1] memory, e.g.
> ZONE_DEVICE memory may be mapped as "Normal Cacheable" at stage 1 but that
> memory may not support MTE tags. This memory can only be safely shared with
> a guest in the following situations:
> 
>  1. MTE is completely disabled for the guest
> 
>  2. The stage 2 mappings are 'device' (e.g. DEVICE_nGnRE)
> 
>  3. We have some guarantee that guest MTE access are in some way safe.
> 
> (1) is the situation today (without this patch series). But it prevents the
> guest from using MTE in any form.
> 
> (2) is pretty terrible for general memory, but is the get-out clause for
> mapping devices into the guest.
> 
> (3) isn't something we have any architectural way of discovering. We'd need
> to know what the device did with the MTE accesses (and any caches between
> the CPU and the device) to ensure there aren't any side-channels or h/w
> lockup issues. We'd also need some way of describing this memory to the
> guest.
> 
> So at least for the time being the approach is to avoid letting a guest with
> MTE enabled have access to this sort of memory.

When a slot is added by the VMM, if it asked MTE in guest (I guess
that's an opt-in by the VMM, haven't checked the other patches), can we
reject it if it's is going to be mapped as Normal Cacheable but it is a
ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
check for ZONE_DEVICE)? This way we don't need to do more expensive
checks in set_pte_at().

We could simplify the set_pte_at() further if we require that the VMM
has a PROT_MTE mapping. This does not mean it cannot have two mappings,
the other without PROT_MTE. But at least we get a set_pte_at() when
swapping in which has PROT_MTE.

We could add another PROT_TAGGED or something which means PG_mte_tagged
set but still mapped as Normal Untagged. It's just that we are short of
pte bits for another flag.

Can we somehow identify when the S2 pte is set and can we get access to
the prior swap pte? This way we could avoid changes to set_pte_at() for
S2 faults.

-- 
Catalin
