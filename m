Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6093132BD65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhCCP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:57:47 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53732 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357589AbhCCLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:10:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UQDrPLL_1614762482;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQDrPLL_1614762482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Mar 2021 17:08:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] SoC: codecs: fix platform_no_drv_owner.cocci warnings
Date:   Wed,  3 Mar 2021 17:08:01 +0800
Message-Id: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./sound/soc/codecs/lpass-rx-macro.c:3588:3-8: No need to set .owner here. 
The core will do it.

Remove .owner field if calls are used which set it automatically

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index c9c21d22..5b9d4e9 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3585,7 +3585,6 @@ static int rx_macro_remove(struct platform_device *pdev)
 static struct platform_driver rx_macro_driver = {
 	.driver = {
 		.name = "rx_macro",
-		.owner = THIS_MODULE,
 		.of_match_table = rx_macro_dt_match,
 		.suppress_bind_attrs = true,
 	},
-- 
1.8.3.1

