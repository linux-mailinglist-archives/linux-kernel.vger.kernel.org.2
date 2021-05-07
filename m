Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF563763A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhEGKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:25:42 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53988 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236541AbhEGKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UY2uhFV_1620383032;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY2uhFV_1620383032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 18:23:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] tracing: Remove redundant assignment to event_var
Date:   Fri,  7 May 2021 18:23:50 +0800
Message-Id: <1620383030-70462-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable event_var is set to 'ERR_PTR(-EINVAL)', but this value
is never read as it is overwritten or not used later on, hence
it is a redundant assignment and can be removed.

Clean up the following clang-analyzer warning:

kernel/trace/trace_events_hist.c:2437:21: warning: Value stored to
'event_var' during its initialization is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63..b37342c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2434,7 +2434,7 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 		      char *subsys_name, char *event_name, char *field_name)
 {
 	struct trace_array *tr = target_hist_data->event_file->tr;
-	struct hist_field *event_var = ERR_PTR(-EINVAL);
+	struct hist_field *event_var;
 	struct hist_trigger_data *hist_data;
 	unsigned int i, n, first = true;
 	struct field_var_hist *var_hist;
-- 
1.8.3.1

