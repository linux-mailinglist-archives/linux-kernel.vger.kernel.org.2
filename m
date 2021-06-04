Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6B39B64C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFDKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:00:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7106 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFDKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:00:10 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxJ6c5dJSzYqBF;
        Fri,  4 Jun 2021 17:55:36 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 17:58:22 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 17:58:22 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] drm/stm: Remove redundant dev_err call in ltdc_load()
Date:   Fri, 4 Jun 2021 18:04:45 +0800
Message-ID: <20210604100445.3653140-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/gpu/drm/stm/ltdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index e99771b947b6..9d06c70b3331 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1284,7 +1284,6 @@ int ltdc_load(struct drm_device *ddev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ldev->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ldev->regs)) {
-		DRM_ERROR("Unable to get ltdc registers\n");
 		ret = PTR_ERR(ldev->regs);
 		goto err;
 	}
-- 
2.25.4

