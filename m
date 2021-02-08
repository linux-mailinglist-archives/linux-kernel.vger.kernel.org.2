Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1334313D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhBHS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBHPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:51:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A884164DC4;
        Mon,  8 Feb 2021 15:51:16 +0000 (UTC)
Date:   Mon, 8 Feb 2021 10:51:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [for-linus][PATCH] tracing: Do not count ftrace events in top level
 enable output
Message-ID: <20210208105113.2c4598ff@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt (VMware) (1):
      tracing: Do not count ftrace events in top level enable output

----
 kernel/trace/trace_events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---------------------------
commit 256cfdd6fdf70c6fcf0f7c8ddb0ebd73ce8f3bc9
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Feb 5 15:40:04 2021 -0500

    tracing: Do not count ftrace events in top level enable output
    
    The file /sys/kernel/tracing/events/enable is used to enable all events by
    echoing in "1", or disabling all events when echoing in "0". To know if all
    events are enabled, disabled, or some are enabled but not all of them,
    cating the file should show either "1" (all enabled), "0" (all disabled), or
    "X" (some enabled but not all of them). This works the same as the "enable"
    files in the individule system directories (like tracing/events/sched/enable).
    
    But when all events are enabled, the top level "enable" file shows "X". The
    reason is that its checking the "ftrace" events, which are special events
    that only exist for their format files. These include the format for the
    function tracer events, that are enabled when the function tracer is
    enabled, but not by the "enable" file. The check includes these events,
    which will always be disabled, and even though all true events are enabled,
    the top level "enable" file will show "X" instead of "1".
    
    To fix this, have the check test the event's flags to see if it has the
    "IGNORE_ENABLE" flag set, and if so, not test it.
    
    Cc: stable@vger.kernel.org
    Fixes: 553552ce1796c ("tracing: Combine event filter_active and enable into single flags field")
    Reported-by: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e9d28eeccb7e..d387b774ceeb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1212,7 +1212,8 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	mutex_lock(&event_mutex);
 	list_for_each_entry(file, &tr->events, list) {
 		call = file->event_call;
-		if (!trace_event_name(call) || !call->class || !call->class->reg)
+		if ((call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
+		    !trace_event_name(call) || !call->class || !call->class->reg)
 			continue;
 
 		if (system && strcmp(call->class->system, system->name) != 0)
