Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A33CD2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhGSKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbhGSKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92840C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:43 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q11-20020ad4434b0000b029030449450d37so8441119qvs.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lb/gYwEJ52V8NJMW9ljOtVfH6PwbyXsZiRh6U1L061M=;
        b=dVcGRuTeuLeRZV2QwASmH66frNnilIZiSJsAaKb1s76JoXlM4AtD3npXiYQzxt28XK
         WRmijrISMsClSbfD/j1ZqOtq+NAIkXrS2vs0tgWk2FNH+4EGuiPN0pghsbdxN4MoQF5k
         dIL201YwNFekTdUovrgHjn/z4+PZxwtyG77qNXlJ+DbJY5BfxZyGA38C7WIW2DXBG+c7
         cAVEg+Vw0+L5Ce2pVQUm3xmwl4XlB7do98+Wr4I207ZGws9WsRZZ3sWM5nrre3xUZJ+Q
         0GH6Old6+be+vA+5Ga601BkY28wqGSPU4phFvCk5iEc0GkkR2DcpFMBULOEnVKIW5OcC
         zJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lb/gYwEJ52V8NJMW9ljOtVfH6PwbyXsZiRh6U1L061M=;
        b=LyICh5E85R/qhQN08DuyESeD8UtsL4IcqqxROatVbhZ1JKt2D+8HL+5f9Jl0JbN6lK
         QLalL6I3IqOjzgZtv2awztppGPNF6DDSxJWGYYpx5M8lcBx7UkG7nCg6u7I/u6w2lfiB
         HHj4EQ5vaTX6vgZTY0cR4Fv0mJ4ZPm1tSXxvRQpDJHxxdtctQhpLPYqwtAS7iniROhX2
         Gaqz9yusOTQAu89m2Un8NObMQOrD6mkIkRFWRXfpVWQHqfTWQgOFSkJaTpBn2te2uqo3
         sl2xcS1t0mVt32dfU+04HxbQkAEloHWpvUJLWxgyTBAv4LXBolJNf+O8+UGKAit+TH/h
         8R6w==
X-Gm-Message-State: AOAM5324wtLbB0lzPGCrfcFU+VxMdI0cf5TMl9hAkNIq5KcD6S9azg9H
        K32lYMNB3J+8rutNj63J/wGjimEBCSte
X-Google-Smtp-Source: ABdhPJytH3lHIJjCHy/P5Ydbwldz1i5qqlyWptr5/IHXQucIC5VXiU31XNnB+3cuKdHQC5Bm27x6uAI37Z5o
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a05:6214:7e9:: with SMTP id
 bp9mr24508149qvb.4.1626691668039; Mon, 19 Jul 2021 03:47:48 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:24 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-4-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 03/14] KVM: arm64: Continue stage-2 map when re-creating mappings
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>,
        Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stage-2 map walkers currently return -EAGAIN when re-creating
identical mappings or only changing access permissions. This allows to
optimize mapping pages for concurrent (v)CPUs faulting on the same
page.

While this works as expected when touching one page-table leaf at a
time, this can lead to difficult situations when mapping larger ranges.
Indeed, a large map operation can fail in the middle if an existing
mapping is found in the range, even if it has compatible attributes,
hence leaving only half of the range mapped.

To avoid having to deal with such failures in the caller, don't
interrupt the map operation when hitting existing PTEs, but make sure to
still return -EAGAIN so that user_mem_abort() can mark the page dirty
when needed.

Cc: Yanan Wang <wangyanan55@huawei.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  2 +-
 arch/arm64/kvm/hyp/pgtable.c         | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d6649352c8b3..af62203d2f7a 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -258,7 +258,7 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
  * If device attributes are not explicitly requested in @prot, then the
  * mapping will be normal, cacheable.
  *
- * Note that the update of a valid leaf PTE in this function will be aborted,
+ * Note that the update of a valid leaf PTE in this function will be skipped,
  * if it's trying to recreate the exact same mapping or only change the access
  * permissions. Instead, the vCPU will exit one more time from guest if still
  * needed and then go through the path of relaxing permissions.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 978f341d02ca..bb73c5331b7c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -475,6 +475,8 @@ struct stage2_map_data {
 	void				*memcache;
 
 	struct kvm_pgtable_mm_ops	*mm_ops;
+
+	int				ret;
 };
 
 u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
@@ -612,8 +614,10 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		 * the vCPU will exit one more time from guest if still needed
 		 * and then go through the path of relaxing permissions.
 		 */
-		if (!stage2_pte_needs_update(old, new))
-			return -EAGAIN;
+		if (!stage2_pte_needs_update(old, new)) {
+			data->ret = -EAGAIN;
+			goto out;
+		}
 
 		stage2_put_pte(ptep, data->mmu, addr, level, mm_ops);
 	}
@@ -629,6 +633,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	smp_store_release(ptep, new);
 	if (stage2_pte_is_counted(new))
 		mm_ops->get_page(ptep);
+out:
 	if (kvm_phys_is_valid(phys))
 		data->phys += granule;
 	return 0;
@@ -771,6 +776,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.mmu		= pgt->mmu,
 		.memcache	= mc,
 		.mm_ops		= pgt->mm_ops,
+		.ret		= 0,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
@@ -789,7 +795,10 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 
 	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
 	dsb(ishst);
-	return ret;
+	if (ret)
+		return ret;
+
+	return map_data.ret;
 }
 
 int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -802,6 +811,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.memcache	= mc,
 		.mm_ops		= pgt->mm_ops,
 		.owner_id	= owner_id,
+		.ret		= 0,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
@@ -815,7 +825,10 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		return -EINVAL;
 
 	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
-	return ret;
+	if (ret)
+		return ret;
+
+	return map_data.ret;
 }
 
 static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
-- 
2.32.0.402.g57bb445576-goog

