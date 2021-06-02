Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B2398114
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFBG0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhFBG0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:26:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01E2961242;
        Wed,  2 Jun 2021 06:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615084;
        bh=giHqiShaNTZlBd45TfhNoIZgN53ZIkUJOvw8FdKdhYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNt9Fl2sRVQuVozb6CHa5ZEVKjM6whLBrwzSGdRUPRhZSpR05vk00AqaUOlSh0aDL
         1vQYHmntWKHMDEZvpf3lTxWJqYAAX1L+q4HoaFCWTVp2k6bB2IHNhLnfLbBKVDDqas
         7UWVjOpTDV1yWXUZ1KK/0ryr+zk9fD+xFPiow8KGqTD2BiAWjbXnltcIklHwMtDzTx
         3D9x/dQlYbGS5CB9XAKUYvkMfix5NvRsEq8xj1b2CctybEf2D72535+z/91J3evD1W
         kw4luBedwGDAXxLSrrBmiDoPoRrAXrS0bIUFnKLtz08sbAPuqHMO5IVv6QS18H8ZWj
         OSfVv0kfwtSmw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 2/6] bootconfig: Change array value to use child node
Date:   Wed,  2 Jun 2021 15:24:40 +0900
Message-Id: <162261508043.255316.10266137231011419236.stgit@devnote2>
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

Change array value to use child node of the xbc_node tree.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
index 9f8c70a98fcf..87d21fe25010 100644
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
@@ -513,21 +521,22 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 
 static int __init xbc_parse_array(char **__v)
 {
-	struct xbc_node *node;
+	struct xbc_node *node, *knode = last_parent;
 	char *next;
 	int c = 0;
 
+	last_parent = xbc_node_get_child(knode);
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
@@ -615,8 +624,12 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 
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
index 7362bef1a368..aaa4fec1c431 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -27,7 +27,7 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 			q = '\'';
 		else
 			q = '"';
-		printf("%c%s%c%s", q, val, q, node->next ? ", " : eol);
+		printf("%c%s%c%s", q, val, q, node->child ? ", " : eol);
 		i++;
 	}
 	return i;

