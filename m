Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615323A8EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhFPCrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:47:52 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41646 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhFPCrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:47:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UcZEGKZ_1623811542;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UcZEGKZ_1623811542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 10:45:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] SoC: codecs: wcd938x: fix boolreturn.cocci warning
Date:   Wed, 16 Jun 2021 10:45:35 +0800
Message-Id: <1623811535-15841-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true/false
instead of 1/0.

Fix the following coccicheck warning:
./sound/soc/codecs/wcd938x.c:1190:9-10: WARNING: return of 0/1 in
function 'wcd938x_volatile_register' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2cf6145..cfe00536 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1187,7 +1187,7 @@ static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
 static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
 {
 	if (reg <= WCD938X_BASE_ADDRESS)
-		return 0;
+		return false;
 
 	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
 		return true;
-- 
1.8.3.1

