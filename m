Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4402037713F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhEHKif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 06:38:35 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39643 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEHKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 06:38:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UY9-dYp_1620470237;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY9-dYp_1620470237)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 18:37:26 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] tracing: Remove redundant assignment to event_var
Date:   Sat,  8 May 2021 18:37:16 +0800
Message-Id: <1620470236-26562-1-git-send-email-jiapeng.chong@linux.alibaba.com>
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
Changes in v2:
  -Move the declaration of event_var below key_field, as their names
   are both the same size in length and are of the same type. This
   keeps the "upside-down x-mas tree" look of the declarations. For
   the follow advice: https://lore.kernel.org/patchwork/patch/1422518/

 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63..dacd6fe 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2434,12 +2434,12 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 		      char *subsys_name, char *event_name, char *field_name)
 {
 	struct trace_array *tr = target_hist_data->event_file->tr;
-	struct hist_field *event_var = ERR_PTR(-EINVAL);
 	struct hist_trigger_data *hist_data;
 	unsigned int i, n, first = true;
 	struct field_var_hist *var_hist;
 	struct trace_event_file *file;
 	struct hist_field *key_field;
+	struct hist_field *event_var;
 	char *saved_filter;
 	char *cmd;
 	int ret;
-- 
1.8.3.1

