Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E9419033
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhI0HuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhI0HuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:50:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F986C061570
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:48:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso12840639pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FGQRpkHFm5jWPBG/X3cVcH6mTWRwTcwTNAv1UtGu6c=;
        b=ThniXubkp20lKAjoW/YNPcxf6QKlFDV3ptz0bdzgot6I9v8o07y9tg0F1/u/yhC8dj
         4Y7rB1lNu8d6Gx//C0L98jEyO1kEcnetL5N4SsRNVh1BNC55NI0Hy7cKpX/J2eD2faql
         GTVnL8W7TUtKNgxcaBZ/lzdygrpH6V5Cd9RhNgbdhZKjWEYuPUl9uIcBgMsvFxIuf2aY
         Em1R6wozVnxANCiQMwx4XAP6aucR1T30o/bSZcyxt5XMpiVs5iJMmcSQBxmSZBgJhgGz
         p0qInyK5lNfYfc40a4bc1XNtRDZnmOc4VeX78sNGuEulFFhCmCmxKXW1ZuuE//9eOim8
         gZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0FGQRpkHFm5jWPBG/X3cVcH6mTWRwTcwTNAv1UtGu6c=;
        b=C+QSlnnRGxAoDI6Gqv5v7Tw/TzTDFfCoNJ4Y1Ais+ps/UjY1vvlvKkVj+a1Alud8LX
         krZhWxYX3gyhnhnh2YUShuaTRQujhaK/L3nYZHzx7hUG7fNX+9E+8QECgN7sSDqh67zG
         lM0YmS2hSW29CZrzqzL6cTIfW65NiKWOR2euQg7hkvYaEaixdvaMzAPmRNWbK+P/1U+K
         2lqxwDiYxFqpv7ljRrBlfCeq9ABm6S4cUBET2x6dj7YJwVFTBORUiva/r9E9iYFgnPni
         9IRUaOobQNMtRPPQR5OI4Tma2lF0CIApFY3pyNmw7Ga64Eh+nUQAKe7lLEqy3xCe7caW
         G/AQ==
X-Gm-Message-State: AOAM532BDyzla/Axxx98bouX8ocg8NFYNc8K/NvU0MahjnkBBdOsvxyl
        XGhN8eIWkHCy5MfV5iOU6kvheNPIiQI=
X-Google-Smtp-Source: ABdhPJwWE0NmrGq1ePwqZUX3w0uM+j+LT17QtpLBWOJbMDxLbBCmeszYxskJ+Fv3A3tM6f0Lu6d+qg==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr18350509pji.149.1632728922424;
        Mon, 27 Sep 2021 00:48:42 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id v4sm8447256pjr.32.2021.09.27.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 00:48:42 -0700 (PDT)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     mhocko@kernel.org, Sultan Alsawaf <sultan@kerneltoast.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU protection
Date:   Mon, 27 Sep 2021 00:48:23 -0700
Message-Id: <20210927074823.5825-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

The shrinker rwsem is problematic because the actual shrinking path must
back off when contention appears, causing some or all shrinkers to be
skipped. This can be especially bad when shrinkers are frequently
registered and unregistered. A high frequency of shrinker registrations/
unregistrations can effectively DoS the shrinker mechanism, rendering it
useless.

Using SRCU to protect iteration through the shrinker list and idr
eliminates this issue entirely. Now, shrinking can happen concurrently
with shrinker registrations/unregistrations.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 mm/vmscan.c | 68 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2d1fed..3dea927be5ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -190,6 +190,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_STATIC_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -212,6 +213,20 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
+static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
+						int nid)
+{
+	return srcu_dereference(memcg->nodeinfo[nid]->shrinker_info,
+				&shrinker_srcu);
+}
+
+static void free_shrinker_info_srcu(struct rcu_head *head)
+{
+	struct shrinker_info *info = container_of(head, typeof(*info), rcu);
+
+	kvfree_rcu(info, rcu);
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int map_size, int defer_size,
 				    int old_map_size, int old_defer_size)
@@ -244,7 +259,12 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		       defer_size - old_defer_size);
 
 		rcu_assign_pointer(pn->shrinker_info, new);
-		kvfree_rcu(old, rcu);
+
+		/*
+		 * Shrinker info is used under both SRCU and regular RCU, so
+		 * synchronize the free against both of them.
+		 */
+		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_srcu);
 	}
 
 	return 0;
@@ -357,7 +377,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -391,7 +410,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
 }
 
@@ -400,7 +419,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
@@ -641,6 +660,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
 		up_write(&shrinker_rwsem);
+		synchronize_srcu(&shrinker_srcu);
 		return;
 	}
 
@@ -651,7 +671,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
 }
@@ -676,11 +696,12 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	up_write(&shrinker_rwsem);
+	synchronize_srcu(&shrinker_srcu);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
@@ -792,15 +813,13 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int i;
+	int i, srcu_idx;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	info = shrinker_info_protected(memcg, nid);
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	info = shrinker_info_srcu(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
@@ -850,14 +869,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
-
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	return freed;
 }
 #else /* CONFIG_MEMCG */
@@ -894,6 +908,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
+	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -905,10 +920,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
+				 srcu_read_lock_held(&shrinker_srcu)) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -919,19 +933,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the registration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 
-	up_read(&shrinker_rwsem);
-out:
 	cond_resched();
 	return freed;
 }
-- 
2.33.0

