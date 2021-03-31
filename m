Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919AF34FBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCaIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:40:21 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34972 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232984AbhCaIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:40:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTwP3vq_1617180001;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UTwP3vq_1617180001)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 31 Mar 2021 16:40:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] soc: bcm: brcmstb: remove unused variable 'brcmstb_machine_match'
Date:   Wed, 31 Mar 2021 16:39:59 +0800
Message-Id: <1617179999-71706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/soc/bcm/brcmstb/common.c:17:34: warning: unused variable
'brcmstb_machine_match' [-Wunused-const-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/soc/bcm/brcmstb/common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index e87dfc6..2a01088 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -14,11 +14,6 @@
 static u32 family_id;
 static u32 product_id;
 
-static const struct of_device_id brcmstb_machine_match[] = {
-	{ .compatible = "brcm,brcmstb", },
-	{ }
-};
-
 u32 brcmstb_get_family_id(void)
 {
 	return family_id;
-- 
1.8.3.1

