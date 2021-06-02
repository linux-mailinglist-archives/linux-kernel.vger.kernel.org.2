Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152CD398575
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhFBJpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhFBJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:42 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:43:59 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so781778wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t3AUZFExsqOFXJcxe9KexRvl4zPYmY7UlKUPgsp6CsY=;
        b=LFwQebQ6RePwquLH6Tgf97KIl837thuo7ff3+yEFRV3EDeRV7KsrNUL4rJGqrD/AbB
         p2fG3lpP5GJrkCuXydJyrK6l3MPS9cDudqAWsO3YQULj7Q4AOqp7BDGmmpJp/eXbLYpV
         +5P5yzxlkadOG9jbu+nc1D8MblpcOvziNBMVqojWWhCX4+5izrXG+RLP2yKvIEZi0h+R
         ngCmZjOtMrzWzG3OFo9IKaI2e0JNd9mdg0XBe9KHPAyxvFHyO9lEYZv5scf2wpx6aGFS
         DkXeFZdRq0VAD3MvwlBjH47tUQD4ah6BqCdvnt4mowpP/VcWY3K+bRZHAEl55a2mfUld
         fhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t3AUZFExsqOFXJcxe9KexRvl4zPYmY7UlKUPgsp6CsY=;
        b=FhzaVv6FF94sgjKG4ZCSetiKSpOeB7gl6M5sKdTnIKMtU4sXvHsJxFHfCk9v71IXxE
         fKjAeyadTFtS5bW/Y4etAT9A81lUFSiFVuQh4mPTAMsC3pc3Tau/lJY8h1akZtgOPfVe
         K1agK/JeGtay93LiJ/BFaotG3ZAmLuGov0GeqvPRE9eqBrUMtx1rI0ANWc0Kh+JvTaVP
         ThCIbeMUlz80dspkMmCyVXKNGN9BpJm85TThVelv+iDnJ8oG6SRxnVflNh109yAjLrC6
         O1aMHu1VKLXfedZr0rxZcQ0q6eHUGKfv/kmkYP8pDKi1Mi3OQ1ihLGxSl2mxgtn00QaH
         0zZA==
X-Gm-Message-State: AOAM533xEUu8Wmz7R4Wji4XIvIrRdIk+rB1kCuVbCYpjrKW/Nauct6xP
        lNhOvqd4wVtDCBqrxiZeWBFz1xrXj7As
X-Google-Smtp-Source: ABdhPJz2xb5KXzKaMGgfcMmLyy8tV7f+4qajv6QtgpSO7AfdaazrcE0h7oP3513BqmP33p6OpeLOE/kr6fO4
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a5d:5752:: with SMTP id
 q18mr5245469wrw.419.1622627038040; Wed, 02 Jun 2021 02:43:58 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:43 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-4-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 3/7] KVM: arm64: Remove list_head from hyp_page
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

The list_head member of struct hyp_page is only needed when the page is
attached to a free-list, which by definition implies the page is free.
As such, nothing prevents us from using the page itself to store the
list_head, hence reducing the size of the vmemmap.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  1 -
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 39 ++++++++++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index fd78bde939ee..7691ab495eb4 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -12,7 +12,6 @@ struct hyp_page {
 	unsigned int refcount;
 	unsigned int order;
 	struct hyp_pool *pool;
-	struct list_head node;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 2602577daa00..34f0eb026dd2 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -62,6 +62,34 @@ static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 
 }
 
+/*
+ * Pages that are available for allocation are tracked in free-lists, so we use
+ * the pages themselves to store the list nodes to avoid wasting space. As the
+ * allocator always returns zeroed pages (which are zeroed on the hyp_put_page()
+ * path to optimize allocation speed), we also need to clean-up the list node in
+ * each page when we take it out of the list.
+ */
+static inline void page_remove_from_list(struct hyp_page *p)
+{
+	struct list_head *node = hyp_page_to_virt(p);
+
+	__list_del_entry(node);
+	memset(node, 0, sizeof(*node));
+}
+
+static inline void page_add_to_list(struct hyp_page *p, struct list_head *head)
+{
+	struct list_head *node = hyp_page_to_virt(p);
+
+	INIT_LIST_HEAD(node);
+	list_add_tail(node, head);
+}
+
+static inline struct hyp_page *node_to_page(struct list_head *node)
+{
+	return hyp_virt_to_page(node);
+}
+
 static void __hyp_attach_page(struct hyp_pool *pool,
 			      struct hyp_page *p)
 {
@@ -83,14 +111,14 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 			break;
 
 		/* Take the buddy out of its list, and coallesce with @p */
-		list_del_init(&buddy->node);
+		page_remove_from_list(buddy);
 		buddy->order = HYP_NO_ORDER;
 		p = min(p, buddy);
 	}
 
 	/* Mark the new head, and insert it */
 	p->order = order;
-	list_add_tail(&p->node, &pool->free_area[order]);
+	page_add_to_list(p, &pool->free_area[order]);
 }
 
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
@@ -99,7 +127,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 {
 	struct hyp_page *buddy;
 
-	list_del_init(&p->node);
+	page_remove_from_list(p);
 	while (p->order > order) {
 		/*
 		 * The buddy of order n - 1 currently has HYP_NO_ORDER as it
@@ -110,7 +138,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 		p->order--;
 		buddy = __find_buddy_nocheck(pool, p, p->order);
 		buddy->order = p->order;
-		list_add_tail(&buddy->node, &pool->free_area[buddy->order]);
+		page_add_to_list(buddy, &pool->free_area[buddy->order]);
 	}
 
 	return p;
@@ -182,7 +210,7 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
 	}
 
 	/* Extract it from the tree at the right order */
-	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
+	p = node_to_page(pool->free_area[i].next);
 	p = __hyp_extract_page(pool, p, order);
 
 	hyp_set_page_refcounted(p);
@@ -210,7 +238,6 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	for (i = 0; i < nr_pages; i++) {
 		p[i].pool = pool;
 		p[i].order = 0;
-		INIT_LIST_HEAD(&p[i].node);
 		hyp_set_page_refcounted(&p[i]);
 	}
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

