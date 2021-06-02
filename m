Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC039856E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFBJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFBJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:38 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:43:55 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id o82-20020a1ca5550000b029019ae053d508so409759wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c9G26svnUWbmDEss+L1TLE5EXYPohttILixiExhT9vI=;
        b=GcqoSOATgdiJrr5Oyizj8W+rLOQpOg6DZBabZvKf0IMeyx8khSL42yhMPQqnKMValL
         uAuTd7nM6YbDqtCbcfkCOb91BewwCwkquHrYu3JXLQuAhzknh9aLKNwGrtiVOjPOF0s3
         MTpErDLuSq5rbVOp8wHNBBV5LvKlhDcle0BvvwrjH9hUYWyryR0raOp0ZUcleQapEoq4
         ZsrhtqCMSeaauWimVgYusqVb6KZP54Kd5hU6BreNlQRzkE1rl+J/nu+1hIq3lFk6wypT
         nmfCTaAyA9oRe3Fgl687yhu8ZucC7AGOBP++xZAZ6+L8CKO8qyNzqJdu7ycUwCrfMU6O
         lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9G26svnUWbmDEss+L1TLE5EXYPohttILixiExhT9vI=;
        b=fC7ArE/cF8m7qUkOJr9O9AhR7bGLIyl8jJRGFV3xLJRJRQsqU7aO/W8DyeYZiIPAza
         QYsFFh/7qHN1sUsDt8kdrRUeDMLrVJ9wNn/BEMkvdft2PwE8w50XI0Qvv8JnbKB9IsOI
         s+gf5YYOFLyRxcf19truvfBinCJQaRxss0k4e7h4XAbttksEMtrvmnrs/eedw1FBgRcZ
         vNW79k47sGISFc7JQ+lEbLGz7ipIo7WWn62TtgFNK9LiFfVS06+9NL801jJUbu9ceINx
         qY+dZb92q75vmjO/gm68mSDc8mHePEUogwH8DNms4epPcgPCeZpCowFo0nVKVfjNWuDE
         +kAA==
X-Gm-Message-State: AOAM530BKr3QsOf2rqXyF0HwQP+U5Peo5Zo7CSthbfsX5QoHoSEk3Us+
        a17OldAlKoVSbEOeFr3VBTd81H737TmF
X-Google-Smtp-Source: ABdhPJxZ5g83EDaY4+kbAAODmvGhWrt2ItBDMTFzKjsuLKEcW0HzeMd2O18SphwhlIcp+ggGfCB1veunhgrR
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:35cc:: with SMTP id
 r12mr385000wmq.1.1622627033853; Wed, 02 Jun 2021 02:43:53 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:41 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-2-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 1/7] KVM: arm64: Move hyp_pool locking out of refcount helpers
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp_page refcount helpers currently rely on the hyp_pool lock for
serialization. However, this means the refcounts can't be changed from
the buddy allocator core as it already holds the lock, which means pages
have to go through odd transient states.

For example, when a page is freed, its refcount is set to 0, and the
lock is transiently released before the page can be attached to a free
list in the buddy tree. This is currently harmless as the allocator
checks the list node of each page to see if it is available for
allocation or not, but it means the page refcount can't be trusted to
represent the state of the page even if the pool lock is held.

In order to fix this, remove the pool locking from the refcount helpers,
and move all the logic to the buddy allocator. This will simplify the
removal of the list node from struct hyp_page in a later patch.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h | 35 ----------------------
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 43 ++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index 18a4494337bd..f2c84e4fa40f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -22,41 +22,6 @@ struct hyp_pool {
 	unsigned int max_order;
 };
 
-static inline void hyp_page_ref_inc(struct hyp_page *p)
-{
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
-	p->refcount++;
-	hyp_spin_unlock(&pool->lock);
-}
-
-static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
-{
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-	int ret;
-
-	hyp_spin_lock(&pool->lock);
-	p->refcount--;
-	ret = (p->refcount == 0);
-	hyp_spin_unlock(&pool->lock);
-
-	return ret;
-}
-
-static inline void hyp_set_page_refcounted(struct hyp_page *p)
-{
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
-	if (p->refcount) {
-		hyp_spin_unlock(&pool->lock);
-		BUG();
-	}
-	p->refcount = 1;
-	hyp_spin_unlock(&pool->lock);
-}
-
 /* Allocation */
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
 void hyp_get_page(void *addr);
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 237e03bf0cb1..d666f4789e31 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -93,15 +93,6 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 	list_add_tail(&p->node, &pool->free_area[order]);
 }
 
-static void hyp_attach_page(struct hyp_page *p)
-{
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
-	__hyp_attach_page(pool, p);
-	hyp_spin_unlock(&pool->lock);
-}
-
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 					   struct hyp_page *p,
 					   unsigned int order)
@@ -125,19 +116,49 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 	return p;
 }
 
+static inline void hyp_page_ref_inc(struct hyp_page *p)
+{
+	p->refcount++;
+}
+
+static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
+{
+	p->refcount--;
+	return (p->refcount == 0);
+}
+
+static inline void hyp_set_page_refcounted(struct hyp_page *p)
+{
+	BUG_ON(p->refcount);
+	p->refcount = 1;
+}
+
+/*
+ * Changes to the buddy tree and page refcounts must be done with the hyp_pool
+ * lock held. If a refcount change requires an update to the buddy tree (e.g.
+ * hyp_put_page()), both operations must be done within the same critical
+ * section to guarantee transient states (e.g. a page with null refcount but
+ * not yet attached to a free list) can't be observed by well-behaved readers.
+ */
 void hyp_put_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
+	struct hyp_pool *pool = hyp_page_to_pool(p);
 
+	hyp_spin_lock(&pool->lock);
 	if (hyp_page_ref_dec_and_test(p))
-		hyp_attach_page(p);
+		__hyp_attach_page(pool, p);
+	hyp_spin_unlock(&pool->lock);
 }
 
 void hyp_get_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
+	struct hyp_pool *pool = hyp_page_to_pool(p);
 
+	hyp_spin_lock(&pool->lock);
 	hyp_page_ref_inc(p);
+	hyp_spin_unlock(&pool->lock);
 }
 
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
@@ -159,8 +180,8 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
 	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
 	p = __hyp_extract_page(pool, p, order);
 
-	hyp_spin_unlock(&pool->lock);
 	hyp_set_page_refcounted(p);
+	hyp_spin_unlock(&pool->lock);
 
 	return hyp_page_to_virt(p);
 }
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

