Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6F33E5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCQBIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:08:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:5477 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhCQBHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:07:55 -0400
IronPort-SDR: FWOGLQTNIub8tRW2jM8Et/YzGFVXEzPAR01HzH5aWVVreV+zyW/bu+OqEoLaVpWvdzvhrvVyOP
 Nx7sKidq/Z5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="253377355"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="253377355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 18:07:55 -0700
IronPort-SDR: 5ESqZJpr09Vf0XxYYlkBPIf+V6tM3LPH9pyOCKYFkYtt+p3g3W2yafDGSwqh3Kvw1IFeEftrS9
 bsXrt30ki69Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="511560007"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2021 18:07:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in intel_pasid_get_entry()
Date:   Wed, 17 Mar 2021 08:58:34 +0800
Message-Id: <20210317005834.173503-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pasid_lock is used to synchronize different threads from modifying a
same pasid directory entry at the same time. It causes below lockdep splat.

[   83.296538] ========================================================
[   83.296538] WARNING: possible irq lock inversion dependency detected
[   83.296539] 5.12.0-rc3+ #25 Tainted: G        W
[   83.296539] --------------------------------------------------------
[   83.296540] bash/780 just changed the state of lock:
[   83.296540] ffffffff82b29c98 (device_domain_lock){..-.}-{2:2}, at:
           iommu_flush_dev_iotlb.part.0+0x32/0x110
[   83.296547] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   83.296547]  (pasid_lock){+.+.}-{2:2}
[   83.296548]

           and interrupts could create inverse lock ordering between them.

[   83.296549] other info that might help us debug this:
[   83.296549] Chain exists of:
                 device_domain_lock --> &iommu->lock --> pasid_lock
[   83.296551]  Possible interrupt unsafe locking scenario:

[   83.296551]        CPU0                    CPU1
[   83.296552]        ----                    ----
[   83.296552]   lock(pasid_lock);
[   83.296553]                                local_irq_disable();
[   83.296553]                                lock(device_domain_lock);
[   83.296554]                                lock(&iommu->lock);
[   83.296554]   <Interrupt>
[   83.296554]     lock(device_domain_lock);
[   83.296555]
                *** DEADLOCK ***

Fix it by replacing the pasid_lock with an atomic exchange operation.

Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 9fb3d3e80408..1ddcb8295f72 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -24,7 +24,6 @@
 /*
  * Intel IOMMU system wide PASID name space:
  */
-static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
 
 int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
@@ -259,19 +258,18 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	index = pasid & PASID_PTE_MASK;
 
-	spin_lock(&pasid_lock);
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
 		entries = alloc_pgtable_page(info->iommu->node);
-		if (!entries) {
-			spin_unlock(&pasid_lock);
+		if (!entries)
 			return NULL;
-		}
 
-		WRITE_ONCE(dir[dir_index].val,
-			   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT);
+		if (cmpxchg64(&dir[dir_index].val, 0ULL,
+			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
+			free_pgtable_page(entries);
+			entries = get_pasid_table_from_pde(&dir[dir_index]);
+		}
 	}
-	spin_unlock(&pasid_lock);
 
 	return &entries[index];
 }
-- 
2.25.1

