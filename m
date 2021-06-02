Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B562398115
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhFBG0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhFBG0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 032D761376;
        Wed,  2 Jun 2021 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615093;
        bh=/KXguwVtnbBaui2NlTIpWrXuEjErv5sbazqE9wOW1oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/bQm7x0zcG4skOZEiChI4SXEPYx2hNS3SlBzz+vTA1gKBEExb7Q5Q2nmSnlzKebJ
         U75RZfiufHtMkqM59SL7nitYNbsWsaukNZPn/SXCZTsyL0eeH2Y+35MPrUYknBsux7
         w16u6t6NGenLWnsrwIJDH8cS8a6FW732khGhR38uGV3ILNJYGrt80/fIVZXfY8dvpK
         zrXgU0hAnNDO7vd7/6rNui0gflKiyEAMFWFXmsaVkKivv06aX39ABJM2aOOqkliBy8
         eCoIRFdYvNmD3KM4fZN4QJab3sQC457Xbbor/moCmzavLgXdB71pdEcE/Ch8KKTRbt
         veCMEfdCPtTVA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 3/6] bootconfig: Support mixing a value and subkeys under a key
Date:   Wed,  2 Jun 2021 15:24:49 +0900
Message-Id: <162261508944.255316.17506337730830769154.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

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
index 87d21fe25010..fc5da88c7847 100644
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
@@ -566,8 +588,9 @@ static int __init __xbc_add_key(char *k)
 		node = find_match_node(xbc_nodes, k);
 	else {
 		child = xbc_node_get_child(last_parent);
+		/* Since the value node is the first child, skip it. */
 		if (child && xbc_node_is_value(child))
-			return xbc_parse_error("Subkey is mixed with value", k);
+			child = xbc_node_get_next(child);
 		node = find_match_node(child, k);
 	}
 
@@ -610,27 +633,29 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
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
index aaa4fec1c431..5441b254eb7c 100644
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
+			 * 	key(@cnode) = value;
+			 * 	key(@cnode) {
+			 * 		subkeys;
+			 * 	}
+			 * }
+			 * */
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
@@ -88,8 +115,10 @@ static void xbc_show_list(void)
 
 	xbc_for_each_key_value(leaf, val) {
 		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
-		if (ret < 0)
+		if (ret < 0) {
+			fprintf(stderr, "Failed to compose key %d\n", ret);
 			break;
+		}
 		printf("%s = ", key);
 		if (!val || val[0] == '\0') {
 			printf("\"\"\n");

