Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AB32DEDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhCEBLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCEBLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:11:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 17:11:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a63so705441yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 17:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uZuqwsLALY1krY1iXlnTM3rA9YU0G849FI8TdMR67Z0=;
        b=QO27+GC7V/SOoob94kAg8EzDLZtMrtUSl4gVWNlEJ9QksMRFESE6lxfb0CkyNkry37
         n2q6GNCkslt23PHWi8uKOOVqjTw5hwquV702w9orhoHo94MZfQ0eMUHnZfZ28uEvMCpJ
         fBK7UyF/rXd+EfATU750RDdEgKy2qid0nyZBLruEmbR6J43YqziuFi8p0vVsDESuXPmD
         3Kxh/uPlMyxqxQcNrvf0jCCrEl+ypLDWggJiF5xX99mv/z77ns+iwd340WIvzqiwXfFB
         YQNsMjYWNbfZKYqNn0SAUQ1GIaOGvg2KNDrYKR3s3aOZfGD1uhleuWbljE9UlGoUdAdJ
         1SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uZuqwsLALY1krY1iXlnTM3rA9YU0G849FI8TdMR67Z0=;
        b=mPiQmv0JW6eS6HFODpWfUwDAfWkUKFBlcah8GlBSSd16z4/vGeFKYOv26Wdai49X0n
         X8B9TSM9CbW5PqKKcZ/RMNWSDzaVi2iuT3mB4Rlj2pralLJLWmpIFkyqaH90noBN3jTB
         Tb+LeH9+1rHeZGF5npwBDeDhq4A+GstXUO60RZKtTLzImZCZmRbhMCSDpZhsJaDLQ8s5
         JT3sFuTjXRaSiSW9axw57d88MitNgyZCerROpBI5Y/RrSKPoYTYhq+Qb2Fmm6Yq2MVVO
         AVUrarqYtXKwKbCQOiGj2WP8Dg+ZwFE/q9qS2Li86Bv498wBeu2CS1ML/F89qSpyVLXF
         mbKg==
X-Gm-Message-State: AOAM530Emu/xpd286ybqiPi4h18LQb5B3xE1nxRLUOwaEiEHGUZzMD1E
        5WdVcLaoCVm8/vgRen6zUGFVyrAO5Dg=
X-Google-Smtp-Source: ABdhPJz9ZIBpw9QvlfCDj4hr0bOdja6zM4RuTgfwg5vgqcGbctm9kwXDTuXA/OgYvGqNSkPQJIL4HAvs6hk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a25:bec4:: with SMTP id k4mr10144083ybm.104.1614906677970;
 Thu, 04 Mar 2021 17:11:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Mar 2021 17:10:49 -0800
In-Reply-To: <20210305011101.3597423-1-seanjc@google.com>
Message-Id: <20210305011101.3597423-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210305011101.3597423-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 05/17] KVM: x86/mmu: Allocate pae_root and lm_root pages in
 dedicated helper
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

Move the on-demand allocation of the pae_root and lm_root pages, used by
nested NPT for 32-bit L1s, into a separate helper.  This will allow a
future patch to hold mmu_lock while allocating the non-special roots so
that make_mmu_pages_available() can be checked once at the start of root
allocation, and thus avoid having to deal with failure in the middle of
root allocation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 84 +++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7cb5fb5d2d4d..dd9d5cc13a46 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3308,38 +3308,10 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL)
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
-	/*
-	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
-	 * tables are allocated and initialized at root creation as there is no
-	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
-	 * on demand, as running a 32-bit L1 VMM is very rare.  Unlike 32-bit
-	 * NPT, the PDP table doesn't need to be in low mem.  Preallocate the
-	 * pages so that the PAE roots aren't leaked on failure.
-	 */
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL &&
-	    (!mmu->pae_root || !mmu->lm_root)) {
-		u64 *lm_root, *pae_root;
-
-		if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->lm_root))
-			return -EIO;
-
-		pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-		if (!pae_root)
-			return -ENOMEM;
-
-		lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-		if (!lm_root) {
-			free_page((unsigned long)pae_root);
-			return -ENOMEM;
-		}
-
-		mmu->pae_root = pae_root;
-		mmu->lm_root = lm_root;
-
-		lm_root[0] = __pa(mmu->pae_root) | pm_mask;
+		mmu->lm_root[0] = __pa(mmu->pae_root) | pm_mask;
 	}
 
 	for (i = 0; i < 4; ++i) {
@@ -3373,6 +3345,55 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u64 *lm_root, *pae_root;
+
+	/*
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at root creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
+	 */
+	if (mmu->direct_map || mmu->root_level >= PT64_ROOT_4LEVEL ||
+	    mmu->shadow_root_level < PT64_ROOT_4LEVEL)
+		return 0;
+
+	/*
+	 * This mess only works with 4-level paging and needs to be updated to
+	 * work with 5-level paging.
+	 */
+	if (WARN_ON_ONCE(mmu->shadow_root_level != PT64_ROOT_4LEVEL))
+		return -EIO;
+
+	if (mmu->pae_root && mmu->lm_root)
+		return 0;
+
+	/*
+	 * The special roots should always be allocated in concert.  Yell and
+	 * bail if KVM ends up in a state where only one of the roots is valid.
+	 */
+	if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->lm_root))
+		return -EIO;
+
+	/* Unlike 32-bit NPT, the PDP table doesn't need to be in low mem. */
+	pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!pae_root)
+		return -ENOMEM;
+
+	lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!lm_root) {
+		free_page((unsigned long)pae_root);
+		return -ENOMEM;
+	}
+
+	mmu->pae_root = pae_root;
+	mmu->lm_root = lm_root;
+
+	return 0;
+}
+
 static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mmu->direct_map)
@@ -4820,6 +4841,9 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	int r;
 
 	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
+	if (r)
+		goto out;
+	r = mmu_alloc_special_roots(vcpu);
 	if (r)
 		goto out;
 	r = mmu_alloc_roots(vcpu);
-- 
2.30.1.766.gb4fecdf3b7-goog

