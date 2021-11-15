Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B154505C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhKONph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:45:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14745 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbhKONnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:43:20 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ht9HZ5L3HzZd42;
        Mon, 15 Nov 2021 21:38:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:23 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:23 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <saravanak@google.com>, <robh+dt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH Resend 1/2] amba: Kill sysfs attribute file of irq
Date:   Mon, 15 Nov 2021 21:51:47 +0800
Message-ID: <20211115135148.171786-2-wangkefeng.wang@huawei.com>
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

As Rob said[1], there doesn't seem to be any users about the sysfs
attribute file of irq[0] and irq[1]. And we don't need to include
<asm/irq.h> as NO_IRQ has gone. Let's kill both of them.

[1] https://lkml.org/lkml/2021/8/25/461

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 720aa6cdd402..16d3c009505b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -21,8 +21,6 @@
 #include <linux/reset.h>
 #include <linux/of_irq.h>
 
-#include <asm/irq.h>
-
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
 /* called on periphid match and class 0x9 coresight device. */
@@ -136,8 +134,6 @@ static ssize_t name##_show(struct device *_dev,				\
 static DEVICE_ATTR_RO(name)
 
 amba_attr_func(id, "%08x\n", dev->periphid);
-amba_attr_func(irq0, "%u\n", dev->irq[0]);
-amba_attr_func(irq1, "%u\n", dev->irq[1]);
 amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
 	 (unsigned long long)dev->res.start, (unsigned long long)dev->res.end,
 	 dev->res.flags);
@@ -488,20 +484,9 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 
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
-
  err_release:
-	release_resource(&dev->res);
+	if (ret)
+		release_resource(&dev->res);
  err_out:
 	return ret;
 
-- 
2.26.2

