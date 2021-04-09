Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB68235924F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhDIC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhDIC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:58:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gQRzkr1bDZ8r+OYpxYmDI0wDDnTIdIa823URnyXbD3I=; b=NvF06kB5/14+S3H4txm+Olt+Xj
        ivCQ/VkTc7Lauh/BEDMtpETWQxyR0Apm6Nzcw0gecf2f7myLsujitoEvXVsxHbBxXLgjB9/yGhJMM
        zR1uECtWKd2K33copDlWXXoesR8RSvBGrES2wnhI8jISDYEE2wkxyjTneJopzxD3Sq46JlfqTlDQf
        hd102fOPDeGLKKkdAy27SNidjY4A8pjg2zru+cRwfJyd8IlMm2OZRmSskVRTYnGPS6u78Auvdbn6X
        L/DgJDCtmM0mxmZmbMfuVjOEQSBxtXZeEJDq0AASMrwhCqfq5rx+ll5g9olLRX98IPFjWI1YfYn0Q
        qCBQxGbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhJw-00HGlj-OQ; Fri, 09 Apr 2021 02:56:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] mbcache: Add mb_cache_lock
Date:   Fri,  9 Apr 2021 03:51:23 +0100
Message-Id: <20210409025131.4114078-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the mbcache hash bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mbcache.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 97c54d3a2227..4ce03ea348dd 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -47,6 +47,7 @@ static struct kmem_cache *mb_entry_cache;
 static unsigned long mb_cache_shrink(struct mb_cache *cache,
 				     unsigned long nr_to_scan);
 
+static DEFINE_SPLIT_LOCK(mb_cache_lock);
 static inline struct hlist_bl_head *mb_cache_entry_head(struct mb_cache *cache,
 							u32 key)
 {
@@ -97,16 +98,16 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	entry->e_reusable = reusable;
 	entry->e_referenced = 0;
 	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
+	hlist_bl_lock(head, &mb_cache_lock);
 	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
 		if (dup->e_key == key && dup->e_value == value) {
-			hlist_bl_unlock(head);
+			hlist_bl_unlock(head, &mb_cache_lock);
 			kmem_cache_free(mb_entry_cache, entry);
 			return -EBUSY;
 		}
 	}
 	hlist_bl_add_head(&entry->e_hash_list, head);
-	hlist_bl_unlock(head);
+	hlist_bl_unlock(head, &mb_cache_lock);
 
 	spin_lock(&cache->c_list_lock);
 	list_add_tail(&entry->e_list, &cache->c_list);
@@ -134,7 +135,7 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	struct hlist_bl_head *head;
 
 	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
+	hlist_bl_lock(head, &mb_cache_lock);
 	if (entry && !hlist_bl_unhashed(&entry->e_hash_list))
 		node = entry->e_hash_list.next;
 	else
@@ -150,7 +151,7 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	}
 	entry = NULL;
 out:
-	hlist_bl_unlock(head);
+	hlist_bl_unlock(head, &mb_cache_lock);
 	if (old_entry)
 		mb_cache_entry_put(cache, old_entry);
 
@@ -203,7 +204,7 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 	struct mb_cache_entry *entry;
 
 	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
+	hlist_bl_lock(head, &mb_cache_lock);
 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
 		if (entry->e_key == key && entry->e_value == value) {
 			atomic_inc(&entry->e_refcnt);
@@ -212,7 +213,7 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 	}
 	entry = NULL;
 out:
-	hlist_bl_unlock(head);
+	hlist_bl_unlock(head, &mb_cache_lock);
 	return entry;
 }
 EXPORT_SYMBOL(mb_cache_entry_get);
@@ -231,12 +232,12 @@ void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value)
 	struct mb_cache_entry *entry;
 
 	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
+	hlist_bl_lock(head, &mb_cache_lock);
 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
 		if (entry->e_key == key && entry->e_value == value) {
 			/* We keep hash list reference to keep entry alive */
 			hlist_bl_del_init(&entry->e_hash_list);
-			hlist_bl_unlock(head);
+			hlist_bl_unlock(head, &mb_cache_lock);
 			spin_lock(&cache->c_list_lock);
 			if (!list_empty(&entry->e_list)) {
 				list_del_init(&entry->e_list);
@@ -250,7 +251,7 @@ void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value)
 			return;
 		}
 	}
-	hlist_bl_unlock(head);
+	hlist_bl_unlock(head, &mb_cache_lock);
 }
 EXPORT_SYMBOL(mb_cache_entry_delete);
 
@@ -301,12 +302,12 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 		 */
 		spin_unlock(&cache->c_list_lock);
 		head = mb_cache_entry_head(cache, entry->e_key);
-		hlist_bl_lock(head);
+		hlist_bl_lock(head, &mb_cache_lock);
 		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
 			hlist_bl_del_init(&entry->e_hash_list);
 			atomic_dec(&entry->e_refcnt);
 		}
-		hlist_bl_unlock(head);
+		hlist_bl_unlock(head, &mb_cache_lock);
 		if (mb_cache_entry_put(cache, entry))
 			shrunk++;
 		cond_resched();
-- 
2.30.2

