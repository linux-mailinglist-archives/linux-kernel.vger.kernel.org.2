Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BA3F9B60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbhH0PDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:03:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbhH0PDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:03:04 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gx2s85WmpzbdJ8;
        Fri, 27 Aug 2021 22:58:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:12 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <saravanak@google.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ruizhe Lin <linruizhe@huawei.com>
Subject: [PATCH v2 4/4] amba: Properly handle device probe without IRQ domain
Date:   Fri, 27 Aug 2021 23:06:00 +0800
Message-ID: <20210827150600.78811-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210827150600.78811-1-wangkefeng.wang@huawei.com>
References: <20210827150600.78811-1-wangkefeng.wang@huawei.com>
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

of_amba_device_create() uses irq_of_parse_and_map() to translate
a DT interrupt specification into a Linux virtual interrupt number.

But it doesn't properly handle the case where the interrupt controller
is not yet available, eg, when pl011 interrupt is connected to MBIGEN
interrupt controller, because the mbigen initialization is too late,
which will lead to no IRQ due to no IRQ domain found, log is shown below,
  "irq: no irq domain found for uart0 !"

use of_irq_get() to return -EPROBE_DEFER as above, and in the driver
deferred probe, it will properly handle in such case, also return 0
in other fail cases to be consistent as before.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reported-by: Ruizhe Lin <linruizhe@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c    | 27 +++++++++++++++++++++++++++
 drivers/of/platform.c |  6 +-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 4d3a565ca079..96e84ce66e9a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -19,6 +19,7 @@
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/of_irq.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
@@ -170,6 +171,28 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return retval;
 }
 
+static int of_amba_device_decode_irq(struct amba_device *dev)
+{
+	struct device_node *node = dev->dev.of_node;
+	int i, irq;
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
@@ -182,6 +205,10 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = of_amba_device_decode_irq(pcdev);
+		if (ret)
+			break;
+
 		ret = of_clk_set_defaults(dev->of_node, false);
 		if (ret < 0)
 			break;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5e..32d5ff8df747 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -222,7 +222,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 {
 	struct amba_device *dev;
 	const void *prop;
-	int i, ret;
+	int ret;
 
 	pr_debug("Creating amba device %pOF\n", node);
 
@@ -253,10 +253,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (prop)
 		dev->periphid = of_read_ulong(prop, 1);
 
-	/* Decode the IRQs and address ranges */
-	for (i = 0; i < AMBA_NR_IRQS; i++)
-		dev->irq[i] = irq_of_parse_and_map(node, i);
-
 	ret = of_address_to_resource(node, 0, &dev->res);
 	if (ret) {
 		pr_err("amba: of_address_to_resource() failed (%d) for %pOF\n",
-- 
2.18.0.huawei.25

