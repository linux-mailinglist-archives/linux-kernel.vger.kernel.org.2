Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE927354D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhDFGwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:52:21 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57012 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhDFGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:52:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUfZeID_1617691907;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUfZeID_1617691907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 14:52:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ftrace: Check if pages were allocated before calling free_pages()
Date:   Tue,  6 Apr 2021 14:51:45 +0800
Message-Id: <1617691905-8016-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that on error pg->size can be zero when getting its
order,which would return a -1 value. It is dangerous to pass in an
order of -1 to free_pages(). Check if order is greater than or equal
to zero before calling free_pages().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b7e29db..74efc33 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6811,7 +6811,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		if (!pg->index) {
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			free_pages((unsigned long)pg->records, order);
+			if (order >= 0)
+				free_pages((unsigned long)pg->records, order);
 			ftrace_number_of_pages -= 1 << order;
 			ftrace_number_of_groups--;
 			kfree(pg);
-- 
1.8.3.1

