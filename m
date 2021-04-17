Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEC362D22
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhDQDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:34209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235608AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: 8Wc11i9n9O7RRcaCUt6yMwdxnrSgtB4EJANX+ZeYZ4sjiwwVB4np3kgr/OXKVoqPyxp16RBxzJ
 DRJZQqvrIBLg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256455866"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256455866"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:50 -0700
IronPort-SDR: N6FH7MiD98g5cQmt2SjRa/GEAA/bg+vGb3V+JwHpcucmt5xTvOqLqApzAwZwqOCN32kH0He75O
 HPkD6Is8Pmlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="616120799"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2021 20:12:49 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id BD50458090C;
        Fri, 16 Apr 2021 20:12:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/9] platform/x86: intel_pmc_core: Add option to set/clear LPM mode
Date:   Fri, 16 Apr 2021 20:12:50 -0700
Message-Id: <20210417031252.3020837-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2:	- Rebase on Tamar/Tomas global reset patch that already adds
	  Extended Test Register 3
	- In write function, make sure count is 1 less than buffer to reserve
	  space for '\0'
	- Use sysfs_streq to properly compare the input string

 drivers/platform/x86/intel_pmc_core.c | 112 ++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  20 +++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 684f13f0c4a5..97cf3384c4c0 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -586,6 +586,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
 	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
@@ -1321,6 +1322,114 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
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
+	if (reg & LPM_STS_LATCH_MODE) {
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
+	unsigned char buf[8];
+	size_t ret;
+	int idx, m, mode;
+	u32 reg;
+
+	if (count > sizeof(buf) - 1)
+		return -EINVAL;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[count] = '\0';
+
+	/*
+	 * Allowed strings are:
+	 *	Any enabled substate, e.g. 'S0i2.0'
+	 *	'c10'
+	 *	'clear'
+	 */
+	mode = sysfs_match_string(pmc_lpm_modes, buf);
+
+	/* Check string matches enabled mode */
+	pmc_for_each_mode(idx, m, pmcdev)
+		if (mode == m)
+			break;
+
+	if (mode != m || mode < 0) {
+		if (sysfs_streq(buf, "clear"))
+			clear = true;
+		else if (sysfs_streq(buf, "c10"))
+			c10 = true;
+		else
+			return -EINVAL;
+	}
+
+	if (clear) {
+		mutex_lock(&pmcdev->lock);
+
+		reg = pmc_core_reg_read(pmcdev, pmcdev->map->etr3_offset);
+		reg |= ETR3_CLEAR_LPM_EVENTS;
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
+		reg &= ~LPM_STS_LATCH_MODE;
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
+	reg = LPM_STS_LATCH_MODE | BIT(mode);
+	mutex_lock(&pmcdev->lock);
+	pmc_core_reg_write(pmcdev, pmcdev->map->lpm_sts_latch_en_offset, reg);
+	mutex_unlock(&pmcdev->lock);
+
+	return count;
+}
+DEFINE_PMC_CORE_ATTR_WRITE(pmc_core_lpm_latch_mode);
+
 static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1439,6 +1548,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 		debugfs_create_file("substate_live_status_registers", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_l_sts_regs_fops);
+		debugfs_create_file("lpm_latch_mode", 0644,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_lpm_latch_mode_fops);
 	}
 
 	if (pmcdev->lpm_req_regs) {
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 64fb368f40f6..c45805671c4a 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -189,6 +189,7 @@ enum ppfear_regs {
 
 #define LPM_MAX_NUM_MODES			8
 #define GET_X2_COUNTER(v)			((v) >> 1)
+#define LPM_STS_LATCH_MODE			BIT(31)
 
 #define TGL_NUM_IP_IGN_ALLOWED			22
 #define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
@@ -197,6 +198,7 @@ enum ppfear_regs {
 /*
  * Tigerlake Power Management Controller register offsets
  */
+#define TGL_LPM_STS_LATCH_EN_OFFSET		0x1C34
 #define TGL_LPM_EN_OFFSET			0x1C78
 #define TGL_LPM_RESIDENCY_OFFSET		0x1C80
 
@@ -211,6 +213,9 @@ enum ppfear_regs {
 #define ETR3_CF9GR				BIT(20)
 #define ETR3_CF9LOCK				BIT(31)
 
+/* Extended Test Mode Register LPM bits (TGL and later */
+#define ETR3_CLEAR_LPM_EVENTS			BIT(28)
+
 const char *pmc_lpm_modes[] = {
 	"S0i2.0",
 	"S0i2.1",
@@ -271,6 +276,7 @@ struct pmc_reg_map {
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
 	const int lpm_res_counter_step_x2;
+	const u32 lpm_sts_latch_en_offset;
 	const u32 lpm_en_offset;
 	const u32 lpm_priority_offset;
 	const u32 lpm_residency_offset;
@@ -319,4 +325,18 @@ struct pmc_dev {
 	     i < pmcdev->num_lpm_modes;			\
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

