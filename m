Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE57641272A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhITUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:07:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:60380 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhITUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:05:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="308775442"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="308775442"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 13:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473779509"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:16 -0700
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
Subject: [PATCH 8/8] docs: x86: Change documentation for SVA (Shared Virtual Addressing)
Date:   Mon, 20 Sep 2021 19:23:49 +0000
Message-Id: <20210920192349.2602141-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since allocating, freeing and fixing up PASID are changed, the
documentation is updated to reflect the changes.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/sva.rst | 81 +++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd51ef1f..868ed4b25002 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -106,16 +106,83 @@ process share the same page tables, thus the same MSR value.
 
 PASID is cleared when a process is created. The PASID allocation and MSR
 programming may occur long after a process and its threads have been created.
-One thread must call iommu_sva_bind_device() to allocate the PASID for the
-process. If a thread uses ENQCMD without the MSR first being populated, a #GP
-will be raised. The kernel will update the PASID MSR with the PASID for all
-threads in the process. A single process PASID can be used simultaneously
+One thread must call iommu_sva_bind(_device) to allocate the PASID for the process.
+If a thread uses ENQCMD without the MSR first being populated, it will cause #GP.
+The kernel will fix up the #GP by writing the process-wide PASID into the
+thread that took the #GP. A single process PASID can be used simultaneously
 with multiple devices since they all share the same address space.
 
-One thread can call iommu_sva_unbind_device() to free the allocated PASID.
-The kernel will clear the PASID MSR for all threads belonging to the process.
+The PASID MSR value is cleared at thread creation and is never inherited from a
+parent. This ensures consistent child behavior no matter whether the thread is
+created first or the PASID is allocated (and the MSR written).
 
-New threads inherit the MSR value from the parent.
+
+PASID Lifecycle Management
+==========================
+
+Only processes that access SVA-capable devices need to have a PASID
+allocated. This allocation happens when a process opens/binds an SVA-capable
+device but finds no PASID for this process. Subsequent binds of the same, or
+other devices will share the same PASID.
+
+Although the PASID is allocated to the process by opening a device,
+it is not active in any of the threads of that process. It's loaded to the
+IA32_PASID MSR lazily when a thread tries to submit a work descriptor
+to a device using the ENQCMD.
+
+That first access will trigger a #GP fault because the IA32_PASID MSR
+has not been initialized with the PASID value assigned to the process
+when the device was opened. The Linux #GP handler notes that a PASID has
+been allocated for the process, and so initializes the IA32_PASID MSR, takes
+a reference to the PASID and returns so that the ENQCMD instruction is
+re-executed.
+
+On fork(2) or exec(2) the PASID is removed from the process as it no
+longer has the same address space that it had when the device was opened.
+
+On clone(2) the new task shares the same address space, so will be
+able to use the PASID allocated to the process. The IA32_PASID is not
+preemptively initialized as the PASID value might not be allocated yet or
+the kernel does not know whether this thread is going to access the device
+and the cleared IA32_PASID MSR reduces context switch overhead by xstate
+init optimization. Since #GP faults have to be handled on any threads that
+were created before the PASID was assigned to the mm of the process, newly
+created threads might as well be treated in a consistent way.
+
+Due to complexity of freeing the PASID and clearing all IA32_PASID MSRs in
+all threads in unbind, free the PASID lazily when there is no PASID user.
+Track the PASID's reference count in the following way:
+
+- Track device usage of the PASID: The PASID's reference count is initialized
+  as 1 when the PASID is allocated in the first bind. Bind takes a reference
+  and unbind drops the reference.
+- Track task usage of the PASID: Fixing up the IA32_PASID MSR in #GP takes
+  reference and exit(2) drops the reference. Once the MSR is fixed up, the
+  PASID value stays in the MSR stays for the rest life of the task.
+
+The PASID is freed lazily in exit(2) or unbind when there is no reference
+to the PASID. After freed, the PASID can be allocated to any process.
+
+ENQCMD needs at least two requirements: a valid IA32_PASID MSR with the
+PASID value of the process and a valid PASID table entry for the PASID.
+To execute ENQCMD, the user must ensure the device is bound to the
+process so that the kernel can guarantee to meet the above two requirements.
+
+Lazy PASID free may cause the task still has the PASID value in IA32_PASID
+while there is no PASID table entry for the PASID. The workqueue submitted
+by ENQCMD in this scenario cannot find the PASID table entry and generates
+a DMAR fault. Currently DMAR fault handler just prints a fault reason.
+Future DMAR fault handler might notify the user the workqueue failure.
+Here are two detailed cases:
+
+- Unbind removes the PASID table entry but the process still owns the PASID
+  and the task's IA32_PASID MSR still keeps the PASID value. The workqueue
+  submitted by ENQCMD in this task will generate a DMAR fault.
+- Unbind removes the PASID table entry but the process still owns the PASID
+  because some task took one reference during fix up. ENQCMD executed in a
+  task that doesn't fix up the IA32_PASID MSR will generate #GP first to get
+  its IA32_PASID MSR fixed up and then the submitted workqueue will generate
+  a DMAR fault.
 
 Relationships
 =============
-- 
2.33.0

