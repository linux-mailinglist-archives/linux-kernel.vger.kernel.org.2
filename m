Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2530D1E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhBCC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:58:55 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57413 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231160AbhBCC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:58:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNiyROB_1612321088;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNiyROB_1612321088)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:58:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] phy: phy-brcm-sata: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:58:07 +0800
Message-Id: <1612321087-14743-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/phy/broadcom/phy-brcm-sata.c:654:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 3ecf413..769c707 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -651,7 +651,7 @@ static int brcm_dsl_sata_init(struct brcm_sata_port *port)
 			break;
 		msleep(20);
 		try--;
-	};
+	}
 
 	if (!try) {
 		/* PLL did not lock; give up */
-- 
1.8.3.1

