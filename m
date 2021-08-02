Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6B3DDC78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhHBPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234371AbhHBPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:30:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4841C610FC;
        Mon,  2 Aug 2021 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627918230;
        bh=OhSnLVQy073jnsPYtg0t1b02oGcKVrDDLHql+kPn4lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsemAHcXQTnrcYs40gUc5B/7RmNlwkLojIeRHR2UxTFwlLqvsClM55te2bwshpbpC
         SetE1UcpMfigPT7ssglMGWAn+CVt1gEwlaCaaTsH+fn2xq+h2m51PBNCH0pIgaqh1l
         ivKza+sIjD3s684HfYvMDLCKqvvLqTOSaMQAwBk+jz4M9NiAHKscMtCD0lVx9AOnfU
         TXtRIF0F2ydeFodBSlZJvdGzw94upgotddBn7zVw6o8cofzOVT0hHw3chAy6krj3GO
         +KfDEf+U1nQ9pM8vuSx7X3mKSNbTiLbZfEwNb+Hz9PtL+sX9ZedufoDz/27aKqmcO8
         Bit4wEwLTbP9A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 2/3] tracing/boot: Add per-event histogram action options
Date:   Tue,  3 Aug 2021 00:30:27 +0900
Message-Id: <162791822760.552329.4114905119356493586.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162791821009.552329.4358174280895732459.stgit@devnote2>
References: <162791821009.552329.4358174280895732459.stgit@devnote2>
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
     onmax|onchange { var = <VAR>, <ACTION> [= <PARAM>] }
     onmatch { event = <EVENT>, <ACTION> [= <PARAM>] }
     filter = <FILTER>
}

Where <ACTION> is one of below;

     trace = <EVENT>, <ARG1>[, ...]
     save = <ARG1>[, ...]
     snapshot

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |  200 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index e6dc9269ad75..56e92d34a88c 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -171,6 +171,200 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 }
 #endif
 
+#ifdef CONFIG_HIST_TRIGGERS
+static int __init
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
+
+	knode = xbc_node_find_child(hnode, key);
+	if (knode) {
+		anode = xbc_node_get_child(knode);
+		if (!anode) {
+			pr_err("hist.%s requires value(s).\n", key);
+			return -EINVAL;
+		}
+
+		append_printf(bufp, end, "%s=", key);
+		xbc_array_for_each_value(anode, p) {
+			append_printf(bufp, end, "%s,", p);
+		}
+		(*bufp)[-1] = ':';
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
+
+	/* Compose 'handler' parameter */
+	p = xbc_node_find_value(hnode, param, NULL);
+	if (!p) {
+		pr_err("hist.%s requires '%s' option.\n",
+		       xbc_node_get_data(hnode), param);
+		return -EINVAL;
+	}
+	append_printf(bufp, end, "%s(%s).", xbc_node_get_data(hnode), p);
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
+		append_printf(bufp, end, "%s(", xbc_node_get_data(knode));
+		xbc_array_for_each_value(anode, p) {
+			append_printf(bufp, end, "%s,", p);
+		}
+		(*bufp)[-1] = ')';
+	} else if (xbc_node_find_child(hnode, "snapshot")) {
+		append_printf(bufp, end, "snapshot()");
+	} else {
+		pr_err("hist.%s requires an action.\n",
+		       xbc_node_get_data(hnode));
+		return -EINVAL;
+	}
+	append_printf(bufp, end, ":");
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
+ *	onmax|onchange { var = <VAR>, <ACTION> [= <PARAM>] }
+ *	onmatch { event = <EVENT>, <ACTION> [= <PARAM>] }
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
+	append_printf(&buf, end, "hist:");
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
+		append_printf(&buf, end, "size=%s:", p);
+
+	p = xbc_node_find_value(hnode, "name", NULL);
+	if (p)
+		append_printf(&buf, end, "name=%s:", p);
+
+	node = xbc_node_find_child(hnode, "var");
+	if (node) {
+		xbc_node_for_each_key_value(node, knode, p) {
+			append_printf(&buf, end, "%s=%s:",
+				      xbc_node_get_data(knode), p);
+		}
+	}
+
+	/* Histogram control attributes */
+	if (xbc_node_find_child(hnode, "pause"))
+		append_printf(&buf, end, "pause:");
+	if (xbc_node_find_child(hnode, "continue"))
+		append_printf(&buf, end, "continue:");
+	if (xbc_node_find_child(hnode, "clear"))
+		append_printf(&buf, end, "clear:");
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
+	/* Remove the last ':' */
+	if (buf + size > end)
+		*(--buf) = '\0';
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
@@ -211,6 +405,12 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
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

