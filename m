Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD439F414
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFHKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:51:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49115 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhFHKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:51:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 803795805DF;
        Tue,  8 Jun 2021 06:49:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 08 Jun 2021 06:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=9T7ZMQ5CKFVHg
        SD/G5Sj7gVjMK/KS0RDtTmI9RMQXWA=; b=L+sP8NyUhFoBEyB5bV12UnQXiQQi0
        JdQ9bhvlWAYz5+vvdmXoT4cx4bwm4oxE7jLdkzKEuS61I2EQO9BZ5FXAkW1UE9ZV
        a600L2SBILgY8NFgOkWT6Kq90bYQbK7+2HfKeC0cu3ndKwZqwxN8umn+ZErh9ZV8
        VJEkq7cwV0w7/kbJOpgVjqHKZwsRXaTCfrV4QFUgjueTVCQ72UXSfnW2SnYAOKt+
        qLpz1ropTYvAdotxRh1zkQgHZaoQio6lDvw6tgdnPdOIxqZx1k548ytl0xGsP/xH
        H3O64vSTHzPuqhEny8H79VEUmb60dHeJ8lpak8VSS3PU1S3e6Q5EDvygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9T7ZMQ5CKFVHgSD/G5Sj7gVjMK/KS0RDtTmI9RMQXWA=; b=aGzTlmC7
        bpw+zE5EAhjjInQTANGdjPg+DZUojjI/VQRc5yYVPF7qu2GdqyHeCrx7nvY/aMct
        z2ckSuwp9nq1bw7jQjeKI2v+T0WPpBeg/lzKu000tsxB9gfQEzLhO48cisJSgUJK
        LXnvbT19pYlqxu1RPD2a3HldU3aK22MtW3QfUhokVuyKoQOOlHYxdgHrWqmOt0on
        TqonKZplRbK4orLqjVcvHLAXjA1kgLQZ7wjbjtMqPljNjRP2WvVE/lxRY6/WmYgV
        T3OAfet7CvKHgnEulKKwcPGIPN3rU+KXejAICyeOSBAxNlj3i8OXT4elYnxWEj44
        6z1KsyntEKb0wA==
X-ME-Sender: <xms:K0u_YPmqKDlVuMgbgSfsqc4y6_XwUKEGUuKp3gii2CsQqkmnR01lRQ>
    <xme:K0u_YC2ebrNOULA3V5a8m-hYRt_fRZpd0vEvUEAofWO0uasn0KvIUFywqNq-ea2az
    HD6p16hVgz3JQqArg>
X-ME-Received: <xmr:K0u_YFofEpdRj1AmEPQZFPxkpXZOlfstJr1eKqgIaWM6A7Ic3GDicvb2ZvOhuCnE8YWbIOrVH8D7D74jUej7XoOmYwoXULGU65o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:K0u_YHmhvdLkZOFniUY4pkooAe1Ne-RHXtWXuzu0pWYGXbD_3KXV5A>
    <xmx:K0u_YN06oB9zFytAzi1IUsvaugMQ2Y_por6ZzlIwDQz7_HAOBZ4OEg>
    <xmx:K0u_YGs6vtZ5a1trslXGKmESGFCr_YARnK5lJqDyKTOjQm6VTXQPOg>
    <xmx:K0u_YOEm_QlvAjWNy2svjHfoceexyYlIo0jFljek87K5LhVkSmHa0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 06:49:09 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com,
        joel@jms.id.au, KWLIU@nuvoton.com
Subject: [PATCH v4 08/16] ipmi: kcs_bmc: Decouple the IPMI chardev from the core
Date:   Tue,  8 Jun 2021 20:17:49 +0930
Message-Id: <20210608104757.582199-9-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608104757.582199-1-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have untangled the data-structures, split the userspace
interface out into its own module. Userspace interfaces and drivers are
registered to the KCS BMC core to support arbitrary binding of either.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/Kconfig             | 13 +++++
 drivers/char/ipmi/Makefile            |  3 +-
 drivers/char/ipmi/kcs_bmc.c           | 80 +++++++++++++++++++++++++--
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 31 +++++++++--
 drivers/char/ipmi/kcs_bmc_client.h    | 14 +++++
 5 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 07847d9a459a..bc5f81899b62 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -124,6 +124,19 @@ config NPCM7XX_KCS_IPMI_BMC
 	  This support is also available as a module.  If so, the module
 	  will be called kcs_bmc_npcm7xx.
 
