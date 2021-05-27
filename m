Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE0392E57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbhE0Mx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbhE0MxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:18 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A9C061763
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:44 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so274385edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gi5cRmDtyloWJMITCIj/sPnhDqshqX/If7D8pZ+Fco8=;
        b=DMh/PwjeROpCuIsXL8vRKNGEi9sHS19ekOOPLJW/yYZpcAXKCDh4kFuF6iI/aU1kMl
         Gd3tI584HoLn+kctQ7quFOApvKA4kHemuJ26RXQjx3fbsek7WyRVBTy4z/hDTF8/7CEL
         zxQX0nPp35II7RVacLFWT/l/To+3fVcczDHqZzs1XFABFaNr9SgLwX30EBRUuUMGhiEz
         5euHTt9w+mN6fCrPAsZ1YWV8quDogTUAATc6+C9p/KeVUkcsAtPRHini8QK1D0L79neA
         NUHURMi7p+5iRahsNBMDoS6FlUOqIo57NM1IYG8tkhwHWec9RAnj7z1x/hxWSkIx0PPp
         axhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gi5cRmDtyloWJMITCIj/sPnhDqshqX/If7D8pZ+Fco8=;
        b=AKCbKvj4VnGGoMVAXMPwmKUtEtYEKVEPkAYCmj2n0BBDRwlVKbPO926CC/G1InhFoj
         0MfaaA5Ym5XiRrZ7Yc6sMlbwUmX+VP3FqyFvvzi3W6TPIkGc0u9IbwC/qE7Bg48bQ6lJ
         6QgVFEnEAWnWWNYVJCNEZpT3o3AHutl+trO3BuHqZggtJ0OrNPo6PN17QyozGFfE3m5l
         t9eicceS1TIAO1/AyLQbTkcjBXUh0qWuurgoPPpcBKkayoLc9+JSqaKTm5fqcX72C127
         EU6qOLF0NQP9X9glGuyMrua/bIGdGV/q2EBPOHR3ZRhvC5OKPCvMJT5/irAN1sh1QzqA
         J09g==
X-Gm-Message-State: AOAM530v7yA8JOPzcokZISSKLciRCs//AI8PQhJymgWgXvtIGTNa6Rcj
        d72UoIH5fHytu+/AKf51h6J241705xM+
X-Google-Smtp-Source: ABdhPJwlv3mU0dZTO0kFr4Yy4f9wIZtT5gFLjr+4vvIMhKkBy7e5WNSw28epAMZVLsvaNdTluQlcqCDUf204
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a17:907:770a:: with SMTP id
 kw10mr3675153ejc.213.1622119903222; Thu, 27 May 2021 05:51:43 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:30 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-4-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 3/7] KVM: arm64: Remove list_head from hyp_page
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
index 7ee882f36767..ce7379f1480b 100644
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
+	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
+
+	__list_del_entry(node);
+	memset(node, 0, sizeof(*node));
+}
+
+static inline void page_add_to_list(struct hyp_page *p, struct list_head *head)
+{
+	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
+
+	INIT_LIST_HEAD(node);
+	list_add_tail(node, head);
+}
+
+static inline struct hyp_page *node_to_page(struct list_head *node)
+{
+	return (struct hyp_page *)hyp_virt_to_page(node);
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
@@ -158,7 +186,7 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
 	}
 
 	/* Extract it from the tree at the right order */
-	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
+	p = node_to_page(pool->free_area[i].next);
 	p = __hyp_extract_page(pool, p, order);
 
 	hyp_set_page_refcounted(p);
@@ -186,7 +214,6 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	for (i = 0; i < nr_pages; i++) {
 		p[i].pool = pool;
 		p[i].order = 0;
-		INIT_LIST_HEAD(&p[i].node);
 		hyp_set_page_refcounted(&p[i]);
 	}
 
-- 
2.31.1.818.g46aad6cb9e-goog

