Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028A39DA8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:04:45 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54944 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhFGLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:04:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=liangyan.peng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ubb.crK_1623063753;
Received: from localhost(mailfrom:liangyan.peng@linux.alibaba.com fp:SMTPD_---0Ubb.crK_1623063753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jun 2021 19:02:49 +0800
From:   Liangyan <liangyan.peng@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>, yinbinbin@alibabacloud.com,
        wetp <wetp.zy@linux.alibaba.com>,
        Liangyan <liangyan.peng@linux.alibaba.com>
Subject: [PATCH] tracing: Correct the length check in use of filter buffer
Date:   Mon,  7 Jun 2021 19:02:31 +0800
Message-Id: <20210607110231.1713929-1-liangyan.peng@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b220c049d519 ("tracing: Check length before giving out
the filter buffer") adds length check to protect trace data overflow
introduced in 0fc1b09ff1ff, seems that this fix can't prevent
overflow entirely, the length check should also take the sizeof
entry->array[0] into account, since this array[0] is filled the
length of trace data and occupy addtional space and risk overflow.

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a21ef9cd2aae..9299057feb56 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2736,7 +2736,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if ((len < (PAGE_SIZE - sizeof(*entry))) && val == 1) {
+		if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
 			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] = len;
 			return entry;
-- 
2.14.4.44.g2045bb6

