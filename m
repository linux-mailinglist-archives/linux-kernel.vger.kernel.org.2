Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E333AA992
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFQD1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:27:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7338 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFQD1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:27:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G56lZ2541z6vDG;
        Thu, 17 Jun 2021 11:21:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 11:25:14 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 11:25:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>
Subject: [PATCH -next] ASoC: spear: spdif_out: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 11:29:00 +0800
Message-ID: <20210617032900.600124-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/spear/spdif_out.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 38f9fff5be6b..549295a6ed50 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -287,8 +287,7 @@ static int spdif_out_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->io_base = devm_ioremap_resource(&pdev->dev, res);
+	host->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(host->io_base))
 		return PTR_ERR(host->io_base);
 
-- 
2.25.1

