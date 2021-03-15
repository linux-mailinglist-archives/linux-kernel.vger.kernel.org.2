Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3216B33BEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbhCOOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbhCOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:49 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A3C0613E6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:33 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z6so15156097wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cxdxaiam1X2gsTV6KPc4g5L7XZMiE67OSu7PD7BcN7o=;
        b=OMsxJI7KJj6F2RuvFviEZz84cZybVuZYThaK3AmaKHP1u8aAuqn1WOOcT2LSJKF9V7
         vDcNvZhVfhqocQA7wmz66kO6OnwWldlrfaZPwqPTi6krQcWQOC+0UvX840UIbbh5ftqt
         oKDtYOHbUc7n70UKZc6DgdOCN7e5chAPaoA9HsJxC5240NXoVoTKtijG7Quiq1R+hOei
         TjvA+2uxGeEJyocrfKq6KpomlHmn6s2H4fQAhHQVouRekpeDPRcMehqic7AHjrCTzQRE
         BlBA46/4o/1J5S3k1AEp73sprYebuMw17kSK4PerOOsOOvSLkme2qCD4p9UoekTY5+3T
         3NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cxdxaiam1X2gsTV6KPc4g5L7XZMiE67OSu7PD7BcN7o=;
        b=qUurWG4mNbzof0b1w25to7RFi/lsjXtXMQeCtcmPbJ3pmNca7PAgATeuMqzccRV7jT
         NcJlPUuD8ZARENEKInAyCdSneSg6sw91uQNT8Asb//VbA8HcraidmncSer5ZcLScem6C
         87fAnYKINEpe8Yr0SrG9sJWqUnmPfmczuB7WEHY7GHkHMUYczvjJ/5ZqzmkTZnz65Hp/
         LcZkQoAdU3NRxNx0Ev7937vPNHP32uKtdF5AjnP2lPZDqRNKUgb1klScb+1Uz6gWQB7I
         fA9ecqxrgUrHtQbnFb1bEkLCv0YUQwDKQimBXMPWLGpLiF4D2nUE8pn+S/DSX+Vnd3c2
         bcMw==
X-Gm-Message-State: AOAM532h/DgXAGLuDU8rraVO92wpnWN4fgIU3RY4zlqFbObXeZC3EN+w
        4G44fvFTsLcwIya85gU6iCVVlxfwfg2D
X-Google-Smtp-Source: ABdhPJzXhlBmc8e/B+KVzi/50+fA2t7x+8GH00VuaEIHUCbA/WbBddcs0rg+cC27VW6NLE39ZvY96jTAe/7X
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:adf:f841:: with SMTP id
 d1mr31309wrq.36.1615818992019; Mon, 15 Mar 2021 07:36:32 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:25 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-26-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 25/36] KVM: arm64: Make memcache anonymous in pgtable allocator
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
index 296675e5600d..bdd6e3d4eeb6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -445,7 +445,7 @@ struct stage2_map_data {
 	kvm_pte_t			*anchor;
 
 	struct kvm_s2_mmu		*mmu;
-	struct kvm_mmu_memory_cache	*memcache;
+	void				*memcache;
 
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
@@ -669,7 +669,7 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
-			   struct kvm_mmu_memory_cache *mc)
+			   void *mc)
 {
 	int ret;
 	struct stage2_map_data map_data = {
-- 
2.31.0.rc2.261.g7f71774620-goog

