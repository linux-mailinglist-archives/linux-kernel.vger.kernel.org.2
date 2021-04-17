Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE23362D25
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhDQDNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:64780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235629AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: KbVTLkqRiMa1f5JBR6mz3rO33R3Nk+5lI4gvi1OPiyOxHWUznQOOeujpoZdclAA9fU+49Kt/pM
 YOajcFiLEiSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182636638"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="182636638"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:49 -0700
IronPort-SDR: /tZWQZ9yHTA7dq2W4Ci4jqzyEESD9D5qKzx9ePgonwHpxoIGlwIEJwiT4ufMu/8CV8kLt5fysw
 LnwNbwH8sbpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="419344502"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2021 20:12:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 33C47580911;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/9] platform/x86: intel_pmc_core: Handle sub-states generically
Date:   Fri, 16 Apr 2021 20:12:46 -0700
Message-Id: <20210417031252.3020837-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

The current implementation of pmc_core_substate_res_show() is written
specifically for Tiger Lake. However, new platform will also have
sub-states and may support different modes. Therefore rewrite the code to
handle sub-states generically.

Obtain the number and type of enabled states form the PMC. Use the Low
Power Mode (LPM) priority register to store the states in order from
shallowest to deepest for displays. Add a for_each macro to simplify
this. While changing the sub-state display it makes sense to show only the
"enabled" sub-states instead of showing all possible ones. After this
patch, the debugfs file looks like this:

Substate   Residency
S0i2.0     0
S0i3.0     0
S0i2.1     9329279
S0i3.1     0
S0i3.2     0

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
---

V2:	Renamed num_modes to num_lpm_modes as suggested by Rajneesh

 drivers/platform/x86/intel_pmc_core.c | 59 ++++++++++++++++++++++-----
 drivers/platform/x86/intel_pmc_core.h | 18 +++++++-
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index e8474d171d23..c02f63c00ecc 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -579,8 +579,9 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
-	.lpm_modes = tgl_lpm_modes,
+	.lpm_num_maps = TGL_LPM_NUM_MAPS,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
+	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
 	.lpm_sts = tgl_lpm_maps,
 	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
@@ -1140,18 +1141,14 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	const char **lpm_modes = pmcdev->map->lpm_modes;
 	u32 offset = pmcdev->map->lpm_residency_offset;
-	u32 lpm_en;
-	int index;
+	int i, mode;
 
-	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
-	seq_printf(s, "status substate residency\n");
-	for (index = 0; lpm_modes[index]; index++) {
-		seq_printf(s, "%7s %7s %-15u\n",
-			   BIT(index) & lpm_en ? "Enabled" : " ",
-			   lpm_modes[index], pmc_core_reg_read(pmcdev, offset));
-		offset += 4;
+	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
+
+	pmc_for_each_mode(i, mode, pmcdev) {
+		seq_printf(s, "%-10s %-15u\n", pmc_lpm_modes[mode],
+			   pmc_core_reg_read(pmcdev, offset + (4 * mode)));
 	}
 
 	return 0;
@@ -1203,6 +1200,45 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
 
+static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
+{
+	u8 lpm_priority[LPM_MAX_NUM_MODES];
+	u32 lpm_en;
+	int mode, i, p;
+
+	/* Use LPM Maps to indicate support for substates */
+	if (!pmcdev->map->lpm_num_maps)
+		return;
+
+	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
+	pmcdev->num_lpm_modes = hweight32(lpm_en);
+
+	/* Each byte contains information for 2 modes (7:4 and 3:0) */
+	for (mode = 0; mode < LPM_MAX_NUM_MODES; mode += 2) {
+		u8 priority = pmc_core_reg_read_byte(pmcdev,
+				pmcdev->map->lpm_priority_offset + (mode / 2));
+		int pri0 = GENMASK(3, 0) & priority;
+		int pri1 = (GENMASK(7, 4) & priority) >> 4;
+
+		lpm_priority[pri0] = mode;
+		lpm_priority[pri1] = mode + 1;
+	}
+
+	/*
+	 * Loop though all modes from lowest to highest priority,
+	 * and capture all enabled modes in order
+	 */
+	i = 0;
+	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
+		int mode = lpm_priority[p];
+
+		if (!(BIT(mode) & lpm_en))
+			continue;
+
+		pmcdev->lpm_en_modes[i++] = mode;
+	}
+}
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -1379,6 +1415,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 
 	mutex_init(&pmcdev->lock);
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
+	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	/*
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 98ebdfe57138..2ffe0eba36e1 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -187,6 +187,8 @@ enum ppfear_regs {
 #define ICL_PMC_LTR_WIGIG			0x1BFC
 #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 
+#define LPM_MAX_NUM_MODES			8
+
 #define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
 
@@ -199,13 +201,15 @@ enum ppfear_regs {
 /* Tigerlake Low Power Mode debug registers */
 #define TGL_LPM_STATUS_OFFSET			0x1C3C
 #define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
+#define TGL_LPM_PRI_OFFSET			0x1C7C
+#define TGL_LPM_NUM_MAPS			6
 
 /* Extended Test Mode Register 3 (CNL and later) */
 #define ETR3_OFFSET				0x1048
 #define ETR3_CF9GR				BIT(20)
 #define ETR3_CF9LOCK				BIT(31)
 
-const char *tgl_lpm_modes[] = {
+const char *pmc_lpm_modes[] = {
 	"S0i2.0",
 	"S0i2.1",
 	"S0i2.2",
@@ -263,8 +267,9 @@ struct pmc_reg_map {
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
 	/* Low Power Mode registers */
-	const char **lpm_modes;
+	const int lpm_num_maps;
 	const u32 lpm_en_offset;
+	const u32 lpm_priority_offset;
 	const u32 lpm_residency_offset;
 	const u32 lpm_status_offset;
 	const u32 lpm_live_status_offset;
@@ -284,6 +289,8 @@ struct pmc_reg_map {
  * @check_counters:	On resume, check if counters are getting incremented
  * @pc10_counter:	PC10 residency counter
  * @s0ix_counter:	S0ix residency (step adjusted)
+ * @num_lpm_modes:	Count of enabled modes
+ * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -298,6 +305,13 @@ struct pmc_dev {
 	bool check_counters; /* Check for counter increments on resume */
 	u64 pc10_counter;
 	u64 s0ix_counter;
+	int num_lpm_modes;
+	int lpm_en_modes[LPM_MAX_NUM_MODES];
 };
 
+#define pmc_for_each_mode(i, mode, pmcdev)		\
+	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
+	     i < pmcdev->num_lpm_modes;			\
+	     i++, mode = pmcdev->lpm_en_modes[i])
+
 #endif /* PMC_CORE_H */
-- 
2.25.1

