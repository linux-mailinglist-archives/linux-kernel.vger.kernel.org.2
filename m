Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF9392E59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhE0Mxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhE0MxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CCC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so370297qkj.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ehs1oQ+8oLxIXVrBNHuhZcAo+D2g9l++j8BZLV6gtTA=;
        b=a+FtUAFPFyiW0uYlgwR0eSULr6xYa8BpYbZNF6URd1JNP9Jw9Hd23+lAYigwVkhKoW
         lyFAkrD2tp/8dk2Rn0LshAJLDfuuF3tyfte6wErSyLZlahexM9sr15qTiMWbRy54SmxA
         CXiqPJ+PxMN1vY+PA3Qkvfqu2y/7s+tGazebtbYsQ+NKZbUxq46OS/xDMwFrSHKhJI8N
         Q50Hl2GkR08amV3wg4iJhrweLLG/4tHzM6TtJFHyR9LfjuSmNPtKWyKL4Ik1TCtRVESm
         4i4sOBb2IvH511qCVxCI/ubxHWCHIZCq9RxmfVeCzmQC4cK/P8RVV750oUvTNGoiuWHm
         IDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ehs1oQ+8oLxIXVrBNHuhZcAo+D2g9l++j8BZLV6gtTA=;
        b=nCLr3ntHlLXll7XLa0FShS/Xh2m5G5KZQ2mkmKBqLiL0aBuQ2FDIlenjDlVVv2zZf8
         r7l/dPRtpq3Odet7Uqwmtk1yWhePEnF68odhya2sQyZjulps4mPZSJtKyrKb/Nang5Jt
         /4GJmO7L/onfmJYF5knnBuc9aul9Dgagmz1lfrg3zvVMClV7zXcJGm5J6Hf/qRE+s9MO
         kwknvsWxLMIO+zGSXMDB5uF7dj8syNVTP04ETR7ofF9BXVfpkoMc++DNmrVX4QezlAi5
         2qsinIYHlwWCMwjRfVMnCs2VI1FuWWbF43MExNzP9BCVZ7gUSBc6MZFFlOawYIx+LsjP
         k9BA==
X-Gm-Message-State: AOAM533HA6pwpR18U4sKY7eWh7R4/PDiqFHhrQyYwmNDC7i3upKW3iJs
        et9KQMNzx2VdEObRNO/el8JgUyFaSu8p
X-Google-Smtp-Source: ABdhPJyaKy4GEnKIJ/S5dR75Z6Sp8g/ueH5v6TANNcDxhzHPzuTTPn0wYyWBm/8d245iHVbNGmkmL9vYBxK9
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:9e4e:: with SMTP id
 z14mr3459560qve.31.1622119907499; Thu, 27 May 2021 05:51:47 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:32 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-6-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 5/7] KVM: arm64: Remove hyp_pool pointer from struct hyp_page
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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 13 +++++++++++--
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     |  7 ++-----
 arch/arm64/kvm/hyp/nvhe/setup.c          | 14 ++++++++++++--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index aada4d97de49..9ed374648364 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -42,8 +42,8 @@ static inline void hyp_set_page_refcounted(struct hyp_page *p)
 
 /* Allocation */
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
-void hyp_get_page(void *addr);
-void hyp_put_page(void *addr);
+void hyp_get_page(void *addr, struct hyp_pool *pool);
+void hyp_put_page(void *addr, struct hyp_pool *pool);
 
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
index fdd5b5702e8a..3603311eb41c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -42,6 +42,15 @@ static void *host_s2_zalloc_page(void *pool)
 {
 	return hyp_alloc_pages(pool, 0);
 }
+static void host_s2_get_page(void *addr)
+{
+	hyp_get_page(addr, &host_s2_pool);
+}
+
+static void host_s2_put_page(void *addr)
+{
+	hyp_put_page(addr, &host_s2_pool);
+}
 
 static int prepare_s2_pool(void *pgt_pool_base)
 {
@@ -60,8 +69,8 @@ static int prepare_s2_pool(void *pgt_pool_base)
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
index ce7379f1480b..e453108a2d95 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -150,20 +150,18 @@ static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
 		__hyp_attach_page(pool, p);
 }
 
-void hyp_put_page(void *addr)
+void hyp_put_page(void *addr, struct hyp_pool *pool)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
-	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
 	__hyp_put_page(pool, p);
 	hyp_spin_unlock(&pool->lock);
 }
 
-void hyp_get_page(void *addr)
+void hyp_get_page(void *addr, struct hyp_pool *pool)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
-	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
 	hyp_page_ref_inc(p);
@@ -212,7 +210,6 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	/* Init the vmemmap portion */
 	p = hyp_phys_to_page(phys);
 	for (i = 0; i < nr_pages; i++) {
-		p[i].pool = pool;
 		p[i].order = 0;
 		hyp_set_page_refcounted(&p[i]);
 	}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 709cb3d19eb7..bf61abd4a330 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -137,6 +137,16 @@ static void *hyp_zalloc_hyp_page(void *arg)
 	return hyp_alloc_pages(&hpool, 0);
 }
 
+static void hpool_get_page(void *addr)
+{
+	hyp_get_page(addr, &hpool);
+}
+
+static void hpool_put_page(void *addr)
+{
+	hyp_put_page(addr, &hpool);
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
2.31.1.818.g46aad6cb9e-goog

