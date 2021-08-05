Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155843E196A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHEQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhHEQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:25:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47DE261158;
        Thu,  5 Aug 2021 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180738;
        bh=NE0tccygodsTro8FtkFkEka66XqPVFTA6T7r8mIIRBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6OEVR2y41cb2Ke7SSNBndJcYV6YJCgPC05bK4mdfQR5OOgDm2HPP8p+Z1CfHnMOF
         wf/J1/Uckhe9HFRxTG07vUHtunASjMg3IZHiAdVxJiQ6coKqLyX+jJigWouxKEhYpj
         /laJ8FTUc0DFmGT0C8xEQBcUnZBShSyIcl1MtaPDg6iX+1alwSg4JV+5CAUkgtrBgU
         +FAeIs52m+umAUgVVoE9MYZw0QxMLb87dI7UbLFutpPxsdRrExoY1qiu+iR94Ul8o+
         WkNnplMILEE6HKLUVPAr1Qn9uBs3X1z73ndz1ur109Kx6I2K9PLFFbvbp7TeTZYQ3M
         3OljgOKWSBHzg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/9] tracing/boot: Add per-event histogram action options
Date:   Fri,  6 Aug 2021 01:25:37 +0900
Message-Id: <162818073683.226227.11151199287512589968.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162818072104.226227.18088999222035270055.stgit@devnote2>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
   - Cleanup code to add ':' as a prefix for each element
     instead of fixup the last ':'.
   - Fix syntax typo for handler actions.
   - Make pause|continue|clear mutual exclusive.
   - Add __printf() attribute to the append_printf().
---
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index e6dc9269ad75..aaaf8b8ed3c9 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -171,6 +171,202 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
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
+			append_printf(&buf, end, ":%s=%s",
+				      xbc_node_get_data(knode), p);
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
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			  struct xbc_node *enode)
@@ -211,6 +407,12 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 		else if (trigger_process_regex(file, buf) < 0)
 			pr_err("Failed to apply an action: %s\n", buf);
 	}
+	anode = xbc_node_find_child(enode, "hist");
+	if (anode &&
+	    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
+		if (trigger_process_regex(file, buf) < 0)
+			pr_err("Failed to apply hist trigger: %s\n", buf);
+	}
 #endif
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {

