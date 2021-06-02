Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794FB39857A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhFBJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFBJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01101C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:44:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso1258395qvb.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M5Wmq+shTVGIkdp11V4c5i7OM/twUXVfGwFeKTKgDek=;
        b=sbhoOROzzgBjQ0Ii5F3WE53vDNE2WQ9bNmdrgZu1xuJ9RSjfTkJSQQOFRCY5YBGWoq
         uLzfsCzlorbdo93AUkTG8w+9z/k/IQhlrlZzGIue7mROdwqxWwzpc4ACpqZ7TQrsr0nR
         HxhodZI0VmshsthL3HyVJ4Llw6dMvOEOg0orUkcuwgmexiBLsW5yMr32mgBpk/UXShq5
         3VsQbZ/2UndcuRP5P5ctxfPvznXxJrBNlmX/yVf4mCCSAdHzRGM9Q7rijkRuyatj6zvf
         hU9a4s+ryYsqN1/rzuOaQGnMC6kXUcDFLbTJdWPGndOcXodaVXtrYT9fbb4sBsC1tai/
         uwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M5Wmq+shTVGIkdp11V4c5i7OM/twUXVfGwFeKTKgDek=;
        b=Yajpn+bxZ/F3GlDS00Sm1p+ah+4pJkep/s5lfzbUCImiZeeZI14fwG+3DTEY1LX6F3
         rvyYEtjDuRQ/Z1buMmZHIXnKw5cUW1iK1AnLxS5lFN91KlfcVodcZbuxGQMBMvodR5ex
         ebscS2S1iUly0PVu0+1USokdNgvKoQjv/6fFKPoXVk2a89D6QjP6CVMCNwpIoljUROBz
         SksO3IVMYq2otfkzHMqk+jbAmLKloHqYvS60Y1xIjv7LrSy5D1dnQ0adYJmYvURhVxPb
         EfsxWrWHNe/jbCA8f+VrD1n+C7ct8p6senkksQUWEf4caBDh8ZRfJ+egAgUd+xF7/Wzl
         defw==
X-Gm-Message-State: AOAM532AhiP9DJp2LPUwxsFFT3veXwzpdPtCIiOk+Vbz7q2QAQdQIA51
        AqCzK6g1+MTdRqlZse2/VMuokOItImTq
X-Google-Smtp-Source: ABdhPJzlMLj9aWOGmgfcq4uAOufpXqkiQRCfhyfBHQEh7YCjqgQkiQm8f+4yZIS6dkEn/iv2Ws85pl+Yel5w
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:19c8:: with SMTP id
 j8mr27500174qvc.42.1622627042096; Wed, 02 Jun 2021 02:44:02 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:45 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-6-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 5/7] KVM: arm64: Remove hyp_pool pointer from struct hyp_page
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

Each struct hyp_page currently contains a pointer to a hyp_pool struct
where the page should be freed if its refcount reaches 0. However, this
information can always be inferred from the context in the EL2 code, so
drop the pointer to save a few bytes in the vmemmap.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  4 ++--
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  2 --
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 14 ++++++++++++--
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     |  7 ++-----
 arch/arm64/kvm/hyp/nvhe/setup.c          | 14 ++++++++++++--
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index f2c84e4fa40f..3ea7bfb6c380 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -24,8 +24,8 @@ struct hyp_pool {
 
 /* Allocation */
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
-void hyp_get_page(void *addr);
-void hyp_put_page(void *addr);
+void hyp_get_page(struct hyp_pool *pool, void *addr);
+void hyp_put_page(struct hyp_pool *pool, void *addr);
 
 /* Used pages cannot be freed */
 int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 7691ab495eb4..991636be2f46 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -7,11 +7,9 @@
 
 #include <linux/types.h>
 
-struct hyp_pool;
 struct hyp_page {
 	unsigned int refcount;
 	unsigned int order;
-	struct hyp_pool *pool;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index fdd5b5702e8a..7727252890d8 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -43,6 +43,16 @@ static void *host_s2_zalloc_page(void *pool)
 	return hyp_alloc_pages(pool, 0);
 }
 
+static void host_s2_get_page(void *addr)
+{
+	hyp_get_page(&host_s2_pool, addr);
+}
+
+static void host_s2_put_page(void *addr)
+{
+	hyp_put_page(&host_s2_pool, addr);
+}
+
 static int prepare_s2_pool(void *pgt_pool_base)
 {
 	unsigned long nr_pages, pfn;
@@ -60,8 +70,8 @@ static int prepare_s2_pool(void *pgt_pool_base)
 		.phys_to_virt = hyp_phys_to_virt,
 		.virt_to_phys = hyp_virt_to_phys,
 		.page_count = hyp_page_count,
-		.get_page = hyp_get_page,
-		.put_page = hyp_put_page,
+		.get_page = host_s2_get_page,
+		.put_page = host_s2_put_page,
 	};
 
 	return 0;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 34f0eb026dd2..e3689def7033 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -174,20 +174,18 @@ static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
  * section to guarantee transient states (e.g. a page with null refcount but
  * not yet attached to a free list) can't be observed by well-behaved readers.
  */
-void hyp_put_page(void *addr)
+void hyp_put_page(struct hyp_pool *pool, void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
-	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
 	__hyp_put_page(pool, p);
 	hyp_spin_unlock(&pool->lock);
 }
 
-void hyp_get_page(void *addr)
+void hyp_get_page(struct hyp_pool *pool, void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
-	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
 	hyp_page_ref_inc(p);
@@ -236,7 +234,6 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	/* Init the vmemmap portion */
 	p = hyp_phys_to_page(phys);
 	for (i = 0; i < nr_pages; i++) {
-		p[i].pool = pool;
 		p[i].order = 0;
 		hyp_set_page_refcounted(&p[i]);
 	}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 709cb3d19eb7..dee099871865 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -137,6 +137,16 @@ static void *hyp_zalloc_hyp_page(void *arg)
 	return hyp_alloc_pages(&hpool, 0);
 }
 
+static void hpool_get_page(void *addr)
+{
+	hyp_get_page(&hpool, addr);
+}
+
+static void hpool_put_page(void *addr)
+{
+	hyp_put_page(&hpool, addr);
+}
+
 void __noreturn __pkvm_init_finalise(void)
 {
 	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
@@ -160,8 +170,8 @@ void __noreturn __pkvm_init_finalise(void)
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
 		.virt_to_phys = hyp_virt_to_phys,
-		.get_page = hyp_get_page,
-		.put_page = hyp_put_page,
+		.get_page = hpool_get_page,
+		.put_page = hpool_put_page,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

