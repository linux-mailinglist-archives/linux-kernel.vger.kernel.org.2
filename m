Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910663F9B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbhH0PDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:03:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15264 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbhH0PDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:03:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gx2xG1hhrz8Bdh;
        Fri, 27 Aug 2021 23:01:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:11 +0800
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
Subject: [PATCH v2 2/4] Revert "ARM: amba: make use of -1 IRQs warn"
Date:   Fri, 27 Aug 2021 23:05:58 +0800
Message-ID: <20210827150600.78811-3-wangkefeng.wang@huawei.com>
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

After commit 77a7300abad7 ("of/irq: Get rid of NO_IRQ usage"),
no irq case has been removed, irq_of_parse_and_map() will return
0 in all cases when get error from parse and map an interrupt into
linux virq space.

amba_device_register() is only used on no-DT initialization, see
  s3c64xx_pl080_init()		arch/arm/mach-s3c/pl080.c
  ep93xx_init_devices()		arch/arm/mach-ep93xx/core.c

They won't set -1 to irq[0], so no need the warn.

This reverts commit 2eac58d5026e4ec8b17ff8b62877fea9e1d2f1b3.

Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index c96fdef92fe1..37fcd5592c6f 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -379,9 +379,6 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	void __iomem *tmp;
 	int i, ret;
 
-	WARN_ON(dev->irq[0] == (unsigned int)-1);
-	WARN_ON(dev->irq[1] == (unsigned int)-1);
-
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
-- 
2.18.0.huawei.25

