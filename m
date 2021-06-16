Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5443A95AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFPJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:15:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10097 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhFPJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:15:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4fXx3VsrzZfWY;
        Wed, 16 Jun 2021 17:10:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:13:01 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 17:13:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <krzysztof.kozlowski@canonical.com>, <s.nawrocki@samsung.com>,
        <broonie@kernel.org>
Subject: [PATCH -next 3/4] ASoC: samsung: s3c2412-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 16 Jun 2021 17:16:51 +0800
Message-ID: <20210616091652.2552927-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616091652.2552927-1-yangyingliang@huawei.com>
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/samsung/s3c2412-i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 81f416ac457e..ec1c6f9d76ac 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -208,8 +208,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	s3c2412_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
+	s3c2412_i2s.regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(s3c2412_i2s.regs))
 		return PTR_ERR(s3c2412_i2s.regs);
 
-- 
2.25.1

