Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E289433A85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhJSPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhJSPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:34:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E97C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:32:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so153209pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Mw4K6UWNDcNnRdtVBwJD7bp/RgWcL/FwDzp2EWsIN8=;
        b=PZvNKSyxg7o7YZZyxxUXprkYyw3STxnK3f6yxC6LDaQ5kcAoMucdRWVTMgD9neVEDo
         ofBmOOiqRDjVOgI7rQ724XVt9Wy04DiSD8uVqNXe+OGAGepGRkVVh1+MBSelICzI8cVV
         8EQU3fW8ZdGf+eXMr779bF90VXMlRDP/zieh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Mw4K6UWNDcNnRdtVBwJD7bp/RgWcL/FwDzp2EWsIN8=;
        b=XEDaMUM43I8rzdJqtkROr0ZvMWltnDBdmN5rNObWdh7d1JT0QCZERfNcjKzPxstUIP
         e7pnph4E8WRK3+6r/kqHbFKA8NLqXgx0hFFn05/u35C/EIVnhG7DXYZjmq46bznIIZUs
         /HcPJoM+EsFqy3p3eqomHoZ9KM0N5H6hmkiK9TYuNcZP+jpro4zlYrxQmEaGRCpQaG8q
         o9/3NdCTXhsgCKgQEesu6a/9jGEeE8PVsq+P/QftS2OV5ddBdI186c2EoZA4RjR8FqDu
         5cu4/+7s77j83qOidHVFS39A90EUQM1k18gMOwF6K+Sq455UcfqhKxjO/sASqN27US+J
         6YKg==
X-Gm-Message-State: AOAM532W1GVWDMv6TuqenIm7emQmpwE3Sve92T0A+jjP2mGbP7fJRpaE
        RN88BRG6nY3Jhp2JJ/AqqZkdGQ==
X-Google-Smtp-Source: ABdhPJyKwDUt2EF/9MuwY+yKmSyn/kIsNyWk1YmPbIR/M/tVEv+y/o5uZI33iA1o688OOCpTcWYOPA==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr642040pjd.35.1634657552736;
        Tue, 19 Oct 2021 08:32:32 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:490f:f89:7449:e615])
        by smtp.gmail.com with ESMTPSA id v8sm3087474pjd.7.2021.10.19.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:32:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHV2 2/3] KVM: x86: use mmu_pte_prefetch for guest_walker
Date:   Wed, 20 Oct 2021 00:32:13 +0900
Message-Id: <20211019153214.109519-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211019153214.109519-1-senozhatsky@chromium.org>
References: <20211019153214.109519-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use fixed size PTE array for prefetch, but switch to
mmu_pte_prefetch cached entries array for PTEs prefetch.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c         |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h | 39 +++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fed3a498a729..3eb034ffbe58 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2788,7 +2788,6 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
 
 	WARN_ON(!sp->role.direct);
 
-	spin_lock(&vcpu->arch.mmu_pte_prefetch.lock);
 	pte_prefetch_num = vcpu->arch.mmu_pte_prefetch.num_ents;
 	i = (sptep - sp->spt) & ~(pte_prefetch_num - 1);
 	spte = sp->spt + i;
@@ -2805,7 +2804,6 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
 	}
 	if (start)
 		direct_pte_prefetch_many(vcpu, sp, start, spte);
-	spin_unlock(&vcpu->arch.mmu_pte_prefetch.lock);
 }
 
 static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
@@ -2832,7 +2830,9 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	if (unlikely(vcpu->kvm->mmu_notifier_count))
 		return;
 
+	spin_lock(&vcpu->arch.mmu_pte_prefetch.lock);
 	__direct_pte_prefetch(vcpu, sp, sptep);
