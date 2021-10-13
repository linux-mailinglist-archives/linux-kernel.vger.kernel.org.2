Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9452642C570
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhJMQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbhJMQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso3679704ybj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xRWQMLf+apv1h1Y0VPkMZJQJu4PG3LU0eGsIqqLuHBE=;
        b=dtGpO69Q22L/0AT3DiJZIAlyjD9Ntx7ATixiCAjJqElqUscnJANNHy8xGBlhLAzASH
         pdMTCLVoMIGPRc5OMmlvsOgZ4F3PpWd403IcwNLULm+Sd0mCbfyt4BbbVrcv+U6xPwy8
         9l/EZD+oqsJ2pZSywdCKsEp5AT9hI6AyFaBDm3LexUQUcce8VitixF3STuVa/UttUXgC
         TL0UmSbwA8c4ZKzdrmvE2y9yd9aY0DQKn60kJWdeTYg0Wett0q+QIYVGPd1tVo09H0sz
         15tm3VQaYKS+GlDNE6LsTero1j0v8nx0eH2shAT8yi2ZENzZBvorWzBnQx+UYLi99Fvz
         9f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xRWQMLf+apv1h1Y0VPkMZJQJu4PG3LU0eGsIqqLuHBE=;
        b=g902n1VH2UZFJDiROphYMFzXPOM3N2K/9XaaqtOtM8wjMi+NNoZstdIoI3hiOr6dFB
         yJpYW3aVD8hlSLGo+Sp/8vWIWgFN2doyXGQx/E/xzHdbUiRyt2cGgAcazVqyc1ymr6wQ
         gTinxTPnrfidPwRQXSRRWMnFYiYRa/JRKHLF/XP2AviRVXxrfBoSqr/4fplREcMW4R9d
         hCJZeuqKlHECDmPNa0Wl5Tgwh/VC59+B9/wENMi3J1ksaQvvZwkTysSCAlvSgBfGfXQK
         iTXYTUF4t4/LGLMZrFcGoIxZhuQ46LrJ6wL13cvbmPKqdnKcokD98D3A9ZpCuaQjg8r8
         JX0Q==
X-Gm-Message-State: AOAM533dJA1cwNJknj/7yDi1bhHBRrPMJB7arkuS+JTFhnchQTIOvbOB
        uTHQDnHaP0gy6JnfwrncK2iKCHGAwQ/U
X-Google-Smtp-Source: ABdhPJz807qmcV7sOwt20TlAiEdslYI8Ep37s2M/k2R6SI9SlHRjD+sPlh7lm4qrKlIzL5wx+7NKSuJQiHA8
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:6902:1024:: with SMTP id
 x4mr207401ybt.514.1634140718834; Wed, 13 Oct 2021 08:58:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:17 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-3-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 02/16] KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

__pkvm_host_share_hyp() shares memory between the host and the hypervisor,
so implement it as an invocation of the new do_share() mechanism.

Note that the new semantics are slightly stricter than before, as we
now validate the physical address when double-sharing a page. However,
this makes no functional difference as long as no other transitions are
supported and the host can only share pages by pfn.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 121 +++++++-------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 53e503501044..6983b83f799f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -342,94 +342,6 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
-static inline bool check_prot(enum kvm_pgtable_prot prot,
-			      enum kvm_pgtable_prot required,
-			      enum kvm_pgtable_prot denied)
-{
-	return (prot & (required | denied)) == required;
-}
-
-int __pkvm_host_share_hyp(u64 pfn)
-{
-	phys_addr_t addr = hyp_pfn_to_phys(pfn);
-	enum kvm_pgtable_prot prot, cur;
-	void *virt = __hyp_va(addr);
-	enum pkvm_page_state state;
-	kvm_pte_t pte;
-	int ret;
-
-	if (!addr_is_memory(addr))
-		return -EINVAL;
-
-	hyp_spin_lock(&host_kvm.lock);
-	hyp_spin_lock(&pkvm_pgd_lock);
-
-	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
-	if (ret)
-		goto unlock;
-	if (!pte)
-		goto map_shared;
-
-	/*
-	 * Check attributes in the host stage-2 PTE. We need the page to be:
-	 *  - mapped RWX as we're sharing memory;
-	 *  - not borrowed, as that implies absence of ownership.
-	 * Otherwise, we can't let it got through
-	 */
-	cur = kvm_pgtable_stage2_pte_prot(pte);
-	prot = pkvm_mkstate(0, PKVM_PAGE_SHARED_BORROWED);
-	if (!check_prot(cur, PKVM_HOST_MEM_PROT, prot)) {
-		ret = -EPERM;
-		goto unlock;
-	}
-
-	state = pkvm_getstate(cur);
-	if (state == PKVM_PAGE_OWNED)
-		goto map_shared;
-
-	/*
-	 * Tolerate double-sharing the same page, but this requires
-	 * cross-checking the hypervisor stage-1.
-	 */
-	if (state != PKVM_PAGE_SHARED_OWNED) {
-		ret = -EPERM;
-		goto unlock;
-	}
-
-	ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, NULL);
-	if (ret)
-		goto unlock;
-
-	/*
-	 * If the page has been shared with the hypervisor, it must be
-	 * already mapped as SHARED_BORROWED in its stage-1.
-	 */
-	cur = kvm_pgtable_hyp_pte_prot(pte);
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	if (!check_prot(cur, prot, ~prot))
-		ret = -EPERM;
-	goto unlock;
-
-map_shared:
-	/*
-	 * If the page is not yet shared, adjust mappings in both page-tables
-	 * while both locks are held.
-	 */
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	ret = pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, prot);
-	BUG_ON(ret);
-
-	prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
-	ret = host_stage2_idmap_locked(addr, PAGE_SIZE, prot);
-	BUG_ON(ret);
-
-unlock:
-	hyp_spin_unlock(&pkvm_pgd_lock);
-	hyp_spin_unlock(&host_kvm.lock);
-
-	return ret;
-}
-
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
@@ -758,3 +670,36 @@ static int do_share(struct pkvm_mem_share *share)
 out:
 	return ret;
 }
+
+int __pkvm_host_share_hyp(u64 pfn)
+{
+	int ret;
+	u64 host_addr = hyp_pfn_to_phys(pfn);
+	u64 hyp_addr = (u64)__hyp_va(host_addr);
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= 1,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= host_addr,
+				.host	= {
+					.completer_addr = hyp_addr,
+				},
+			},
+			.completer	= {
+				.id	= PKVM_ID_HYP,
+			},
+		},
+		.prot	= PAGE_HYP,
+	};
+
+	host_lock_component();
+	hyp_lock_component();
+
+	ret = do_share(&share);
+
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.33.0.882.g93a45727a2-goog

