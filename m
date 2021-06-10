Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06C63A2CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:24:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5329 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:24:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G14KS6lLLz1BJp1;
        Thu, 10 Jun 2021 21:18:04 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 21:22:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 21:22:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
Subject: [PATCH -next] ASoC: axi-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 10 Jun 2021 21:27:05 +0800
Message-ID: <20210610132705.138706-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/adi/axi-i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index aa082131fb90..1289cb4e2988 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -198,8 +198,7 @@ static int axi_i2s_probe(struct platform_device *pdev)
 
 	axi_i2s_parse_of(i2s, pdev->dev.of_node);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.25.1

