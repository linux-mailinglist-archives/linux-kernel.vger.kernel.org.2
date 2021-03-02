Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D116E32AD7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837780AbhCBV6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581629AbhCBTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:00:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E63C061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:45:59 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id g18so7495630qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xSeBS7Kkuswt1KbMfW4UczMoQ+fxzPvhhz5Kktd9Pv0=;
        b=YUxL4pYACB8SQ3QzMqoxEsPYOaUy16pHdcAVDxMDQfIzuizatcQ8GzpfhI8eXsDb63
         NADj9FSNeN27FxGFguuHLUI+HmvBOp3Su47bqhl1LK45RdU9SWj4T3KxFOMp9h/DkyNX
         l3NHkgOaHDcoZMImZFOBRObMOmkcT0WoJLROuTqwrS7qOuqyzUfjYQ7pQNR7k6FRAdD3
         ZMvMwpkTx3tskoHMwaFpdfvL8zaWpXXy52K857z5n4sxkC2qVgbNnZ+jH1pWlRJ/Opxn
         SduuuqU1Umn5RvBjPDLAFOAXu7Dx8gkxVZGOpEse15hfhk6bD5vd0yv7EgWyOpu+Bjsb
         +vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xSeBS7Kkuswt1KbMfW4UczMoQ+fxzPvhhz5Kktd9Pv0=;
        b=K3Sy5mF4GsgTpYdVqOhhzDI58jM5WCMGsPbE1OYFVnNi4l8Nr6UzREyeka/W9uo70A
         8meIBFazOoeke2DxJiEtcagwc8f6mgIdCM+d7bFpjuKOcoUOVsxd3OmH0CZfzij0k56x
         PG0panjRajXNjOVhiTxyH4ridFMD6kZ42jvNPq33fPnhaY5BoDTsAehO9SSp8bGh4SB+
         R7kcV4sqjIMjfnJ2sxgIzYkeaP9QpA+MtoPM/NcYP7Zlq4jF3vl/M+yxuktqwDuD9P/D
         jvIjjpIo9sSizup5opDLJg+vJ24wIAUqyZJzPq9EIAHVzF5iVq6RTPOOtaPZGhbs9YET
         3BGA==
X-Gm-Message-State: AOAM531rtiiNnF/oY+L3g1AGlMmRz500DECv1orni59jzzv2LrjftPXO
        cXKeKaH5dkh1UHVs++/Pp7BKr40j6Fw=
X-Google-Smtp-Source: ABdhPJw8xbuyNh4DfpQ3wgjXW+zW+ZzUIgplHu54WbdcY1+OcDQ8ex7kSdNUsQKBPIVmB3+nw0Fmh/TIPQg=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a0c:9148:: with SMTP id q66mr21367972qvq.0.1614710758535;
 Tue, 02 Mar 2021 10:45:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:30 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 05/15] KVM: x86/mmu: Check PDPTRs before allocating PAE roots
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

Check the validity of the PDPTRs before allocating any of the PAE roots,
otherwise a bad PDPTR will cause KVM to leak any previously allocated
roots.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e5c3701112f8..aa20e8d32197 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3262,7 +3262,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
-	u64 pdptr, pm_mask;
+	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
 	hpa_t root;
 	int i;
@@ -3273,6 +3273,17 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	if (mmu_check_root(vcpu, root_gfn))
 		return 1;
 
+	if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
+		for (i = 0; i < 4; ++i) {
+			pdptrs[i] = vcpu->arch.mmu->get_pdptr(vcpu, i);
+			if (!(pdptrs[i] & PT_PRESENT_MASK))
+				continue;
+
+			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
+				return 1;
+		}
+	}
+
 	/*
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
@@ -3331,14 +3342,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
 
 		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
-			pdptr = vcpu->arch.mmu->get_pdptr(vcpu, i);
-			if (!(pdptr & PT_PRESENT_MASK)) {
+			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
 				vcpu->arch.mmu->pae_root[i] = 0;
 				continue;
 			}
-			root_gfn = pdptr >> PAGE_SHIFT;
-			if (mmu_check_root(vcpu, root_gfn))
-				return 1;
+			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-- 
2.30.1.766.gb4fecdf3b7-goog

