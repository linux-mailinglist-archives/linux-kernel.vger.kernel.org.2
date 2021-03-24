Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1EF347004
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhCXDMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:12:43 -0400
Received: from m12-16.163.com ([220.181.12.16]:48836 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234860AbhCXDMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=0IDwd8zGV3tXRIuwLd
        IoAMYQ18gg+J7ylD3fRmJ6cgI=; b=aoPLh2Q5m4vehoKJojuS3LhDKRWPlvWi+J
        YyeMriKMoaeXewcbK3ILqsU0F5cYM51pxYbIHLvdfDdNmQWTO8+tvJZ+KntnNdLj
        dmIlj8G37sF79apXO4k6y1a/xj3clB5tVSX6pDAuK6ABIDAMSU+uqeCaCPK6i7Ln
        RhNtQoqQk=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowAAHcUPxrVpgUqWOiA--.18703S2;
        Wed, 24 Mar 2021 11:11:51 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: [RESEND] regulator: mt6360: remove redundant error print
Date:   Wed, 24 Mar 2021 11:11:14 +0800
Message-Id: <1616555474-158789-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: EMCowAAHcUPxrVpgUqWOiA--.18703S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4rWr17AryxKFyDWryUJrb_yoWkGFXEkr
        18Aa1xWrs7Zr4akr4IqFsIvr9IyFn2ga17WrsrKFyaqry5A3WDC347GFW7Zr4UW3y8KF9x
        Ww1rWr4xZr13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LmRUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbB0hdf3VUMa9XS3QAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

fixes coccicheck warning:

drivers/regulator/mt6360-regulator.c:384:3-10: line 384 is
redundant because platform_get_irq() already prints an error

in fact it is not platform_get_irq but platform_get_irq_byname print error

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/regulator/mt6360-regulator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 15308ee..4d34be9 100644
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
 
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler, 0,
 						irq_desc->name, rdev);
-- 
1.9.1


