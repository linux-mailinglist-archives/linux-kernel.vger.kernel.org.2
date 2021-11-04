Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9729044514A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKDJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:47:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14715 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhKDJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:47:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlJZx5N2gzZcdV;
        Thu,  4 Nov 2021 17:42:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 17:44:40 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 17:44:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>, <saravanak@google.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] amba: Move of_amba_device_decode_irq() into amba_probe()
Date:   Thu, 4 Nov 2021 17:56:43 +0800
Message-ID: <20211104095643.180429-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211104095643.180429-1-wangkefeng.wang@huawei.com>
References: <20211104095643.180429-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other resources the AMBA bus "gets" for the device,
move irq obtain from amba_device_add() to amba_probe().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 16d3c009505b..89ecadc81f62 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -183,6 +183,10 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = of_amba_device_decode_irq(dev);
+		if (ret)
+			break;
+
 		ret = of_clk_set_defaults(dev->of_node, false);
 		if (ret < 0)
 			break;
@@ -396,10 +400,6 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
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

