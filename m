Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB03F9B62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbhH0PDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:03:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8790 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbhH0PDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:03:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gx2wv5Mn6zYthf;
        Fri, 27 Aug 2021 23:01:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:11 +0800
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/4] amba: Kill sysfs attribute file of irq
Date:   Fri, 27 Aug 2021 23:05:59 +0800
Message-ID: <20210827150600.78811-4-wangkefeng.wang@huawei.com>
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

As Rob said[1], there doesn't seem to be any users about the sysfs
attribute file of irq[0] and irq[1]. And we don't need to include
<asm/irq.h> as NO_IRQ has gone. Let's kill both of them.

[1] https://lkml.org/lkml/2021/8/25/461

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 37fcd5592c6f..4d3a565ca079 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,8 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
-#include <asm/irq.h>
-
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
 /* called on periphid match and class 0x9 coresight device. */
@@ -135,8 +133,6 @@ static ssize_t name##_show(struct device *_dev,				\
 static DEVICE_ATTR_RO(name)
 
 amba_attr_func(id, "%08x\n", dev->periphid);
-amba_attr_func(irq0, "%u\n", dev->irq[0]);
-amba_attr_func(irq1, "%u\n", dev->irq[1]);
 amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
 	 (unsigned long long)dev->res.start, (unsigned long long)dev->res.end,
 	 dev->res.flags);
@@ -463,20 +459,10 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 
  skip_probe:
 	ret = device_add(&dev->dev);
-	if (ret)
-		goto err_release;
-
-	if (dev->irq[0])
-		ret = device_create_file(&dev->dev, &dev_attr_irq0);
-	if (ret == 0 && dev->irq[1])
-		ret = device_create_file(&dev->dev, &dev_attr_irq1);
-	if (ret == 0)
-		return ret;
-
-	device_unregister(&dev->dev);
 
  err_release:
-	release_resource(&dev->res);
+	if (ret)
+		release_resource(&dev->res);
  err_out:
 	return ret;
 
-- 
2.18.0.huawei.25

