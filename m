Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B2405746
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357219AbhIINdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357691AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 664B4611C9;
        Thu,  9 Sep 2021 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193147;
        bh=oHq/wsKbnNqm9hs7dpDl8AZfaJsqyb3T7iIWKc/hQGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsLFRTkJ0QiZG3C5YUKDkuF5CkqFbbG1T/TNBKiyeBMnvFHWLBqNrkHkxBVPrq8LC
         Ud3QEhDDIub5skzwu6VvaETQ5O0uPYOkPhHJ0HVYOJx9hw3MM0KFW5e2Cbq7t7K7Eo
         tVKXYNBcZtnQUKBVgaLn4BWhlEIHv3fIK0Ev2uqPqqfq6NDd7f0ouYyF5yeAhh/vRC
         kCeT98+y2I7haojuk4FdLEZbjtRVZHWkUFhQG4+uMzRcWlfxCaXpDnV5nOV8YCFC8l
         ZkYsQX2E1VtyZ9gzo8cP2cOXx/MP7iYg+0njXkumtTJJdj/KY9xJRr2HtHn7gDAiOp
         1iA3m64C3i9Rg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
Date:   Thu,  9 Sep 2021 22:12:25 +0900
Message-Id: <163119314554.159092.13861261054992653824.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163119312321.159092.9694278669123009540.stgit@devnote2>
References: <163119312321.159092.9694278669123009540.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename xbc_node_find_child() to xbc_node_find_subkey() for
clarifying that function returns a key node (no value node).
Since there are xbc_node_for_each_child() (loop on all child
nodes) and xbc_node_for_each_subkey() (loop on only subkey
nodes), this name distinction is necessary to avoid confusing
users.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |    4 ++--
 kernel/trace/trace_boot.c  |   24 ++++++++++++------------
 lib/bootconfig.c           |    8 ++++----
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

