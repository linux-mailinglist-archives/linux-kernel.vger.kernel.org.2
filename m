Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871037F650
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhEMLFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:05:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:45133 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233166AbhEMLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:04:27 -0400
IronPort-SDR: ujgZFsbYmqt5NueXv7eCOerjt4bY26hpWqnNLGqNgHYF9xE2Mcfak+i+EGoP77VqSyRwCbNOn/
 nVSbvrC031uA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048345"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:26 -0700
IronPort-SDR: jsnnCi1IS9iU4wdLPc+RK7wG5nj6uE0CwtcM3ph3g2mcBsMOLSJQ/No14x+q8jSMYgzImIYCxk
 nvcjDTq/8GKQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984254"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:24 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: [PATCH v3 12/14] intel_gna: add a 'misc' device
Date:   Thu, 13 May 2021 13:00:38 +0200
Message-Id: <20210513110040.2268-13-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new 'misc' device is the node for applications in user space to
interact with the driver.

Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
---
 drivers/misc/intel/gna/device.c | 52 +++++++++++++++++++++++++++++++--
 drivers/misc/intel/gna/device.h | 11 +++----
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 0e31b8c6bb70..1e6345a8325b 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -20,6 +20,18 @@ module_param(recovery_timeout, int, 0644);
 MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
 #endif
 
+struct file;
+
+static int gna_open(struct inode *inode, struct file *f)
+{
+	return -EPERM;
+}
+
+static const struct file_operations gna_file_ops = {
+	.owner		=	THIS_MODULE,
+	.open		=	gna_open,
+};
+
 static void gna_devm_idr_destroy(void *data)
 {
 	struct idr *idr = data;
@@ -27,6 +39,36 @@ static void gna_devm_idr_destroy(void *data)
 	idr_destroy(idr);
 }
 
+static void gna_devm_deregister_misc_dev(void *data)
+{
+	struct miscdevice *misc = data;
+
+	misc_deregister(misc);
+}
+
+static int gna_devm_register_misc_dev(struct device *parent, struct miscdevice *misc)
+{
+	int ret;
+
+	ret = misc_register(misc);
+	if (ret) {
+		dev_err(parent, "misc device %s registering failed. errcode: %d\n",
+			misc->name, ret);
+		gna_devm_deregister_misc_dev(misc);
+	} else {
+		dev_dbg(parent, "device: %s registered\n",
+			misc->name);
+	}
+
+	ret = devm_add_action(parent, gna_devm_deregister_misc_dev, misc);
+	if (ret) {
+		dev_err(parent, "could not add devm action for %s misc deregister\n", misc->name);
+		gna_devm_deregister_misc_dev(misc);
+	}
+
+	return ret;
+}
+
 static irqreturn_t gna_interrupt(int irq, void *priv)
 {
 	struct gna_private *gna_priv;
@@ -81,13 +123,13 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	gna_priv->recovery_timeout_jiffies = msecs_to_jiffies(recovery_timeout * 1000);
 	gna_priv->iobase = iobase;
 	gna_priv->info = *dev_info;
-	gna_priv->parent = parent;
+	gna_priv->misc.parent = parent;
 
 	dev_misc_name = devm_kasprintf(parent, GFP_KERNEL, "%s%d", GNA_DV_NAME, gna_priv->index);
 	if (!dev_misc_name)
 		return -ENOMEM;
 
-	gna_priv->name = dev_misc_name;
+	gna_priv->misc.name = dev_misc_name;
 
 	if (!(sizeof(dma_addr_t) > 4) ||
 		dma_set_mask(parent, DMA_BIT_MASK(64))) {
@@ -145,7 +187,11 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 		return ret;
 	}
 
-	return 0;
+	gna_priv->misc.minor = MISC_DYNAMIC_MINOR;
+	gna_priv->misc.fops = &gna_file_ops;
+	gna_priv->misc.mode = 0666;
+
+	return gna_devm_register_misc_dev(parent, &gna_priv->misc);
 }
 
 static u32 gna_device_type_by_hwid(u32 hwid)
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index 75784882f57c..ea3caf679c77 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/list.h>
+#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
@@ -41,8 +42,8 @@ struct gna_private {
 
 	int recovery_timeout_jiffies;
 
-	const char *name;
-	struct device *parent;
+	/* gna misc-device */
+	struct miscdevice misc;
 
 	/* hardware status set by interrupt handler */
 	u32 hw_status;
@@ -86,17 +87,17 @@ static inline void gna_reg_write(struct gna_private *gna_priv, u32 reg, u32 val)
 
 static inline struct device *gna_parent(struct gna_private *gna_priv)
 {
-	return gna_priv->parent;
+	return gna_priv->misc.parent;
 }
 
 static inline const char *gna_name(struct gna_private *gna_priv)
 {
-	return gna_priv->name;
+	return gna_priv->misc.name;
 }
 
 static inline struct device *gna_dev(struct gna_private *gna_priv)
 {
-	return gna_priv->parent;
+	return gna_priv->misc.this_device;
 }
 
 #endif /* __GNA_DEVICE_H__ */
-- 
2.28.0

