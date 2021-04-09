Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1350359247
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhDIC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:57:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709DC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VdvPP2rGrTTGDx7m77stYwghjrZG/xDWW7yRQqW3Qnk=; b=gBg8UJJnkMPVt+sn47yNd6oacm
        V80Jv0ijKm3jsl52oVLBDdY1XgN4avUsYg5vHPF/My+oP7QsEXa2N/MIjuCI4Ct5a0QPgYllAz/O/
        cRv68CqKt/edL+TH609mjWf+AhgCVGurLYZicZ7jctOUGuPYNGhH8TV4NW9W4EqeNyv07mme5G0l4
        5LQ54xCeu58fngipEJT7Q52KzXRpjZ/3EzU0JdfLIaneKQuxZfQi4tOhZ1xSzqP0wL3b7V3O3/eBn
        ezj9KrNa7H4SFml0XJDFKJtHOcazCvekd33hgq9C6uLFPiAe7PP23dekcl7RYyeHw54hEcA/7XDtI
        ZwodSS0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhIk-00HGgi-QJ; Fri, 09 Apr 2021 02:55:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] fscache: Add cookie_hash_lock
Date:   Fri,  9 Apr 2021 03:51:21 +0100
Message-Id: <20210409025131.4114078-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the fscache cookie hash bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fscache/cookie.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 751bc5b1cddf..65d514d12592 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -17,6 +17,7 @@ struct kmem_cache *fscache_cookie_jar;
 
 static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
 
+static DEFINE_SPLIT_LOCK(cookie_hash_lock);
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 
@@ -202,7 +203,7 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
 	h = &fscache_cookie_hash[bucket];
 
-	hlist_bl_lock(h);
+	hlist_bl_lock(h, &cookie_hash_lock);
 	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
 		if (fscache_compare_cookie(candidate, cursor) == 0)
 			goto collision;
@@ -212,7 +213,7 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 	fscache_cookie_get(candidate->parent, fscache_cookie_get_acquire_parent);
 	atomic_inc(&candidate->parent->n_children);
 	hlist_bl_add_head(&candidate->hash_link, h);
-	hlist_bl_unlock(h);
+	hlist_bl_unlock(h, &cookie_hash_lock);
 	return candidate;
 
 collision:
@@ -222,12 +223,12 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 		pr_err("Duplicate cookie detected\n");
 		fscache_print_cookie(cursor, 'O');
 		fscache_print_cookie(candidate, 'N');
-		hlist_bl_unlock(h);
+		hlist_bl_unlock(h, &cookie_hash_lock);
 		return NULL;
 	}
 
 	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
-	hlist_bl_unlock(h);
+	hlist_bl_unlock(h, &cookie_hash_lock);
 	return cursor;
 }
 
@@ -845,9 +846,9 @@ static void fscache_unhash_cookie(struct fscache_cookie *cookie)
 	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
 	h = &fscache_cookie_hash[bucket];
 
-	hlist_bl_lock(h);
+	hlist_bl_lock(h, &cookie_hash_lock);
 	hlist_bl_del(&cookie->hash_link);
-	hlist_bl_unlock(h);
+	hlist_bl_unlock(h, &cookie_hash_lock);
 }
 
 /*
-- 
2.30.2

