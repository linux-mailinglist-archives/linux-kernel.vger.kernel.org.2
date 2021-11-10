Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5F44CCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhKJWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhKJWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:33:45 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29956C06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p13-20020a63c14d000000b002da483902b1so2207040pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U0pc7GNjNaZx6eJ03QWleInOW3Gt7Fz+Qc/8LyqURhE=;
        b=px2lwMl/TZx0yUhF4SwNScmSrQAUFBznydcVGXRUwo/79hhD0xBfJ3/LE9EB545hKE
         HLfb07EwbOpxADghWPpD89GqAwaOVd9LQFKKUe4oNZzV18T0FwtJhKUpgBziskAKWqHu
         9fOTUHgSI3rik7QjveUsjqyTjKBNTeD7tTZu+zqECNEEXyTF41Bwl86wH2WTMvExAaCG
         OFAeVw+LtiyW3rdHd2FCFGLBLI8C1ik2ZQbb5jidCHAwu3kte/5rz17Fwq+usTZXmYP+
         OjwRBnMMAQI0NjT84Ipa7zkh42kIMc/dUfOxZPbUC6T5WJ2mqMxmOGRHujdULkcmYgz8
         mRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U0pc7GNjNaZx6eJ03QWleInOW3Gt7Fz+Qc/8LyqURhE=;
        b=rIiU/nE/qBCCqzGKLl4v52jAKIdHpI65+qzrB/q8jetEq0tOaGWytpvzkQAuRf+eYo
         H3CXd/HxrwiMru7ESZ63sTCjwP5QUCaCZWWGrtMDA5rMEZ6ZrKfvWDdq0mAIc22LUscp
         lcY5bjuBePZgi7TOgjXOEoLWFp9IkIzSoJJ1RvAh6VNuol0t1lrgBaS1GZj3qwo8xIdL
         C+s1BnO2N6T2W0Qm1rivGIu+yQVNZ8H3d6HUgRCsQRVAmS0RMMqYqY+gRuKvDZE83BR6
         cw9kJcniRqzsAve6Nk4wXxGA4tcxsZpgmHhMCyowo1G8MDmeBEmfH+FAQyoc+4Y1XDXP
         B7Mw==
X-Gm-Message-State: AOAM531h1ztd3tCFhtY44vCBisexG2w/6FhyLYy/2/Rnv5NotxFSbcrV
        3WdzwvBS8rxjmcMSb2iYeOq04EgLTxN4AfkvHTW2ChbJkxivzK5gE9uCGvHRCoCz4WCZ2dI6PEB
        FOZ5rfOl9cCe7Prsfgj8MKcg2nGmqHQJ/JQiXls1pwCSq6zWeKVoO/FNF4ancSDjwEqoOBG/0
X-Google-Smtp-Source: ABdhPJwpl3E6b33pF25B4V3bd+PvVjLl0XHsteOkH1O86mYcfkRiNXJAHcPrAJgqD7qqHHYZZaJtlkhNuAFC
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6586:7b2f:b259:2011])
 (user=bgardon job=sendgmr) by 2002:a17:902:c245:b0:141:f279:1c72 with SMTP id
 5-20020a170902c24500b00141f2791c72mr2462731plg.18.1636583456490; Wed, 10 Nov
 2021 14:30:56 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:30:03 -0800
In-Reply-To: <20211110223010.1392399-1-bgardon@google.com>
Message-Id: <20211110223010.1392399-13-bgardon@google.com>
Mime-Version: 1.0
References: <20211110223010.1392399-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC 12/19] KVM: x86/mmu: Replace vcpu argument with kvm pointer in make_spte
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No that nothing in make_spte actually needs the vCPU argument, just
pass in a pointer to the struct kvm. This allows the function to be used
in situations where there is no relevant struct vcpu.

No functional change intended.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/spte.c | 8 ++++----
 arch/x86/kvm/mmu/spte.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index d3b059e96c6e..d98723b14cec 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -89,7 +89,7 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 				     E820_TYPE_RAM);
 }
 
-bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+bool make_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
@@ -161,7 +161,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		 * e.g. it's write-tracked (upper-level SPs) or has one or more
 		 * shadow pages and unsync'ing pages is not allowed.
 		 */
-		if (mmu_try_to_unsync_pages(vcpu->kvm, slot, gfn, can_unsync, prefetch)) {
+		if (mmu_try_to_unsync_pages(kvm, slot, gfn, can_unsync, prefetch)) {
 			pgprintk("%s: found shadow page for %llx, marking ro\n",
 				 __func__, gfn);
 			wrprot = true;
@@ -184,7 +184,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if ((spte & PT_WRITABLE_MASK) && kvm_slot_dirty_track_enabled(slot)) {
 		/* Enforced by kvm_mmu_hugepage_adjust. */
 		WARN_ON(level > PG_LEVEL_4K);
-		mark_page_dirty_in_slot(vcpu->kvm, slot, gfn);
+		mark_page_dirty_in_slot(kvm, slot, gfn);
 	}
 
 	*new_spte = spte;
@@ -201,7 +201,7 @@ bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 						       kvm_is_mmio_pfn(pfn));
 	struct rsvd_bits_validate *shadow_zero_check = &vcpu->arch.mmu->shadow_zero_check;
 
-	return make_spte(vcpu, sp, slot, pte_access, gfn, pfn, old_spte,
+	return make_spte(vcpu->kvm, sp, slot, pte_access, gfn, pfn, old_spte,
 			 prefetch, can_unsync, host_writable,
 			 ad_need_write_protect, mt_mask, shadow_zero_check,
 			 new_spte);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 6134a10487c4..5bb055688080 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -329,7 +329,7 @@ static inline u64 get_mmio_spte_generation(u64 spte)
 	return gen;
 }
 
-bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+bool make_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
-- 
2.34.0.rc0.344.g81b53c2807-goog

