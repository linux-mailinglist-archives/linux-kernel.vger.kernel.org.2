Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6013D1E73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGVGEt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 02:04:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3982 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhGVGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:04:44 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4GVjWW3rB9zPy7X;
        Thu, 22 Jul 2021 14:40:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:45:16 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 22 Jul 2021 07:45:14 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
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
Subject: RE: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Thread-Topic: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Thread-Index: AQHXYshdKTToNwJp/0KRL8OlJabnS6tNxW6AgAD8jbA=
Date:   Thu, 22 Jul 2021 06:45:14 +0000
Message-ID: <f7d708704fb84380af85298a98f7a48c@huawei.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
In-Reply-To: <20210721163138.GD11003@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.80.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 21 July 2021 17:32
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; Linuxarm <linuxarm@huawei.com>;
> qperret@google.com
> Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the
> arm64 ASID one
> 
> [+Quentin]
> 
> On Wed, Jun 16, 2021 at 04:56:06PM +0100, Shameer Kolothum wrote:
> > From: Julien Grall <julien.grall@arm.com>
> >
> > At the moment, the VMID algorithm will send an SGI to all the CPUs to
> > force an exit and then broadcast a full TLB flush and I-Cache
> > invalidation.
> >
> > This patch use the new VMID allocator. The
> > benefits are:
> >     - CPUs are not forced to exit at roll-over. Instead the VMID will be
> >     marked reserved and the context will be flushed at next exit. This
> >     will reduce the IPIs traffic.
> >     - Context invalidation is now per-CPU rather than broadcasted.
> >     - Catalin has a formal model of the ASID allocator.
> >
> > With the new algo, the code is now adapted:
> >     - The function __kvm_flush_vm_context() has been renamed to
> >     __kvm_tlb_flush_local_all() and now only flushing the current CPU
> >     context.
> >     - The call to update_vmid() will be done with preemption disabled
> >     as the new algo requires to store information per-CPU.
> >     - The TLBs associated to EL1 will be flushed when booting a CPU to
> >     deal with stale information. This was previously done on the
> >     allocation of the first VMID of a new generation.
> >
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h      |   4 +-
> >  arch/arm64/include/asm/kvm_host.h     |   6 +-
> >  arch/arm64/include/asm/kvm_mmu.h      |   3 +-
> >  arch/arm64/kvm/Makefile               |   2 +-
> >  arch/arm64/kvm/arm.c                  | 115 +++++++-------------------
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c    |   6 +-
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c |   3 +-
> >  arch/arm64/kvm/hyp/nvhe/tlb.c         |  10 +--
> >  arch/arm64/kvm/hyp/vhe/tlb.c          |  10 +--
> >  arch/arm64/kvm/mmu.c                  |   1 -
> >  10 files changed, 52 insertions(+), 108 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/kvm_host.h
> b/arch/arm64/include/asm/kvm_host.h
> > index 75a7e8071012..d96284da8571 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -70,9 +70,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
> >  void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu);
> >
> >  struct kvm_vmid {
> > -	/* The VMID generation used for the virt. memory system */
> > -	u64    vmid_gen;
> > -	u32    vmid;
> > +	atomic64_t id;
> 
> Maybe a typedef would be better if this is the only member of the structure?

Ok.

> 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 4b60c0056c04..a02c4877a055 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -106,8 +106,7 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool,
> void *dev_pgt_pool)
> >  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
> >  	mmu->arch = &host_kvm.arch;
> >  	mmu->pgt = &host_kvm.pgt;
> > -	mmu->vmid.vmid_gen = 0;
> > -	mmu->vmid.vmid = 0;
> > +	atomic64_set(&mmu->vmid.id, 0);
> 
> I think this is the first atomic64 use in the EL2 object, which may pull in
> some fatal KCSAN instrumentation. Quentin, have you run into this before?
> 
> Might be simple just to zero-initialise mmu for now, if it isn't already.

I will check that.

> 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c
> b/arch/arm64/kvm/hyp/nvhe/tlb.c
> > index 83dc3b271bc5..42df9931ed9a 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/tlb.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
> > @@ -140,10 +140,10 @@ void __kvm_flush_cpu_context(struct
> kvm_s2_mmu *mmu)
> >  	__tlb_switch_to_host(&cxt);
> >  }
> >
> > -void __kvm_flush_vm_context(void)
> > +void __kvm_tlb_flush_local_all(void)
> >  {
> > -	dsb(ishst);
> > -	__tlbi(alle1is);
> > +	dsb(nshst);
> > +	__tlbi(alle1);
> >
> >  	/*
> >  	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
> > @@ -155,7 +155,7 @@ void __kvm_flush_vm_context(void)
> >  	 *
> >  	 */
> >  	if (icache_is_vpipt())
> > -		asm volatile("ic ialluis");
> > +		asm volatile("ic iallu" : : );
> >
> > -	dsb(ish);
> > +	dsb(nsh);
> 
> Hmm, I'm wondering whether having this local stuff really makes sense for
> VMIDs. For ASIDs, where rollover can be frequent and TLBI could result in
> IPI on 32-bit, the local option was important, but here rollover is less
> frequent, DVM is relied upon to work and the cost of a hypercall is
> significant with nVHE.
> 
> So I do think you could simplify patch 2 slightly to drop the
> flush_pending and just issue inner-shareable invalidation on rollover.
> With that, it might also make it straightforward to clear active_asids
> when scheduling out a vCPU, which would solve the other problem I
> mentioned
> about unnecessarily reserving a bunch of the VMID space.

Ok. I will try out the above suggestion. Hope it will be acceptable for 8 bit 
VMID systems as well as there is a higher chance for rollover especially
when we introduce pinned VMIDs(I am not sure such platforms care about
Pinned VMID or not. If not, we could limit Pinned VMIDs to 16 bit systems).

Thanks,
Shameer
