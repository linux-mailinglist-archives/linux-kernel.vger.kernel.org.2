Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990FB4073AB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhIJXF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhIJXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:05:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6D961214;
        Fri, 10 Sep 2021 23:04:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mOpYy-001JJC-8d; Fri, 10 Sep 2021 19:04:04 -0400
Message-ID: <20210910230404.110084893@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Sep 2021 19:03:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 3/3] bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
References: <20210910230327.606986082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Rename xbc_node_find_child() to xbc_node_find_subkey() for
clarifying that function returns a key node (no value node).
Since there are xbc_node_for_each_child() (loop on all child
nodes) and xbc_node_for_each_subkey() (loop on only subkey
nodes), this name distinction is necessary to avoid confusing
users.

Link: https://lkml.kernel.org/r/163119459826.161018.11200274779483115300.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h |  4 ++--
 kernel/trace/trace_boot.c  | 24 ++++++++++++------------
 lib/bootconfig.c           |  8 ++++----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index abe089c27529..537e1b991f11 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -110,7 +110,7 @@ static inline __init bool xbc_node_is_leaf(struct xbc_node *node)
 }
 
 /* Tree-based key-value access APIs */
-struct xbc_node * __init xbc_node_find_child(struct xbc_node *parent,
+struct xbc_node * __init xbc_node_find_subkey(struct xbc_node *parent,
 					     const char *key);
 
 const char * __init xbc_node_find_value(struct xbc_node *parent,
@@ -148,7 +148,7 @@ xbc_find_value(const char *key, struct xbc_node **vnode)
  */
 static inline struct xbc_node * __init xbc_find_node(const char *key)
 {
-	return xbc_node_find_child(NULL, key);
+	return xbc_node_find_subkey(NULL, key);
 }
 
 /**
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index db6ee372dc6d..8d252f63cd78 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -262,9 +262,9 @@ trace_boot_hist_add_one_handler(struct xbc_node *hnode, char **bufp,
 	append_printf(bufp, end, ":%s(%s)", handler, p);
 
 	/* Compose 'action' parameter */
-	knode = xbc_node_find_child(hnode, "trace");
+	knode = xbc_node_find_subkey(hnode, "trace");
 	if (!knode)
-		knode = xbc_node_find_child(hnode, "save");
+		knode = xbc_node_find_subkey(hnode, "save");
 
 	if (knode) {
 		anode = xbc_node_get_child(knode);
@@ -283,7 +283,7 @@ trace_boot_hist_add_one_handler(struct xbc_node *hnode, char **bufp,
 				sep = ',';
 		}
 		append_printf(bufp, end, ")");
-	} else if (xbc_node_find_child(hnode, "snapshot")) {
+	} else if (xbc_node_find_subkey(hnode, "snapshot")) {
 		append_printf(bufp, end, ".snapshot()");
 	} else {
 		pr_err("hist.%s requires an action.\n",
@@ -314,7 +314,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 			break;
 	}
 
-	if (xbc_node_find_child(hnode, param))
+	if (xbc_node_find_subkey(hnode, param))
 		ret = trace_boot_hist_add_one_handler(hnode, bufp, end, handler, param);
 
 	return ret;
@@ -374,7 +374,7 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 	if (p)
 		append_printf(&buf, end, ":name=%s", p);
 
-	node = xbc_node_find_child(hnode, "var");
+	node = xbc_node_find_subkey(hnode, "var");
 	if (node) {
 		xbc_node_for_each_key_value(node, knode, p) {
 			/* Expression must not include spaces. */
@@ -393,13 +393,13 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 		append_printf(&buf, end, ":clear");
 
 	/* Histogram handler and actions */
-	node = xbc_node_find_child(hnode, "onmax");
+	node = xbc_node_find_subkey(hnode, "onmax");
 	if (node && trace_boot_hist_add_handlers(node, &buf, end, "var") < 0)
 		return -EINVAL;
-	node = xbc_node_find_child(hnode, "onchange");
+	node = xbc_node_find_subkey(hnode, "onchange");
 	if (node && trace_boot_hist_add_handlers(node, &buf, end, "var") < 0)
 		return -EINVAL;
-	node = xbc_node_find_child(hnode, "onmatch");
+	node = xbc_node_find_subkey(hnode, "onmatch");
 	if (node && trace_boot_hist_add_handlers(node, &buf, end, "event") < 0)
 		return -EINVAL;
 
@@ -436,7 +436,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 		}
 	}
 
-	if (xbc_node_find_child(hnode, "keys")) {
+	if (xbc_node_find_subkey(hnode, "keys")) {
 		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
 			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
@@ -495,7 +495,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
 		}
-		anode = xbc_node_find_child(enode, "hist");
+		anode = xbc_node_find_subkey(enode, "hist");
 		if (anode)
 			trace_boot_init_histograms(file, anode, buf, ARRAY_SIZE(buf));
 	} else if (xbc_node_find_value(enode, "actions", NULL))
@@ -517,7 +517,7 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 	bool enable, enable_all = false;
 	const char *data;
 
-	node = xbc_node_find_child(node, "event");
+	node = xbc_node_find_subkey(node, "event");
 	if (!node)
 		return;
 	/* per-event key starts with "event.GROUP.EVENT" */
@@ -620,7 +620,7 @@ trace_boot_init_instances(struct xbc_node *node)
 	struct trace_array *tr;
 	const char *p;
 
-	node = xbc_node_find_child(node, "instance");
+	node = xbc_node_find_subkey(node, "instance");
 	if (!node)
 		return;
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 927017431fb6..f8419cff1147 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -142,16 +142,16 @@ xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
 }
 
 /**
- * xbc_node_find_child() - Find a child node which matches given key
+ * xbc_node_find_subkey() - Find a subkey node which matches given key
  * @parent: An XBC node.
  * @key: A key string.
  *
- * Search a node under @parent which matches @key. The @key can contain
+ * Search a key node under @parent which matches @key. The @key can contain
  * several words jointed with '.'. If @parent is NULL, this searches the
  * node from whole tree. Return NULL if no node is matched.
  */
 struct xbc_node * __init
-xbc_node_find_child(struct xbc_node *parent, const char *key)
+xbc_node_find_subkey(struct xbc_node *parent, const char *key)
 {
 	struct xbc_node *node;
 
@@ -191,7 +191,7 @@ const char * __init
 xbc_node_find_value(struct xbc_node *parent, const char *key,
 		    struct xbc_node **vnode)
 {
-	struct xbc_node *node = xbc_node_find_child(parent, key);
+	struct xbc_node *node = xbc_node_find_subkey(parent, key);
 
 	if (!node || !xbc_node_is_key(node))
 		return NULL;
-- 
2.32.0
