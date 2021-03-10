Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C99B334623
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhCJR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhCJR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:51 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00686C061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:50 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id d26so13243867qve.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mIqe1MGSlcb95mMvYxk2H+NidebDAWpSvKZgF+GIUJ4=;
        b=vx1GePNKXUsy3lm2tRdqorO6elSbn6hExBP9oaHOyHkER8tNbdC4pg+nDr9AGdaxu/
         3Pewgjk9+slL6lrKsPYNW1OpM3lhTxz2lcsvqeup2Wyxbzq2NXQaVBftczldIThhz7Yp
         /HAcyfzAp3RoP8J9843KokXr36i92XcvOZWvZo93MZts7mNB1shqN4YA+qaTXAvDoTS6
         28UBYIp8LKmk/A0xaarxs0aZTp/RH/iKCJj4GooZLOJUopksawDWvdVuHDx/lrG+zeV5
         gDMOvGL4kjJ01oz0/cO/LrK5/pM+kPniLilZvJxb6+MyXtgKLpLtfI2U/M6uuxfIEjR/
         72Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mIqe1MGSlcb95mMvYxk2H+NidebDAWpSvKZgF+GIUJ4=;
        b=HX16mTzE2MyjjASFpHoxV0xCy2LY0iJ6pzLnYQeywp+IXDHi7FiRFVMww9/l2IJVTU
         IzmB2wWbg3Es4itT4dPTBwcLUbvw5czPJS7dmxFjzajWgzqIC6v77apVsiJN1931YGpU
         l7PH5a0sFG+zvVLcM9cElGljrohnCkcsrEzEPjI+qSNeFb3J7n8GxHFGUFAjwXHm/ffn
         8PtcV13d019dSisegNjyU5hcHkewLEnVy2Bmq1q1gXGEsrYneb+UrSVR08mhizG7Zx7H
         DQBC0mR8ewZ1WPZ+jc5Uh2zfjH5h4zp4WzWl4OsZM5GnMiy4EfJ/OeEQh/Tw5KHvOWAx
         GeuA==
X-Gm-Message-State: AOAM5337cwNChEv2TdYotzyo+mIHimTxnG6DPp8czDjX2i9CuQ7NxuJ2
        uP1Y/Ua+IwLDKHNhKpni0Dt3MzffNKpT
X-Google-Smtp-Source: ABdhPJy2ywA58O3Ivcmfuywfr7DLLO/RhF30F1qBje3/94+cZdCa6U9wIlM0XrJdUI5Hekvh7JWZdZjaP3b/
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:bec3:: with SMTP id
 f3mr3180215qvj.49.1615399130193; Wed, 10 Mar 2021 09:58:50 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:42 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-26-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 25/34] KVM: arm64: Reserve memory for host stage 2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the memory pool allocated for the hypervisor to include enough
pages to map all of memory at page granularity for the host stage 2.
While at it, also reserve some memory for device mappings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 27 ++++++++++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++++
 arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index ac0f7fcffd08..0095f6289742 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -53,7 +53,7 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
 	return total;
 }
 
-static inline unsigned long hyp_s1_pgtable_pages(void)
+static inline unsigned long __hyp_pgtable_total_pages(void)
 {
 	unsigned long res = 0, i;
 
@@ -63,9 +63,34 @@ static inline unsigned long hyp_s1_pgtable_pages(void)
 		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
 	}
 
+	return res;
+}
+
+static inline unsigned long hyp_s1_pgtable_pages(void)
+{
+	unsigned long res;
+
+	res = __hyp_pgtable_total_pages();
+
 	/* Allow 1 GiB for private mappings */
 	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
 
 	return res;
 }
+
+static inline unsigned long host_s2_mem_pgtable_pages(void)
+{
+	/*
+	 * Include an extra 16 pages to safely upper-bound the worst case of
+	 * concatenated pgds.
+	 */
+	return __hyp_pgtable_total_pages() + 16;
+}
+
+static inline unsigned long host_s2_dev_pgtable_pages(void)
+{
+	/* Allow 1 GiB for MMIO mappings */
+	return __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
+}
+
 #endif /* __KVM_HYP_MM_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 1e8bcd8b0299..c1a3e7e0ebbc 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -24,6 +24,8 @@ unsigned long hyp_nr_cpus;
 
 static void *vmemmap_base;
 static void *hyp_pgt_base;
+static void *host_s2_mem_pgt_base;
+static void *host_s2_dev_pgt_base;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
@@ -42,6 +44,16 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!hyp_pgt_base)
 		return -ENOMEM;
 
+	nr_pages = host_s2_mem_pgtable_pages();
+	host_s2_mem_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_mem_pgt_base)
+		return -ENOMEM;
+
+	nr_pages = host_s2_dev_pgtable_pages();
+	host_s2_dev_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_dev_pgt_base)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index 9bc6a6d27904..fd42705a3c26 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -52,6 +52,8 @@ void __init kvm_hyp_reserve(void)
 	}
 
 	hyp_mem_pages += hyp_s1_pgtable_pages();
+	hyp_mem_pages += host_s2_mem_pgtable_pages();
+	hyp_mem_pages += host_s2_dev_pgtable_pages();
 
 	/*
 	 * The hyp_vmemmap needs to be backed by pages, but these pages
-- 
2.30.1.766.gb4fecdf3b7-goog

