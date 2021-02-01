Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBB30A31C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBAIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:14:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34637 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhBAIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:14:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNVd5Kb_1612167182;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNVd5Kb_1612167182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 16:13:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     keescook@chromium.org
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] gcc-plugins: Remove unneeded return variable
Date:   Mon,  1 Feb 2021 16:13:00 +0800
Message-Id: <1612167180-7136-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./scripts/gcc-plugins/structleak_plugin.c:173:14-17: Unneeded variable:
"ret". Return "0" on line 203

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 scripts/gcc-plugins/structleak_plugin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index 29b480c..d7190e4 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -170,7 +170,6 @@ static void initialize(tree var)
 static unsigned int structleak_execute(void)
 {
 	basic_block bb;
-	unsigned int ret = 0;
 	tree var;
 	unsigned int i;
 
@@ -200,7 +199,7 @@ static unsigned int structleak_execute(void)
 			initialize(var);
 	}
 
-	return ret;
+	return 0;
 }
 
 #define PASS_NAME structleak
-- 
1.8.3.1