+config IPMI_KCS_BMC_CDEV_IPMI
+	depends on IPMI_KCS_BMC
+	tristate "IPMI character device interface for BMC KCS devices"
+	help
+	  Provides a BMC-side character device implementing IPMI
+	  semantics for KCS IPMI devices.
+
+	  Say YES if you wish to expose KCS devices on the BMC for IPMI
+	  purposes.
+
+	  This support is also available as a module. The module will be
+	  called kcs_bmc_cdev_ipmi.
+
 config ASPEED_BT_IPMI_BMC
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
index a302bc865370..fcfa676afddb 100644
--- a/drivers/char/ipmi/Makefile
+++ b/drivers/char/ipmi/Makefile
@@ -22,7 +22,8 @@ obj-$(CONFIG_IPMI_SSIF) += ipmi_ssif.o
 obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
 obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
 obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
-obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o kcs_bmc_cdev_ipmi.o
+obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
+obj-$(CONFIG_IPMI_KCS_BMC_CDEV_IPMI) += kcs_bmc_cdev_ipmi.o
 obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
 obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
 obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) += kcs_bmc_npcm7xx.o
diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 2ec934f0dba3..9860c7b75157 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -5,7 +5,9 @@
  */
 
 #include <linux/device.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 #include "kcs_bmc.h"
 
@@ -13,6 +15,11 @@
 #include "kcs_bmc_device.h"
 #include "kcs_bmc_client.h"
 
+/* Record registered devices and drivers */
+static DEFINE_MUTEX(kcs_bmc_lock);
+static LIST_HEAD(kcs_bmc_devices);
+static LIST_HEAD(kcs_bmc_drivers);
+
 /* Consumer data access */
 
 u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc)
@@ -98,22 +105,83 @@ void kcs_bmc_disable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_clien
 }
 EXPORT_SYMBOL(kcs_bmc_disable_device);
 
-int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc);
 int kcs_bmc_add_device(struct kcs_bmc_device *kcs_bmc)
 {
-	return kcs_bmc_ipmi_add_device(kcs_bmc);
+	struct kcs_bmc_driver *drv;
+	int error = 0;
+	int rc;
+
+	spin_lock_init(&kcs_bmc->lock);
+	kcs_bmc->client = NULL;
+
+	mutex_lock(&kcs_bmc_lock);
+	list_add(&kcs_bmc->entry, &kcs_bmc_devices);
+	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
+		rc = drv->ops->add_device(kcs_bmc);
+		if (!rc)
+			continue;
+
+		dev_err(kcs_bmc->dev, "Failed to add chardev for KCS channel %d: %d",
+			kcs_bmc->channel, rc);
+		error = rc;
+	}
+	mutex_unlock(&kcs_bmc_lock);
+
+	return error;
 }
 EXPORT_SYMBOL(kcs_bmc_add_device);
 
-int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc);
 void kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc)
 {
-	if (kcs_bmc_ipmi_remove_device(kcs_bmc))
-		pr_warn("Failed to remove device for KCS channel %d\n",
-			kcs_bmc->channel);
+	struct kcs_bmc_driver *drv;
+	int rc;
+
+	mutex_lock(&kcs_bmc_lock);
+	list_del(&kcs_bmc->entry);
+	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
+		rc = drv->ops->remove_device(kcs_bmc);
+		if (rc)
+			dev_err(kcs_bmc->dev, "Failed to remove chardev for KCS channel %d: %d",
+				kcs_bmc->channel, rc);
+	}
+	mutex_unlock(&kcs_bmc_lock);
 }
 EXPORT_SYMBOL(kcs_bmc_remove_device);
 
