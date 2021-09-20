Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5156C412725
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhITUFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:05:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:63268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhITUDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:03:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202723608"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="202723608"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 13:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473779468"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:13 -0700
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
Subject: [PATCH 1/8] iommu/vt-d: Clean up unused PASID updating functions
Date:   Mon, 20 Sep 2021 19:23:42 +0000
Message-Id: <20210920192349.2602141-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_pasid() and its call chain are currently unused in the tree because
Thomas disabled the ENQCMD feature. The feature will be re-enabled shortly
using a different approach and update_pasid() and its call chain will not
be used in the new approach.

Remove the useless functions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  2 --
 drivers/iommu/intel/svm.c      | 24 +-----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 23bef08a8388..ca4d0dee1ecd 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -106,6 +106,4 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
  */
 #define PASID_DISABLED	0
 
-static inline void update_pasid(void) { }
-
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0c228787704f..5b5d69b04fcc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -505,21 +505,6 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
-static void _load_pasid(void *unused)
-{
-	update_pasid();
-}
-
-static void load_pasid(struct mm_struct *mm, u32 pasid)
-{
-	mutex_lock(&mm->context.lock);
-
-	/* Update PASID MSR on all CPUs running the mm's tasks. */
-	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
-
-	mutex_unlock(&mm->context.lock);
-}
-
 static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 				 unsigned int flags)
 {
@@ -614,10 +599,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	if (ret)
 		goto free_sdev;
 
-	/* The newly allocated pasid is loaded to the mm. */
-	if (!(flags & SVM_FLAG_SUPERVISOR_MODE) && list_empty(&svm->devs))
-		load_pasid(mm, svm->pasid);
-
 	list_add_rcu(&sdev->list, &svm->devs);
 success:
 	return &sdev->sva;
@@ -670,11 +651,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				if (svm->notifier.ops) {
+				if (svm->notifier.ops)
 					mmu_notifier_unregister(&svm->notifier, mm);
-					/* Clear mm's pasid. */
-					load_pasid(mm, PASID_DISABLED);
-				}
 				pasid_private_remove(svm->pasid);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
-- 
2.33.0

