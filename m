Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A91379DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEKDiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:38:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2438 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEKDiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:38:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FfNn64z1szCrFZ;
        Tue, 11 May 2021 11:33:46 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 11:36:16 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] regulator: uniphier: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 11:53:18 +0800
Message-ID: <1620705198-104566-1-git-send-email-zou_wei@huawei.com>
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
 drivers/regulator/uniphier-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 2e02e26..e75b097 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -201,6 +201,7 @@ static const struct of_device_id uniphier_regulator_match[] = {
 	},
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, uniphier_regulator_match);
 
 static struct platform_driver uniphier_regulator_driver = {
 	.probe = uniphier_regulator_probe,
-- 
2.6.2

