Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9113DB72A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhG3Ka2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:30:28 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34500 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238440AbhG3KaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:30:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UhR6K7y_1627641004;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UhR6K7y_1627641004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 18:30:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     chris@zankel.net
Cc:     jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xtensa: ISS: Fix warning comparing pointer to 0
Date:   Fri, 30 Jul 2021 18:29:59 +0800
Message-Id: <1627640999-17706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./arch/xtensa/platforms/iss/console.c:204:10-11: WARNING comparing
pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/xtensa/platforms/iss/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 81f9889..92d4624 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -201,7 +201,7 @@ static void iss_console_write(struct console *co, const char *s, unsigned count)
 {
 	int len = strlen(s);
 
-	if (s != 0 && *s != 0)
+	if (s && *s != 0)
 		simc_write(1, s, count < len ? count : len);
 }
 
-- 
1.8.3.1

