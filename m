Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE139BB2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFDOxX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Jun 2021 10:53:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4308 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:53:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FxQZZ31Y7z1BHbD;
        Fri,  4 Jun 2021 22:46:46 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 22:51:32 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 22:51:31 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Fri, 4 Jun 2021 15:51:29 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
 approach) 
Thread-Topic: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
 approach) 
Thread-Index: AQHXQph5pwodb0a/4kShAMz7Pnc+rqsDq0rQgABREYCAABlY4A==
Date:   Fri, 4 Jun 2021 14:51:29 +0000
Message-ID: <95bb84ffdb0f4db3b64b38cc3b651f90@huawei.com>
References: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
        <e62829990c50479292af94c4152011fc@huawei.com> <87sg1xzqea.wl-maz@kernel.org>
In-Reply-To: <87sg1xzqea.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.52]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier [mailto:maz@kernel.org]
> Sent: 04 June 2021 14:55
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; will@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org; Alexandru Elisei
> <Alexandru.Elisei@arm.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
> approach)
> 
> On Fri, 04 Jun 2021 09:13:10 +0100,
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> wrote:
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > Sent: 06 May 2021 17:52
> > > To: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> > > linux-kernel@vger.kernel.org
> > > Cc: maz@kernel.org; will@kernel.org; catalin.marinas@arm.com;
> > > james.morse@arm.com; julien.thierry.kdev@gmail.com;
> > > suzuki.poulose@arm.com; jean-philippe@linaro.org; Linuxarm
> > > <linuxarm@huawei.com>
> > > Subject: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
> > > approach)
> > >
> > > This is based on a suggestion from Will [0] to try out the asid
> > > based kvm vmid solution as a separate VMID allocator instead of
> > > the shared lib approach attempted in v4[1].
> > >
> > > The idea is to compare both the approaches and see whether the
> > > shared lib solution with callbacks make sense or not.
> >
> > A gentle ping on this. Please take a look and let me know.
> 
> I had a look and I don't overly dislike it. I'd like to see the code
> without the pinned stuff though, at least to ease the reviewing. I
> haven't tested it in anger, but I have pushed the rebased code at [1]
> as it really didn't apply to 5.13-rc4.

Thanks for taking a look and the rebase. I will remove the pinned stuff
in the next revision as that was added just to compare against the previous
version.

> 
> One thing I'm a bit worried about is that we so far relied on VMID 0
> never being allocated to a guest, which is now crucial for protected
> KVM. I can't really convince myself that this can never happen with
> this.

Hmm..not sure I quite follow that. As per the current logic vmid 0 is
reserved and is not allocated to Guest. 

> Plus, I've found this nugget:
> 
> <quote
> 	max_pinned_vmids = NUM_USER_VMIDS - num_possible_cpus() - 2;
> </quote>
> 
> What is this "- 2"? My hunch is that it should really be "- 1" as VMID
> 0 is reserved, and we have no equivalent of KPTI for S2.

I think this is more related to the "pinned vmid" stuff and was borrowed from
the asid_update_limit() fn in arch/arm64/mm/context.c. But I missed the
comment that explains the reason behind it. It says,

---x---
	/*
	 * There must always be an ASID available after rollover. Ensure that,
	 * even if all CPUs have a reserved ASID and the maximum number of ASIDs
	 * are pinned, there still is at least one empty slot in the ASID map.
	 */
	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
---x---

So this is to make sure we will have at least one VMID available after rollover
in case we have pinned the max number of VMIDs. I will include that comment
to make it clear.

Thanks,
Shameer

> 
> 	M.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h
> =kvm-arm64/mmu/vmid
> 
> --
> Without deviation from the norm, progress is not possible.
