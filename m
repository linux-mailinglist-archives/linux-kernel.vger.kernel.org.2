Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32625312548
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBGP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhBGPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:23:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92628C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 07:22:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f4so8952714pgk.19
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LwrzzUOqvk7nQXNMsXvC9PLN9Jy02gm7UHyjOCvTH/w=;
        b=qPmlvXJSc8bIT6hbfFnv1+yDNzerJMSANr63wbcNfBh43VbJiYiAxQvI7xw+iJnMl5
         d0GZRjEC/sOJiBr1patZSeDTTwK5Dcjvr4Qf6PLHgLo1Pq+Gp3EOVVmcbZIrJAe7Bqr7
         Ny10J+rVytml1qdMeHYSD33XQY7M3/Jo7m6OPh7wZVyuaM+5Xrun86IY29p5M+iA/J98
         b6af/ohF1+RaDhlmrCX5J3wH/d423U5pxEQFrTzPy8kGa0XKm4n912W65Oa5qV90gZRq
         xC45SIIklGT5mSngAfGK1wUPHagYKZ3hHRbx+yrSPQxyXe6Pu2Q/VgpnDDh+Yb58x4xE
         AxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LwrzzUOqvk7nQXNMsXvC9PLN9Jy02gm7UHyjOCvTH/w=;
        b=WGJjWt/SxKixnxI6GrxA6NqAWMo+U6F0U0AQov9SpcgtAnpBWDhisKnst6OPZBT7ZO
         IKGCk/lR+UnBae8HgUa1sprSQHR035YzRfhMYh9uDFXHTUg7rAB5lQo2wcJm+TUzBEPt
         6C7jI8050kw9g5MknF55buo2X9BkfQlCRkLPNEoi4iS6KdAY6ikk7WT+JEu0UhpWRgpA
         TO9KdmC7xNPI9b4rSr6AiFWrZlW+PNMsvE/DfR9b7EAHCz7E0eykcL7PWYPyKkNBYrrY
         LjtULbl5fSfEDLoaAI4AiteMI6FpMwR89R6wgak+2SZw8PAL/J0vbw0c1BjsgfqCzzNR
         5xeA==
X-Gm-Message-State: AOAM5316WCnLnpcs16KuXP9UbOyfMNZqr6B6VsURh7t2f+h43ORfBH7l
        +7lDfpzgDkakd9gML30RCsGJS4j2AKKmvQ==
X-Google-Smtp-Source: ABdhPJzEoqAkDISvW4T1npZCil6IfrXD0/PuwQsWrgAJNG8LDrjN93B1viaKvHDAwgXLfezciuVHGJ03Ldganw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:193e:fc7f:b382:cc9f])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:780c:: with SMTP id
 w12mr8190290pjk.135.1612711321765; Sun, 07 Feb 2021 07:22:01 -0800 (PST)
Date:   Sun,  7 Feb 2021 07:21:48 -0800
Message-Id: <20210207152148.1285842-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] mm/list_lru.c: remove kvfree_rcu_local()
From:   Shakeel Butt <shakeelb@google.com>
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list_lru file used to have local kvfree_rcu() which was renamed by
commit e0feed08ab41 ("mm/list_lru.c: Rename kvfree_rcu() to local
variant") to introduce the globally visible kvfree_rcu(). Now we have
global kvfree_rcu(), so remove the local kvfree_rcu_local() and just
use the global one.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index fe230081690b..6f067b6b935f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -373,21 +373,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu_local(struct rcu_head *head)
-{
-	struct list_lru_memcg *mlru;
-
-	mlru = container_of(head, struct list_lru_memcg, rcu);
-	kvfree(mlru);
-}
-
 static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 				      int old_size, int new_size)
 {
@@ -419,7 +411,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu_local);
+	kvfree_rcu(old, rcu);
 	return 0;
 }
 
-- 
2.30.0.478.g8a0d178c01-goog

