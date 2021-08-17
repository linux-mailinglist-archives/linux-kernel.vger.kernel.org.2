Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71523EF2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhHQTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbhHQTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5583461075;
        Tue, 17 Aug 2021 19:43:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zI-004TQ6-DE; Tue, 17 Aug 2021 15:43:04 -0400
Message-ID: <20210817194304.249678281@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/19] tracing/boot: Add per-event histogram action options
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a hist-trigger action syntax support to boot-time tracing.
Currently, boot-time tracing supports per-event actions as option
strings. However, for the histogram action, it has a special syntax
and usually needs a long action definition.
To make it readable and fit to the bootconfig syntax, this introduces
a new options for histogram.

Here are the histogram action options for boot-time tracing.

ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
     keys = <KEY>[,...]
     values = <VAL>[,...]
     sort = <SORT-KEY>[,...]
     size = <ENTRIES>
     name = <HISTNAME>
     var { <VAR> = <EXPR> ... }
     pause|continue|clear
     onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
     onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }
     filter = <FILTER>
}

Where <ACTION> is one of below;

     trace = <EVENT>, <ARG1>[, ...]
     save = <ARG1>[, ...]
     snapshot

Link: https://lkml.kernel.org/r/162856124106.203126.10501871028479029087.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 231 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index d713714cba67..3d0e51368f51 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -171,6 +171,231 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 }
 #endif
 
