Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2825935D7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhDMGDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:03:19 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40113 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243829AbhDMGDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:03:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVQPvrp_1618293771;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVQPvrp_1618293771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 14:02:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] hwmon: (nct6683) remove useless function
Date:   Tue, 13 Apr 2021 14:02:50 +0800
Message-Id: <1618293770-55307-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/hwmon/nct6683.c:491:19: warning: unused function 'in_to_reg'
[-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hwmon/nct6683.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a23047a..b886cf0 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -488,17 +488,6 @@ static inline long in_from_reg(u16 reg, u8 src)
 	return reg * scale;
 }
 
-static inline u16 in_to_reg(u32 val, u8 src)
-{
-	int scale = 16;
-
-	if (src == MON_SRC_VCC || src == MON_SRC_VSB || src == MON_SRC_AVSB ||
-	    src == MON_SRC_VBAT)
-		scale <<= 1;
-
-	return clamp_val(DIV_ROUND_CLOSEST(val, scale), 0, 127);
-}
-
 static u16 nct6683_read(struct nct6683_data *data, u16 reg)
 {
 	int res;
-- 
1.8.3.1

