Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7B334622
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhCJR7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhCJR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:49 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC4C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:49 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h5so8295503wrr.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nO+Dw20r7SUumZfYakzeexkud+udjeRUH05spovGIBc=;
        b=q98vijkRUeBOdzAWoY6jRSeh2vMwodAX3jBub6VuJmeqX1nog5ludU2AjzqL8PAyuq
         3cPVvj3cnJOPB8MRhg4r4XPGpnVaB3OyXeAowiksQMcBVNgSPw1LkT2uJGYyKIgFxcij
         M/JowpIjqjiIs5oXD3XYIS+g6gTCrKX6YM5/vQZkGhwkzjsiNiVrklSK8eGZPwXSALI6
         mjfYDEg94yHnnmrjLyFv4KW5o/KxZZAxhFmGgZWX80bSgINRDmOqSImA4+eg8cM0yeQl
         VKWh5T18d3rrEZMMW5p0AAVlXtJD4jrKvoyWlmZ1E7RkfQg7ecYwBLpIYjCgOV4lU9Tu
         jHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nO+Dw20r7SUumZfYakzeexkud+udjeRUH05spovGIBc=;
        b=En6cFF6K/5neYSXpxRPiONAdWAzRnUBFGGVC56T5Y/azV2egi9Km1kdM/u+ogV2ydO
         CAFxaplOjQvG4/QFQVS6vsh8IHXmfpzfieY98Zk3vfs40dDMql+A5EjdOfey9FRkGSWN
         +xpvRIyW63j+GbBqDv7KRTToerIAierh2ZioZ7pBo5ceQ2qGLieRz1pov166DtV24sn3
         wNBdkE2Qw/gQJHb9n66VukJIKsWroiAEIjZL8AuNf1Fi6nCjATA0KQ5g3RF4cMNoRCR/
         pVcBnCaeqw5iggpjGhSMUd+/6Wco8jYFfUvfRy9SKKnNOVR2UFFkaMdJ+DAYOURULNlA
         VY/Q==
X-Gm-Message-State: AOAM530ZdFE0YFkeQB3mFyyFnUdHKi68HdKJsMiAdk0NzB/J7maGuEKF
        F9WMaVg/coMlmRitYgdi8FPBINFCsU5p
X-Google-Smtp-Source: ABdhPJwVhnSLfeKiraD5idqzHXTWJrPR2Q57MoB1wpdcj8fUwYlAEfZZUCvSXNNkTOyW9ggJRQmLFzB6VaEi
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:cf16:: with SMTP id
 l22mr4421313wmg.26.1615399128195; Wed, 10 Mar 2021 09:58:48 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:41 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-25-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 24/34] KVM: arm64: Make memcache anonymous in pgtable allocator
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
2.30.1.766.gb4fecdf3b7-goog

