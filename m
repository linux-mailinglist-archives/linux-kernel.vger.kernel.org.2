Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA5350CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhDADGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:06:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:2838 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhDADGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:06:17 -0400
IronPort-SDR: U3w7ShK+jodgrBgrV9t2FFDkrZ9+XWmj83WLaoPyuqtOjp6q7ZwXSCjv37j+Z9mTORow990I2Y
 fRArp4TLd6hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="256124342"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="256124342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 20:06:17 -0700
IronPort-SDR: z7T/Y8Q9ujTeVKJ/7opEvAERzG7lvXFzKuwGvXlDc11oMyb3w/HpmL2Xt2WacblDLIqm/fLXxl
 Bjg4P0VIHzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="517155103"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 20:06:16 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 614EA5808ED;
        Wed, 31 Mar 2021 20:06:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] platform/x86: intel_pmc_core: Remove global struct pmc_dev
Date:   Wed, 31 Mar 2021 20:05:51 -0700
Message-Id: <20210401030558.2301621-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_pmc_core driver did not always bind to a device which meant it
lacked a struct device that could be used to maintain driver data. So a
global instance of struct pmc_dev was used for this purpose and functions
accessed this directly. Since the driver now binds to an ACPI device,
remove the global pmc_dev in favor of one that is allocated during probe.
Modify users of the global to obtain the object by argument instead.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 260d49dca1ad..5ca40fe3da59 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -31,8 +31,6 @@
 
 #include "intel_pmc_core.h"
 
-static struct pmc_dev pmc;
-
 /* PKGC MSRs are common across Intel Core SoCs */
 static const struct pmc_bit_map msr_map[] = {
 	{"Package C2",                  MSR_PKG_C2_RESIDENCY},
@@ -617,9 +615,8 @@ static int pmc_core_dev_state_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_dev_state, pmc_core_dev_state_get, NULL, "%llu\n");
 
-static int pmc_core_check_read_lock_bit(void)
+static int pmc_core_check_read_lock_bit(struct pmc_dev *pmcdev)
 {
-	struct pmc_dev *pmcdev = &pmc;
 	u32 value;
 
 	value = pmc_core_reg_read(pmcdev, pmcdev->map->pm_cfg_offset);
@@ -744,28 +741,26 @@ static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 DEFINE_SHOW_ATTRIBUTE(pmc_core_ppfear);
 
 /* This function should return link status, 0 means ready */
-static int pmc_core_mtpmc_link_status(void)
+static int pmc_core_mtpmc_link_status(struct pmc_dev *pmcdev)
 {
-	struct pmc_dev *pmcdev = &pmc;
 	u32 value;
 
 	value = pmc_core_reg_read(pmcdev, SPT_PMC_PM_STS_OFFSET);
 	return value & BIT(SPT_PMC_MSG_FULL_STS_BIT);
 }
 
-static int pmc_core_send_msg(u32 *addr_xram)
+static int pmc_core_send_msg(struct pmc_dev *pmcdev, u32 *addr_xram)
 {
-	struct pmc_dev *pmcdev = &pmc;
 	u32 dest;
 	int timeout;
 
 	for (timeout = NUM_RETRIES; timeout > 0; timeout--) {
-		if (pmc_core_mtpmc_link_status() == 0)
+		if (pmc_core_mtpmc_link_status(pmcdev) == 0)
 			break;
 		msleep(5);
 	}
 
-	if (timeout <= 0 && pmc_core_mtpmc_link_status())
+	if (timeout <= 0 && pmc_core_mtpmc_link_status(pmcdev))
 		return -EBUSY;
 
 	dest = (*addr_xram & MTPMC_MASK) | (1U << 1);
@@ -791,7 +786,7 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 
 	mutex_lock(&pmcdev->lock);
 
-	if (pmc_core_send_msg(&mphy_core_reg_low) != 0) {
+	if (pmc_core_send_msg(pmcdev, &mphy_core_reg_low) != 0) {
 		err = -EBUSY;
 		goto out_unlock;
 	}
@@ -799,7 +794,7 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 	msleep(10);
 	val_low = pmc_core_reg_read(pmcdev, SPT_PMC_MFPMC_OFFSET);
 
-	if (pmc_core_send_msg(&mphy_core_reg_high) != 0) {
+	if (pmc_core_send_msg(pmcdev, &mphy_core_reg_high) != 0) {
 		err = -EBUSY;
 		goto out_unlock;
 	}
@@ -842,7 +837,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	mphy_common_reg  = (SPT_PMC_MPHY_COM_STS_0 << 16);
 	mutex_lock(&pmcdev->lock);
 
-	if (pmc_core_send_msg(&mphy_common_reg) != 0) {
+	if (pmc_core_send_msg(pmcdev, &mphy_common_reg) != 0) {
 		err = -EBUSY;
 		goto out_unlock;
 	}
@@ -863,9 +858,8 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-static int pmc_core_send_ltr_ignore(u32 value)
+static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 {
-	struct pmc_dev *pmcdev = &pmc;
 	const struct pmc_reg_map *map = pmcdev->map;
 	u32 reg;
 	int err = 0;
@@ -891,6 +885,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 					 const char __user *userbuf,
 					 size_t count, loff_t *ppos)
 {
+	struct seq_file *s = file->private_data;
+	struct pmc_dev *pmcdev = s->private;
 	u32 buf_size, value;
 	int err;
 
@@ -900,7 +896,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(value);
+	err = pmc_core_send_ltr_ignore(pmcdev, value);
 
 	return err == 0 ? count : err;
 }
@@ -1228,13 +1224,19 @@ static void pmc_core_do_dmi_quirks(struct pmc_dev *pmcdev)
 static int pmc_core_probe(struct platform_device *pdev)
 {
 	static bool device_initialized;
-	struct pmc_dev *pmcdev = &pmc;
+	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
 	u64 slp_s0_addr;
 
 	if (device_initialized)
 		return -ENODEV;
 
+	pmcdev = devm_kzalloc(&pdev->dev, sizeof(*pmcdev), GFP_KERNEL);
+	if (!pmcdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pmcdev);
+
 	cpu_id = x86_match_cpu(intel_pmc_core_ids);
 	if (!cpu_id)
 		return -ENODEV;
@@ -1264,8 +1266,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&pmcdev->lock);
-	platform_set_drvdata(pdev, pmcdev);
-	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
+	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	/*
@@ -1274,7 +1275,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	 */
 	if (pmcdev->map == &tgl_reg_map) {
 		dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
-		pmc_core_send_ltr_ignore(3);
+		pmc_core_send_ltr_ignore(pmcdev, 3);
 	}
 
 	pmc_core_dbgfs_register(pmcdev);
-- 
2.25.1

