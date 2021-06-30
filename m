Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D53B7B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhF3CGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:06:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5944 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhF3CGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:06:54 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GF4M24zzVz749f;
        Wed, 30 Jun 2021 10:01:02 +0800 (CST)
Received: from huawei.com (10.175.104.82) by dggeme766-chm.china.huawei.com
 (10.3.19.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 10:04:22 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <lvb@xiphos.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: lmk04832: fix return value check in lmk04832_probe()
Date:   Wed, 30 Jun 2021 10:03:22 +0800
Message-ID: <20210630020322.2555946-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_kzalloc() and devm_kcalloc() return
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/clk/clk-lmk04832.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 0cd76e626c3..66ad5cbe702 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1425,23 +1425,23 @@ static int lmk04832_probe(struct spi_device *spi)
 
 	lmk->dclk = devm_kcalloc(lmk->dev, info->num_channels >> 1,
 				 sizeof(struct lmk_dclk), GFP_KERNEL);
-	if (IS_ERR(lmk->dclk)) {
-		ret = PTR_ERR(lmk->dclk);
+	if (!lmk->dclk) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
 	lmk->clkout = devm_kcalloc(lmk->dev, info->num_channels,
 				   sizeof(*lmk->clkout), GFP_KERNEL);
-	if (IS_ERR(lmk->clkout)) {
-		ret = PTR_ERR(lmk->clkout);
+	if (!lmk->clkout) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
 	lmk->clk_data = devm_kzalloc(lmk->dev, struct_size(lmk->clk_data, hws,
 							   info->num_channels),
 				     GFP_KERNEL);
-	if (IS_ERR(lmk->clk_data)) {
-		ret = PTR_ERR(lmk->clk_data);
+	if (!lmk->clk_data) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
-- 
2.17.1

