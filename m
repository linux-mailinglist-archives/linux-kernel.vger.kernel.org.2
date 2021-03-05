Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2509532DED4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCEBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:11:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 17:11:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l3so651131ybf.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uL/f26X0wR1TrSq8wwKTyq3/1XDiiBIv6kyywcEmzC0=;
        b=AE495IerCTeNJHsk14pa0aeMKLbFQ+PO39FXKuTblVreZrrosG7OhTBxjBUgnapn1Y
         rIXDLyHa0lOB8gDKaShoRKQ+sNPnP1cxr9SaJJkqjFUyZXWv/omOlHru8fgr18w6VTz8
         ujM/w9RjqXgjlVIENB0LVFJIsGFybW5gi/pG5jiP3QxlEeaesJVhl/L9jvms5hKgSvvG
         RytNg++loAv+eZhBXNExcQGwvgEdxx7xmJ/52jsuJ+S4uQK3ILpXyGlaVcSULGtYAnvE
         t7n/iOSlqbGReMjqY8IkPkfXlUd+Q8gT7y/9qvwCW4dsN1EITNcA7Jv4G6dRSZ/zs6W+
         900w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uL/f26X0wR1TrSq8wwKTyq3/1XDiiBIv6kyywcEmzC0=;
        b=VmkWJdl5EX6AkhHT1ZxnqWEADKj19qhrSkFZoO4IIyV7kfWGj8fRcy6e8n6YwfBvOy
         sCj98pQiXUtHJBui95mRVdzVhx4n6yIA/j6MBZ3z3PzIGJPTaNCX5IBrj/C5pfJmk0BG
         UAJZ6g4PbkfUBhsCgHq/Ki0HsOwI3m9IEF/C7yo8knbTzeB/wHnfQw3Ztnk/pxSFV4jz
         5g9wqdhBnJ06yRTuOlCbAsfIcAF0oqHSTNDkFeAzStfvdmY20D4zzlqU0qmTIgx+k12A
         +1RXzEm1zWAs5kIJ9Xy0NxrGEZ2J6fBFQMVfRfe/4+u5aNHLhEFlxhOns/4gjZ7foUer
         +6CQ==
X-Gm-Message-State: AOAM5323/vwItsYXZHmOhLTIiQxdSTBr//ha3PEbNC9VWxrvQbdj/xvd
        ChYwrkuqjs/KqLwrC1yKt8+a6hsUAJs=
X-Google-Smtp-Source: ABdhPJyNWE6toNEOXAP6ueAU8azUs5F2xbWvNWqjHRUkTueIkVzmEAcIL91FuaN6CZlJGgEtXSrTg0qehcE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a25:af05:: with SMTP id a5mr10817378ybh.86.1614906669696;
 Thu, 04 Mar 2021 17:11:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Mar 2021 17:10:46 -0800
In-Reply-To: <20210305011101.3597423-1-seanjc@google.com>
Message-Id: <20210305011101.3597423-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210305011101.3597423-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 02/17] KVM: x86/mmu: Alloc page for PDPTEs when shadowing
 32-bit NPT with 64-bit
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the so called pae_root page on-demand, along with the lm_root
page, when shadowing 32-bit NPT with 64-bit NPT, i.e. when running a
32-bit L1.  KVM currently only allocates the page when NPT is disabled,
or when L0 is 32-bit (using PAE paging).

Note, there is an existing memory leak involving the MMU roots, as KVM
fails to free the PAE roots on failure.  This will be addressed in a
future commit.

Fixes: ee6268ba3a68 ("KVM: x86: Skip pae_root shadow allocation if tdp enabled")
Fixes: b6b80c78af83 ("KVM: x86/mmu: Allocate PAE root array when using SVM's 32-bit NPT")
Cc: stable@vger.kernel.org
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0987cc1d53eb..2ed3fac1244e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3187,14 +3187,14 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL &&
 		    (mmu->root_level >= PT64_ROOT_4LEVEL || mmu->direct_map)) {
 			mmu_free_root_page(kvm, &mmu->root_hpa, &invalid_list);
-		} else {
+		} else if (mmu->pae_root) {
 			for (i = 0; i < 4; ++i)
 				if (mmu->pae_root[i] != 0)
 					mmu_free_root_page(kvm,
 							   &mmu->pae_root[i],
 							   &invalid_list);
-			mmu->root_hpa = INVALID_PAGE;
 		}
+		mmu->root_hpa = INVALID_PAGE;
 		mmu->root_pgd = 0;
 	}
 
@@ -3306,9 +3306,23 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
+		/*
+		 * Allocate the page for the PDPTEs when shadowing 32-bit NPT
+		 * with 64-bit only when needed.  Unlike 32-bit NPT, it doesn't
+		 * need to be in low mem.  See also lm_root below.
+		 */
+		if (!vcpu->arch.mmu->pae_root) {
+			WARN_ON_ONCE(!tdp_enabled);
+
+			vcpu->arch.mmu->pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+			if (!vcpu->arch.mmu->pae_root)
+				return -ENOMEM;
+		}
+	}
+
 	for (i = 0; i < 4; ++i) {
 		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
 		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
@@ -3331,21 +3345,19 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 
 	/*
-	 * If we shadow a 32 bit page table with a long mode page
-	 * table we enter this path.
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at MMU creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM is very rare.  The PDP is
+	 * handled above (to share logic with PAE), deal with the PML4 here.
 	 */
 	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
 		if (vcpu->arch.mmu->lm_root == NULL) {
-			/*
-			 * The additional page necessary for this is only
-			 * allocated on demand.
-			 */
-
 			u64 *lm_root;
 
 			lm_root = (void*)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (lm_root == NULL)
-				return 1;
+			if (!lm_root)
+				return -ENOMEM;
 
 			lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
 
@@ -5248,9 +5260,11 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 	 * while the PDP table is a per-vCPU construct that's allocated at MMU
 	 * creation.  When emulating 32-bit mode, cr3 is only 32 bits even on
 	 * x86_64.  Therefore we need to allocate the PDP table in the first
-	 * 4GB of memory, which happens to fit the DMA32 zone.  Except for
-	 * SVM's 32-bit NPT support, TDP paging doesn't use PAE paging and can
-	 * skip allocating the PDP table.
+	 * 4GB of memory, which happens to fit the DMA32 zone.  TDP paging
+	 * generally doesn't use PAE paging and can skip allocating the PDP
+	 * table.  The main exception, handled here, is SVM's 32-bit NPT.  The
+	 * other exception is for shadowing L1's 32-bit or PAE NPT on 64-bit
+	 * KVM; that horror is handled on-demand by mmu_alloc_shadow_roots().
 	 */
 	if (tdp_enabled && kvm_mmu_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
 		return 0;
-- 
2.30.1.766.gb4fecdf3b7-goog

