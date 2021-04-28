Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0487836D51C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhD1JzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbhD1JzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56EC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so44337394pgj.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsZpxnSCiHU3yOSRKuQ5Nn0zsBnruhO0+WHjObzR7x8=;
        b=CVN6j6GWu+63QHDHliyf2AZ1WZ20KwHrSvk5XqYiXCO7XP6C3pKHdUDBT4SxVeMhrP
         L7tMKIH47RxVvddI2lTDpeJ8zoSoyEYMuQ45LVFeb5DXE+Fh6X6ChHpirl3PFzwWAMLR
         Mq16ofgtQ7FlNKOSAT4pY+afeqGjvzzZCTuj0MZdV7TOq3YnjHw7tiV/vRs6qP2M2Xgm
         th2Wnk7lULXJi9N8kST37AJ0xLNcyrFfwLaX9ZH7VPC/rOXuYy0wadwRq00TeBP8sxq3
         UWfh5WsU99QG0r6ObL1e/F7tLvVLs7RbR4LYSVxhVou+9gePD8fjRXBe3VlMtaRlw2Xe
         LMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsZpxnSCiHU3yOSRKuQ5Nn0zsBnruhO0+WHjObzR7x8=;
        b=jnQYzfndaupNs6ld/pXY2TgtsLo2F70XMYtdR49cz50PRQYbIMwWCjxWLROyeNlvC6
         fL5o5KELaC1TdsKO64Jz57jSZmqmVJkDXBVZ3jtNxdeBlazq+gLHGIyvYVwRUstpUUxh
         wri4l7mbKbw1xobys69Vol6976g5KWddO82dIEE2q1xNI1xbLfilWqxqGycj68/nGG7C
         6dE8RGi58Wj5nwcV7gZdgv/VYvOhwQlhKUItpgY+WWjEzFjGTwOjtN92WsuGleeVmVyr
         oyq/eWqG9LlQorFCSkFKJfxudExKEcyxO5XVHcPSSr5fF90Sn/Evl3DbTHrozj0fjFDo
         mXgQ==
X-Gm-Message-State: AOAM532c0lzFWN9st2h2ZNW/W4aQlxksGtuvjh2i8LD0Rl9f9+jZWhW8
        VvHgGwU1lweWG7XA4il4WlNG7w==
X-Google-Smtp-Source: ABdhPJxeJwwMM87CerPEYoMJbuNWzwWZUAqJ1LCPLGY2k3lesIokTfkNVrUPpW+Jem/IzuHxzll8pA==
X-Received: by 2002:a63:570b:: with SMTP id l11mr26184726pgb.193.1619603672214;
        Wed, 28 Apr 2021 02:54:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6/9] mm: list_lru: support for shrinking list lru
Date:   Wed, 28 Apr 2021 17:49:46 +0800
Message-Id: <20210428094949.43579-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now memcg_update_all_list_lrus() only can increase the size of all the
list lrus. This patch adds an ability to make it can shrink the size
of all the list lrus. This can help us save memory when the user want
to shrink the size.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index d78dba5a6dab..3ee5239922c9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -383,13 +383,11 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	kvfree(memcg_lrus);
 }
 
-static int memcg_update_list_lru_node(struct list_lru_node *nlru,
-				      int old_size, int new_size)
+static int memcg_list_lru_node_inc(struct list_lru_node *nlru,
+				   int old_size, int new_size)
 {
 	struct list_lru_memcg *old, *new;
 
-	BUG_ON(old_size > new_size);
-
 	old = rcu_dereference_protected(nlru->memcg_lrus,
 					lockdep_is_held(&list_lrus_mutex));
 	new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
@@ -418,11 +416,58 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	return 0;
 }
 
+/* This function always returns 0. */
+static int memcg_list_lru_node_dec(struct list_lru_node *nlru,
+				   int old_size, int new_size)
+{
+	struct list_lru_memcg *old, *new;
+
+	old = rcu_dereference_protected(nlru->memcg_lrus,
+					lockdep_is_held(&list_lrus_mutex));
+	__memcg_destroy_list_lru_node(old, new_size, old_size);
+
+	/* Reuse the old array if the allocation failures here. */
+	new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
+	if (!new)
+		return 0;
+
+	memcpy(&new->lru, &old->lru, new_size * sizeof(void *));
+
+	/*
+	 * The locking below allows readers that hold nlru->lock avoid taking
+	 * rcu_read_lock (see list_lru_from_memcg_idx).
+	 *
+	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
+	 * we have to use IRQ-safe primitives here to avoid deadlock.
+	 */
+	spin_lock_irq(&nlru->lock);
+	rcu_assign_pointer(nlru->memcg_lrus, new);
+	spin_unlock_irq(&nlru->lock);
+
+	kvfree_rcu(old, rcu);
+	return 0;
+}
+
+static int memcg_update_list_lru_node(struct list_lru_node *nlru,
+				      int old_size, int new_size)
+{
+	if (new_size > old_size)
+		return memcg_list_lru_node_inc(nlru, old_size, new_size);
+	else if (new_size < old_size)
+		return memcg_list_lru_node_dec(nlru, old_size, new_size);
+
+	return 0;
+}
+
 static void memcg_cancel_update_list_lru_node(struct list_lru_node *nlru,
 					      int old_size, int new_size)
 {
 	struct list_lru_memcg *memcg_lrus;
 
+	/* Nothing to do for the shrinking case. */
+	if (old_size >= new_size)
+		return;
+
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus,
 					       lockdep_is_held(&list_lrus_mutex));
 	/* do not bother shrinking the array back to the old size, because we
-- 
2.11.0

