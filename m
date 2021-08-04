Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66D53E0A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhHDVlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:41:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:20975 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhHDVlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:41:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="299608443"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="299608443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 14:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="467271217"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2021 14:40:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id CD07958090B;
        Wed,  4 Aug 2021 14:40:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: intel_pmc_core: Prevent possibile overflow
Date:   Wed,  4 Aug 2021 14:38:43 -0700
Message-Id: <20210804213843.498937-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Low Power Mode (LPM) priority is encoded in 4 bits. Yet, this value is used
as an index to an array whose element size was less than 16, leading to the
possibility of overflow should we read a larger than expected priority.  In
addition to the overflow, bad values can lead to incorrect state reporting.
So rework the priority code to prevent the overflow and perform some
validation of the register. Use the priority register values if they give
an ordering of unique numbers between 0 and the maximum number of states.
Otherwise, use a default ordering instead.

Reported-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

v2:	Remove lpm_priority size increase. Instead, remove that array and
	create 2 new local arrays, one to save priority levels in mode order,
	and one to save modes in priority order. Use the mode_order list to
	validate that no priority level is above the maximum and to validate
	that they are all unique values. Then we can safely create a
	priority_order list that will be the basis of how we report substate
	information.

 drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
 drivers/platform/x86/intel_pmc_core.h |  4 ++
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index b0e486a6bdfb..0f623c422d4e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1449,11 +1449,15 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
 
-static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
+static void pmc_core_get_low_power_modes(struct platform_device *pdev)
 {
-	u8 lpm_priority[LPM_MAX_NUM_MODES];
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
+	u8 mode_order[LPM_MAX_NUM_MODES];
+	u32 lpm_pri;
 	u32 lpm_en;
-	int mode, i, p;
+	int mode, i, j, p;
+	bool bad_pri_reg = false;
 
 	/* Use LPM Maps to indicate support for substates */
 	if (!pmcdev->map->lpm_num_maps)
@@ -1462,24 +1466,59 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
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
+	if (!lpm_pri)
+		bad_pri_reg = true;
+
+	if (!bad_pri_reg) {
+		/*
+		 * Each byte contains gives the priority level for 2 modes (7:4 and 3:0).
+		 * In a 32 bit register this allows for describing 8 modes. Store the
+		 * levels and look for values out of range.
+		 */
+		for (mode = 0; mode < 8; mode++) {
+			int level = GENMASK(3, 0) & lpm_pri;
 
-		lpm_priority[pri0] = mode;
-		lpm_priority[pri1] = mode + 1;
+			if (level >= LPM_MAX_NUM_MODES) {
+				bad_pri_reg = true;
+				break;
+			}
+
+			mode_order[mode] = level;
+			lpm_pri >>= 4;
+		}
 	}
 
+	if (!bad_pri_reg) {
+		/* Check that we have unique values */
+		for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
+			for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
+				if (mode_order[i] == mode_order[j]) {
+					bad_pri_reg = true;
+					break;
+				}
+	}
+
+	/*
+	 * If bad_pri_reg is false, then mode_order must contain unique values for
+	 * all priority levels from 0 to LPM_MAX_NUM_MODES and this loop with properly
+	 * overwrite our default ordering. Otherwise just use the default.
+	 */
+	if (!bad_pri_reg)
+		/* Get list of modes in priority order */
+		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
+			pri_order[mode_order[mode]] = mode;
+	else
+		dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
+
 	/*
 	 * Loop though all modes from lowest to highest priority,
 	 * and capture all enabled modes in order
 	 */
 	i = 0;
 	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
-		int mode = lpm_priority[p];
+		int mode = pri_order[p];
 
 		if (!(BIT(mode) & lpm_en))
 			continue;
@@ -1675,7 +1714,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	mutex_init(&pmcdev->lock);
 
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
-	pmc_core_get_low_power_modes(pmcdev);
+	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	if (pmcdev->map == &tgl_reg_map)
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index e8dae9c6c45f..9aaadb0f87df 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -188,6 +188,10 @@ enum ppfear_regs {
 #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 
 #define LPM_MAX_NUM_MODES			8
+
+/* Must contain LPM_MAX_NUM_MODES elements */
+#define LPM_DEFAULT_PRI				{ 7, 5, 2, 6, 4, 3, 1, 0 }
+
 #define GET_X2_COUNTER(v)			((v) >> 1)
 #define LPM_STS_LATCH_MODE			BIT(31)
 
-- 
2.25.1

