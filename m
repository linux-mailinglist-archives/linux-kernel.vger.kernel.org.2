Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CC37F800
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhEMMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:33:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2477 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhEMMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:33:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgrZm08cvzBvDG;
        Thu, 13 May 2021 20:29:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 20:32:23 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] mfd: max8907: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Thu, 13 May 2021 20:32:25 +0800
Message-ID: <1620909145-21744-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is just to simplify the code, no actual functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mfd/max8907.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index d44baaf..40e70ab 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -228,11 +228,9 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap_rtc;
 	}
 
-	irq_set_status_flags(max8907->i2c_gen->irq, IRQ_NOAUTOEN);
-
 	ret = regmap_add_irq_chip(max8907->regmap_gen, max8907->i2c_gen->irq,
-				  IRQF_ONESHOT | IRQF_SHARED, -1,
-				  &max8907_chg_irq_chip,
+				  IRQF_ONESHOT | IRQF_SHARED | IRQF_NO_AUTOEN,
+				  -1, &max8907_chg_irq_chip,
 				  &max8907->irqc_chg);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "failed to add chg irq chip: %d\n", ret);
-- 
2.7.4