+#ifdef CONFIG_HIST_TRIGGERS
+static int __init __printf(3, 4)
+append_printf(char **bufp, char *end, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	if (*bufp == end)
+		return -ENOSPC;
+
+	va_start(args, fmt);
+	ret = vsnprintf(*bufp, end - *bufp, fmt, args);
+	if (ret < end - *bufp) {
+		*bufp += ret;
+	} else {
+		*bufp = end;
+		ret = -ERANGE;
+	}
+	va_end(args);
+
+	return ret;
+}
+
+static int __init
+append_str_nospace(char **bufp, char *end, const char *str)
+{
+	char *p = *bufp;
+	int len;
+
+	while (p < end - 1 && *str != '\0') {
+		if (!isspace(*str))
+			*(p++) = *str;
+		str++;
+	}
+	*p = '\0';
+	if (p == end - 1) {
+		*bufp = end;
+		return -ENOSPC;
+	}
+	len = p - *bufp;
+	*bufp = p;
+	return (int)len;
+}
+
+static int __init
+trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
+			  char *end, const char *key)
+{
+	struct xbc_node *knode, *anode;
+	const char *p;
+	char sep;
+
+	knode = xbc_node_find_child(hnode, key);
+	if (knode) {
+		anode = xbc_node_get_child(knode);
+		if (!anode) {
+			pr_err("hist.%s requires value(s).\n", key);
+			return -EINVAL;
+		}
+
+		append_printf(bufp, end, ":%s", key);
+		sep = '=';
+		xbc_array_for_each_value(anode, p) {
+			append_printf(bufp, end, "%c%s", sep, p);
+			if (sep == '=')
+				sep = ',';
+		}
+	} else
+		return -ENOENT;
+
+	return 0;
+}
+
+static int __init
+trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
+			    char *end, const char *param)
+{
+	struct xbc_node *knode, *anode;
+	const char *p;
+	char sep;
+
+	/* Compose 'handler' parameter */
+	p = xbc_node_find_value(hnode, param, NULL);
+	if (!p) {
+		pr_err("hist.%s requires '%s' option.\n",
+		       xbc_node_get_data(hnode), param);
+		return -EINVAL;
+	}
+	append_printf(bufp, end, ":%s(%s)", xbc_node_get_data(hnode), p);
+
+	/* Compose 'action' parameter */
+	knode = xbc_node_find_child(hnode, "trace");
+	if (!knode)
+		knode = xbc_node_find_child(hnode, "save");
+
+	if (knode) {
+		anode = xbc_node_get_child(knode);
+		if (!anode || !xbc_node_is_value(anode)) {
+			pr_err("hist.%s.%s requires value(s).\n",
+			       xbc_node_get_data(hnode),
+			       xbc_node_get_data(knode));
+			return -EINVAL;
+		}
+
+		append_printf(bufp, end, ".%s", xbc_node_get_data(knode));
+		sep = '(';
+		xbc_array_for_each_value(anode, p) {
+			append_printf(bufp, end, "%c%s", sep, p);
+			if (sep == '(')
+				sep = ',';
+		}
+		append_printf(bufp, end, ")");
+	} else if (xbc_node_find_child(hnode, "snapshot")) {
+		append_printf(bufp, end, ".snapshot()");
+	} else {
+		pr_err("hist.%s requires an action.\n",
+		       xbc_node_get_data(hnode));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Histogram boottime tracing syntax.
+ *
+ * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
+ *	keys = <KEY>[,...]
+ *	values = <VAL>[,...]
+ *	sort = <SORT-KEY>[,...]
+ *	size = <ENTRIES>
+ *	name = <HISTNAME>
+ *	var { <VAR> = <EXPR> ... }
+ *	pause|continue|clear
+ *	onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
+ *	onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }
+ *	filter = <FILTER>
+ * }
+ *
+ * Where <ACTION> are;
+ *
+ *	trace = <EVENT>, <ARG1>[, ...]
+ *	save = <ARG1>[, ...]
+ *	snapshot
+ */
+static int __init
+trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
+{
+	struct xbc_node *node, *knode;
+	char *end = buf + size;
+	const char *p;
+	int ret = 0;
+
+	append_printf(&buf, end, "hist");
+
+	ret = trace_boot_hist_add_array(hnode, &buf, end, "keys");
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			pr_err("hist requires keys.\n");
+		return -EINVAL;
+	}
+
+	ret = trace_boot_hist_add_array(hnode, &buf, end, "values");
+	if (ret == -EINVAL)
+		return ret;
+	ret = trace_boot_hist_add_array(hnode, &buf, end, "sort");
+	if (ret == -EINVAL)
+		return ret;
+
+	p = xbc_node_find_value(hnode, "size", NULL);
+	if (p)
+		append_printf(&buf, end, ":size=%s", p);
+
+	p = xbc_node_find_value(hnode, "name", NULL);
+	if (p)
+		append_printf(&buf, end, ":name=%s", p);
+
+	node = xbc_node_find_child(hnode, "var");
+	if (node) {
+		xbc_node_for_each_key_value(node, knode, p) {
+			/* Expression must not include spaces. */
+			append_printf(&buf, end, ":%s=",
+				      xbc_node_get_data(knode));
+			append_str_nospace(&buf, end, p);
+		}
+	}
+
+	/* Histogram control attributes (mutual exclusive) */
+	if (xbc_node_find_child(hnode, "pause"))
+		append_printf(&buf, end, ":pause");
+	else if (xbc_node_find_child(hnode, "continue"))
+		append_printf(&buf, end, ":continue");
+	else if (xbc_node_find_child(hnode, "clear"))
+		append_printf(&buf, end, ":clear");
+
+	/* Histogram handler and actions */
+	node = xbc_node_find_child(hnode, "onmax");
+	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
+		return -EINVAL;
+	node = xbc_node_find_child(hnode, "onchange");
+	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
+		return -EINVAL;
+	node = xbc_node_find_child(hnode, "onmatch");
+	if (node && trace_boot_hist_add_handler(node, &buf, end, "event") < 0)
+		return -EINVAL;
+
+	p = xbc_node_find_value(hnode, "filter", NULL);
+	if (p)
+		append_printf(&buf, end, " if %s", p);
+
+	if (buf == end) {
+		pr_err("hist exceeds the max command length.\n");
+		return -E2BIG;
+	}
+
+	return 0;
+}
+#else
+static int __init
+trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			  struct xbc_node *enode)
@@ -212,6 +437,12 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", buf);
 		}
+		anode = xbc_node_find_child(enode, "hist");
+		if (anode &&
+		    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
+			if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply hist trigger: %s\n", buf);
+		}
 	} else if (xbc_node_find_value(enode, "actions", NULL))
 		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 
-- 
2.30.2
