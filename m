Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACA34195D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCSKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCSKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:45 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:44 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id a63so4395567wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GoB0Yt2mReKBbMoIr+lrsMAUtacP9flbLvax4BQ0cpo=;
        b=mN+FVC37//OEHQaXZ4xc2thLgYxUYcwEXaW5TBfO3XlbhCuyXV8jvTNRJLii5RLIj0
         xmKkGauvXEi0qyjP0Kcp8OK66FoyG8uJe7Q6GNxfmPmV/oSHgYoO6GSkxdZm7du+bwhl
         8V2Fz7Q7VbHRBBEgX+9Q2JzGBbVYLb+nSh+WoVGi6HtrU1vY3OCpXTt6SzkMpifbf1xs
         RNOGHY5XdRY09XTS/UcNCjZcWMpii07Z8v375fHeOTd3nS/z/i2DthjHr5hibcvG6s5v
         pMF0THMZMLV9n48Pn91vMViDEYTJ0ZRN7zRVf3rPR2wVJi3CbJPDNxDmioYHC948CiXF
         A5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GoB0Yt2mReKBbMoIr+lrsMAUtacP9flbLvax4BQ0cpo=;
        b=Yz0zTfYLJViW81GG0S7/ISt3laBilrIdDWEv/XH3sJTUBTHpx0uVLgwgF8vdTgXGC4
         WWBLamqR36O018/11WJI4YCU1wvtITJRxv/OFd74p1TriDB8wnTU+QPvDxK1PRUTLajJ
         OYMFlH0TI65Hvv0s95nAxXTE8C8rzCAQkrEQYfGaBvx2tUgdwMm7yKUH1SwZ/YYxwlWb
         SHtATAOOOgyVQLiIY30jSpco5pYv4JJ/SDM2v0dczwkulfc6ZKKwQRxXjjW0E+QJMOc6
         n5i1Ky9JhJ3hfkvqZp4OKUIGh7COh5DusuoCx//f2v/uWuPSsMwPLJ4SmBeyu2hsTVK1
         8hQw==
X-Gm-Message-State: AOAM530PeuhOkUFOTI6rWL5RKqJh33sSYgcKtRx0uo6vVql6UwsA8kLw
        jnuLvFsTgnDeLzzfPEi0dx6Q3Ep5H6v8
X-Google-Smtp-Source: ABdhPJwANOYdeS5v07RyJarildN3aDLb2D0RRdsdS4nj5tblGB/ls84kq0dI4zckrcY6q898orz04xgstkQm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1312452wmi.1.1616148162823; Fri, 19 Mar 2021 03:02:42 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:33 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-26-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 25/38] KVM: arm64: Make memcache anonymous in pgtable allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current stage2 page-table allocator uses a memcache to get
pre-allocated pages when it needs any. To allow re-using this code at
EL2 which uses a concept of memory pools, make the memcache argument of
kvm_pgtable_stage2_map() anonymous, and let the mm_ops zalloc_page()
callbacks use it the way they need to.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
 arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 9cdc198ea6b4..4ae19247837b 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -213,8 +213,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
  * @size:	Size of the mapping.
  * @phys:	Physical address of the memory to map.
  * @prot:	Permissions and attributes for the mapping.
- * @mc:		Cache of pre-allocated GFP_PGTABLE_USER memory from which to
- *		allocate page-table pages.
+ * @mc:		Cache of pre-allocated and zeroed memory from which to allocate
+ *		page-table pages.
  *
  * The offset of @addr within a page is ignored, @size is rounded-up to
  * the next page boundary and @phys is rounded-down to the previous page
@@ -236,7 +236,7 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
  */
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
-			   struct kvm_mmu_memory_cache *mc);
+			   void *mc);
 
 /**
  * kvm_pgtable_stage2_unmap() - Remove a mapping from a guest stage-2 page-table.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 4e15ccafd640..15de1708cfcd 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -446,7 +446,7 @@ struct stage2_map_data {
 	kvm_pte_t			*anchor;
 
 	struct kvm_s2_mmu		*mmu;
-	struct kvm_mmu_memory_cache	*memcache;
+	void				*memcache;
 
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
@@ -670,7 +670,7 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
-			   struct kvm_mmu_memory_cache *mc)
+			   void *mc)
 {
 	int ret;
 	struct stage2_map_data map_data = {
-- 
2.31.0.rc2.261.g7f71774620-goog

