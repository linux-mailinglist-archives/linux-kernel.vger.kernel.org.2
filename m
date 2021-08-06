Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A653E2A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbhHFMY7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 08:24:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4026 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbhHFMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:24:58 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Gh4Mr5HQgzmnmx;
        Fri,  6 Aug 2021 20:21:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 20:24:38 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Fri, 6 Aug 2021 13:24:36 +0100
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
        "qperret@google.com" <qperret@google.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Thread-Topic: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Thread-Index: AQHXhGar1JrryboKrU+7h+yU/0K2/6thny2AgAAaZCCAACXigIAAEl3QgAR0ioA=
Date:   Fri, 6 Aug 2021 12:24:36 +0000
Message-ID: <b2146ea5db47485f8410a4c1ab0c15fe@huawei.com>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
 <20210803114034.GB30853@willie-the-truck>
 <ee2863107d614ef8a36006b5aa912eca@huawei.com>
 <20210803153036.GA31125@willie-the-truck> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.89.202]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 03 August 2021 16:57
> To: 'Will Deacon' <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; qperret@google.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: RE: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU
> schedule out
> 
> 
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will@kernel.org]
> > Sent: 03 August 2021 16:31
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> > linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> > james.morse@arm.com; julien.thierry.kdev@gmail.com;
> > suzuki.poulose@arm.com; jean-philippe@linaro.org;
> > Alexandru.Elisei@arm.com; qperret@google.com; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU
> > schedule out
> >
> > On Tue, Aug 03, 2021 at 12:55:25PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > > > diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> > > > > index 5584e84aed95..5fd51f5445c1 100644
> > > > > --- a/arch/arm64/kvm/vmid.c
> > > > > +++ b/arch/arm64/kvm/vmid.c
> > > > > @@ -116,6 +116,12 @@ static u64 new_vmid(struct kvm_vmid
> > > > *kvm_vmid)
> > > > >  	return idx2vmid(vmid) | generation;
> > > > >  }
> > > > >
> > > > > +/* Call with preemption disabled */
> > > > > +void kvm_arm_vmid_clear_active(void)
> > > > > +{
> > > > > +	atomic64_set(this_cpu_ptr(&active_vmids), 0);
> > > > > +}
> > > >
> > > > I think this is very broken, as it will force everybody to take the
> > > > slow-path when they see an active_vmid of 0.
> > >
> > > Yes. I have seen that happening in my test setup.
> >
> > Why didn't you say so?!
> 
> Sorry. I thought of getting some performance numbers with and
> without this patch and measure the impact. But didn't quite get time
> to finish it yet.

These are some test numbers with and without this patch, run on two
different test setups.


a)Test Setup -1
-----------------------

Platform: HiSilicon D06 with 128 CPUs, VMID bits = 16
Run 128 VMs concurrently each with 2 vCPUs. Each Guest will execute hackbench
5 times before exiting.

Measurements taken avg. of 10 Runs.

Image : 5.14-rc3
---------------------------
  Time(s)       44.43813888
  No. of exits    145,348,264

Image: 5.14-rc3 + vmid-v3
----------------------------------------
  Time(s)        46.59789034
  No. of exits     133,587,307

%diff against 5.14-rc3
  Time: 4.8% more
  Exits: 8% less 

Image: 5.14-rc3 + vmid-v3 + Without active_asid clear
---------------------------------------------------------------------------
  Time(s)         44.5031782
  No. of exits      144,443,188

%diff against 5.14-rc3
  Time: 0.15% more
  Exits: 2.42% less

b)Test Setup -2
-----------------------

Platform: HiSilicon D06 + Kernel with maxcpus set to 8 and VMID bits set to 4.
Run 40 VMs concurrently each with 2 vCPUs. Each Guest will execute hackbench
5 times before exiting.

Measurements taken avg. of 10 Runs.

Image : 5.14-rc3-vmid4bit
------------------------------------
  Time(s)        46.19963266
  No. of exits     23,699,546

Image: 5.14-rc3-vmid4bit + vmid-v3
---------------------------------------------------
  Time(s)          45.83307736
  No. of exits      23,260,203

%diff against 5.14-rc3-vmid4bit
  Time: 0.8% less
  Exits: 1.85% less 

Image: 5.14-rc3-vmid4bit + vmid-v3 + Without active_asid clear
-----------------------------------------------------------------------------------------
  Time(s)           44.5031782
  No. of exits        144,443,188

%diff against 5.14-rc3-vmid4bit
  Time: 1.05% less
  Exits: 2.06% less

As expected, the active_asid clear on schedule out is not helping.
But without this patch, the numbers seems to be better than the
vanilla kernel when we force the setup(cpus=8, vmd=4bits)
to perform rollover.

Please let me know your thoughts.

Thanks,
Shameer

> 
> >
> > > > It also doesn't solve the issue I mentioned before, as an active_vmid of 0
> > > > means that the reserved vmid is preserved.
> > > >
> > > > Needs more thought...
> > >
> > > How about we clear all the active_vmids in kvm_arch_free_vm() if it
> > > matches the kvm_vmid->id ? But we may have to hold the lock
> > > there
> >
> > I think we have to be really careful not to run into the "suspended
> > animation" problem described in ae120d9edfe9 ("ARM: 7767/1: let the ASID
> > allocator handle suspended animation") if we go down this road.
> 
> 
> Ok. I will go through that.
> 
> > Maybe something along the lines of:
> >
> > ROLLOVER
> >
> >   * Take lock
> >   * Inc generation
> >     => This will force everybody down the slow path
> >   * Record active VMIDs
> >   * Broadcast TLBI
> >     => Only active VMIDs can be dirty
> >     => Reserve active VMIDs and mark as allocated
> >
> > VCPU SCHED IN
> >
> >   * Set active VMID
> >   * Check generation
> >   * If mismatch then:
> >         * Take lock
> >         * Try to match a reserved VMID
> >         * If no reserved VMID, allocate new
> >
> > VCPU SCHED OUT
> >
> >   * Clear active VMID
> >
> > but I'm not daft enough to think I got it right first time. I think it
> > needs both implementing *and* modelling in TLA+ before we merge it!
> >
> 
> Ok. I need some time to digest the above first :).
> 
> On another note, how serious do you think is the problem of extra
> reservation of the VMID space? Just wondering if we can skip this
> patch for now or not..
> 
> Thanks,
> Shameer
