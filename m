Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3132AD6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837550AbhCBV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581589AbhCBS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:59:15 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABBC061221
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:45:57 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o20so13824776qtx.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=J9+GlmlwlBYdlrT0JTLp/uAtDmX9L8zEya3ghwKZEGA=;
        b=tvhcBBrrgkXavFJY5bBbzP2Swe8VNCGt80pZSYzvqr/EHh9fliGx+4IlE5/Sqg1Trc
         RnOQGU9NdBkDWFhCVBAzRPTkNuL6KSpC09x9eQ76nXYJUGk+JIX/Cuc3wCQ6wtWCvfDD
         kW0i+57Xyo6UxAblgdxIxlY1Kf8qb67lVRvfdqlUcE873nmJcVr5b55CC6khTdGjDbZS
         hNPFkE9EMDBO+v0R8WflmgywQakD3cdXOvq9gn4JOd3hmvvhOI+ZFt8DnHA+g4qs0Pu2
         NyGB2JarvZhjg2q5/61DLyUCelQdybWVkc866tUIZE2elNp6xPW1bN+/fB7eMlxy/Ph5
         NyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=J9+GlmlwlBYdlrT0JTLp/uAtDmX9L8zEya3ghwKZEGA=;
        b=OZk5NiHnaPI+GEZQh3GlkxJJQTUTs4ZRBY3w/+wRngF4RiqmcGyDBfilu3tP1RgQln
         W6sZJ6+2CVYoVhbm6cVrvIkYd324kAxRWTKZMPuUcjcdYG6MG0WK8yzFjFskHiFQlbQJ
         out0AKkALtkke9OWFvAIxiqAZmf1T3oFuM5/lt5DexjBF08PMiVrX+cJF0F5yNjDzh6Q
         8BfuJ9xDcU+hTMlc7eyyqO8u0kc0pk3Qd+HUx/bM2389SSzv88EK8hlPgBGqWXiB30Vn
         ADGfnoMb5BDALLj0owRQyZwVpvP9LLll/F/c2sSKFSgR8KqL30Hf73lDJN3CF1Cbv8bG
         Cvdw==
X-Gm-Message-State: AOAM530MwJ8ossa3HdbSl1iLpyoY4+4W1ZSQSO8qtm3A/prW8Taae/Yh
        /LPIosHV7OB7fg50K8XA+6JNJZpGnHE=
X-Google-Smtp-Source: ABdhPJxx3HS/5Rnb3Lb6mt6u5vJ+ymSDXuni5FaZ477WaCV+KwPK5g/CwhAbVJjcWEa/FwlcoAHADyZkDbQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a0c:b509:: with SMTP id d9mr4749962qve.29.1614710756204;
 Tue, 02 Mar 2021 10:45:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:29 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 04/15] KVM: x86/mmu: Allocate the lm_root before allocating
 PAE roots
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

Allocate lm_root before the PAE roots so that the PAE roots aren't
leaked if the memory allocation for the lm_root happens to fail.

Note, KVM can _still_ leak PAE roots if mmu_check_root() fails on a
guest's PDPTR.  That too will be fixed in a future commit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 65 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1f129001a30c..e5c3701112f8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3292,21 +3292,39 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
-		/*
-		 * Allocate the page for the PDPTEs when shadowing 32-bit NPT
-		 * with 64-bit only when needed.  Unlike 32-bit NPT, it doesn't
-		 * need to be in low mem.  See also lm_root below.
-		 */
-		if (!vcpu->arch.mmu->pae_root) {
-			WARN_ON_ONCE(!tdp_enabled);
+	/*
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at root creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM is very rare.  Unlike 32-bit
+	 * NPT, the PDP table doesn't need to be in low mem.  Preallocate the
+	 * pages so that the PAE roots aren't leaked on failure.
+	 */
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL &&
+	    (!vcpu->arch.mmu->pae_root || !vcpu->arch.mmu->lm_root)) {
+		u64 *lm_root, *pae_root;
 
-			vcpu->arch.mmu->pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (!vcpu->arch.mmu->pae_root)
-				return -ENOMEM;
+		if (WARN_ON_ONCE(!tdp_enabled || vcpu->arch.mmu->pae_root ||
+				 vcpu->arch.mmu->lm_root))
+			return -EIO;
+
+		pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		if (!pae_root)
+			return -ENOMEM;
+
+		lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		if (!lm_root) {
+			free_page((unsigned long)pae_root);
+			return -ENOMEM;
 		}
+
+		vcpu->arch.mmu->pae_root = pae_root;
+		vcpu->arch.mmu->lm_root = lm_root;
+
+		lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
 	}
 
 	for (i = 0; i < 4; ++i) {
@@ -3327,30 +3345,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				      PT32_ROOT_LEVEL, false);
 		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
 	}
-	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
-
-	/*
-	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
-	 * tables are allocated and initialized at MMU creation as there is no
-	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
-	 * on demand, as running a 32-bit L1 VMM is very rare.  The PDP is
-	 * handled above (to share logic with PAE), deal with the PML4 here.
-	 */
-	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
-		if (vcpu->arch.mmu->lm_root == NULL) {
-			u64 *lm_root;
-
-			lm_root = (void*)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (!lm_root)
-				return -ENOMEM;
-
-			lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
-
-			vcpu->arch.mmu->lm_root = lm_root;
-		}
 
+	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
-	}
+	else
+		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 
 set_root_pgd:
 	vcpu->arch.mmu->root_pgd = root_pgd;
-- 
2.30.1.766.gb4fecdf3b7-goog

