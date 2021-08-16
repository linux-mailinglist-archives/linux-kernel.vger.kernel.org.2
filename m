Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203093ECF91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhHPHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:43:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17023 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhHPHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:43:47 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gp5dt5TbVzb2Qj;
        Mon, 16 Aug 2021 15:39:30 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:13 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] Revert "ARM: amba: make use of -1 IRQs warn"
Date:   Mon, 16 Aug 2021 15:46:18 +0800
Message-ID: <20210816074619.177383-3-wangkefeng.wang@huawei.com>
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
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 2f2137518be0..36f2f42c8014 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -377,9 +377,6 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	void __iomem *tmp;
 	int i, ret;
 
-	WARN_ON(dev->irq[0] == (unsigned int)-1);
-	WARN_ON(dev->irq[1] == (unsigned int)-1);
-
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
-- 
2.26.2

