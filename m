Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A857F3DF691
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhHCUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHCUqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:46:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FBC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KwS04zHg80LQteaaJobSnff6xWOJoAvmuOYagGyDQF4=; b=PthhJ80FjQaA8i2j/Kg9nRLzzr
        sZmzKLtRmRiU1lzAAjuchNbDcd4Myid9/ylayGQCny9psXGTPI4EGrfUbcKqeWw+93M7+QtQO5COP
        izl6wOwr8aaw1WE/FUEjiI57WdMavJ5ngmlQE/4C8i46JaCrezMDyYAJCaZlW+eUxD9erOGSieo/G
        acg6ab4dEDnXyq8/XhQDAWrpokupCqy0CcHby79fFnKkzPwtY7qEMbowkeoGYsXMD4sbZMnPul/uT
        ZGC49ziFqxs5lQ+Pmw40f2RhIZJhesK7z64RwRi8gPieMKFN2v6F13261wmgyyMBOLiM2laMCCLLZ
        QxZVuMpA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB1Ig-004Bw0-BI; Tue, 03 Aug 2021 20:46:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next/-mmotm] kernel/user.c: fix build when POLL not enabled
Date:   Tue,  3 Aug 2021 13:46:09 -0700
Message-Id: <20210803204609.32329-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.

../kernel/user.c: In function ‘free_user’:
../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
  percpu_counter_destroy(&up->epoll_watches);
                              ^~~~~~~~~~~~~
In file included from ../include/linux/sched/user.h:7:0,
                 from ../kernel/user.c:17:
../kernel/user.c: In function ‘alloc_uid’:
../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
   if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
                                 ^
../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
    percpu_counter_destroy(&new->epoll_watches);
                                 ^~~~~~~~~~~~~
In file included from ../include/linux/sched/user.h:7:0,
                 from ../kernel/user.c:17:
../kernel/user.c: In function ‘uid_cache_init’:
../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named ‘epoll_watches’; did you mean ‘nr_watches’?
  if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
                                     ^
Also fix type: "cpunter" -> "counter" in a panic message.

Fixes: e75b89477811 ("fs/epoll: use a per-cpu counter for user's watches count")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 kernel/user.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- mmotm-2021-0802-1851.orig/kernel/user.c
+++ mmotm-2021-0802-1851/kernel/user.c
@@ -137,9 +137,11 @@ static void free_user(struct user_struct
 	__releases(&uidhash_lock)
 {
 	uid_hash_remove(up);
+#ifdef CONFIG_EPOLL
 	spin_unlock_irqrestore(&uidhash_lock, flags);
 	percpu_counter_destroy(&up->epoll_watches);
 	kmem_cache_free(uid_cachep, up);
+#endif
 }
 
 /*
@@ -186,10 +188,12 @@ struct user_struct *alloc_uid(kuid_t uid
 
 		new->uid = uid;
 		refcount_set(&new->__count, 1);
+#ifdef CONFIG_EPOLL
 		if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
 			kmem_cache_free(uid_cachep, new);
 			return NULL;
 		}
+#endif
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
@@ -200,7 +204,9 @@ struct user_struct *alloc_uid(kuid_t uid
 		spin_lock_irq(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
+#ifdef CONFIG_EPOLL
 			percpu_counter_destroy(&new->epoll_watches);
+#endif
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
@@ -222,8 +228,10 @@ static int __init uid_cache_init(void)
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_HLIST_HEAD(uidhash_table + n);
 
+#ifdef CONFIG_EPOLL
 	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
-		panic("percpu cpunter alloc failed");
+		panic("percpu counter alloc failed");
+#endif
 
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
