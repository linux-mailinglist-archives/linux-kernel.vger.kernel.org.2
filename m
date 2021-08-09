Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0873E46E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhHINtF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Aug 2021 09:49:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3960 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhHINtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:49:04 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Gjy4X68kLz81kl;
        Mon,  9 Aug 2021 21:44:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 21:48:39 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 9 Aug 2021 14:48:38 +0100
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
Thread-Index: AQHXhGar1JrryboKrU+7h+yU/0K2/6thny2AgAAaZCCAACXigIAAEl3QgAR0ioCABL+ZgIAAETIA
Date:   Mon, 9 Aug 2021 13:48:37 +0000
Message-ID: <85b1c1a7861a4cb2a92fc87af800bf4c@huawei.com>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
 <20210803114034.GB30853@willie-the-truck>
 <ee2863107d614ef8a36006b5aa912eca@huawei.com>
 <20210803153036.GA31125@willie-the-truck>
 <b2146ea5db47485f8410a4c1ab0c15fe@huawei.com>
 <20210809130917.GA1207@willie-the-truck>
In-Reply-To: <20210809130917.GA1207@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 09 August 2021 14:09
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; qperret@google.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU
> schedule out
> 
> On Fri, Aug 06, 2021 at 12:24:36PM +0000, Shameerali Kolothum Thodi
> wrote:
> > These are some test numbers with and without this patch, run on two
> > different test setups.
> >
> >
> > a)Test Setup -1
> > -----------------------
> >
> > Platform: HiSilicon D06 with 128 CPUs, VMID bits = 16
> > Run 128 VMs concurrently each with 2 vCPUs. Each Guest will execute
> hackbench
> > 5 times before exiting.
> >
> > Measurements taken avg. of 10 Runs.
> >
> > Image : 5.14-rc3
> > ---------------------------
> >   Time(s)       44.43813888
> >   No. of exits    145,348,264
> >
> > Image: 5.14-rc3 + vmid-v3
> > ----------------------------------------
> >   Time(s)        46.59789034
> >   No. of exits     133,587,307
> >
> > %diff against 5.14-rc3
> >   Time: 4.8% more
> >   Exits: 8% less
> >
> > Image: 5.14-rc3 + vmid-v3 + Without active_asid clear
> > ---------------------------------------------------------------------------
> >   Time(s)         44.5031782
> >   No. of exits      144,443,188
> >
> > %diff against 5.14-rc3
> >   Time: 0.15% more
> >   Exits: 2.42% less
> >
> > b)Test Setup -2
> > -----------------------
> >
> > Platform: HiSilicon D06 + Kernel with maxcpus set to 8 and VMID bits set to
> 4.
> > Run 40 VMs concurrently each with 2 vCPUs. Each Guest will execute
> hackbench
> > 5 times before exiting.
> >
> > Measurements taken avg. of 10 Runs.
> >
> > Image : 5.14-rc3-vmid4bit
> > ------------------------------------
> >   Time(s)        46.19963266
> >   No. of exits     23,699,546
> >
> > Image: 5.14-rc3-vmid4bit + vmid-v3
> > ---------------------------------------------------
> >   Time(s)          45.83307736
> >   No. of exits      23,260,203
> >
> > %diff against 5.14-rc3-vmid4bit
> >   Time: 0.8% less
> >   Exits: 1.85% less
> >
> > Image: 5.14-rc3-vmid4bit + vmid-v3 + Without active_asid clear
> > -----------------------------------------------------------------------------------------
> >   Time(s)           44.5031782
> >   No. of exits        144,443,188
> 
> Really? The *exact* same numbers as the "Image: 5.14-rc3 + vmid-v3 +
> Without
> active_asid clear" configuration? Guessing a copy-paste error here.
> 
> > %diff against 5.14-rc3-vmid4bit
> >   Time: 1.05% less
> >   Exits: 2.06% less
> >
> > As expected, the active_asid clear on schedule out is not helping.
> > But without this patch, the numbers seems to be better than the
> > vanilla kernel when we force the setup(cpus=8, vmd=4bits)
> > to perform rollover.
> 
> I'm struggling a bit to understand these numbers. Are you saying that
> clearing the active_asid helps in the 16-bit VMID case but not in the
> 4-bit case?

Nope, the other way around.. The point I was trying to make is that
clearing the active_vmids definitely have an impact in 16-bit vmid
case, where rollover is not happening, as it ends up taking the slow
path more frequently.

Test setup-1, case 2(with active_vmids clear): Around 4.8% more time
to finish the test compared to vanilla kernel.

Test setup-1, case 3(Without clear): 0.15% more time compared to
vanilla kernel.

For the 4-bit vmid case, the impact of clearing vmids is not that obvious
probably because we have more rollovers.

Test setup-2, case 2(with active_vmids clear):0.8% less time compared to vanilla.
Test setup-2, case 3(Without clear): 1.05% less time compared to vanilla kernel.
 
So between the two(with and without clearing the active_vmids), the "without" 
one has better numbers for both Test setups.

> Why would the active_asid clear have any impact on the number of exits?

In 16 bit vmid case, it looks like the no. of exits is considerably lower if we clear
active_vmids. . Not sure it is because of the frequent slow path or not. But anyway,
the time to finish the test is higher.
 
> The problem I see with not having the active_asid clear is that we will
> roll over more frequently as the number of reserved VMIDs increases.

Ok. The idea of running the 4-bit test setup was to capture that. It doesn't
look like it has a major impact when compared to the original kernel. May be
I should take an average of more test runs. Please let me know if there is a 
better way to measure that impact.

Hope, I am clear.

Thanks,
Shameer
