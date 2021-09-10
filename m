Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B34073B9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhIJXOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhIJXOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:14:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707CC611AD;
        Fri, 10 Sep 2021 23:13:25 +0000 (UTC)
Date:   Fri, 10 Sep 2021 19:13:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Minor fixes to the bootconfig processing
Message-ID: <20210910191324.217c2812@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Minor fixes to the processing of the bootconfig tree.


Please pull the latest trace-v5.15-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-3

Tag SHA1: 38cd35cdd85430a99c001ef2bbf9077f125b07db
Head SHA1: 5dfe50b05588010f347cb2f436434bf22b7a84ed


Masami Hiramatsu (3):
      tracing/boot: Fix trace_boot_hist_add_array() to check array is value
      tracing/boot: Fix to check the histogram control param is a leaf node
      bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()

----
 include/linux/bootconfig.h |  4 ++--
 kernel/trace/trace_boot.c  | 37 ++++++++++++++++++-------------------
 lib/bootconfig.c           |  8 ++++----
 3 files changed, 24 insertions(+), 25 deletions(-)
---------------------------
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
index 388e65d05978..8d252f63cd78 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -219,13 +219,12 @@ static int __init
 trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
 			  char *end, const char *key)
 {
-	struct xbc_node *knode, *anode;
+	struct xbc_node *anode;
 	const char *p;
 	char sep;
 
-	knode = xbc_node_find_child(hnode, key);
-	if (knode) {
-		anode = xbc_node_get_child(knode);
+	p = xbc_node_find_value(hnode, key, &anode);
+	if (p) {
 		if (!anode) {
 			pr_err("hist.%s requires value(s).\n", key);
 			return -EINVAL;
@@ -263,9 +262,9 @@ trace_boot_hist_add_one_handler(struct xbc_node *hnode, char **bufp,
 	append_printf(bufp, end, ":%s(%s)", handler, p);
 
 	/* Compose 'action' parameter */
-	knode = xbc_node_find_child(hnode, "trace");
+	knode = xbc_node_find_subkey(hnode, "trace");
 	if (!knode)
-		knode = xbc_node_find_child(hnode, "save");
+		knode = xbc_node_find_subkey(hnode, "save");
 
 	if (knode) {
 		anode = xbc_node_get_child(knode);
@@ -284,7 +283,7 @@ trace_boot_hist_add_one_handler(struct xbc_node *hnode, char **bufp,
 				sep = ',';
 		}
 		append_printf(bufp, end, ")");
-	} else if (xbc_node_find_child(hnode, "snapshot")) {
+	} else if (xbc_node_find_subkey(hnode, "snapshot")) {
 		append_printf(bufp, end, ".snapshot()");
 	} else {
 		pr_err("hist.%s requires an action.\n",
@@ -315,7 +314,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 			break;
 	}
 
-	if (xbc_node_find_child(hnode, param))
+	if (xbc_node_find_subkey(hnode, param))
 		ret = trace_boot_hist_add_one_handler(hnode, bufp, end, handler, param);
 
 	return ret;
@@ -375,7 +374,7 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 	if (p)
 		append_printf(&buf, end, ":name=%s", p);
 
-	node = xbc_node_find_child(hnode, "var");
+	node = xbc_node_find_subkey(hnode, "var");
 	if (node) {
 		xbc_node_for_each_key_value(node, knode, p) {
 			/* Expression must not include spaces. */
@@ -386,21 +385,21 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 	}
 
 	/* Histogram control attributes (mutual exclusive) */
-	if (xbc_node_find_child(hnode, "pause"))
+	if (xbc_node_find_value(hnode, "pause", NULL))
 		append_printf(&buf, end, ":pause");
-	else if (xbc_node_find_child(hnode, "continue"))
+	else if (xbc_node_find_value(hnode, "continue", NULL))
 		append_printf(&buf, end, ":continue");
-	else if (xbc_node_find_child(hnode, "clear"))
+	else if (xbc_node_find_value(hnode, "clear", NULL))
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
 
@@ -437,7 +436,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 		}
 	}
 
-	if (xbc_node_find_child(hnode, "keys")) {
+	if (xbc_node_find_subkey(hnode, "keys")) {
 		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
 			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
@@ -496,7 +495,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
 		}
-		anode = xbc_node_find_child(enode, "hist");
+		anode = xbc_node_find_subkey(enode, "hist");
 		if (anode)
 			trace_boot_init_histograms(file, anode, buf, ARRAY_SIZE(buf));
 	} else if (xbc_node_find_value(enode, "actions", NULL))
@@ -518,7 +517,7 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 	bool enable, enable_all = false;
 	const char *data;
 
-	node = xbc_node_find_child(node, "event");
+	node = xbc_node_find_subkey(node, "event");
 	if (!node)
 		return;
 	/* per-event key starts with "event.GROUP.EVENT" */
@@ -621,7 +620,7 @@ trace_boot_init_instances(struct xbc_node *node)
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
