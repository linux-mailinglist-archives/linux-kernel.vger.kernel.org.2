Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65723A399A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFKCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:19:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5381 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFKCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:19:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1PWx0JV1z6wTd;
        Fri, 11 Jun 2021 10:13:17 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 10:17:10 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 10:17:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
Subject: [PATCH -next] ASoC: atmel-classd: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 11 Jun 2021 10:21:15 +0800
Message-ID: <20210611022115.3583765-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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
 sound/soc/atmel/atmel-classd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 6023369e0f1a..a9f9f449c48c 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -558,8 +558,7 @@ static int atmel_classd_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(dev, res);
+	io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-- 
2.25.1

