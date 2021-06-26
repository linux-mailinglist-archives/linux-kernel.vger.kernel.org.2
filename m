Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C43B4E94
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFZNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhFZNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0055361C38;
        Sat, 26 Jun 2021 13:05:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx807-000Eer-0B; Sat, 26 Jun 2021 09:05:35 -0400
Message-ID: <20210626130534.843190721@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/24] bootconfig: Support mixing a value and subkeys under a key
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support mixing a value and subkeys under a key. Since kernel cmdline
options will support "aaa.bbb=value1 aaa.bbb.ccc=value2", it is
better that the bootconfig supports such configuration too.

Note that this does not change syntax itself but just accepts
mixed value and subkeys e.g.

key = value1
key.subkey = value2

But this is not accepted;

key {
 value1
 subkey = value2
}

That will make value1 as a subkey.

Also, the order of the value node under a key is fixed. If there
are a value and subkeys, the value is always the first child node
of the key. Thus if user specifies subkeys first, e.g.

key.subkey = value1
key = value2

In the program (and /proc/bootconfig), it will be shown as below

key = value2
key.subkey = value1

Link: https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h | 32 +++++++++++++++++++
 lib/bootconfig.c           | 65 ++++++++++++++++++++++++++------------
 tools/bootconfig/main.c    | 45 +++++++++++++++++++++-----
 3 files changed, 114 insertions(+), 28 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 3178a31fdabc..e49043ac77c9 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -80,6 +80,8 @@ static inline __init bool xbc_node_is_array(struct xbc_node *node)
  *
  * Test the @node is a leaf key node which is a key node and has a value node
  * or no child. Returns true if it is a leaf node, or false if not.
+ * Note that the leaf node can have subkey nodes in addition to the
+ * value node.
  */
 static inline __init bool xbc_node_is_leaf(struct xbc_node *node)
 {
@@ -129,6 +131,23 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
 	return xbc_node_find_child(NULL, key);
 }
 
+/**
+ * xbc_node_get_subkey() - Return the first subkey node if exists
+ * @node: Parent node
+ *
+ * Return the first subkey node of the @node. If the @node has no child
+ * or only value node, this will return NULL.
+ */
+static inline struct xbc_node * __init xbc_node_get_subkey(struct xbc_node *node)
+{
+	struct xbc_node *child = xbc_node_get_child(node);
+
+	if (child && xbc_node_is_value(child))
+		return xbc_node_get_next(child);
+	else
+		return child;
+}
+
 /**
  * xbc_array_for_each_value() - Iterate value nodes on an array
  * @anode: An XBC arraied value node
@@ -149,11 +168,24 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
  * @child: Iterated XBC node.
  *
  * Iterate child nodes of @parent. Each child nodes are stored to @child.
+ * The @child can be mixture of a value node and subkey nodes.
  */
 #define xbc_node_for_each_child(parent, child)				\
 	for (child = xbc_node_get_child(parent); child != NULL ;	\
 	     child = xbc_node_get_next(child))
 
+/**
+ * xbc_node_for_each_subkey() - Iterate child subkey nodes
+ * @parent: An XBC node.
+ * @child: Iterated XBC node.
+ *
+ * Iterate subkey nodes of @parent. Each child nodes are stored to @child.
+ * The @child is only the subkey node.
+ */
+#define xbc_node_for_each_subkey(parent, child)				\
+	for (child = xbc_node_get_subkey(parent); child != NULL ;	\
+	     child = xbc_node_get_next(child))
+
 /**
  * xbc_node_for_each_array_value() - Iterate array entries of geven key
  * @node: An XBC node.
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 44dcdcbd746a..927017431fb6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -156,7 +156,7 @@ xbc_node_find_child(struct xbc_node *parent, const char *key)
 	struct xbc_node *node;
 
 	if (parent)
-		node = xbc_node_get_child(parent);
+		node = xbc_node_get_subkey(parent);
 	else
 		node = xbc_root_node();
 
@@ -164,7 +164,7 @@ xbc_node_find_child(struct xbc_node *parent, const char *key)
 		if (!xbc_node_match_prefix(node, &key))
 			node = xbc_node_get_next(node);
 		else if (*key != '\0')
-			node = xbc_node_get_child(node);
+			node = xbc_node_get_subkey(node);
 		else
 			break;
 	}
@@ -274,6 +274,8 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 						 struct xbc_node *node)
 {
+	struct xbc_node *next;
+
 	if (unlikely(!xbc_data))
 		return NULL;
 
@@ -282,6 +284,13 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 		if (!node)
 			node = xbc_nodes;
 	} else {
+		/* Leaf node may have a subkey */
+		next = xbc_node_get_subkey(node);
+		if (next) {
+			node = next;
+			goto found;
+		}
+
 		if (node == root)	/* @root was a leaf, no child node. */
 			return NULL;
 
@@ -296,6 +305,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 		node = xbc_node_get_next(node);
 	}
 
+found:
 	while (node && !xbc_node_is_leaf(node))
 		node = xbc_node_get_child(node);
 
