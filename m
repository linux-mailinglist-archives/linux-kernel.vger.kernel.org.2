Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7F35924C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhDIC5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIC5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:57:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB30C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=njxS96JE8mn5kkjlv0vEp+LwNRezueDJksYV3gC4ETI=; b=BeBnaRKFXUGgR6hqkYLReO7TGP
        ga3f75ejtab9f16ngXtI0cdixBBpAs1MsvzBaXVdiBhJ/riKaodLH7TlJ9Hv5hdLh/mYQ30HtrLtu
        b7etPYJ0UATDnkVNMAsHkrCbX1ea1/RQC7ixtdyKCKuKXt+8srtzdtDePklecFk1Ph2ZVHQEEwQz/
        imJrHO+ALdC+wkxmcRyz6cl9cVm4JlT4v1umo7/dauud6dtwqK1YTCxNcusEnSfnkYSdN66o1mwpc
        JzBHqyQXkwx7ptipVWg4YqKAoXvA+pLxTSi+YBB3moz8Xb2jsIYmSah0RAxmzAUO0LJW4H/q0QfV2
        b8W+969A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhJO-00HGiv-4Y; Fri, 09 Apr 2021 02:56:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] gfs2: Add qd_hash_lock
Date:   Fri,  9 Apr 2021 03:51:22 +0100
Message-Id: <20210409025131.4114078-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the hash bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/quota.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 9b1aca7e1264..a933eb441ee9 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -80,6 +80,7 @@
 static DEFINE_SPINLOCK(qd_lock);
 struct list_lru gfs2_qd_lru;
 
+static DEFINE_SPLIT_LOCK(qd_hash_lock);
 static struct hlist_bl_head qd_hash_table[GFS2_QD_HASH_SIZE];
 
 static unsigned int gfs2_qd_hash(const struct gfs2_sbd *sdp,
@@ -95,12 +96,12 @@ static unsigned int gfs2_qd_hash(const struct gfs2_sbd *sdp,
 
 static inline void spin_lock_bucket(unsigned int hash)
 {
-        hlist_bl_lock(&qd_hash_table[hash]);
+        hlist_bl_lock(&qd_hash_table[hash], &qd_hash_lock);
 }
 
 static inline void spin_unlock_bucket(unsigned int hash)
 {
-        hlist_bl_unlock(&qd_hash_table[hash]);
+        hlist_bl_unlock(&qd_hash_table[hash], &qd_hash_lock);
 }
 
 static void gfs2_qd_dealloc(struct rcu_head *rcu)
-- 
2.30.2

