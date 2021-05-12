Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4537B47B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELDZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:25:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2783 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhELDZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:25:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg0S640xQzmg36;
        Wed, 12 May 2021 11:21:10 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:24:23 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <iuliana.prodan@nxp.com>, <Anson.Huang@nxp.com>,
        <peng.fan@nxp.com>, <alice.guo@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] soc: imx8m: add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 11:41:25 +0800
Message-ID: <1620790885-15892-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/soc/imx/soc-imx8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 071e144..8debf62 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -186,6 +186,7 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, imx8_soc_match);
 
 #define imx8_revision(soc_rev) \
 	soc_rev ? \
-- 
2.6.2

