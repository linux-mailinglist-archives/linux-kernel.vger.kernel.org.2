Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C75350CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhDADG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:60449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhDADGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:20 -0400
IronPort-SDR: o6IOM1jqE7sQv0xXGNzYpBAbVORz6Jpe1pLy3h8FUsYkF4/9CQw8sou6hwxQbMuz0lUPTbxgVP
 6Lihbs/4uuIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241102"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192241102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:16 -0700
IronPort-SDR: TYAUT1CXbZxMon8AwsjkMUEVHBOghmmrksUlr89TYVeZEF5+PXTAI5TSnPwrWYk3yB2T1ZEmWc
 CxlaKT47hRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="416487617"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id BC318580961;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] platform/x86: intel_pmc_core: Add option to set/clear LPM mode
Date:   Wed, 31 Mar 2021 20:05:56 -0700
Message-Id: <20210401030558.2301621-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the Low Power Mode (LPM or sub-state) status registers will
latch condition status on every entry into Package C10. This is
configurable in the PMC to allow latching on any achievable sub-state. Add
a debugfs file to support this.

Also add the option to clear the status registers to 0. Clearing the status
registers before testing removes ambiguity around when the current values
were set.

The new file, latch_lpm_mode, looks like this:

	[c10] S0i2.0 S0i3.0 S0i2.1 S0i3.1 S0i3.2 clear

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 94 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h | 20 ++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 0b47a1da5f49..458c0056e7a1 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -584,6 +584,8 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.etr3_offset = TGL_ETR3_OFFSET,
+	.lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
 	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
@@ -1202,6 +1204,95 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
 
+static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	bool c10;
+	u32 reg;
+	int idx, mode;
+
+	reg = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_sts_latch_en_offset);
+	if (reg & BIT(LPM_STS_LATCH_MODE_BIT)) {
+		seq_puts(s, "c10");
+		c10 = false;
+	} else {
+		seq_puts(s, "[c10]");
+		c10 = true;
+	}
+
+	pmc_for_each_mode(idx, mode, pmcdev) {
+		if ((BIT(mode) & reg) && !c10)
+			seq_printf(s, " [%s]", pmc_lpm_modes[mode]);
+		else
+			seq_printf(s, " %s", pmc_lpm_modes[mode]);
+	}
+
+	seq_puts(s, " clear\n");
+
+	return 0;
+}
+
+static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
+					     const char __user *userbuf,
+					     size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pmc_dev *pmcdev = s->private;
+	bool clear = false, c10 = false;
+	unsigned char buf[10] = {0};
+	size_t ret;
+	int mode;
+	u32 reg;
+
+	ret = simple_write_to_buffer(buf, 10, ppos, userbuf, count);
+	if (ret < 0)
+		return ret;
+
+	mode = sysfs_match_string(pmc_lpm_modes, buf);
+	if (mode < 0) {
+		if (strncmp("clear", buf, 5) == 0)
+			clear = true;
+		else if (strncmp("c10", buf, 3) == 0)
+			c10 = true;
+		else
+			return mode;
+	}
+
+	if (clear) {
+		mutex_lock(&pmcdev->lock);
+
+		reg = pmc_core_reg_read(pmcdev, pmcdev->map->etr3_offset);
+		reg |= BIT(ETR3_CLEAR_LPM_EVENTS_BIT);
+		pmc_core_reg_write(pmcdev, pmcdev->map->etr3_offset, reg);
+
+		mutex_unlock(&pmcdev->lock);
+
+		return count;
+	}
+
+	if (c10) {
+		mutex_lock(&pmcdev->lock);
+
+		reg = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_sts_latch_en_offset);
+		reg &= ~BIT(LPM_STS_LATCH_MODE_BIT);
+		pmc_core_reg_write(pmcdev, pmcdev->map->lpm_sts_latch_en_offset, reg);
+
+		mutex_unlock(&pmcdev->lock);
+
+		return count;
+	}
+
+	/*
+	 * For LPM mode latching we set the latch enable bit and selected mode
+	 * and clear everything else.
+	 */
+	reg = BIT(LPM_STS_LATCH_MODE_BIT) | BIT(mode);
+	pmc_core_reg_write(pmcdev, pmcdev->map->lpm_sts_latch_en_offset, reg);
+
+	return count;
+}
+DEFINE_PMC_CORE_ATTR_WRITE(pmc_core_lpm_latch_mode);
+
 static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1320,6 +1411,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 		debugfs_create_file("substate_live_status_registers", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_l_sts_regs_fops);
+		debugfs_create_file("lpm_latch_mode", 0644,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_lpm_latch_mode_fops);
 	}
 
 	if (pmcdev->lpm_req_regs) {
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 81d797feed33..f41f61aa7008 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -189,6 +189,8 @@ enum ppfear_regs {
 
 #define LPM_MAX_NUM_MODES			8
 #define GET_X2_COUNTER(v)			((v) >> 1)
+#define ETR3_CLEAR_LPM_EVENTS_BIT		28
+#define LPM_STS_LATCH_MODE_BIT			31
 
 #define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
@@ -197,6 +199,8 @@ enum ppfear_regs {
 /*
  * Tigerlake Power Management Controller register offsets
  */
+#define TGL_ETR3_OFFSET				0x1048
+#define TGL_LPM_STS_LATCH_EN_OFFSET		0x1C34
 #define TGL_LPM_EN_OFFSET			0x1C78
 #define TGL_LPM_RESIDENCY_OFFSET		0x1C80
 
@@ -266,6 +270,8 @@ struct pmc_reg_map {
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
 	const int lpm_res_counter_step_x2;
+	const u32 etr3_offset;
+	const u32 lpm_sts_latch_en_offset;
 	const u32 lpm_en_offset;
 	const u32 lpm_priority_offset;
 	const u32 lpm_residency_offset;
@@ -313,4 +319,18 @@ struct pmc_dev {
 	     i < pmcdev->num_modes;			\
 	     i++, mode = pmcdev->lpm_en_modes[i])
 
+#define DEFINE_PMC_CORE_ATTR_WRITE(__name)				\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.write		= __name ## _write,				\
+	.release	= single_release,				\
+}
+
 #endif /* PMC_CORE_H */
-- 
2.25.1

