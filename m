Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0A3D2140
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhGVJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhGVJJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B7FB60725;
        Thu, 22 Jul 2021 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626947416;
        bh=1fTJzkwRBBXvLw3M2jo2NjL1Gq2JwYZPXQMQ+PsKlKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSihkVRV1wezfnc8Z4ZiE7ndBzY/FfUy7o6c23SS0bLn5V7c+2QCW9tuk3p6ZmfEf
         lPBGNoiVcmQYKpjqWF+x/tqps0JMdtOSbHzB1griSKgXbNg8uEJgfuuJxGG9y/Dv8N
         PIJr10rsZMwLAdTgp3nY3u1A/u6FNKG/IckpsjdVAg8PnkRFKToryQ7Lw0zVtMV0rv
         8aKKlbyQ7JItbrbEn7RTuZf0ZpJ7IvODALCZiao/X3xTQf50nIsXw1Lwe8J2IyPITj
         42fXMSDwLqZ61wc2xtDFxT9raPBi4CHfP3ZA/eFvqmxQQoRPs7SpcArbVr/u7NSVLg
         ppSo48UESDOgQ==
Date:   Thu, 22 Jul 2021 10:50:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "qperret@google.com" <qperret@google.com>
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <20210722095010.GA12012@willie-the-truck>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d708704fb84380af85298a98f7a48c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:45:14AM +0000, Shameerali Kolothum Thodi wrote:
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c
> > b/arch/arm64/kvm/hyp/nvhe/tlb.c
> > > index 83dc3b271bc5..42df9931ed9a 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/tlb.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
> > > @@ -140,10 +140,10 @@ void __kvm_flush_cpu_context(struct
> > kvm_s2_mmu *mmu)
> > >  	__tlb_switch_to_host(&cxt);
> > >  }
> > >
> > > -void __kvm_flush_vm_context(void)
> > > +void __kvm_tlb_flush_local_all(void)
> > >  {
> > > -	dsb(ishst);
> > > -	__tlbi(alle1is);
> > > +	dsb(nshst);
> > > +	__tlbi(alle1);
> > >
> > >  	/*
> > >  	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
> > > @@ -155,7 +155,7 @@ void __kvm_flush_vm_context(void)
> > >  	 *
> > >  	 */
> > >  	if (icache_is_vpipt())
> > > -		asm volatile("ic ialluis");
> > > +		asm volatile("ic iallu" : : );
> > >
> > > -	dsb(ish);
> > > +	dsb(nsh);
> > 
> > Hmm, I'm wondering whether having this local stuff really makes sense for
> > VMIDs. For ASIDs, where rollover can be frequent and TLBI could result in
> > IPI on 32-bit, the local option was important, but here rollover is less
> > frequent, DVM is relied upon to work and the cost of a hypercall is
> > significant with nVHE.
> > 
> > So I do think you could simplify patch 2 slightly to drop the
> > flush_pending and just issue inner-shareable invalidation on rollover.
> > With that, it might also make it straightforward to clear active_asids
> > when scheduling out a vCPU, which would solve the other problem I
> > mentioned
> > about unnecessarily reserving a bunch of the VMID space.
> 
> Ok. I will try out the above suggestion. Hope it will be acceptable for 8 bit 
> VMID systems as well as there is a higher chance for rollover especially
> when we introduce pinned VMIDs(I am not sure such platforms care about
> Pinned VMID or not. If not, we could limit Pinned VMIDs to 16 bit systems).

So I woke up at 3am in a cold sweat after dreaming about this code.

I think my suggestion above still stands for the VMID allocator, but
interestingly, it would _not_ be valid for the ASID allocator because there
the ASID is part of the active context and so, during the window where the
active_asid is out of sync with the TTBR, receiving a broadcast TLBI from a
concurrent rollover wouldn't be enough to knock out the old ASID from the
TLB despite it subsequently being made available for reallocation. So the
local TLB invalidation is not just a performance hint as I said; it's crucial
to the way the thing works (and this is also why the CnP code has to switch
to the reserved TTBR0).

As an aside: I'm more and more inclined to rip out the CnP stuff given
that it doesn't appear to being any benefits, but does have some clear
downsides. Perhaps something for next week.

Will
