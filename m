Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1E3A8205
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFOONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:13:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6382 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFOONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G499n18wFz63cB;
        Tue, 15 Jun 2021 22:07:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 22:11:07 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 22:11:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>
Subject: [PATCH -next 3/3] ASoC: rockchip: spdif: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 22:15:02 +0800
Message-ID: <20210615141502.1683686-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141502.1683686-1-yangyingliang@huawei.com>
References: <20210615141502.1683686-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/rockchip/rockchip_spdif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index ffb4ec306441..73226a46d489 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -313,8 +313,7 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	if (IS_ERR(spdif->mclk))
 		return PTR_ERR(spdif->mclk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.25.1

