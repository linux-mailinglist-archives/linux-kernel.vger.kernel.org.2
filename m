Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52168458E19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhKVMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:22:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4119 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhKVMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:22:20 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyR6x0rvDz6H7ML;
        Mon, 22 Nov 2021 20:15:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 13:19:12 +0100
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 12:19:05 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Date:   Mon, 22 Nov 2021 12:18:40 +0000
Message-ID: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:
- Main change is in patch #4, where the VMID is now set to an
  invalid one on vCPU schedule out. Introduced an 
  INVALID_ACTIVE_VMID which is basically a VMID 0 with generation 1.
  Since the basic allocator algorithm reserves vmid #0, it is never
  used as an active VMID. This (hopefully) will fix the issue of
  unnecessarily reserving VMID space with active_vmids when those
  VMs are no longer active[0] and at the same time address the
  problem noted in v3 wherein everything ends up in slow-path[1].

Testing:
 -Run with VMID bit set to 4 and maxcpus to 8 on D06. The test
  involves running concurrently 50 guests with 4 vCPUs. Each
  guest will then execute hackbench 5 times before exiting.
  No crash was observed for a 4-day continuous run.
  The latest branch is here,
   https://github.com/hisilicon/kernel-dev/tree/private-v5.16-rc1-vmid-v4

 -TLA+ model. Modified the asidalloc model to incorporate the new
  VMID algo. The main differences are,
  -flush_tlb_all() instead of local_tlb_flush_all() on rollover.
  -Introduced INVALID_VMID and vCPU Sched Out logic.
  -No CnP (Removed UniqueASIDAllCPUs & UniqueASIDActiveTask invariants).
  -Removed  UniqueVMIDPerCPU invariant for now as it looks like
   because of the speculative fetching with flush_tlb_all() there
   is a small window where this gets triggered. If I change the
   logic back to local_flush_tlb_all(), UniqueVMIDPerCPU seems to
   be fine. With my limited knowledge on TLA+ model, it is not
   clear to me whether this is a problem with the above logic
   or the VMID model implementation. Really appreciate any help
   with the model.
   The initial VMID TLA+ model is here,
   https://github.com/shamiali2008/kernel-tla/tree/private-vmidalloc-v1

Please take a look and let me know.

Thanks,
Shameer

[0] https://lore.kernel.org/kvmarm/20210721160614.GC11003@willie-the-truck/
[1] https://lore.kernel.org/kvmarm/20210803114034.GB30853@willie-the-truck/

History:
--------
v2 --> v3
  -Dropped adding a new static key and cpufeature for retrieving
   supported VMID bits. Instead, we now make use of the
   kvm_arm_vmid_bits variable (patch #2).

  -Since we expect less frequent rollover in the case of VMIDs,
   the TLB invalidation is now broadcasted on rollover instead
   of keeping per CPU flush_pending info and issuing a local
   context flush.

  -Clear active_vmids on vCPU schedule out to avoid unnecessarily
   reserving the VMID space(patch #3).

  -I have kept the struct kvm_vmid as it is for now(instead of a
   typedef as suggested), as we may soon add another variable to
   it when we introduce Pinned KVM VMID support.

RFCv1 --> v2
   -Dropped "pinned VMID" support for now.
   -Dropped RFC tag.
RFCv1
   https://lore.kernel.org/kvmarm/20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com/

Julien Grall (1):
  KVM: arm64: Align the VMID allocation with the arm64 ASID

Shameer Kolothum (3):
  KVM: arm64: Introduce a new VMID allocator for KVM
  KVM: arm64: Make VMID bits accessible outside of allocator
  KVM: arm64: Make active_vmids invalid on vCPU schedule out

 arch/arm64/include/asm/kvm_host.h     |  10 +-
 arch/arm64/include/asm/kvm_mmu.h      |   4 +-
 arch/arm64/kernel/image-vars.h        |   3 +
 arch/arm64/kvm/Makefile               |   2 +-
 arch/arm64/kvm/arm.c                  | 106 +++-----------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |   3 +-
 arch/arm64/kvm/mmu.c                  |   1 -
 arch/arm64/kvm/vmid.c                 | 196 ++++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm64/kvm/vmid.c

-- 
2.17.1

