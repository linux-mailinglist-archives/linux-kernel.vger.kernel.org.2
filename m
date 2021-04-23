Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793093689A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhDWAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhDWAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:07:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC010C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so10430671ybn.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IGXfwfXD78G9Ehh8nz9VOrnaPh2MN+c9PGYDs1kjN3Y=;
        b=bv/Un5aPqGBWb/OBgRH9+bb3UargdwBWqSNVY+wLxsX41UKwlKwv8hCx7ggQJ5PQAZ
         NXi/SQT4HMLTFNBLaJHJ7jCS+nPR1fRemFYLJlPqAzf+xNjr5cj4Vhaw1jWDEaJeywM1
         zXE1mrN3CmaRgElOP3MEvfvjrp4QGXTroDLE16bQ4UpEBkpR3CHPzP/XIWM7Ed33r+SK
         6z8qF8eFpFqsTcz1kx+COIjIAOgzemB4j3WAaRgoa+R9E+2PQ1625OAQ7O44tptOUdqR
         uTw27GDumL444ME2yhdtr+PzpvcuWPQHIGD+D74aXwvYyTQVbydtG+TvBWjfZ8xFs/SI
         rQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IGXfwfXD78G9Ehh8nz9VOrnaPh2MN+c9PGYDs1kjN3Y=;
        b=UK6/qXeBKHOz1QeRFunD7x+CWY5YG7a4yMZlqZnkxCrzapJNOqMALfHGq4d78tlxaj
         DYj9adpUIzCN/SPcjRn+IRxjCK0qJ0+L4bxg8aJTOYWt9P4TqPlzPLuIl2rbsyh7qp94
         q6WjhNIlDocYVKXu0yaLJt9U+G9jpsQ6FXEcFtLK4PtebXVE7i7LHRvn/GnLuFt9OHVG
         Dqfpwmusl9CAsQvmZCdWVOf3Q0/DZT+QvbwgkZqYsNazqUAveFXU5RhB/nrugDcn6w+u
         7kBC1pv0fOW1HLRIwx3rNzjS6K8Ghdet/DIhnU+wE8C0R3eFDjxOtDdHQ1ld8OJFgxb+
         hDHw==
X-Gm-Message-State: AOAM532aWurx7siXOXqtPDtgJ20o07heFPfVe0RwVTr7Yl81hyJQNpQR
        ivfdVoO+1a2vlzuZWpsTh5UtnmZnsKc=
X-Google-Smtp-Source: ABdhPJyWh3H8mbwN66UAycr7VAov5SVM1XKiDeNiu+aEWquKgyO5ry6R4f49378qTqHyaDAg9LAwjcTRSv0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:8302:: with SMTP id s2mr1880980ybk.290.1619136407233;
 Thu, 22 Apr 2021 17:06:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 22 Apr 2021 17:06:36 -0700
In-Reply-To: <20210423000637.3692951-1-seanjc@google.com>
Message-Id: <20210423000637.3692951-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210423000637.3692951-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 3/4] KVM: x86: Always load PDPTRs on CR3 load for SVM w/o NPT
 and a PAE guest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill off pdptrs_changed() and instead go through the full kvm_set_cr3()
for PAE guest, even if the new CR3 is the same as the current CR3.  For
VMX, and SVM with NPT enabled, the PDPTRs are unconditionally marked as
unavailable after VM-Exit, i.e. the optimization is dead code except for
SVM without NPT.

In the unlikely scenario that anyone cares about SVM without NPT _and_ a
PAE guest, they've got bigger problems if their guest is loading the same
CR3 so frequently that the performance of kvm_set_cr3() is notable,
especially since KVM's fast PGD switching means reloading the same CR3
does not require a full rebuild.  Given that PAE and PCID are mutually
exclusive, i.e. a sync and flush are guaranteed in any case, the actual
benefits of the pdptrs_changed() optimization are marginal at best.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 34 ++-------------------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e5fc80a35c8..30e95c52769c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1475,7 +1475,6 @@ unsigned long kvm_mmu_calculate_default_mmu_pages(struct kvm *kvm);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
 
 int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3);
-bool pdptrs_changed(struct kvm_vcpu *vcpu);
 
 int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
 			  const void *val, int bytes);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3bf52ba5f2bb..d099d6e54a6f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -751,13 +751,6 @@ int kvm_read_guest_page_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_page_mmu);
 
-static int kvm_read_nested_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
-			       void *data, int offset, int len, u32 access)
-{
-	return kvm_read_guest_page_mmu(vcpu, vcpu->arch.walk_mmu, gfn,
-				       data, offset, len, access);
-}
-
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
@@ -799,30 +792,6 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 }
 EXPORT_SYMBOL_GPL(load_pdptrs);
 
-bool pdptrs_changed(struct kvm_vcpu *vcpu)
-{
-	u64 pdpte[ARRAY_SIZE(vcpu->arch.walk_mmu->pdptrs)];
-	int offset;
-	gfn_t gfn;
-	int r;
-
-	if (!is_pae_paging(vcpu))
-		return false;
-
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_PDPTR))
-		return true;
-
-	gfn = (kvm_read_cr3(vcpu) & 0xffffffe0ul) >> PAGE_SHIFT;
-	offset = (kvm_read_cr3(vcpu) & 0xffffffe0ul) & (PAGE_SIZE - 1);
-	r = kvm_read_nested_guest_page(vcpu, gfn, pdpte, offset, sizeof(pdpte),
-				       PFERR_USER_MASK | PFERR_WRITE_MASK);
-	if (r < 0)
-		return true;
-
-	return memcmp(pdpte, vcpu->arch.walk_mmu->pdptrs, sizeof(pdpte)) != 0;
-}
-EXPORT_SYMBOL_GPL(pdptrs_changed);
-
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
 	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
@@ -1069,7 +1038,8 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	}
 #endif
 
-	if (cr3 == kvm_read_cr3(vcpu) && !pdptrs_changed(vcpu)) {
+	/* PDPTRs are always reloaded for PAE paging. */
+	if (cr3 == kvm_read_cr3(vcpu) && !is_pae_paging(vcpu)) {
 		if (!skip_tlb_flush) {
 			kvm_mmu_sync_roots(vcpu);
 			kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

