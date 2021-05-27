Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4172392E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhE0Mxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhE0MxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:25 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3399C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:51 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so1715432wri.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1VjwQ4Izjf01RJSguF+MyepUhFZaPW5Ia+1I2PStwVY=;
        b=vg6SBmeyHn1if0S0th7HR74BmQq74KmKE1yJjpIX9ye6dYwZLFggZYO5tq/veoHetZ
         5Q674WCyrQCG1WcqWZ/jITEVUmcJ4tH02f9Q/jSUmO3DkI1nwPjLa+F+mh/xVPVUv70u
         DhwBIsTjMJG0vUJsYatwyaGUIVp0XfFCtM9O20KmFC1EMHi61ZbgXBOmMAjh+wSNpiwj
         TgqBPSdq5pZx3UnHrUAtAGwfF9G6cMEuCVccdMwhdvt+8C55BcGj7kQFJiqmktvWDITl
         rETXsw+t6gsxPNXVtXZPbOGAzOxk9VekuOtK3lGvNUe4dEMSFsj/2aKbiiLuCFSz7wWp
         YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1VjwQ4Izjf01RJSguF+MyepUhFZaPW5Ia+1I2PStwVY=;
        b=cgM11flco+hcECWzHFSUYqXEo2GEZDiSTxA3lSB0VUQZi3k/WPiIJ56Dvc37P7p57w
         SpTxLkcJYx0EzHXv3hL4fHe11HYWUk927rU/mhvHZ2P5gOvyfLOOYYUqAIN0HWyAbYgq
         Y8ihY5X56JGslmAk75Ps1dfBr08s4rEF9VV9sRXjkFaMMqphb495+LPufoa1mi9Mq0pt
         Sx59a9ryIthhceArJLgH67wcXt60LPazUFGohNqYUiBNdzRxQZuCCkYLAQA/Wuis02k8
         li/okp8kEzcrYc8WqAP2UJfNjtCA0AhcS10eP5H+rrT6NtOX9ydYYO5lzds4mmSgCqs6
         hvVQ==
X-Gm-Message-State: AOAM53315zvx+Ro0vfmB7hCEK0n7lHLr0raMHb/Gyn/SwJ8DTUEzu/3P
        1GDnuDHNdxbDq50Svz9u8pWZzZh+MLUc
X-Google-Smtp-Source: ABdhPJyrMPjGXOBkf7UTBcOaGjq3koWvGQeLen0va0jMrfOi2lbpRnwG62zACEHhkBJxblCYtamLOJFnGkdm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:e205:: with SMTP id
 z5mr6882602wmg.70.1622119910127; Thu, 27 May 2021 05:51:50 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:33 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-7-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 6/7] KVM: arm64: Use less bits for hyp_page order
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
index 9ed374648364..d420e5c0845f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -7,7 +7,7 @@
 #include <nvhe/memory.h>
 #include <nvhe/spinlock.h>
 
-#define HYP_NO_ORDER	UINT_MAX
+#define HYP_NO_ORDER	USHRT_MAX
 
 struct hyp_pool {
 	/*
@@ -19,7 +19,7 @@ struct hyp_pool {
 	struct list_head free_area[MAX_ORDER];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
-	unsigned int max_order;
+	unsigned short max_order;
 };
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
@@ -41,7 +41,7 @@ static inline void hyp_set_page_refcounted(struct hyp_page *p)
 }
 
 /* Allocation */
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
+void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
 void hyp_get_page(void *addr, struct hyp_pool *pool);
 void hyp_put_page(void *addr, struct hyp_pool *pool);
 
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
index e453108a2d95..2ba2c550ab03 100644
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
 
@@ -168,9 +168,9 @@ void hyp_get_page(void *addr, struct hyp_pool *pool)
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
2.31.1.818.g46aad6cb9e-goog