@@ -375,18 +385,20 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+static struct xbc_node * __init __xbc_add_sibling(char *data, u32 flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
 	if (node) {
 		if (!last_parent) {
+			/* Ignore @head in this case */
 			node->parent = XBC_NODE_MAX;
 			sib = xbc_last_sibling(xbc_nodes);
 			sib->next = xbc_node_index(node);
 		} else {
 			node->parent = xbc_node_index(last_parent);
-			if (!last_parent->child) {
+			if (!last_parent->child || head) {
+				node->next = last_parent->child;
 				last_parent->child = xbc_node_index(node);
 			} else {
 				sib = xbc_node_get_child(last_parent);
@@ -400,6 +412,16 @@ static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
 	return node;
 }
 
+static inline struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+{
+	return __xbc_add_sibling(data, flag, false);
+}
+
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, u32 flag)
+{
+	return __xbc_add_sibling(data, flag, true);
+}
+
 static inline __init struct xbc_node *xbc_add_child(char *data, u32 flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
@@ -568,8 +590,9 @@ static int __init __xbc_add_key(char *k)
 		node = find_match_node(xbc_nodes, k);
 	else {
 		child = xbc_node_get_child(last_parent);
+		/* Since the value node is the first child, skip it. */
 		if (child && xbc_node_is_value(child))
-			return xbc_parse_error("Subkey is mixed with value", k);
+			child = xbc_node_get_next(child);
 		node = find_match_node(child, k);
 	}
 
@@ -612,27 +635,29 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 	if (ret)
 		return ret;
 
-	child = xbc_node_get_child(last_parent);
-	if (child) {
-		if (xbc_node_is_key(child))
-			return xbc_parse_error("Value is mixed with subkey", v);
-		else if (op == '=')
-			return xbc_parse_error("Value is redefined", v);
-	}
-
 	c = __xbc_parse_value(&v, &next);
 	if (c < 0)
 		return c;
 
-	if (op == ':' && child) {
-		xbc_init_node(child, v, XBC_VALUE);
-	} else {
-		if (op == '+' && child)
-			last_parent = xbc_last_child(child);
-		if (!xbc_add_sibling(v, XBC_VALUE))
-			return -ENOMEM;
+	child = xbc_node_get_child(last_parent);
+	if (child && xbc_node_is_value(child)) {
+		if (op == '=')
+			return xbc_parse_error("Value is redefined", v);
+		if (op == ':') {
+			unsigned short nidx = child->next;
+
+			xbc_init_node(child, v, XBC_VALUE);
+			child->next = nidx;	/* keep subkeys */
+			goto array;
+		}
+		/* op must be '+' */
+		last_parent = xbc_last_child(child);
 	}
+	/* The value node should always be the first child */
+	if (!xbc_add_head_sibling(v, XBC_VALUE))
+		return -ENOMEM;
 
+array:
 	if (c == ',') {	/* Array */
 		c = xbc_parse_array(&next);
 		if (c < 0)
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 23569fb634f1..62a3b5064b17 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -35,30 +35,55 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 
 static void xbc_show_compact_tree(void)
 {
-	struct xbc_node *node, *cnode;
+	struct xbc_node *node, *cnode = NULL, *vnode;
 	int depth = 0, i;
 
 	node = xbc_root_node();
 	while (node && xbc_node_is_key(node)) {
 		for (i = 0; i < depth; i++)
 			printf("\t");
-		cnode = xbc_node_get_child(node);
+		if (!cnode)
+			cnode = xbc_node_get_child(node);
 		while (cnode && xbc_node_is_key(cnode) && !cnode->next) {
+			vnode = xbc_node_get_child(cnode);
+			/*
+			 * If @cnode has value and subkeys, this
+			 * should show it as below.
+			 *
+			 * key(@node) {
+			 *      key(@cnode) = value;
+			 *      key(@cnode) {
+			 *          subkeys;
+			 *      }
+			 * }
+			 */
+			if (vnode && xbc_node_is_value(vnode) && vnode->next)
+				break;
 			printf("%s.", xbc_node_get_data(node));
 			node = cnode;
-			cnode = xbc_node_get_child(node);
+			cnode = vnode;
 		}
 		if (cnode && xbc_node_is_key(cnode)) {
 			printf("%s {\n", xbc_node_get_data(node));
 			depth++;
 			node = cnode;
+			cnode = NULL;
 			continue;
 		} else if (cnode && xbc_node_is_value(cnode)) {
 			printf("%s = ", xbc_node_get_data(node));
 			xbc_show_value(cnode, true);
+			/*
+			 * If @node has value and subkeys, continue
+			 * looping on subkeys with same node.
+			 */
+			if (cnode->next) {
+				cnode = xbc_node_get_next(cnode);
+				continue;
+			}
 		} else {
 			printf("%s;\n", xbc_node_get_data(node));
 		}
+		cnode = NULL;
 
 		if (node->next) {
 			node = xbc_node_get_next(node);
@@ -70,10 +95,12 @@ static void xbc_show_compact_tree(void)
 				return;
 			if (!xbc_node_get_child(node)->next)
 				continue;
-			depth--;
-			for (i = 0; i < depth; i++)
-				printf("\t");
-			printf("}\n");
+			if (depth) {
+				depth--;
+				for (i = 0; i < depth; i++)
+					printf("\t");
+				printf("}\n");
+			}
 		}
 		node = xbc_node_get_next(node);
 	}
@@ -86,8 +113,10 @@ static void xbc_show_list(void)
 	const char *val;
 
 	xbc_for_each_key_value(leaf, val) {
-		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0)
+		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
+			fprintf(stderr, "Failed to compose key %d\n", ret);
 			break;
+		}
 		printf("%s = ", key);
 		if (!val || val[0] == '\0') {
 			printf("\"\"\n");
-- 
2.30.2
