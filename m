Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505F345DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCWMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:23:56 -0400
Received: from m12-16.163.com ([220.181.12.16]:36737 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhCWMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8Om3vnhENKRPd8B7S0
        OAH/SN8Lmo00lT5UbB0lg3uOg=; b=i8X2Z3kjUQSuM58xunF5/31Vq9W7lVmh5b
        Cfjyq4cG95AgRIcqpj+lZjNXC3j5PqNsuH6cgLDZSodaToQ1LeDuVwQ0uncITWYq
        qOShon5ILGYj8RTanD385iSSO2fM7wxjkfcN4Hd6Z2vJvGAT5FEQHXH8CMrkmUa2
        oqb0SgMNg=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowAAHDSmo3Vlgc0EniA--.12617S2;
        Tue, 23 Mar 2021 20:23:08 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     matthias.bgg@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: [PATCH] regulator: mt6360: remove redundant error print
Date:   Tue, 23 Mar 2021 20:22:41 +0800
Message-Id: <1616502161-125407-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: EMCowAAHDSmo3Vlgc0EniA--.12617S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4rWr17AryxKFyDWryUJrb_yoWkXwcEkr
        1xAa1xWrs7Zr4akr4IqFsIvrZIyFn7Ka17WrsrKFyavry5Aa4DC347GFW7Zr4UW3yUKr9x
        W3sagrs7Zr13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnO18PUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbB0g9e3VUMa88jEQABsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

fixes coccicheck warning:

drivers/regulator/mt6360-regulator.c:384:3-10: line 384 is
redundant because platform_get_irq() already prints an error

in fact, it is not platform_get_irq but platform_get_irq_byname print error

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/regulator/mt6360-regulator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 947350d..178180c 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -380,10 +380,8 @@ static int mt6360_regulator_irq_register(struct platform_device *pdev,
 		const struct mt6360_irq_mapping *irq_desc = tbls + i;
 
 		irq = platform_get_irq_byname(pdev, irq_desc->name);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Fail to get %s irq\n", irq_desc->name);
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler,
 					IRQF_ONESHOT, irq_desc->name, rdev);
-- 
1.9.1


