Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908043DA16A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhG2Kni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:43:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3518 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhG2Knh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:43:37 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gb6F30FB3z6GDSW;
        Thu, 29 Jul 2021 18:28:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 12:43:31 +0200
Received: from A2006125610.china.huawei.com (10.47.90.183) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:43:24 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 0/4] kvm/arm: New VMID allocator based on asid
Date:   Thu, 29 Jul 2021 11:40:05 +0100
Message-ID: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.90.183]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Major changes since v2 (Based on Will's feedback)
  -Dropped adding a new static key and cpufeature for retrieving
   supported VMID bits. Instead, we now make use of the 
   kvm_arm_vmid_bits variable (patch #2).

  -Since we expect less frequent rollover in the case of VMIDs,
   the TLB invalidation is now broadcasted on rollover instead
   of keeping per CPU flush_pending info and issuing a local
   context flush.  

 -Clear active_vmids on vCPU schedule out to avoid unnecessarily
  reserving the VMID space(patch #3). 

 -I have kept the struct kvm_vmid as it is for now(instead of a
  typedef as suggested), as we may soon add another variable to
  it when we introduce Pinned KVM VMID support.

Sanity tested on HiSilicon D06 board.

Thanks,
Shameer


RFCv1 --> v2
   - Dropped "pinned VMID" support for now.
   - Dropped RFC tag.

History(from RFC v1):
-------------------

Please find the RFC series here,
https://lore.kernel.org/kvmarm/20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com/

This is based on a suggestion from Will [0] to try out the asid
based kvm vmid solution as a separate VMID allocator instead of
the shared lib approach attempted in v4[1].

The idea is to compare both the approaches and see whether the
shared lib solution with callbacks make sense or not. 

Though we are not yet using the pinned vmids yet, patch #2 has
code for pinned vmid support. This is just to help the comparison.

Test Setup/Results
----------------
The measurement was made with maxcpus set to 8 and with the
number of VMID limited to 4-bit. The test involves running
concurrently 40 guests with 2 vCPUs. Each guest will then
execute hackbench 5 times before exiting.

The performance difference between the current algo and the
new one are(avg. of 10 runs):
    - 1.9% less entry/exit from the guest
    - 0.5% faster

This is more or less comparable to v4 numbers.

For the complete series, please see,
https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-vmid-2nd-rfc

and for the shared asid lib v4 solution,
https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc7-asid-v4

As you can see there are ofcourse code duplication with this
approach but may be it is more easy to maintain considering
the complexity involved.

Please take a look and let me know your feedback.

Thanks,
Shameer

Julien Grall (1):
  KVM: arm64: Align the VMID allocation with the arm64 ASID one

Shameer Kolothum (3):
  KVM: arm64: Introduce a new VMID allocator for KVM
  KVM: arm64: Make VMID bits accessible outside of allocator
  KVM: arm64: Clear active_vmids on vCPU schedule out

 arch/arm64/include/asm/kvm_host.h     |  10 +-
 arch/arm64/include/asm/kvm_mmu.h      |   4 +-
 arch/arm64/kernel/image-vars.h        |   3 +
 arch/arm64/kvm/Makefile               |   2 +-
 arch/arm64/kvm/arm.c                  | 122 +++++------------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |   3 +-
 arch/arm64/kvm/mmu.c                  |   1 -
 arch/arm64/kvm/vmid.c                 | 182 ++++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm64/kvm/vmid.c

-- 
2.17.1

