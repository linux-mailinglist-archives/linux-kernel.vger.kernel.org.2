Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF24505D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKONqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:46:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26315 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhKONnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:43:42 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ht9Dr2ysDzbhtB;
        Mon, 15 Nov 2021 21:35:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:24 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:23 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <saravanak@google.com>, <robh+dt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH Resend 2/2] amba: Move of_amba_device_decode_irq() into amba_probe()
Date:   Mon, 15 Nov 2021 21:51:48 +0800
Message-ID: <20211115135148.171786-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211115135148.171786-1-wangkefeng.wang@huawei.com>
References: <20211115135148.171786-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other resources the AMBA bus "gets" for the device,
move irq obtain from amba_device_add() to amba_probe().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 16d3c009505b..e1a5eca3ae3c 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -171,6 +171,28 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return retval;
 }
 
+static int of_amba_device_decode_irq(struct amba_device *dev)
+{
+	struct device_node *node = dev->dev.of_node;
+	int i, irq = 0;
+
+	if (IS_ENABLED(CONFIG_OF_IRQ) && node) {
+		/* Decode the IRQs and address ranges */
+		for (i = 0; i < AMBA_NR_IRQS; i++) {
+			irq = of_irq_get(node, i);
+			if (irq < 0) {
+				if (irq == -EPROBE_DEFER)
+					return irq;
+				irq = 0;
+			}
+
+			dev->irq[i] = irq;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * These are the device model conversion veneers; they convert the
  * device model structures to our more specific structures.
@@ -183,6 +205,10 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = of_amba_device_decode_irq(pcdev);
+		if (ret)
+			break;
+
 		ret = of_clk_set_defaults(dev->of_node, false);
 		if (ret < 0)
 			break;
@@ -368,38 +394,12 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-static int of_amba_device_decode_irq(struct amba_device *dev)
-{
-	struct device_node *node = dev->dev.of_node;
-	int i, irq = 0;
-
-	if (IS_ENABLED(CONFIG_OF_IRQ) && node) {
-		/* Decode the IRQs and address ranges */
-		for (i = 0; i < AMBA_NR_IRQS; i++) {
-			irq = of_irq_get(node, i);
-			if (irq < 0) {
-				if (irq == -EPROBE_DEFER)
-					return irq;
-				irq = 0;
-			}
-
-			dev->irq[i] = irq;
-		}
-	}
-
-	return 0;
-}
-
 static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 {
 	u32 size;
 	void __iomem *tmp;
 	int i, ret;
 
-	ret = of_amba_device_decode_irq(dev);
-	if (ret)
-		goto err_out;
-
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
-- 
2.26.2

