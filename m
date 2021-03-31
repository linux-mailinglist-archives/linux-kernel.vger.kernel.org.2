Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275C350295
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhCaOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:45:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:14863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236168AbhCaOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:45:19 -0400
IronPort-SDR: EEMnxTb3FTloF2C1TfN86SPBfYKl8EQRZEv8s27JrUYYJmZ/c6Kn+AEWq/VoYxvEIchuGQH7+b
 OhwBxiBRtiFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="189787302"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="189787302"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 07:45:18 -0700
IronPort-SDR: q4cpvPvmrmVab77e4d/Vz2YZD5U6A/6TUSwBdXEil30+pbrLr3FXcEAvBXKrb1KIvPrIOswGQe
 FaLSnDU2WgZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="377291801"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2021 07:45:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6EE4B199; Wed, 31 Mar 2021 17:45:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v1 1/1] driver core: platform: Make platform_get_irq_optional() optional
Date:   Wed, 31 Mar 2021 17:45:26 +0300
Message-Id: <20210331144526.19439-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the platform_get_irq_optional() returns an error code even
if IRQ resource sumply has not been found. It prevents caller to be
error code agnostic in their error handling.

Now:
	ret = platform_get_irq_optional(...);
	if (ret != -ENXIO)
		return ret; // respect deferred probe
	if (ret > 0)
		...we get an IRQ...

After proposed change:
	ret = platform_get_irq_optional(...);
	if (ret < 0)
		return ret;
	if (ret > 0)
		...we get an IRQ...

Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6e1f8e0b661c..d82db3eabcd4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -168,25 +168,7 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
 
-/**
- * platform_get_irq_optional - get an optional IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- *
- * Gets an IRQ for a platform device. Device drivers should check the return
- * value for errors so as to not pass a negative integer value to the
- * request_irq() APIs. This is the same as platform_get_irq(), except that it
- * does not print an error message if an IRQ can not be obtained.
- *
- * For example::
- *
- *		int irq = platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
- *			return irq;
- *
- * Return: non-zero IRQ number on success, negative error number on failure.
- */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+static int platform_do_get_irq(struct platform_device *dev, unsigned int num)
 {
 	int ret;
 #ifdef CONFIG_SPARC
@@ -255,6 +237,37 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	WARN(ret == 0, "0 is an invalid IRQ number\n");
 	return ret;
 }
+
+/**
+ * platform_get_irq_optional - get an optional IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device. Device drivers should check the return
+ * value for errors so as to not pass a negative integer value to the
+ * request_irq() APIs. This is the same as platform_get_irq(), except that it
+ * does not print an error message if an IRQ can not be obtained and returns
+ * 0 when IRQ resource has not been found.
+ *
+ * For example::
+ *
+ *		int irq = platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *		if (irq > 0)
+ *			...we have IRQ line defined...
+ *
+ * Return: non-zero IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	int ret;
+
+	ret = platform_do_get_irq(dev, num);
+	if (ret == -ENXIO)
+		return 0;
+	return ret;
+}
 EXPORT_SYMBOL_GPL(platform_get_irq_optional);
 
 /**
@@ -278,7 +291,7 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
 	int ret;
 
-	ret = platform_get_irq_optional(dev, num);
+	ret = platform_do_get_irq(dev, num);
 	if (ret < 0 && ret != -EPROBE_DEFER)
 		dev_err(&dev->dev, "IRQ index %u not found\n", num);
 
@@ -296,7 +309,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq_optional(dev, nr)) >= 0)
+	while ((ret = platform_do_get_irq(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
-- 
2.30.2

