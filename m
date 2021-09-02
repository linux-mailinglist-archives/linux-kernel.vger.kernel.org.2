Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895223FE8B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhIBF0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:26:05 -0400
Received: from mx21.baidu.com ([220.181.3.85]:59006 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230261AbhIBF0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:26:04 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id 4E875701F09CFEBBBE1F;
        Thu,  2 Sep 2021 13:25:05 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 2 Sep 2021 13:25:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 13:25:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] driver core: platform: Add the helper function devm_platform_get_and_ioremap_resource_byname()
Date:   Thu, 2 Sep 2021 13:24:58 +0800
Message-ID: <20210902052459.31890-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since provide the helper function devm_platform_ioremap_resource_byname()
which is wrap platform_get_resource_byname() and devm_ioremap_resource().
But sometimes, many drivers still need to use the resource variables
obtained by platform_get_resource(). In these cases, provide this helper
function devm_platform_get_and_ioremap_resource_byname().

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
 include/linux/platform_device.h |  3 +++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 52a1b94428c8..29e3ad6dde70 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -124,6 +124,31 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
+/**
+ * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource() for a
+ *						   platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @name: name of the resource
+ * @res: optional output parameter to store a pointer to the obtained resource.
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
+ */
+void __iomem *
+devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
+					      const char *name, struct resource **res)
+{
+	struct resource *r;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (res)
+		*res = r;
+	return devm_ioremap_resource(&pdev->dev, r);
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource_byname);
+
 /**
  * devm_platform_ioremap_resource_byname - call devm_ioremap_resource for
  *					   a platform device, retrieve the
@@ -140,10 +165,7 @@ void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name)
 {
-	struct resource *res;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	return devm_ioremap_resource(&pdev->dev, res);
+	return devm_platform_get_and_ioremap_resource_byname(pdev, name, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 07e1bba45243..a20f3ecc1cd8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -66,6 +66,9 @@ extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
+devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
+					      const char *name, struct resource **res);
+extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
 extern int platform_get_irq(struct platform_device *, unsigned int);
-- 
2.25.1

