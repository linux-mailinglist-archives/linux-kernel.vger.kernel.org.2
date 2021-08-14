Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C63EBF6F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhHNBuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:50:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:23992 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236200AbhHNBuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:50:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195238741"
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="195238741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 18:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="674660337"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2021 18:49:53 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 07CFF5807C5;
        Fri, 13 Aug 2021 18:49:53 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/x86: intel_pmc_core: Prevent possibile overflow
Date:   Fri, 13 Aug 2021 18:47:28 -0700
Message-Id: <20210814014728.520856-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substate priority levels are encoded in 4 bits in the LPM_PRI register.
This value was used as an index to an array whose element size was less
than 16, leading to the possibility of overflow should we read a larger
than expected priority.  In addition to the overflow, bad values could lead
to incorrect state reporting.  So rework the priority code to prevent the
overflow and perform some validation of the register. Use the priority
register values if they give an ordering of unique numbers between 0 and
the maximum number of states.  Otherwise, use a default ordering instead.

Reported-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
v3:	Modifying Andy's suggestion, just place the entire verification
	in a separate function. If it fails, then keep the default
	ordering. If it passes, overwrite with the verified ordering.

	Fix error in default order array.

	Also fix spelling noted by Andy drop the size comment since
	the array size is set when declared.

v2:	Remove lpm_priority size increase. Instead, remove that array and
	create 2 new local arrays, one to save priority levels in mode order,
	and one to save modes in priority order. Use the mode_order list to
	validate that no priority level is above the maximum and to validate
	that they are all unique values. Then we can safely create a
	priority_order list that will be the basis of how we report substate
	information.

 drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
 drivers/platform/x86/intel_pmc_core.h |  2 +
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index b0e486a6bdfb..ae410a358ffe 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1449,9 +1449,42 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
 
-static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
+static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
 {
-	u8 lpm_priority[LPM_MAX_NUM_MODES];
+	int i, j;
+
+	if (!lpm_pri)
+		return false;
+	/*
+	 * Each byte contains the priority level for 2 modes (7:4 and 3:0).
+	 * In a 32 bit register this allows for describing 8 modes. Store the
+	 * levels and look for values out of range.
+	 */
+	for (i = 0; i < 8; i++) {
+		int level = lpm_pri & GENMASK(3, 0);
+
+		if (level >= LPM_MAX_NUM_MODES)
+			return false;
+
+		mode_order[i] = level;
+		lpm_pri >>= 4;
+	}
+
+	/* Check that we have unique values */
+	for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
+		for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
+			if (mode_order[i] == mode_order[j])
+				return false;
+
+	return true;
+}
+
+static void pmc_core_get_low_power_modes(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
+	u8 mode_order[LPM_MAX_NUM_MODES];
+	u32 lpm_pri;
 	u32 lpm_en;
 	int mode, i, p;
 
@@ -1462,24 +1495,28 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
 	pmcdev->num_lpm_modes = hweight32(lpm_en);
 
-	/* Each byte contains information for 2 modes (7:4 and 3:0) */
-	for (mode = 0; mode < LPM_MAX_NUM_MODES; mode += 2) {
-		u8 priority = pmc_core_reg_read_byte(pmcdev,
-				pmcdev->map->lpm_priority_offset + (mode / 2));
-		int pri0 = GENMASK(3, 0) & priority;
-		int pri1 = (GENMASK(7, 4) & priority) >> 4;
+	/* Read 32 bit LPM_PRI register */
+	lpm_pri = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_priority_offset);
 
-		lpm_priority[pri0] = mode;
-		lpm_priority[pri1] = mode + 1;
-	}
 
 	/*
-	 * Loop though all modes from lowest to highest priority,
+	 * If lpm_pri value passes verification, then override the default
+	 * modes here. Otherwise stick with the default.
+	 */
+	if (pmc_core_pri_verify(lpm_pri, mode_order))
+		/* Get list of modes in priority order */
+		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
+			pri_order[mode_order[mode]] = mode;
+	else
+		dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
+
+	/*
+	 * Loop through all modes from lowest to highest priority,
 	 * and capture all enabled modes in order
 	 */
 	i = 0;
 	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
-		int mode = lpm_priority[p];
+		int mode = pri_order[p];
 
 		if (!(BIT(mode) & lpm_en))
 			continue;
@@ -1675,7 +1712,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	mutex_init(&pmcdev->lock);
 
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
-	pmc_core_get_low_power_modes(pmcdev);
+	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	if (pmcdev->map == &tgl_reg_map)
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index e8dae9c6c45f..b9bf3d3d6f7a 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -188,6 +188,8 @@ enum ppfear_regs {
 #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 
 #define LPM_MAX_NUM_MODES			8
+#define LPM_DEFAULT_PRI				{ 7, 6, 2, 5, 4, 1, 3, 0 }
+
 #define GET_X2_COUNTER(v)			((v) >> 1)
 #define LPM_STS_LATCH_MODE			BIT(31)
 

base-commit: e4ec7a49ef8bb4edc85a0eee005d59fa65c94a0e
-- 
2.25.1

