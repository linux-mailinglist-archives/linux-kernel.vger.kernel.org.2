Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689D139F57F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhFHLsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:48:33 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56036 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhFHLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:48:28 -0400
Received: by mail-qk1-f201.google.com with SMTP id o186-20020a37bec30000b02903aa376d30fdso9434747qkf.22
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CcKhBHrtrE/oRoJL40NCriVUGHKq+WAbrBb37/bST5E=;
        b=N6R/REz4ypDjIMoMcK3tEjc75MX/zkNinHX3hHsQVqihRFxwe8089S+UykOpHh8VwK
         qMH3bqnJPyrAJyvloziZBUaZfldnmKgRTZlx+kdBdNLGLoruhCS7iGBtlroyKTvXXDgK
         LD3GcWTVf/fQbryWYSgQ2xvXpwKh4JIYZYscTMNMaCrgTG2zwW+m5l+EFFLoJS7c4TCB
         W6z/jkBN+t+2ozsr4N2Q2lH4wIODWu50ZT/OqhGNZKId0rX7dbZ+iQYr4EruboN6kKSx
         6ueh5m5IwsSofk/VxH5YzAOHmp1FVNoKszwyAYWxGDeYYAzxAEzYw8E3+m/NDiSC5Wjn
         h52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CcKhBHrtrE/oRoJL40NCriVUGHKq+WAbrBb37/bST5E=;
        b=si5cJ7PFK9Ykcsgm5Idz9FKszMz4jsasPK4M4tDJTImzlGrux6J78DoCFFwbXJYJgN
         rek23vAHmgkPtEZUR2i2rKtjPVUSVMW5wgoJ85aLA1rM4xNOWiS6sjRjrwIf5iXBtdEC
         maM2OCe32/r3lSWMjb4kMxzhx3t5349yUFtp+evk5/y9bbZ4YoPj5VEH0f7sxrXKC3kI
         Abm3aVT0E5oeEqF2bL4aOmkHVCeLDNr4Nm49zRMn7ghd09G7pPX1moSBKyrgBW97dzt5
         dHehTYzAMvxDi4gdt5r1D3Yq/cR1x0zJC+x4KfHFAl02GocDnH17jHzE5c3y5KJbCQLm
         NlCQ==
X-Gm-Message-State: AOAM532f5Oyru1MB/jhsLruCtr55V6fZIhoFtIlHExMFJxYKrsVF66AV
        lptka56O9NfAEANrYj+a6EKVW+qUiQMi
X-Google-Smtp-Source: ABdhPJwmV4HHnFr5CoJZmAB4zmxtaQ4QQ4wZomGtKJiRX7H4lCdFOrj6XD5yptTjk6e2TsAql/Ga999/epVc
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:e4d:: with SMTP id
 o13mr23256075qvc.19.1623152735694; Tue, 08 Jun 2021 04:45:35 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:16 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-6-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 5/7] KVM: arm64: Remove hyp_pool pointer from struct hyp_page
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
index c8ed7e86231b..d938ce95d3bd 100644
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
index 1cff3259a493..f834833ac921 100644
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
2.32.0.rc1.229.g3e70b5a671-goog

