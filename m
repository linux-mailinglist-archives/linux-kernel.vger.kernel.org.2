Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3939F582
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhFHLss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:48:48 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41690 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhFHLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:48:46 -0400
Received: by mail-wm1-f74.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so653604wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5BNxXykWbSSzvgU2PyfVwBVhSOGhRGpGA/8JFAOEVmg=;
        b=RpPiV66cUY0ERU4ts0ZWRLX6HM855EURR0LBhraB/GG2HQQvfPX5fQ0d+wqECu1yLq
         BsE7Qc/3grhd+Y7hO/9tzN2u4M7IuO5K5lTpp/JBQnQGhV3/G1ye2lIf895dn6H3e3be
         wS0Ei7PbgSVXOUPIOPom6v5UkiPp56iUJV37nQoNTAEKbcMhVn/gyg8Sn//+5g5KmWj3
         lKFXL1+52EY0b01a6d8k5AOOqf/kDkJSPiz/bLZqz3mIMK/siOA8lcAZXWXMUFDBTg7F
         VdqnAvUR2UCk5v0EQhE2ze7cx0VNHSnDWjZGyxerqm3ql6BNqZ8v4RfO8LSfHiNFDdWf
         oGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5BNxXykWbSSzvgU2PyfVwBVhSOGhRGpGA/8JFAOEVmg=;
        b=mItJxE6SZotf44GtLHR6oYpL0EOse6dMJfgX4VU08m5gJ8K6lamPjMXv1qxC6he2aO
         O47ysh3VAweHM4G7tcbYQUGlzs9bEPiDG8endx2FiPCCQ+EsrNekszLTEm1THnlQfJBF
         2ArKBM9M7MHvDu37huVSWKa3sszG9aCGdedKVSx8VJp5rXWPzBGiQGODhaYVldIA4X2J
         3HC4xx2cO5IWsOUE1GKPIfLASkcwFigf7USFBlF05VVXUMIp3/Zc3ICvL9Hatn43LEPt
         HYJfvGZMe/icU68TWZLcxqTRdbVSwzOtdM90dtUO/ZpGna6pV2fN+72whET50jV8//4T
         /oWw==
X-Gm-Message-State: AOAM533fwEKEYInK1mGjmUzGrVWbfQMzJOR1DLN8X0gSb4jZOxwcZUFm
        OugKEp8tBlPqE5VTudtx9R6xxHkinu4Q
X-Google-Smtp-Source: ABdhPJxY0xFXprzkSg2IzWugfcreotUMtjfhIgxJAyEAb/go+uRuv0+nLOY4lwHHvo9KG8qAO8hAvcdRsU0b
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:cb0b:: with SMTP id
 u11mr307833wmj.0.1623152737523; Tue, 08 Jun 2021 04:45:37 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:17 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-7-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 6/7] KVM: arm64: Use less bits for hyp_page order
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

The hyp_page order is currently encoded on 4 bytes even though it is
guaranteed to be smaller than this. Make it 2 bytes to reduce the hyp
vmemmap overhead.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  6 +++---
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index 3ea7bfb6c380..fb0f523d1492 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -7,7 +7,7 @@
 #include <nvhe/memory.h>
 #include <nvhe/spinlock.h>
 
-#define HYP_NO_ORDER	UINT_MAX
+#define HYP_NO_ORDER	USHRT_MAX
 
 struct hyp_pool {
 	/*
@@ -19,11 +19,11 @@ struct hyp_pool {
 	struct list_head free_area[MAX_ORDER];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
-	unsigned int max_order;
+	unsigned short max_order;
 };
 
 /* Allocation */
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
+void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
 void hyp_get_page(struct hyp_pool *pool, void *addr);
 void hyp_put_page(struct hyp_pool *pool, void *addr);
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 991636be2f46..3fe34fa30ea4 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -9,7 +9,7 @@
 
 struct hyp_page {
 	unsigned int refcount;
-	unsigned int order;
+	unsigned short order;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index e3689def7033..be07055bbc10 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -32,7 +32,7 @@ u64 __hyp_vmemmap;
  */
 static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 					     struct hyp_page *p,
-					     unsigned int order)
+					     unsigned short order)
 {
 	phys_addr_t addr = hyp_page_to_phys(p);
 
@@ -51,7 +51,7 @@ static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 /* Find a buddy page currently available for allocation */
 static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned int order)
+					   unsigned short order)
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
@@ -93,7 +93,7 @@ static inline struct hyp_page *node_to_page(struct list_head *node)
 static void __hyp_attach_page(struct hyp_pool *pool,
 			      struct hyp_page *p)
 {
-	unsigned int order = p->order;
+	unsigned short order = p->order;
 	struct hyp_page *buddy;
 
 	memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
@@ -123,7 +123,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned int order)
+					   unsigned short order)
 {
 	struct hyp_page *buddy;
 
@@ -192,9 +192,9 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
 	hyp_spin_unlock(&pool->lock);
 }
 
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
+void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
 {
-	unsigned int i = order;
+	unsigned short i = order;
 	struct hyp_page *p;
 
 	hyp_spin_lock(&pool->lock);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