+	spin_unlock(&vcpu->arch.mmu_pte_prefetch.lock);
 }
 
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d8889e02c4b7..6a0924261d81 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -86,7 +86,6 @@ struct guest_walker {
 	unsigned max_level;
 	gfn_t table_gfn[PT_MAX_FULL_LEVELS];
 	pt_element_t ptes[PT_MAX_FULL_LEVELS];
-	pt_element_t prefetch_ptes[PTE_PREFETCH_NUM];
 	gpa_t pte_gpa[PT_MAX_FULL_LEVELS];
 	pt_element_t __user *ptep_user[PT_MAX_FULL_LEVELS];
 	bool pte_writable[PT_MAX_FULL_LEVELS];
@@ -592,23 +591,30 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 static bool FNAME(gpte_changed)(struct kvm_vcpu *vcpu,
 				struct guest_walker *gw, int level)
 {
+	pt_element_t *prefetch_ptes;
 	pt_element_t curr_pte;
 	gpa_t base_gpa, pte_gpa = gw->pte_gpa[level - 1];
-	u64 mask;
+	u32 pte_prefetch_num;
+	u64 len;
 	int r, index;
 
+	spin_lock(&vcpu->arch.mmu_pte_prefetch.lock);
+	prefetch_ptes = (pt_element_t *)vcpu->arch.mmu_pte_prefetch.ents;
+	pte_prefetch_num = vcpu->arch.mmu_pte_prefetch.num_ents;
+
 	if (level == PG_LEVEL_4K) {
-		mask = PTE_PREFETCH_NUM * sizeof(pt_element_t) - 1;
-		base_gpa = pte_gpa & ~mask;
+		len = pte_prefetch_num * sizeof(pt_element_t);
+		base_gpa = pte_gpa & ~(len - 1);
 		index = (pte_gpa - base_gpa) / sizeof(pt_element_t);
 
-		r = kvm_vcpu_read_guest_atomic(vcpu, base_gpa,
-				gw->prefetch_ptes, sizeof(gw->prefetch_ptes));
-		curr_pte = gw->prefetch_ptes[index];
+		r = kvm_vcpu_read_guest_atomic(vcpu, base_gpa, prefetch_ptes,
+					       len);
+		curr_pte = prefetch_ptes[index];
 	} else
 		r = kvm_vcpu_read_guest_atomic(vcpu, pte_gpa,
 				  &curr_pte, sizeof(curr_pte));
 
+	spin_unlock(&vcpu->arch.mmu_pte_prefetch.lock);
 	return r || curr_pte != gw->ptes[level - 1];
 }
 
@@ -616,7 +622,8 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 				u64 *sptep)
 {
 	struct kvm_mmu_page *sp;
-	pt_element_t *gptep = gw->prefetch_ptes;
+	u32 pte_prefetch_num;
+	pt_element_t *gptep;
 	u64 *spte;
 	int i;
 
@@ -632,13 +639,19 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 	if (unlikely(vcpu->kvm->mmu_notifier_count))
 		return;
 
-	if (sp->role.direct)
-		return __direct_pte_prefetch(vcpu, sp, sptep);
+	spin_lock(&vcpu->arch.mmu_pte_prefetch.lock);
+	gptep = (pt_element_t *)vcpu->arch.mmu_pte_prefetch.ents;
+	pte_prefetch_num = vcpu->arch.mmu_pte_prefetch.num_ents;
+
+	if (sp->role.direct) {
+		__direct_pte_prefetch(vcpu, sp, sptep);
+		goto out;
+	}
 
-	i = (sptep - sp->spt) & ~(PTE_PREFETCH_NUM - 1);
+	i = (sptep - sp->spt) & ~(pte_prefetch_num - 1);
 	spte = sp->spt + i;
 
-	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
+	for (i = 0; i < pte_prefetch_num; i++, spte++) {
 		if (spte == sptep)
 			continue;
 
@@ -648,6 +661,8 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 		if (!FNAME(prefetch_gpte)(vcpu, sp, spte, gptep[i], true))
 			break;
 	}
+out:
+	spin_unlock(&vcpu->arch.mmu_pte_prefetch.lock);
 }
 
 /*
-- 
2.33.0.1079.g6e70778dc9-goog

