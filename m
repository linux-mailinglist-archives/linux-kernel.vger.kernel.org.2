Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77241272B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhITUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:07:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:63268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhITUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:05:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202723602"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="202723602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 13:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473779464"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:12 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/8] Re-enable ENQCMD and PASID MSR
Date:   Mon, 20 Sep 2021 19:23:41 +0000
Message-Id: <20210920192349.2602141-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since updating PASID (Process Address Space ID) MSR through IPI has a few
issues that are beyond repair, Thomas disables ENQCMD [1].

Please check Documentation/x86/sva.rst for various concepts and terms
related to PASID, ENQCMD, SVM (Shared Virtual Memory), etc.

This series re-enables ENQCMD and IA32_PASID MSR by using a #GP fix up
method previously published in [2]. A PASID is allocated to a mm once
a SVM is bound to the mm via intel_svm_bind() API. The #GP fix up method
updates the PASID MSR from the mm's PASID in #GP handler when one thread
in a process executes ENQCMD for the first time and one reference is taken
to the PASID. Once the MSR is uploaded, the thread keeps and can use it
for the rest life time of the thread. In exit(2) or unbind, the PASID's
reference is dropped and the PASID is freed if there is no reference.

References:
1. ENQCMD was disabled in upstream due to serious issues:
https://lore.kernel.org/linux-iommu/87mtsd6gr9.ffs@nanos.tec.linutronix.de/

2. #GP fix up PASID MSR:
https://lore.kernel.org/linux-iommu/1594684087-61184-1-git-send-email-fenghua.yu@intel.com/

Fenghua Yu (7):
  iommu/vt-d: Clean up unused PASID updating functions
  x86/process: Clear PASID state for a newly forked/cloned thread
  x86/traps: Demand-populate PASID MSR via #GP
  x86/mmu: Add mm-based PASID refcounting
  x86/cpufeatures: Re-enable ENQCMD
  tools/objtool: Check for use of the ENQCMD instruction in the kernel
  docs: x86: Change documentation for SVA (Shared Virtual Addressing)

Peter Zijlstra (1):
  sched: Define and initialize a flag to identify valid PASID in the
    task

 Documentation/x86/sva.rst                | 81 ++++++++++++++++++--
 arch/x86/include/asm/disabled-features.h |  7 +-
 arch/x86/include/asm/fpu/api.h           |  6 +-
 arch/x86/include/asm/iommu.h             |  8 ++
 arch/x86/include/asm/mmu_context.h       |  2 +
 arch/x86/kernel/fpu/xstate.c             | 59 +++++++++++++++
 arch/x86/kernel/process.c                |  8 ++
 arch/x86/kernel/traps.c                  | 12 +++
 drivers/iommu/intel/svm.c                | 95 ++++++++++++++++++------
 include/linux/sched.h                    |  4 +
 kernel/fork.c                            |  4 +
 tools/objtool/arch/x86/decode.c          | 10 ++-
 tools/objtool/check.c                    | 20 +++++
 tools/objtool/include/objtool/arch.h     |  1 +
 14 files changed, 283 insertions(+), 34 deletions(-)

-- 
2.33.0

