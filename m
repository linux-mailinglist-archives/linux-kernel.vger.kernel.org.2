Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28F4333DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhJSKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:51:24 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53034 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235282AbhJSKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:51:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Usued8d_1634640540;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Usued8d_1634640540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 18:49:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ftrace: make ftrace_profile_pages_init static
Date:   Tue, 19 Oct 2021 18:48:54 +0800
Message-Id: <1634640534-18280-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

This symbol is not used outside of ftrace.c, so marks it static.

Fixes the following sparse warning:

kernel/trace/ftrace.c:579:5: warning: symbol 'ftrace_profile_pages_init'
was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: cafb168a1c92 ("tracing: make the function profiler per cpu")
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 655a7deb59d6..f89d25125d97 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -576,7 +576,7 @@ static void ftrace_profile_reset(struct ftrace_profile_stat *stat)
 	       FTRACE_PROFILE_HASH_SIZE * sizeof(struct hlist_head));
 }
 
-int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
+static int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
 {
 	struct ftrace_profile_page *pg;
 	int functions;
-- 
2.19.1.6.gb485710b

