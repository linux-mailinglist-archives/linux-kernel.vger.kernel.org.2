Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201E33F173D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhHSK0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236149AbhHSK0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:26:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7ADD60ED3;
        Thu, 19 Aug 2021 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629368765;
        bh=SSMtInlpuewpUuRecz0kePiL21Ixjy/lZSC95ZWxifs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvnH4zhFNC6TxmNZKTfg651xRAnOCZjBnMdFsOTVowDNDlbfPzlrMx3cW/cMzJ7TR
         FIL45x85IKoR7EO/DmVi73guVsIySWJ7pfOMqNoL9FQHHvDXzGoh7SvX7d4I5wsKtM
         wR06MMWJler4dDm0v8y4cgtAbIbfTNLXP1g29Zl5sWAHGTFNUtgM3jekESgiEZpixp
         U1xk7eCWfffJj8PH5ooDKygQVPH2rEaz43KA/kamcQ11SdRFe+J79QkUFMkAQzxUeJ
         pr+4tenGg9wHPKvtl110xT3mA8/EWwtCJsuKv+KeodfqQwLxY8RsByLs7D4lho8CRg
         2P108reX9nPnw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing/probes: Reject events which have the same name of existing one
Date:   Thu, 19 Aug 2021 19:26:02 +0900
Message-Id: <162936876189.187130.17558311387542061930.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819192258.7e39bafa8084417d96a8244e@kernel.org>
References: <20210819192258.7e39bafa8084417d96a8244e@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobe_events and uprobe_events only check whether the
other same-type probe event has the same name or not, if the
user gives the same name of the existing tracepoint event (or
the other type of probe events), it silently fails to create
the tracefs entry (but registered.) as below.


/sys/kernel/tracing # ls events/task/task_rename
enable   filter   format   hist     id       trigger
/sys/kernel/tracing # echo p:task/task_rename vfs_read >> kprobe_events
[  113.048508] Could not create tracefs 'task_rename' directory
/sys/kernel/tracing # cat kprobe_events
p:task/task_rename vfs_read


To fix this issue, check whether the existing events have the
same name or not in trace_probe_register_event_call(). If exists,
it rejects to register the new event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Steve, I think this is also good to your eprobe series.
---
 kernel/trace/trace_kprobe.c |    6 +++++-
 kernel/trace/trace_probe.c  |   25 +++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    1 +
 kernel/trace/trace_uprobe.c |    6 +++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ea6178cb5e33..032191977e34 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -647,7 +647,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	/* Register new event */
 	ret = register_kprobe_event(tk);
 	if (ret) {
-		pr_warn("Failed to register probe event(%d)\n", ret);
+		if (ret == -EEXIST) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, EVENT_EXIST);
+		} else
+			pr_warn("Failed to register probe event(%d)\n", ret);
 		goto end;
 	}
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 15413ad7cef2..0e29bb14fc8b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1029,11 +1029,36 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 	return ret;
 }
 
+static struct trace_event_call *
+find_trace_event_call(const char *system, const char *event_name)
+{
+	struct trace_event_call *tp_event;
+	const char *name;
+
+	list_for_each_entry(tp_event, &ftrace_events, list) {
+		if (!tp_event->class->system ||
+		    strcmp(system, tp_event->class->system))
+			continue;
+		name = trace_event_name(tp_event);
+		if (!name || strcmp(event_name, name))
+			continue;
+		return tp_event;
+	}
+
+	return NULL;
+}
+
 int trace_probe_register_event_call(struct trace_probe *tp)
 {
 	struct trace_event_call *call = trace_probe_event_call(tp);
 	int ret;
 
+	lockdep_assert_held(&event_mutex);
+
+	if (find_trace_event_call(trace_probe_group_name(tp),
+				  trace_probe_name(tp)))
+		return -EEXIST;
+
 	ret = register_trace_event(&call->event);
 	if (!ret)
 		return -ENODEV;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 227d518e5ba5..9f14186d132e 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -399,6 +399,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_EVENT_NAME,	"Event name is not specified"),		\
 	C(EVENT_TOO_LONG,	"Event name is too long"),		\
 	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
+	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
 	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
 	C(BAD_STACK_NUM,	"Invalid stack number"),		\
 	C(BAD_ARG_NUM,		"Invalid argument number"),		\
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9b50869a5ddb..957244ee07c8 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -514,7 +514,11 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 	ret = register_uprobe_event(tu);
 	if (ret) {
-		pr_warn("Failed to register probe event(%d)\n", ret);
+		if (ret == -EEXIST) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, EVENT_EXIST);
+		} else
+			pr_warn("Failed to register probe event(%d)\n", ret);
 		goto end;
 	}
 

