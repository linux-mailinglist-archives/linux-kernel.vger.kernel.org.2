Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0273E4335AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhJSMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbhJSMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:48 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CDC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:36 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l39-20020a05600c1d2700b0030dba1dc6eeso1068476wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ck8KqbWWMae7AkcYUcDJVvLhTKwYixox75Gde7aqwnI=;
        b=N1X0+fMmX2ELYVHNfvnYshgrGY1QPYHtzxD2UrOgV3PkeCujsVtLhyaC7O9FoW3Ppl
         P8iizGRJTkEPDqs+zvQodXLZP/nhkcLJMA3ySJ5DA+FpQO+nginrBfDiSj8Rlk/nN/fM
         N4LAy5E8anFDzGfCbnMUmYZ6lfUnSJ/2ZfVreeRN2N+0ISdPuQVD+D+UKKuv1JBaTw5r
         XqUgHq8AR/wKJDtRW06u51EP+Kn92ZF/THtMU+7kA83TRHin40ZyxcHcjiHA+Cc+vxIv
         gBtq+0o5RQNM5lgPUZIBuKx8nZQ+bZEZoDmWh2yHB1Z7soqQzthwhUMjoF9Re2+qw2Ha
         2PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ck8KqbWWMae7AkcYUcDJVvLhTKwYixox75Gde7aqwnI=;
        b=SWLyr/fuTdv1GKg2YdVGHKthfZ2hmp6v9ZW9hlb8BDuB140BTlGrjEKcg0q2ymflje
         /685wCTPtQbKGHd4HdgoxkrhX5eWvRjm6vD8inSymUyop+XoGXjDD+KhDCzTUBFxxeBO
         sOVEHhiwkuf8chhq68/7KojrsTnXgqQ4HWZZDmIDY78sb+NrNVruMLIG/TrpwiHdWKxF
         c7e+5p2bXLsxo9hSiwcpNso+JkdhFGlkFUmUw4PneMu2vcpVRJlA6ixdyQ/0rTXe22s0
         ktDBHe9i7i87L259NZHvJPiLEsJWSxhQJ3+BeiU/8S0gaW/LMBQwp1ZFGzKz7S/LHViY
         yLtg==
X-Gm-Message-State: AOAM53337/fEiZ9o4GPowFKKZqu32ue3kaI3BJRBgDqt0l35t5QSL/a0
        8EeR+tXQwNBmRThHqWe1yx9/IQws05n3
X-Google-Smtp-Source: ABdhPJwuoB1vbPKcvGKMvoxjhGJXSCqivwYwRjiSn+hagjA4deHJDWh9elWq7/kmk5iywJnzibKQqL+7r11H
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:adf:f10c:: with SMTP id
 r12mr31956400wro.298.1634645614634; Tue, 19 Oct 2021 05:13:34 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:13:01 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-13-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 12/15] KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

__pkvm_host_share_hyp() shares memory between the host and the
hypervisor so implement it as an invocation of the new do_share()
mechanism.

Note that double-sharing is no longer permitted (as this allows us to
reduce the number of page-table walks significantly), but is thankfully
no longer relied upon by the host.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 121 +++++++-------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d87cdd53dd21..ab1732c38b3b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -359,94 +359,6 @@ static int host_stage2_idmap(u64 addr)
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
-	host_lock_component();
-	hyp_lock_component();
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
-	hyp_unlock_component();
-	host_unlock_component();
-
-	return ret;
-}
-
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
@@ -697,3 +609,36 @@ static int do_share(struct pkvm_mem_share *share)
 
 	return WARN_ON(__do_share(share));
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
2.33.0.1079.g6e70778dc9-goog

