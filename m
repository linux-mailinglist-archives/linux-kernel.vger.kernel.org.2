Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8F39811D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFBG1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhFBG11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:27:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r9y2MIYHC1ZVT120C073M6ZnWMYa9AIdCVt6UqfKA4I=; b=VppKp40XA12T1ZYkMvv9l83acr
        j0azsJaviVPYS5KWfR/jHnuTSePSjdQ+9/YqV479R7DMWswQ7+vT38oNlePLOGu6CULPH5L7KCxUx
        9H99QPeNPiFpJ1/HUS5FMbHmelXHRPZnmv9TAcFJ2RsfdDfarY/h6oPPJ4r7Z2CD517xzKRGSOsvw
        WrmBmvnaLdsz8lPAwb958ZA4sQB00PJ3cd34t2sZ803/cPqHNGmOkFk6ND1vxqnq0DHYaMMQK/74R
        guFqJViXFpM2fXYYHxsrPy4kETbISk1xlbeAwHOPaK4KPRyCPeVfeyx9ooe+cdy4XP3F9Hrk7Usw9
        3cx9+CNA==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loKJy-0021P0-Ru; Wed, 02 Jun 2021 06:25:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] rbtree: repair some kernel-doc whining
Date:   Tue,  1 Jun 2021 23:25:42 -0700
Message-Id: <20210602062542.8188-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some kernel-doc warnings and use the documented
Return: notation for function return values.

rbtree_latch.h:64: warning: cannot understand function prototype: 'struct latch_
tree_ops '
rbtree.h:343: warning: Function parameter or member 'node' not described in 'rb_
next_match'
rbtree.h:343: warning: Excess function parameter 'tree' description in 'rb_next_
match'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rbtree.h       |   14 +++++++-------
 include/linux/rbtree_latch.h |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20210601.orig/include/linux/rbtree_latch.h
+++ linux-next-20210601/include/linux/rbtree_latch.h
@@ -47,7 +47,7 @@ struct latch_tree_root {
 };
 
 /**
- * latch_tree_ops - operators to define the tree order
+ * struct latch_tree_ops - operators to define the tree order
  * @less: used for insertion; provides the (partial) order between two elements.
  * @comp: used for lookups; provides the order between the search key and an element.
  *
--- linux-next-20210601.orig/include/linux/rbtree.h
+++ linux-next-20210601/include/linux/rbtree.h
@@ -186,7 +186,7 @@ static inline void rb_replace_node_cache
  * @tree: leftmost cached tree to insert @node into
  * @less: operator defining the (partial) node order
  *
- * Returns @node when it is the new leftmost, or NULL.
+ * Return: @node when it is the new leftmost, or %NULL.
  */
 static __always_inline struct rb_node *
 rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
@@ -243,7 +243,7 @@ rb_add(struct rb_node *node, struct rb_r
  * @tree: tree to search / modify
  * @cmp: operator defining the node order
  *
- * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * Return: the rb_node matching @node, or %NULL when no match is found and @node
  * is inserted.
  */
 static __always_inline struct rb_node *
@@ -277,7 +277,7 @@ rb_find_add(struct rb_node *node, struct
  * @tree: tree to search
  * @cmp: operator defining the node order
  *
- * Returns the rb_node matching @key or NULL.
+ * Return: the rb_node matching @key or %NULL.
  */
 static __always_inline struct rb_node *
 rb_find(const void *key, const struct rb_root *tree,
@@ -305,7 +305,7 @@ rb_find(const void *key, const struct rb
  * @tree: tree to search
  * @cmp: operator defining node order
  *
- * Returns the leftmost node matching @key, or NULL.
+ * Return: the leftmost node matching @key, or %NULL.
  */
 static __always_inline struct rb_node *
 rb_find_first(const void *key, const struct rb_root *tree,
@@ -330,12 +330,12 @@ rb_find_first(const void *key, const str
 }
 
 /**
- * rb_next_match() - find the next @key in @tree
+ * rb_next_match() - find the next @key in tree
  * @key: key to match
- * @tree: tree to search
+ * @node: where the previous match was found, then continue searching from here
  * @cmp: operator defining node order
  *
- * Returns the next node matching @key, or NULL.
+ * Return: the next node matching @key, or %NULL.
  */
 static __always_inline struct rb_node *
 rb_next_match(const void *key, struct rb_node *node,
