Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB44333400
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCJDye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:54:34 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37547 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhCJDyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:54:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0URBTWf-_1615348439;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URBTWf-_1615348439)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 11:54:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] mfd: dbx500-prcmu: Use true and false for bool variable
Date:   Wed, 10 Mar 2021 11:53:59 +0800
Message-Id: <1615348439-57732-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./include/linux/mfd/db8500-prcmu.h:723:8-9: WARNING: return of 0/1 in
function 'db8500_prcmu_is_ac_wake_requested' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  - Make the commit message more clearer.

 include/linux/mfd/db8500-prcmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 4b63d3e..a62de3d 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -720,7 +720,7 @@ static inline int db8500_prcmu_load_a9wdog(u8 id, u32 val)
 
 static inline bool db8500_prcmu_is_ac_wake_requested(void)
 {
-	return 0;
+	return false;
 }
 
 static inline int db8500_prcmu_set_arm_opp(u8 opp)
-- 
1.8.3.1

