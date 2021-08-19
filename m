Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3233F1532
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhHSIaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:30:00 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37123 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237250AbhHSIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:30:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uk.dLfh_1629361758;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uk.dLfh_1629361758)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 16:29:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     heiko@sntech.de
Cc:     lgirdwood@gmail.com, broonie@kernel.org, jay.xu@rock-chips.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] soc: rockchip: io-domain: Remove unneeded semicolon
Date:   Thu, 19 Aug 2021 16:29:09 +0800
Message-Id: <1629361749-97977-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/soc/rockchip/io-domain.c:118:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/soc/rockchip/io-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index 13c446f..9df513d1 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -115,7 +115,7 @@ static int rk3568_iodomain_write(struct rockchip_iodomain_supply *supply, int uV
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
1.8.3.1

