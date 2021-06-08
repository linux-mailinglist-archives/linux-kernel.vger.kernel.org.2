Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECA39F581
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFHLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:48:43 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56962 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhFHLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:48:40 -0400
Received: by mail-qk1-f202.google.com with SMTP id h4-20020a05620a2444b02903aacdbd70b7so2966254qkn.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sWbrRz6YFSv51K0ZiaeJfgkblqcqVJvp4mAMJ4g6evQ=;
        b=oMijNQKaRNBFiQ1m3Qen4ujOBqjvKBFOUAcRFp8lVBza1ZVmHJBg08yWChcmh4N3ZM
         OGodg6TU7O/n8uagXshvezjlQtF2vboBz78E2pGnEzfJf46ws36OW4bI1/aj3MDGCs9e
         Xfirtd13uPSSZLeEVxOgsYyY+418xQDc1+nXfhX45f/aIEHSgwagqS8YMo1NSiFFfY0c
         ieFXm6t/oQ5DXdoraPM0zQT1nRFddABeIHqKydm2Xvwr/+8QtiaDN5+AZINlYTdU70RH
         fSSMTVRLvAV+5ixRteovyozG1HBoKb7EkgINPdYQBbU5sNB1iJxJxaMi3xxL78dUJvgH
         LNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sWbrRz6YFSv51K0ZiaeJfgkblqcqVJvp4mAMJ4g6evQ=;
        b=NX4Mg4M3aqphD2e77JO+vhGFaC4DEXLJhiki7ndvLy/JdiC9T6HyCniw4lcQNYEUJg
         hUaR6XXYXh1yEcAwsgjVbuFWihT9b8wGt2jszhBzeJqYI827xzRzBSwn6FcZl5hvObQw
         +jHHq2AlsEDX2ZXR1jAVWLpb+rwkwSIEw5PmV0VFen+MK65hhxkaNcb9DGpb7JIJ4OTn
         UB2UfFEYfvmMwQz8NkiwL9dq98SmIlYwzwbnRxOjYmpN+LFlFPxqltcC1kfAdFhS58S+
         fEwwE0/0A+a+EHpcdfnNJ3qHoIJzPJ3qnMX+tDNoQUo+EEapX+jz0ywS0t4EAUjhl68q
         1TDg==
X-Gm-Message-State: AOAM5335cmvctL6pEjHItd8JYW5OHv0QOx4/wmEfjqr7O44VlCC6G0s+
        zlUTrrEOYq+2A/k3BQZSxOzq18USJ3ph
X-Google-Smtp-Source: ABdhPJwsxbCizlABk5SfV18s0TUyC2fSDZX+uNojDJncA7j/acMAyKtd4wzKVHkNbef2eVClKkhRAeeIxy79
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:e8cd:: with SMTP id
 m13mr23073154qvo.52.1623152731419; Tue, 08 Jun 2021 04:45:31 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:14 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-4-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 3/7] KVM: arm64: Remove list_head from hyp_page
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
2.32.0.rc1.229.g3e70b5a671-goog

