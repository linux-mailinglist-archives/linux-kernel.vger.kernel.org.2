Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8B3983F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhFBIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhFBIUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B98A613D0;
        Wed,  2 Jun 2021 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621941;
        bh=dfG7WEPna/UQaJW6YSt2v2nt+bzT8Iu4sAq+WvTZG1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMccTg8Y29q1mNzlNJmLdgi8AwG5LaDiRUO3Zr1cxNTcsV9FE/dqVbJMWJCREGyQk
         WVhifbc1GJcGq1oE740oIo+TR5rDFON7pYr9MZcJIVQLUF72XrECG+5mY7Nj3yj4hQ
         vdSPd7rCCYKcbWfKPqnReayoqyWfh73VzymxXCZ4C86Gxw+kSlQAxcLJIb8ibKz7ij
         ed3ObItdlnFpLMK0hLtfzviViG98g3AEBsmU1LCIR+5AOQpBPQi4qyb+Rea4YhbbiQ
         FOzGFLXErkiRwNppZRo8T4LiAp78CjSj8iMF3AzRh09mGSldzDwbathzcMsd+I9Kmz
         tpgT4Yk3wu8+Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v4 2/6] bootconfig: Change array value to use child node
Date:   Wed,  2 Jun 2021 17:18:58 +0900
Message-Id: <162262193838.264090.16044473274501498656.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162262192121.264090.6540508908529705156.stgit@devnote2>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to put an array value with subkeys under
a key node, because both of subkeys and the array elements
are using "next" field of the xbc_node.

Thus this changes the array values to use "child" field in
the array case. The reason why split this change is to
test it easily.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix /proc/bootconfig accroding to Devin's report (Thanks!)
  - Update patch description to explain why, not what.
  - Use xbc_node_is_array() instead of checking field directly.
---
 fs/proc/bootconfig.c       |    2 +-
 include/linux/bootconfig.h |    6 +++---
 lib/bootconfig.c           |   23 +++++++++++++++++++----
 tools/bootconfig/main.c    |    2 +-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index ad31ec4ad627..6d8d4bf20837 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -49,7 +49,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				else
 					q = '"';
 				ret = snprintf(dst, rest(dst, end), "%c%s%c%s",
-					q, val, q, vnode->next ? ", " : "\n");
+					q, val, q, xbc_node_is_array(vnode) ? ", " : "\n");
 				if (ret < 0)
 					goto out;
 				dst += ret;
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 2696eb0fc149..3178a31fdabc 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -71,7 +71,7 @@ static inline __init bool xbc_node_is_key(struct xbc_node *node)
  */
 static inline __init bool xbc_node_is_array(struct xbc_node *node)
 {
-	return xbc_node_is_value(node) && node->next != 0;
+	return xbc_node_is_value(node) && node->child != 0;
 }
 
 /**
@@ -140,7 +140,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
  */
 #define xbc_array_for_each_value(anode, value)				\
 	for (value = xbc_node_get_data(anode); anode != NULL ;		\
-	     anode = xbc_node_get_next(anode),				\
+	     anode = xbc_node_get_child(anode),				\
 	     value = anode ? xbc_node_get_data(anode) : NULL)
 
 /**
@@ -171,7 +171,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
  */
 #define xbc_node_for_each_array_value(node, key, anode, value)		\
 	for (value = xbc_node_find_value(node, key, &anode); value != NULL; \
-	     anode = xbc_node_get_next(anode),				\
+	     anode = xbc_node_get_child(anode),				\
 	     value = anode ? xbc_node_get_data(anode) : NULL)
 
 /**
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 9f8c70a98fcf..44dcdcbd746a 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -367,6 +367,14 @@ static inline __init struct xbc_node *xbc_last_sibling(struct xbc_node *node)
 	return node;
 }
 
+static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
+{
+	while (node->child)
+		node = xbc_node_get_child(node);
+
+	return node;
+}
+
 static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
@@ -517,17 +525,20 @@ static int __init xbc_parse_array(char **__v)
 	char *next;
 	int c = 0;
 
+	if (last_parent->child)
+		last_parent = xbc_node_get_child(last_parent);
+
 	do {
 		c = __xbc_parse_value(__v, &next);
 		if (c < 0)
 			return c;
 
-		node = xbc_add_sibling(*__v, XBC_VALUE);
+		node = xbc_add_child(*__v, XBC_VALUE);
 		if (!node)
 			return -ENOMEM;
 		*__v = next;
 	} while (c == ',');
-	node->next = 0;
+	node->child = 0;
 
 	return c;
 }
@@ -615,8 +626,12 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 
 	if (op == ':' && child) {
 		xbc_init_node(child, v, XBC_VALUE);
-	} else if (!xbc_add_sibling(v, XBC_VALUE))
-		return -ENOMEM;
+	} else {
+		if (op == '+' && child)
+			last_parent = xbc_last_child(child);
+		if (!xbc_add_sibling(v, XBC_VALUE))
+			return -ENOMEM;
+	}
 
 	if (c == ',') {	/* Array */
 		c = xbc_parse_array(&next);
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7362bef1a368..7a98756e594a 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -27,7 +27,7 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 			q = '\'';
 		else
 			q = '"';
-		printf("%c%s%c%s", q, val, q, node->next ? ", " : eol);
+		printf("%c%s%c%s", q, val, q, xbc_node_is_array(node) ? ", " : eol);
 		i++;
 	}
 	return i;

