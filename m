Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98139B4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFDIPD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Jun 2021 04:15:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhFDIPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:15:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxFl0079FzWrcJ;
        Fri,  4 Jun 2021 16:08:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (7.185.36.66) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:13:13 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:13:12 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Fri, 4 Jun 2021 09:13:10 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
 approach) 
Thread-Topic: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
 approach) 
Thread-Index: AQHXQph5pwodb0a/4kShAMz7Pnc+rqsDq0rQ
Date:   Fri, 4 Jun 2021 08:13:10 +0000
Message-ID: <e62829990c50479292af94c4152011fc@huawei.com>
References: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
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

Hi,

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 06 May 2021 17:52
> To: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org
> Cc: maz@kernel.org; will@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd
> approach)
> 
> This is based on a suggestion from Will [0] to try out the asid
> based kvm vmid solution as a separate VMID allocator instead of
> the shared lib approach attempted in v4[1].
> 
> The idea is to compare both the approaches and see whether the
> shared lib solution with callbacks make sense or not.

A gentle ping on this. Please take a look and let me know.

Thanks,
Shameer

> Though we are not yet using the pinned vmids yet, patch #2 has
> code for pinned vmid support. This is just to help the comparison.
> 
> Test Setup/Results
> ----------------
> The measurement was made with maxcpus set to 8 and with the
> number of VMID limited to 4-bit. The test involves running
> concurrently 40 guests with 2 vCPUs. Each guest will then
> execute hackbench 5 times before exiting.
> 
> The performance difference between the current algo and the
> new one are(avg. of 10 runs):
>     - 1.9% less entry/exit from the guest
>     - 0.5% faster
> This is more or less comparable to v4 numbers.
> 
> For the complete series, please see,
> https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-vmid-2nd-rfc
> 
> and for the shared asid lib v4 solution,
> https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-asid-v4
> 
> As you can see there are of course code duplication with this
> approach but may be this one is more easy to maintain considering
> the complexity involved.
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> 
> 
> [0] https://lore.kernel.org/lkml/20210422160846.GB2214@willie-the-truck/
> [1]
> https://lore.kernel.org/lkml/20210414112312.13704-1-shameerali.kolothum.t
> hodi@huawei.com/
> 
> Julien Grall (2):
>   arch/arm64: Introduce a capability to tell whether 16-bit VMID is
>     available
>   kvm/arm: Align the VMID allocation with the arm64 ASID one
> 
> Shameer Kolothum (1):
>   kvm/arm: Introduce a new vmid allocator for KVM
> 
>  arch/arm64/include/asm/cpucaps.h   |   3 +-
>  arch/arm64/include/asm/kvm_asm.h   |   4 +-
>  arch/arm64/include/asm/kvm_host.h  |  11 +-
>  arch/arm64/include/asm/kvm_mmu.h   |   7 +-
>  arch/arm64/kernel/cpufeature.c     |   9 +
>  arch/arm64/kvm/Makefile            |   2 +-
>  arch/arm64/kvm/arm.c               | 115 ++++--------
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c |   6 +-
>  arch/arm64/kvm/hyp/nvhe/tlb.c      |  10 +-
>  arch/arm64/kvm/hyp/vhe/tlb.c       |  10 +-
>  arch/arm64/kvm/mmu.c               |   1 -
>  arch/arm64/kvm/vmid.c              | 285
> +++++++++++++++++++++++++++++
>  12 files changed, 354 insertions(+), 109 deletions(-)
>  create mode 100644 arch/arm64/kvm/vmid.c
> 
> --
> 2.17.1

