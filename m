Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4D4034E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbhIHHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:12:24 -0400
Received: from mx20.baidu.com ([111.202.115.85]:57046 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348180AbhIHHMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:12:16 -0400
Received: from BJHW-MAIL-EX04.internal.baidu.com (unknown [10.127.64.14])
        by Forcepoint Email with ESMTPS id CC4942B7F11C8AB7D8A1;
        Wed,  8 Sep 2021 15:11:07 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:07 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:07 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] soc: mtk-scpsys: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:10:58 +0800
Message-ID: <20210908071059.291-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071059.291-1-caihuoqing@baidu.com>
References: <20210908071059.291-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ca75b14931ec..2bed34b2b1c7 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -425,7 +425,6 @@ static struct scp *init_scp(struct platform_device *pdev,
 			bool bus_prot_reg_update)
 {
 	struct genpd_onecell_data *pd_data;
-	struct resource *res;
 	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
@@ -441,8 +440,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	scp->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	scp->base = devm_ioremap_resource(&pdev->dev, res);
+	scp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(scp->base))
 		return ERR_CAST(scp->base);
 
-- 
2.25.1

