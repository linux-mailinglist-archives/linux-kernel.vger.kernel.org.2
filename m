Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64A3D9E21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhG2HNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:13:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbhG2HM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:12:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gb1qP6CdYzZt7v;
        Thu, 29 Jul 2021 15:09:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:12:50 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 29 Jul
 2021 15:12:49 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <michal.simek@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH] pinctrl: zynqmp: Drop pinctrl_unregister for devm_ registered device
Date:   Thu, 29 Jul 2021 15:19:05 +0800
Message-ID: <20210729071905.3235953-1-yangyingliang@huawei.com>
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

It's not necessary to unregister pin controller device registered
with devm_pinctrl_register() and using pinctrl_unregister() leads
to a double free.

Fixes: fa99e7013827 ("pinctrl: zynqmp: some code cleanups")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index bbde676b7313..e14012209992 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -866,15 +866,6 @@ static int zynqmp_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int zynqmp_pinctrl_remove(struct platform_device *pdev)
-{
-	struct zynqmp_pinctrl *pctrl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pctrl->pctrl);
-
-	return 0;
-}
-
 static const struct of_device_id zynqmp_pinctrl_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-pinctrl" },
 	{ }
@@ -887,7 +878,6 @@ static struct platform_driver zynqmp_pinctrl_driver = {
 		.of_match_table = zynqmp_pinctrl_of_match,
 	},
 	.probe = zynqmp_pinctrl_probe,
-	.remove = zynqmp_pinctrl_remove,
 };
 module_platform_driver(zynqmp_pinctrl_driver);
 
-- 
2.25.1

