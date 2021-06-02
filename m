Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1352D39857E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhFBJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFBJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546FC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:44:04 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so1203320qkd.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ge7hgJuDR1OpL3eSXNKyct/Yzp2Tl/Woy/7gBbj6zjQ=;
        b=SGe/vI9/qoCqTrH+bcIEubNmK7H5mOii/6aJ7flU0VvoG+l9VpXBTcsBtOfu9zM6Le
         7rG86QSqJXdsMmuUrCOYSJY45EaW1zs86TqCiEjOMym4hEd27qd7N1ER72U0Fldirwtk
         YpiawF0q6cWlEBkdfwtCXrVyUgcpsXlUf6eKEkGBNu5881nqHe+QVg31Bk84i7XPLYom
         NPJ+n940IN6ugXYoxgScSNzm9aVvwIieFCWVKCi2awubsPBuTyDkz89BFag6+HJgeehc
         RdF8TuSXEjWNX2szcC9S2t6MQwm8yO/xuEG76vjbEmFccD5UL3F13X6RH/r1n6e2q5wy
         r82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ge7hgJuDR1OpL3eSXNKyct/Yzp2Tl/Woy/7gBbj6zjQ=;
        b=uAfuFKh/JZ9pZfesEsdjpEaLiaCHRXwDTCi4/j0ZLemMZodAmuUCmwSasmOr1PdsjY
         irEWnehsLK9DUV8/z5z1TI/JZZCI7w36naPdA/SBT2LDKfDQZ+D1wK0Ot0+feXfGUo6T
         4rdiZZSklJYhVxZD661s8rWSlX436xuMxV0jCP2nAYRcD3v/NphIUP8ZERDZ1DsArR5H
         AmYsCstTdE6EVDAXak11LOLkDqHTcztzAOGlp4awzm8bTTM40BRIa0cws/8yHH7jsWni
         gfQtWwGegdiI056NRsiglQOpN/u22ADLbXkILKNI+Y2o3uybgnRDJ4Ms6Kw8HPa00GZK
         Makg==
X-Gm-Message-State: AOAM531KCq5Kz57GMRr5g8Ua2NLh8WuQpMvVy31Y1ooljkLtyudYfNM/
        7GThnKAbzlsvW6IH+QyFE3IJTueKDJnE
X-Google-Smtp-Source: ABdhPJwsIzGYhk0U69gO8w3MHa79EDRbAbnBjGKRU6QKgQTKDkQjjmn2EG/UXRBfHqwlMUkGRST8bkfSbrh3
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:2125:: with SMTP id
 r5mr27655598qvc.28.1622627044088; Wed, 02 Jun 2021 02:44:04 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:46 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-7-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 6/7] KVM: arm64: Use less bits for hyp_page order
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
2.32.0.rc0.204.g9fa02ecfa5-goog

