Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA84239B6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFDKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:07:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7107 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:07:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxJHX2Jm2zYqnx
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 18:03:20 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 18:06:06 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 18:06:05 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] EDAC/armada_xp: Remove redundant dev_err call in axp_mc_probe() and aurora_l2_probe()
Date:   Fri, 4 Jun 2021 18:12:18 +0800
Message-ID: <20210604101218.3656427-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/edac/armada_xp_edac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index e3e757513d1b..9661c72e6554 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -297,10 +297,8 @@ static int axp_mc_probe(struct platform_device *pdev)
 	}
 
 	base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(base)) {
-		dev_err(&pdev->dev, "Unable to map regs\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	config = readl(base + SDRAM_CONFIG_REG);
 	if (!(config & SDRAM_CONFIG_ECC_MASK)) {
@@ -525,10 +523,8 @@ static int aurora_l2_probe(struct platform_device *pdev)
 	}
 
 	base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(base)) {
-		dev_err(&pdev->dev, "Unable to map regs\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	l2x0_aux_ctrl = readl(base + L2X0_AUX_CTRL);
 	if (!(l2x0_aux_ctrl & AURORA_ACR_PARITY_EN))
-- 
2.25.4

