Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F543F9B61
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbhH0PDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:03:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15263 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241780AbhH0PDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:03:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gx2xD5Xysz8B0r;
        Fri, 27 Aug 2021 23:01:52 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:10 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <saravanak@google.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Rob Herring" <robh@kernel.org>
Subject: [PATCH v2 1/4] amba: Drop unused functions about APB/AHB devices add
Date:   Fri, 27 Aug 2021 23:05:57 +0800
Message-ID: <20210827150600.78811-2-wangkefeng.wang@huawei.com>
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

No one use the following functions, kill them.

  amba_aphb_device_add()
  amba_apb_device_add()
  amba_apb_device_add_res()
  amba_ahb_device_add()
  amba_ahb_device_add_res()

Cc: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c       | 72 ----------------------------------------
 include/linux/amba/bus.h | 18 ----------
 2 files changed, 90 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 939ca220bf78..c96fdef92fe1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -581,78 +581,6 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
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
2.18.0.huawei.25

