Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1E3F124E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhHSETU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhHSETS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:19:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6634D61100;
        Thu, 19 Aug 2021 04:18:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mGZVp-004dvT-AY; Thu, 19 Aug 2021 00:18:41 -0400
Message-ID: <20210819041841.159849933@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 19 Aug 2021 00:13:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v7 01/10] tracing: Add DYNAMIC flag for dynamic events
References: <20210819041321.105110033@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

To differentiate between static and dynamic events, add a new flag
DYNAMIC to the event flags that all dynamic events have set. This will
allow to differentiate when attaching to a dynamic event from a static
event.

Static events have a mod pointer that references the module they were
created in (or NULL for core kernel). This can be incremented when the
event has something attached to it. But there exists no such mechanism for
dynamic events. This is dangerous as the dynamic events may now disappear
without the "attachment" knowing that it no longer exists.

To enforce the dynamic flag, change dyn_event_add() to pass the event that
is being created such that it can set the DYNAMIC flag of the event. This
helps make sure that no location that creates a dynamic event misses
setting this flag.

Link: https://lore.kernel.org/linux-trace-devel/20210813004448.51c7de69ce432d338f4d226b@kernel.org/
Link: https://lkml.kernel.org/r/20210817035026.936958254@goodmis.org

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h      | 3 +++
 kernel/trace/trace_dynevent.h     | 4 +++-
 kernel/trace/trace_events_synth.c | 2 +-
 kernel/trace/trace_kprobe.c       | 4 ++--
 kernel/trace/trace_uprobe.c       | 4 ++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3c..53c9dffd87fd 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -310,6 +310,7 @@ enum {
 	TRACE_EVENT_FL_NO_SET_FILTER_BIT,
 	TRACE_EVENT_FL_IGNORE_ENABLE_BIT,
 	TRACE_EVENT_FL_TRACEPOINT_BIT,
+	TRACE_EVENT_FL_DYNAMIC_BIT,
 	TRACE_EVENT_FL_KPROBE_BIT,
 	TRACE_EVENT_FL_UPROBE_BIT,
 };
@@ -321,6 +322,7 @@ enum {
  *  NO_SET_FILTER - Set when filter has error and is to be ignored
  *  IGNORE_ENABLE - For trace internal events, do not enable with debugfs file
  *  TRACEPOINT    - Event is a tracepoint
+ *  DYNAMIC       - Event is a dynamic event (created at run time)
  *  KPROBE        - Event is a kprobe
  *  UPROBE        - Event is a uprobe
  */
@@ -330,6 +332,7 @@ enum {
 	TRACE_EVENT_FL_NO_SET_FILTER	= (1 << TRACE_EVENT_FL_NO_SET_FILTER_BIT),
 	TRACE_EVENT_FL_IGNORE_ENABLE	= (1 << TRACE_EVENT_FL_IGNORE_ENABLE_BIT),
 	TRACE_EVENT_FL_TRACEPOINT	= (1 << TRACE_EVENT_FL_TRACEPOINT_BIT),
+	TRACE_EVENT_FL_DYNAMIC		= (1 << TRACE_EVENT_FL_DYNAMIC_BIT),
 	TRACE_EVENT_FL_KPROBE		= (1 << TRACE_EVENT_FL_KPROBE_BIT),
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
 };
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 7754936b57ee..936477a111d3 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -76,13 +76,15 @@ int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
 	return 0;
 }
 
-static inline int dyn_event_add(struct dyn_event *ev)
+static inline int dyn_event_add(struct dyn_event *ev,
+				struct trace_event_call *call)
 {
 	lockdep_assert_held(&event_mutex);
 
 	if (!ev || !ev->ops)
 		return -EINVAL;
 
+	call->flags |= TRACE_EVENT_FL_DYNAMIC;
 	list_add_tail(&ev->list, &dyn_event_list);
 	return 0;
 }
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9315fc03e303..f4f5489e1e28 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1298,7 +1298,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	}
 	ret = register_synth_event(event);
 	if (!ret)
-		dyn_event_add(&event->devent);
+		dyn_event_add(&event->devent, &event->call);
 	else
 		free_synth_event(event);
  out:
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ea6178cb5e33..bfef43bfce37 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -618,7 +618,7 @@ static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
 	if (ret)
 		trace_probe_unlink(&tk->tp);
 	else
-		dyn_event_add(&tk->devent);
+		dyn_event_add(&tk->devent, trace_probe_event_call(&tk->tp));
 
 	return ret;
 }
@@ -661,7 +661,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret < 0)
 		unregister_kprobe_event(tk);
 	else
-		dyn_event_add(&tk->devent);
+		dyn_event_add(&tk->devent, trace_probe_event_call(&tk->tp));
 
 end:
 	mutex_unlock(&event_mutex);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9b50869a5ddb..50eca53b8d22 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -455,7 +455,7 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
 	if (!ret)
-		dyn_event_add(&tu->devent);
+		dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
 
 	return ret;
 }
@@ -518,7 +518,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 		goto end;
 	}
 
-	dyn_event_add(&tu->devent);
+	dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
 
 end:
 	mutex_unlock(&event_mutex);
-- 
2.30.2
