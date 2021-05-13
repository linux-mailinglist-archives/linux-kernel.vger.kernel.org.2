Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B538C37F657
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEMLGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:06:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:45138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhEMLE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:04:56 -0400
IronPort-SDR: VO5Uwcz1s7cglbI9HeD+WCvZE4j9Yn9TJnyQpyZLxrUrEaynvzl0aU6u5J1rSKc+3rw0MMVXxh
 6Z1xM+4Pburw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048406"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048406"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:31 -0700
IronPort-SDR: Gcvd0heUu5Qpp4h0DBF1BcV/EuAd7y/R7hMd8DCnjqb8rnGomajjvSXnKx68NfSclkuLZnPTI9
 HgPhTcIeb0uw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984335"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:29 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>
Subject: [PATCH v3 14/14] intel_gna: add power management
Date:   Thu, 13 May 2021 13:00:40 +0200
Message-Id: <20210513110040.2268-15-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement power management in intel_gna driver

Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
---
 drivers/misc/intel/gna/device.c  | 55 +++++++++++++++++++++++++++++++-
 drivers/misc/intel/gna/device.h  |  3 ++
 drivers/misc/intel/gna/hw.h      |  1 +
 drivers/misc/intel/gna/pci.c     |  3 ++
 drivers/misc/intel/gna/request.c | 15 +++++++++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index c882055de8cf..d7b0697bdd7c 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -22,6 +22,30 @@ module_param(recovery_timeout, int, 0644);
 MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
 #endif
 
+static int __maybe_unused gna_runtime_suspend(struct device *dev)
+{
+	struct gna_private *gna_priv = dev_get_drvdata(dev);
+	u32 val = gna_reg_read(gna_priv, GNA_MMIO_D0I3C);
+
+	dev_dbg(dev, "%s D0I3, reg %.8x\n", __func__, val);
+
+	return 0;
+}
+
+static int __maybe_unused gna_runtime_resume(struct device *dev)
+{
+	struct gna_private *gna_priv = dev_get_drvdata(dev);
+	u32 val = gna_reg_read(gna_priv, GNA_MMIO_D0I3C);
+
+	dev_dbg(dev, "%s D0I3, reg %.8x\n", __func__, val);
+
+	return 0;
+}
+
+const struct dev_pm_ops __maybe_unused gna_pm = {
+	SET_RUNTIME_PM_OPS(gna_runtime_suspend, gna_runtime_resume, NULL)
+};
+
 static int gna_open(struct inode *inode, struct file *f)
 {
 	struct gna_file_private *file_priv;
@@ -123,6 +147,22 @@ static int gna_devm_register_misc_dev(struct device *parent, struct miscdevice *
 	return ret;
 }
 
+static void gna_pm_init(struct device *dev)
+{
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_allow(dev);
+	pm_runtime_put_noidle(dev);
+}
+
+static void gna_pm_remove(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_get_noresume(dev);
+}
+
 static irqreturn_t gna_interrupt(int irq, void *priv)
 {
 	struct gna_private *gna_priv;
@@ -245,7 +285,20 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	gna_priv->misc.fops = &gna_file_ops;
 	gna_priv->misc.mode = 0666;
 
-	return gna_devm_register_misc_dev(parent, &gna_priv->misc);
+	ret = gna_devm_register_misc_dev(parent, &gna_priv->misc);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(parent, gna_priv);
+
+	gna_pm_init(parent);
+	ret = devm_add_action(parent, gna_pm_remove, parent);
+	if (ret) {
+		dev_err(parent, "could not add devm action for pm\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 static u32 gna_device_type_by_hwid(u32 hwid)
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index ea3caf679c77..a0e28d05ebfa 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -75,6 +76,8 @@ struct gna_private {
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase, int irq);
 int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param);
 
+extern const struct dev_pm_ops __maybe_unused gna_pm;
+
 static inline u32 gna_reg_read(struct gna_private *gna_priv, u32 reg)
 {
 	return readl(gna_priv->iobase + reg);
diff --git a/drivers/misc/intel/gna/hw.h b/drivers/misc/intel/gna/hw.h
index 2a6890fb748e..c0a8120b84d9 100644
--- a/drivers/misc/intel/gna/hw.h
+++ b/drivers/misc/intel/gna/hw.h
@@ -49,6 +49,7 @@ struct gna_private;
 #define GNA_MMIO_CTRL		0x84
 #define GNA_MMIO_PTC		0x8C
 #define GNA_MMIO_PSC		0x90
+#define GNA_MMIO_D0I3C		0xA8
 #define GNA_MMIO_DESBASE	0xB0
 #define GNA_MMIO_IBUFFS		0xB4
 
diff --git a/drivers/misc/intel/gna/pci.c b/drivers/misc/intel/gna/pci.c
index a31f0142a4f2..4aad4cf702b7 100644
--- a/drivers/misc/intel/gna/pci.c
+++ b/drivers/misc/intel/gna/pci.c
@@ -139,6 +139,9 @@ static struct pci_driver gna_pci_driver = {
 	.name = GNA_DV_NAME,
 	.id_table = gna_pci_ids,
 	.probe = gna_pci_probe,
+	.driver = {
+		.pm = &gna_pm,
+	},
 };
 
 module_pci_driver(gna_pci_driver);
diff --git a/drivers/misc/intel/gna/request.c b/drivers/misc/intel/gna/request.c
index eabbab8924be..e923f0d2651d 100644
--- a/drivers/misc/intel/gna/request.c
+++ b/drivers/misc/intel/gna/request.c
@@ -6,6 +6,7 @@
 #include <linux/idr.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
@@ -65,6 +66,14 @@ static void gna_request_process(struct work_struct *work)
 
 	score_request->drv_perf.pre_processing = ktime_get_ns();
 
+	ret = pm_runtime_get_sync(gna_parent(gna_priv));
+	if (ret < 0 && ret != -EACCES) {
+		dev_warn(gna_dev(gna_priv), "pm_runtime_get_sync() failed: %d\n", ret);
+		score_request->status = -ENODEV;
+		pm_runtime_put_noidle(gna_parent(gna_priv));
+		goto end;
+	}
+
 	/* Set busy flag before kicking off HW. The isr will clear it and wake up us. There is
 	 * no difference if isr is missed in a timeout situation of the last request. We just
 	 * always set it busy and let the wait_event_timeout check the reset.
@@ -75,6 +84,8 @@ static void gna_request_process(struct work_struct *work)
 
 	ret = gna_score(score_request);
 	if (ret) {
+		if (pm_runtime_put(gna_parent(gna_priv)) < 0)
+			dev_warn(gna_dev(gna_priv), "pm_runtime_put() failed: %d\n", ret);
 		score_request->status = ret;
 		goto end;
 	}
@@ -94,6 +105,10 @@ static void gna_request_process(struct work_struct *work)
 	gna_request_update_status(score_request);
 	gna_abort_hw(gna_priv);
 
+	ret = pm_runtime_put(gna_parent(gna_priv));
+	if (ret < 0)
+		dev_warn(gna_dev(gna_priv), "pm_runtime_put() failed: %d\n", ret);
+
 	buffer = score_request->buffer_list;
 	for (i = 0; i < score_request->buffer_count; i++, buffer++) {
 		mutex_lock(&gna_priv->memidr_lock);
-- 
2.28.0

