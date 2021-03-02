Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC61D32A833
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579962AbhCBRVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448595AbhCBPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:06:09 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1482EC0698CB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id e7so4385493wrw.18
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eue23Q78bOa6+/qbv0+6w883I/AngR/tMntsoJXpnuQ=;
        b=nXDl1eBiQI2Aja03chUT9gTykyTfm89UeBlE5QXB1z3z62rESZY1NMmtIQrrBv8WOF
         Ass0zOOFiuM+77TewQc5zQ9f+75XlVxMT9kaHRSFP5pdy5PGn8GGHcVrFZ/Dn8X0pSDl
         zAxJ+7yMDdHK5Hubnm4RtSb+mytr0rfVYMT0DDBLLEV2kdB3bjFW48XozEWVs1ckcr3N
         dDr5smJaj/nTDAeNxI35YfwpklQwX+z7ZLIMRdSwDbzl0Vce1qAdeTeoJb2lQi68my3Y
         yyWI94ahVEOhCs2D1coNOmWYjpek8J80PGFS3oGu7r+aS3BF/QiUyFoyeeaOb2T+gs2+
         HY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eue23Q78bOa6+/qbv0+6w883I/AngR/tMntsoJXpnuQ=;
        b=mn3tCjrgG2f5NuXEGVmi/hn1Ds45RJAWNwX1P+9Je6XSA1DEpTxRBt7IuC/6GUX/y7
         +i8vS5pe+52a/DFSUC1SztH9D5EeccAs+RjOExU5WJmGBLzyj+QGyFx8L86Oo6OZDqUN
         QNMemE9UXg8hwlDjYDoTxa1HGdR+oaVxtMKUOh8eKRrh3e7f6/W7FlzRXgAb+AyWh4+F
         Pus2z5iAVpkt610hdBeMJDmvwPDHsVzQkhW/SNufWgHdHBjacsPLBSblFhFxOEJFNtam
         3rdNd2EmwORIXI1fPZWDeiCM0+/DWRwtrDp50cK3Ox1mYIwQNpnPPPZVlY9iJjnihspH
         VV5g==
X-Gm-Message-State: AOAM532dLUWanTmswSblSu/0ngHGZOwlnaoCWj7mdB7B79UA+VGZoDl8
        Y3Jc+gzsO+5zRCG9t4xS38D9VvlRdnN5
X-Google-Smtp-Source: ABdhPJxEqIQZb2BYYx4oJbXqcI8pQfBowRyHhxZCpcsx84Q/DAuukPbVQiX0S9b4CaaJzjpiugoRR377rmIT
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:b6d7:: with SMTP id
 g206mr4472055wmf.123.1614697257976; Tue, 02 Mar 2021 07:00:57 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:53 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-24-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 23/32] KVM: arm64: Make memcache anonymous in pgtable allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current stage2 page-table allocator uses a memcache to get
pre-allocated pages when it needs any. To allow re-using this code at
EL2 which uses a concept of memory pools, make the memcache argument of
kvm_pgtable_stage2_map() anonymous, and let the mm_ops zalloc_page()
callbacks use it the way they need to.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
 arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 21e0985d2e00..9935dbae2cc1 100644
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

