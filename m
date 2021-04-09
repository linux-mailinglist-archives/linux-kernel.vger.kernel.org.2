Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C032359245
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhDIC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhDIC4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:56:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B722C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dYZPgqJLhrE/Ec4JP30XHPYKZ3ET9ZAHbrPv+aTEuHQ=; b=ltvh8TC8tM6z/l+J4AOMb+hUyq
        pMHp6RkNacH0dvmHbe4kbYn4Kpmrnuqil8G2PbiVbVvv0NLcnrTpNI1ZgUpToAXn2UeoKLvnRnZ6z
        QjStD8RbRon7cdu5YqZRX0tua1Ez8yjQacZ3r5zg0A6SgVGXWajuO/b7S0u5cLRC079Tc2FbKXFWw
        UdMMzhEe1jmS2n+bh+8UML1fz/4JPnMSOzHBChMCCG4iag3oFDiWzf5sAGlUdoMzO1ut1l7sZ1JbV
        c+Sq4GGIly2cLRyoIee7cIpvxxoke8pRXPxTn5QWB7hMA2N+ncI28o37a0Cn869MN4u6j9gVJAcdx
        Gw0MIlKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhHl-00HGYV-9c; Fri, 09 Apr 2021 02:54:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] dm-snap: Add dm_exceptional_lock
Date:   Fri,  9 Apr 2021 03:51:19 +0100
Message-Id: <20210409025131.4114078-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the dm-snap bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/md/dm-snap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 8f3ad87e6117..4c2a01e433de 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -644,16 +644,18 @@ static void dm_exception_table_lock_init(struct dm_snapshot *s, chunk_t chunk,
 	lock->pending_slot = &pending->table[exception_hash(pending, chunk)];
 }
 
+static DEFINE_SPLIT_LOCK(dm_exception_lock);
+
 static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
 {
-	hlist_bl_lock(lock->complete_slot);
-	hlist_bl_lock(lock->pending_slot);
+	hlist_bl_lock(lock->complete_slot, &dm_exception_lock);
+	hlist_bl_lock_nested(lock->pending_slot, &dm_exception_lock, 1);
 }
 
 static void dm_exception_table_unlock(struct dm_exception_table_lock *lock)
 {
-	hlist_bl_unlock(lock->pending_slot);
-	hlist_bl_unlock(lock->complete_slot);
+	hlist_bl_unlock(lock->pending_slot, &dm_exception_lock);
+	hlist_bl_unlock(lock->complete_slot, &dm_exception_lock);
 }
 
 static int dm_exception_table_init(struct dm_exception_table *et,
-- 
2.30.2

