Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83B388C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhESKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26159 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346022AbhESKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UZPQYA2_1621421393;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZPQYA2_1621421393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 May 2021 18:50:01 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     andrew@lunn.ch
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] net: dsa: Remove unsigned expression compared with zero
Date:   Wed, 19 May 2021 18:49:51 +0800
Message-Id: <1621421391-36681-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable val is "u32" always >= 0, so val >= 0 condition are redundant.

Clean up the following coccicheck warning:

./drivers/net/dsa/qca8k.c:732:5-8: WARNING: Unsigned expression compared
with zero: val >= 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/dsa/qca8k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 4753228..7b38b8d 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -729,8 +729,7 @@
 
 	mutex_unlock(&bus->mdio_lock);
 
-	if (val >= 0)
-		val &= QCA8K_MDIO_MASTER_DATA_MASK;
+	val &= QCA8K_MDIO_MASTER_DATA_MASK;
 
 	return val;
 }
-- 
1.8.3.1

