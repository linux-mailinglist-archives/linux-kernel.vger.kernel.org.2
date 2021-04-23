Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E781368ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhDWIbv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Apr 2021 04:31:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3091 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDWIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:31:49 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FRS872hQ1zWb1D;
        Fri, 23 Apr 2021 16:27:19 +0800 (CST)
Received: from dggpeml100024.china.huawei.com (7.185.36.115) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 23 Apr 2021 16:31:09 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 16:31:08 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Fri, 23 Apr 2021 09:31:06 +0100
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
        "julien@xen.org" <julien@xen.org>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 00/16] kvm/arm: Align the VMID allocation with the
 arm64 ASID one
Thread-Topic: [PATCH v4 00/16] kvm/arm: Align the VMID allocation with the
 arm64 ASID one
Thread-Index: AQHXMSCyInFjZI/53EW8vK01de3czarAsIkAgAENuIA=
Date:   Fri, 23 Apr 2021 08:31:06 +0000
Message-ID: <acb761853cb1494a9eb2c345ddd9afd4@huawei.com>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
 <20210422160846.GB2214@willie-the-truck>
In-Reply-To: <20210422160846.GB2214@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.116]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 22 April 2021 18:09
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org; julien@xen.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 00/16] kvm/arm: Align the VMID allocation with the
> arm64 ASID one
> 
> On Wed, Apr 14, 2021 at 12:22:56PM +0100, Shameer Kolothum wrote:
> > Hi,
> >
> > This is an attempt to revive this series originally posted by
> > Julien Grall[1]. The main motive to work on this now is because
> > of the requirement to have Pinned KVM VMIDs and the RFC discussion
> > for the same basically suggested[2] to have a common/better vmid
> > allocator for KVM which this series provides.
> >
> > Major Changes from v3:
> >
> > -Changes related to Pinned ASID support.
> > -Changes to take care KPTI related bits reservation.
> > -Dropped support for 32 bit KVM.
> > -Rebase to 5.12-rc7
> >
> > Individual patches have change history for any major changes
> > from v3.
> >
> > Tests were performed on a HiSilicon D06 platform and so far not observed
> > any regressions.
> >
> > For ASID allocation,
> >
> > Avg of 10 runs(hackbench -s 512 -l 200 -g 300 -f 25 -P),
> > 5.12-rc7: Time:18.8119
> > 5.12-rc7+v4: Time: 18.459
> >
> > ~1.8% improvement.
> >
> > For KVM VMID,
> >
> > The measurement was made with maxcpus set to 8 and with the
> > number of VMID limited to 4-bit. The test involves running
> > concurrently 40 guests with 2 vCPUs. Each guest will then
> > execute hackbench 5 times before exiting.
> >
> > The performance difference between the current algo and the
> > new one are(ag. of 10 runs):
> >     - 1.9% less exit from the guest
> >     - 0.7% faster
> >
> > For complete series, please see,
> >  https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-asid-v4
> >
> > Please take a look and let me know your feedback.
> 
> Although I think aligning the two algorithms makes sense, I'm not completely
> sold on the need to abstract all this into a library and whether the
> additional indirection is justified.
> 
> It would be great to compare this approach with one where portions of the
> code are duplicated into a separate VMID allocator. Have you tried that to
> see what it looks like? Doesn't need to be a proper patch set, but comparing
> the end result might help to evaluate the proposal here.

Ok. I will give it a go and get back.

Thanks,
Shameer
	
