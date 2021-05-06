Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FAE3758C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhEFQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:55:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17137 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhEFQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:55:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbfjV3ckdzqSVg;
        Fri,  7 May 2021 00:51:10 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.85.115) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 00:54:16 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 0/3] kvm/arm: New VMID allocator based on asid(2nd approach) 
Date:   Thu, 6 May 2021 17:52:29 +0100
Message-ID: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.115]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on a suggestion from Will [0] to try out the asid
based kvm vmid solution as a separate VMID allocator instead of
the shared lib approach attempted in v4[1].

The idea is to compare both the approaches and see whether the
shared lib solution with callbacks make sense or not. 

Though we are not yet using the pinned vmids yet, patch #2 has
code for pinned vmid support. This is just to help the comparison.

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

As you can see there are of course code duplication with this
approach but may be this one is more easy to maintain considering
the complexity involved.

Please take a look and let me know your feedback.

Thanks,
Shameer


[0] https://lore.kernel.org/lkml/20210422160846.GB2214@willie-the-truck/
[1] https://lore.kernel.org/lkml/20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com/

Julien Grall (2):
  arch/arm64: Introduce a capability to tell whether 16-bit VMID is
    available
  kvm/arm: Align the VMID allocation with the arm64 ASID one

Shameer Kolothum (1):
  kvm/arm: Introduce a new vmid allocator for KVM

 arch/arm64/include/asm/cpucaps.h   |   3 +-
 arch/arm64/include/asm/kvm_asm.h   |   4 +-
 arch/arm64/include/asm/kvm_host.h  |  11 +-
 arch/arm64/include/asm/kvm_mmu.h   |   7 +-
 arch/arm64/kernel/cpufeature.c     |   9 +
 arch/arm64/kvm/Makefile            |   2 +-
 arch/arm64/kvm/arm.c               | 115 ++++--------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |   6 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c      |  10 +-
 arch/arm64/kvm/hyp/vhe/tlb.c       |  10 +-
 arch/arm64/kvm/mmu.c               |   1 -
 arch/arm64/kvm/vmid.c              | 285 +++++++++++++++++++++++++++++
 12 files changed, 354 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm64/kvm/vmid.c

-- 
2.17.1