+void kcs_bmc_register_driver(struct kcs_bmc_driver *drv)
+{
+	struct kcs_bmc_device *kcs_bmc;
+	int rc;
+
+	mutex_lock(&kcs_bmc_lock);
+	list_add(&drv->entry, &kcs_bmc_drivers);
+	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
+		rc = drv->ops->add_device(kcs_bmc);
+		if (rc)
+			dev_err(kcs_bmc->dev, "Failed to add driver for KCS channel %d: %d",
+				kcs_bmc->channel, rc);
+	}
+	mutex_unlock(&kcs_bmc_lock);
+}
+EXPORT_SYMBOL(kcs_bmc_register_driver);
+
+void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
+{
+	struct kcs_bmc_device *kcs_bmc;
+	int rc;
+
+	mutex_lock(&kcs_bmc_lock);
+	list_del(&drv->entry);
+	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
+		rc = drv->ops->remove_device(kcs_bmc);
+		if (rc)
+			dev_err(kcs_bmc->dev, "Failed to remove driver for KCS channel %d: %d",
+				kcs_bmc->channel, rc);
+	}
+	mutex_unlock(&kcs_bmc_lock);
+}
+EXPORT_SYMBOL(kcs_bmc_unregister_driver);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 865d8b93f3b7..486834a962c3 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -469,8 +469,7 @@ static const struct file_operations kcs_bmc_ipmi_fops = {
 static DEFINE_SPINLOCK(kcs_bmc_ipmi_instances_lock);
 static LIST_HEAD(kcs_bmc_ipmi_instances);
 
-int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc);
-int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
+static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_ipmi *priv;
 	int rc;
@@ -512,10 +511,8 @@ int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 
 	return 0;
 }
-EXPORT_SYMBOL(kcs_bmc_ipmi_add_device);
 
-int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc);
-int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
+static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_ipmi *priv = NULL, *pos;
 
@@ -541,7 +538,29 @@ int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 
 	return 0;
 }
-EXPORT_SYMBOL(kcs_bmc_ipmi_remove_device);
+
+static const struct kcs_bmc_driver_ops kcs_bmc_ipmi_driver_ops = {
+	.add_device = kcs_bmc_ipmi_add_device,
+	.remove_device = kcs_bmc_ipmi_remove_device,
+};
+
+static struct kcs_bmc_driver kcs_bmc_ipmi_driver = {
+	.ops = &kcs_bmc_ipmi_driver_ops,
+};
+
+static int kcs_bmc_ipmi_init(void)
+{
+	kcs_bmc_register_driver(&kcs_bmc_ipmi_driver);
+
+	return 0;
+}
+module_init(kcs_bmc_ipmi_init);
+
+static void kcs_bmc_ipmi_exit(void)
+{
+	kcs_bmc_unregister_driver(&kcs_bmc_ipmi_driver);
+}
+module_exit(kcs_bmc_ipmi_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
index a32fdc4a7707..814ad8e052ef 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/drivers/char/ipmi/kcs_bmc_client.h
@@ -8,6 +8,17 @@
 
 #include "kcs_bmc.h"
 
+struct kcs_bmc_driver_ops {
+	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
+	int (*remove_device)(struct kcs_bmc_device *kcs_bmc);
+};
+
+struct kcs_bmc_driver {
+	struct list_head entry;
+
+	const struct kcs_bmc_driver_ops *ops;
+};
+
 struct kcs_bmc_client_ops {
 	irqreturn_t (*event)(struct kcs_bmc_client *client);
 };
@@ -18,6 +29,9 @@ struct kcs_bmc_client {
 	struct kcs_bmc_device *dev;
 };
 
+void kcs_bmc_register_driver(struct kcs_bmc_driver *drv);
+void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv);
+
 int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
 void kcs_bmc_disable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
 
-- 
2.30.2

