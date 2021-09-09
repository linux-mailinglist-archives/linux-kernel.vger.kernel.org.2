Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840AB40490E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhIILTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhIILTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:16 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0321C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:18:06 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 405EB60F; Thu,  9 Sep 2021 13:18:03 +0200 (CEST)
Date:   Thu, 9 Sep 2021 13:17:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to
 AVIC
Message-ID: <YTntZSVDjQ5yb0NQ@8bytes.org>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
 <YTB/jWr9vb6xvTQp@8bytes.org>
 <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, after this triggered a defconfig compile warning, I squashed patch
1 and 2 into one and also #ifdef'ed check_feature_on_all_iommus(). The
result is here:

From c3811a50addd23b9bb5a36278609ee1638debcf6 Mon Sep 17 00:00:00 2001
From: Wei Huang <wei.huang2@amd.com>
Date: Fri, 20 Aug 2021 15:29:55 -0500
Subject: [PATCH] iommu/amd: Relocate GAMSup check to early_enable_iommus

Currently, iommu_init_ga() checks and disables IOMMU VAPIC support
(i.e. AMD AVIC support in IOMMU) when GAMSup feature bit is not set.
However it forgets to clear IRQ_POSTING_CAP from the previously set
amd_iommu_irq_ops.capability.

This triggers an invalid page fault bug during guest VM warm reboot
if AVIC is enabled since the irq_remapping_cap(IRQ_POSTING_CAP) is
incorrectly set, and crash the system with the following kernel trace.

    BUG: unable to handle page fault for address: 0000000000400dd8
    RIP: 0010:amd_iommu_deactivate_guest_mode+0x19/0xbc
    Call Trace:
     svm_set_pi_irte_mode+0x8a/0xc0 [kvm_amd]
     ? kvm_make_all_cpus_request_except+0x50/0x70 [kvm]
     kvm_request_apicv_update+0x10c/0x150 [kvm]
     svm_toggle_avic_for_irq_window+0x52/0x90 [kvm_amd]
     svm_enable_irq_window+0x26/0xa0 [kvm_amd]
     vcpu_enter_guest+0xbbe/0x1560 [kvm]
     ? avic_vcpu_load+0xd5/0x120 [kvm_amd]
     ? kvm_arch_vcpu_load+0x76/0x240 [kvm]
     ? svm_get_segment_base+0xa/0x10 [kvm_amd]
     kvm_arch_vcpu_ioctl_run+0x103/0x590 [kvm]
     kvm_vcpu_ioctl+0x22a/0x5d0 [kvm]
     __x64_sys_ioctl+0x84/0xc0
     do_syscall_64+0x33/0x40
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes by moving the initializing of AMD IOMMU interrupt remapping mode
(amd_iommu_guest_ir) earlier before setting up the
amd_iommu_irq_ops.capability with appropriate IRQ_POSTING_CAP flag.

[joro:	Squashed the two patches and limited
	check_features_on_all_iommus() to CONFIG_IRQ_REMAP
	to fix a compile warning.]

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20210820202957.187572-2-suravee.suthikulpanit@amd.com
Link: https://lore.kernel.org/r/20210820202957.187572-3-suravee.suthikulpanit@amd.com
Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bdcf167b4afe..4e753d1860b3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -297,6 +297,22 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+#ifdef CONFIG_IRQ_REMAP
+static bool check_feature_on_all_iommus(u64 mask)
+{
+	bool ret = false;
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		ret = iommu_feature(iommu, mask);
+		if (!ret)
+			return false;
+	}
+
+	return true;
+}
+#endif
+
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
  * Default to IVHD EFR since it is available sooner
@@ -853,13 +869,6 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	int ret = 0;
 
 #ifdef CONFIG_IRQ_REMAP
-	/* Note: We have already checked GASup from IVRS table.
-	 *       Now, we need to make sure that GAMSup is set.
-	 */
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !iommu_feature(iommu, FEATURE_GAM_VAPIC))
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-
 	ret = iommu_init_ga_log(iommu);
 #endif /* CONFIG_IRQ_REMAP */
 
@@ -2479,6 +2488,14 @@ static void early_enable_iommus(void)
 	}
 
 #ifdef CONFIG_IRQ_REMAP
+	/*
+	 * Note: We have already checked GASup from IVRS table.
+	 *       Now, we need to make sure that GAMSup is set.
+	 */
+	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
 #endif
-- 
2.33.0

