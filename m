Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7E39F570
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFHLrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFHLrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:47:23 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 04:45:27 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so6676080ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vxwHJ+G94OJ1pE095VNOnJheGz25iQDynuEQjCESIh0=;
        b=qaed+O4Pp9KTEzvs+APK7fEuJPXtpKOQgrKsvMynvTCDksxLejAvbkSsyykvk7D8sS
         S8yR429zh5Q4ejjDIGva2qL7h2gIADTNFNMYwCoCH7pWsJg+c/D/RQF4oqP7Fgp4StAW
         +40ljDrP3JbD1vmJYd9ufdc85M0oGXSwb7Z6GmmDI1I56uYN3310sFRXr2EprFL06o0R
         H/ApsliuhwPxG8ykxG+ifXKqhtcBXzStm7uLNdf1Z+UozesEAohJUpYCFAbHR6eqQg77
         4YmpUv4RainpfmuH97cTwY0tAH62FWahweNsmaxYoZcCa3x1nBeGaKijk6TxnmFCR4di
         XHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vxwHJ+G94OJ1pE095VNOnJheGz25iQDynuEQjCESIh0=;
        b=EgNQj9drVTuYj2+b0dDGhzXddkhz6R5cfuNnCxFANsWzwHVPkvsCSfoegdp29SDKZ/
         kX/Eo0ZahU1GUZ/e1NpiFMDTtf33dDISzGmK2mkxfqKFoDp6yCJc/01OWnk1pLUE/EVw
         JdGu/MdABbJaW4dI10mqeSUhTOGw8rIMPx3sB+6PDcb4uFG+pTqA6C44eIDl6u50XW5a
         /gX7fpk3MYexeeiYEbORPlSpfIXTqxkQNljVa+6SZxdeah/H61V2A2hM9Nc23JR6egLK
         vk7scaSOmUiNntbkiPIA8sx5N2JMyyuFahGMUXuWuXp9c0JmucYmbXxC9bUrQFCJIO12
         51FQ==
X-Gm-Message-State: AOAM533mFLY2IVU51NRkhPY0LnmFjVNyl72KWW+9FGetmDgCEE0unmPJ
        g3pYT8FKu9bXTYkAcRVCxdwvUFPmtKb7
X-Google-Smtp-Source: ABdhPJxjy7h6qUzJMJc1Bbkt8we2RleHBUTUerWb3KW3/8CCh8UqtZ6HhCYhLc5ZOrmlQyHAQHfiTn44GB2u
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a17:906:a04e:: with SMTP id
 bg14mr6427415ejb.366.1623152726119; Tue, 08 Jun 2021 04:45:26 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:12 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-2-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 1/7] KVM: arm64: Move hyp_pool locking out of refcount helpers
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
2.32.0.rc1.229.g3e70b5a671-goog

