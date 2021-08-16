Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC83ECF99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhHPHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:44:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8423 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhHPHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:44:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gp5dp43zRz81p8;
        Mon, 16 Aug 2021 15:39:26 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:13 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] amba: Drop unused functions about APB/AHB devices add
Date:   Mon, 16 Aug 2021 15:46:17 +0800
Message-ID: <20210816074619.177383-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one use the following functions, kill them.

  amba_aphb_device_add()
  amba_apb_device_add()
  amba_apb_device_add_res()
  amba_ahb_device_add()
  amba_ahb_device_add_res()

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c       | 72 ----------------------------------------
 include/linux/amba/bus.h | 18 ----------
 2 files changed, 90 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 962041148482..2f2137518be0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -579,78 +579,6 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 }
 EXPORT_SYMBOL_GPL(amba_device_add);
 
-static struct amba_device *
-amba_aphb_device_add(struct device *parent, const char *name,
-		     resource_size_t base, size_t size, int irq1, int irq2,
-		     void *pdata, unsigned int periphid, u64 dma_mask,
-		     struct resource *resbase)
-{
-	struct amba_device *dev;
-	int ret;
-
-	dev = amba_device_alloc(name, base, size);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->dev.coherent_dma_mask = dma_mask;
-	dev->irq[0] = irq1;
-	dev->irq[1] = irq2;
-	dev->periphid = periphid;
-	dev->dev.platform_data = pdata;
-	dev->dev.parent = parent;
-
-	ret = amba_device_add(dev, resbase);
-	if (ret) {
-		amba_device_put(dev);
-		return ERR_PTR(ret);
-	}
-
-	return dev;
-}
-
-struct amba_device *
-amba_apb_device_add(struct device *parent, const char *name,
-		    resource_size_t base, size_t size, int irq1, int irq2,
-		    void *pdata, unsigned int periphid)
-{
-	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
-				    periphid, 0, &iomem_resource);
-}
-EXPORT_SYMBOL_GPL(amba_apb_device_add);
-
-struct amba_device *
-amba_ahb_device_add(struct device *parent, const char *name,
-		    resource_size_t base, size_t size, int irq1, int irq2,
-		    void *pdata, unsigned int periphid)
-{
-	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
-				    periphid, ~0ULL, &iomem_resource);
-}
-EXPORT_SYMBOL_GPL(amba_ahb_device_add);
-
-struct amba_device *
-amba_apb_device_add_res(struct device *parent, const char *name,
-			resource_size_t base, size_t size, int irq1,
-			int irq2, void *pdata, unsigned int periphid,
-			struct resource *resbase)
-{
-	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
-				    periphid, 0, resbase);
-}
-EXPORT_SYMBOL_GPL(amba_apb_device_add_res);
-
-struct amba_device *
-amba_ahb_device_add_res(struct device *parent, const char *name,
-			resource_size_t base, size_t size, int irq1,
-			int irq2, void *pdata, unsigned int periphid,
-			struct resource *resbase)
-{
-	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
-				    periphid, ~0ULL, resbase);
-}
-EXPORT_SYMBOL_GPL(amba_ahb_device_add_res);
-
-
 static void amba_device_initialize(struct amba_device *dev, const char *name)
 {
 	device_initialize(&dev->dev);
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index c68d87b87283..edfcf7a14dcd 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -122,24 +122,6 @@ struct amba_device *amba_device_alloc(const char *, resource_size_t, size_t);
 void amba_device_put(struct amba_device *);
 int amba_device_add(struct amba_device *, struct resource *);
 int amba_device_register(struct amba_device *, struct resource *);
-struct amba_device *amba_apb_device_add(struct device *parent, const char *name,
-					resource_size_t base, size_t size,
-					int irq1, int irq2, void *pdata,
-					unsigned int periphid);
-struct amba_device *amba_ahb_device_add(struct device *parent, const char *name,
-					resource_size_t base, size_t size,
-					int irq1, int irq2, void *pdata,
-					unsigned int periphid);
-struct amba_device *
-amba_apb_device_add_res(struct device *parent, const char *name,
-			resource_size_t base, size_t size, int irq1,
-			int irq2, void *pdata, unsigned int periphid,
-			struct resource *resbase);
-struct amba_device *
-amba_ahb_device_add_res(struct device *parent, const char *name,
-			resource_size_t base, size_t size, int irq1,
-			int irq2, void *pdata, unsigned int periphid,
-			struct resource *resbase);
 void amba_device_unregister(struct amba_device *);
 struct amba_device *amba_find_device(const char *, struct device *, unsigned int, unsigned int);
 int amba_request_regions(struct amba_device *, const char *);
-- 
2.26.2

