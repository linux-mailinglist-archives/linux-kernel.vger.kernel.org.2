Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1263A21B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFJBD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhFJBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FE66140D;
        Thu, 10 Jun 2021 01:01:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr953-002bYH-Az; Wed, 09 Jun 2021 21:01:57 -0400
Message-ID: <20210610010157.181456048@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH 03/11] tracing: Remove redundant assignment to event_var
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable event_var is set to 'ERR_PTR(-EINVAL)', but this value
is never read as it is overwritten or not used later on, hence
it is a redundant assignment and can be removed.

Clean up the following clang-analyzer warning:

kernel/trace/trace_events_hist.c:2437:21: warning: Value stored to
'event_var' during its initialization is never read
[clang-analyzer-deadcode.DeadStores].

Link: https://lkml.kernel.org/r/1620470236-26562-1-git-send-email-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63f1d6c..dacd6fe0f60c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2434,12 +2434,12 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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
2.30.2
