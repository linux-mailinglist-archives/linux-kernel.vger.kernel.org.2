Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54039359246
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhDIC4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:56:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121CBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SIjeIVSYyN8GRA4IUq1K+E1Ly/eurxG9Jq0kyWHn2gc=; b=IgCWw5FVt9jUO9cBKDzE9/DgCf
        0hco7AwhqZJftOlO5nyU7W3XJBsAtbmc+LH89gxSC3gykTdL0XG0dtdb4r+u26aSgxA4kk4zC3hpA
        LZ6bzM5n6Eib55BezWNlLfjZ2mBJwAG+hBitpKyX0njocum94q/Umo71NyVT4JF75Fjasf7tLXFXn
        EyCMdHktr8C+SBG0KzduRzUx+z287B9irdJzJt9K5R0DGDte8M4Lrg96m2aPnGU3rFJtekEgYzIbl
        hk5lOC6VXkFJDFJ0AyxETs7RGVcaLotLdDjhMR1rNCNnLiwsIN5+QTYp0elNFZpcr45xsZzQijH3M
        +UH+CrsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhIK-00HGaf-LY; Fri, 09 Apr 2021 02:55:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] dcache: Add d_hash_lock
Date:   Fri,  9 Apr 2021 03:51:20 +0100
Message-Id: <20210409025131.4114078-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the d_hash bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dcache.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d24ff7eb206..a3861d330001 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -96,6 +96,7 @@ EXPORT_SYMBOL(slash_name);
 
 static unsigned int d_hash_shift __read_mostly;
 
+static DEFINE_SPLIT_LOCK(d_hash_lock);
 static struct hlist_bl_head *dentry_hashtable __read_mostly;
 
 static inline struct hlist_bl_head *d_hash(unsigned int hash)
@@ -469,9 +470,9 @@ static void ___d_drop(struct dentry *dentry)
 	else
 		b = d_hash(dentry->d_name.hash);
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	__hlist_bl_del(&dentry->d_hash);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 }
 
 void __d_drop(struct dentry *dentry)
@@ -2074,9 +2075,9 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	if (!disconnected) {
-		hlist_bl_lock(&dentry->d_sb->s_roots);
+		hlist_bl_lock(&dentry->d_sb->s_roots, &d_hash_lock);
 		hlist_bl_add_head(&dentry->d_hash, &dentry->d_sb->s_roots);
-		hlist_bl_unlock(&dentry->d_sb->s_roots);
+		hlist_bl_unlock(&dentry->d_sb->s_roots, &d_hash_lock);
 	}
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
@@ -2513,9 +2514,9 @@ static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 }
 
 /**
@@ -2606,9 +2607,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		goto retry;
 	}
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {
-		hlist_bl_unlock(b);
+		hlist_bl_unlock(b, &d_hash_lock);
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -2626,7 +2627,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			continue;
 		if (!d_same_name(dentry, parent, name))
 			continue;
-		hlist_bl_unlock(b);
+		hlist_bl_unlock(b, &d_hash_lock);
 		/* now we can try to grab a reference */
 		if (!lockref_get_not_dead(&dentry->d_lockref)) {
 			rcu_read_unlock();
@@ -2664,7 +2665,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
 	hlist_bl_add_head_rcu(&new->d_u.d_in_lookup_hash, b);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 	return new;
 mismatch:
 	spin_unlock(&dentry->d_lock);
@@ -2677,12 +2678,12 @@ void __d_lookup_done(struct dentry *dentry)
 {
 	struct hlist_bl_head *b = in_lookup_hash(dentry->d_parent,
 						 dentry->d_name.hash);
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
 	wake_up_all(dentry->d_wait);
 	dentry->d_wait = NULL;
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
 }
-- 
2.30.2

