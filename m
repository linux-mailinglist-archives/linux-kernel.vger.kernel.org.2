Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9530DF30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhBCQHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234815AbhBCQGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:06:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202CB64F92;
        Wed,  3 Feb 2021 16:05:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf7-009J67-0m; Wed, 03 Feb 2021 11:05:49 -0500
Message-ID: <20210203160548.907625517@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 02/15] tracing: Update trace_ignore_this_task() kernel-doc comment
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

Update kernel-doc parameter after
commit b3b1e6ededa4 ("ftrace: Create set_ftrace_notrace_pid to not trace tasks")
added @filtered_no_pids.

Link: https://lkml.kernel.org/r/20201231153558.4804-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8a2d786b503..9e4f4043a3df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -530,6 +530,7 @@ trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
 /**
  * trace_ignore_this_task - should a task be ignored for tracing
  * @filtered_pids: The list of pids to check
+ * @filtered_no_pids: The list of pids not to be traced
  * @task: The task that should be ignored if not filtered
  *
  * Checks if @task should be traced or not from @filtered_pids.
@@ -780,7 +781,7 @@ u64 ftrace_now(int cpu)
 }
 
 /**
- * tracing_is_enabled - Show if global_trace has been disabled
+ * tracing_is_enabled - Show if global_trace has been enabled
  *
  * Shows if the global trace has been enabled or not. It uses the
  * mirror flag "buffer_disabled" to be used in fast paths such as for
-- 
2.29.2


