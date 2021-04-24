Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5A369DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbhDXAsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbhDXAru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:47:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3103C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p9-20020a2574090000b02904e2cb6a90e7so26400291ybc.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=eLXITIaRSuUPT8nfK0P77aCKjNJeDULPyebo6963mgA=;
        b=D01Z2nQvrqvPGM2+TMi1fDQ40FrBs4SoH9NdPjhrjuAk39IioVMxoDDE8TIoyEfPty
         ZC4AXMSXhuDPcIQSSiD7a2b3FZz4MZHmLyygGcs7fxOIJyDI4Pj8zQuJ3Y1zhh+Ry4KD
         CFS60tnES5yM1Qi02DdBwBZDKSh7wbviijj648HM2ATHBO5vCKcoMc85THK32jgAaO5w
         19f7NAhS94vaL3rdmyC0i5tBcQ13w0abEnJ5oSLx+ixsSbgiIggrZcpFiaU+W9JL8kET
         jqdVrgvoMMKpiiuMo5VecgzQAIcNplDmDi6y6rNeYzcRXdlCVxdV/ZHN/bdOu+1XG69A
         GV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=eLXITIaRSuUPT8nfK0P77aCKjNJeDULPyebo6963mgA=;
        b=sH0X39m/cURGqteGSLN7Fb4SBMW0/dXxcVifKy8JpcAQVel3VSHKyMEEXCe9MWCeF9
         Cy2dvo53xYOpeYPEuBnaOQiIKvRUrZR8vJLSOSIXOIRj+f/DxZABWFEwY0KEgA/VtOS2
         k8yG3hg70LtUDvHH7W8af0u4oG6dkk8davLWsZnYtgO3O3pYkvDn9XXy/CK44ie77HOc
         zOmAOdjVZ1axQJu8RYzGBX8dFBrWxcbxYwU1JxH78aHpMJiCHCmJSi3EkdyOEDyIYOsM
         1rnk/889+IUBbUJeC6A1jTIAjUMQ5HNoeoCLry/wQcWKzIwj6p6aNz93eEuznJsOJosP
         Emeg==
X-Gm-Message-State: AOAM532OwfNXSgvGG6XKRB084mN8Fw219c/9j8HyUaIk4TbFN85Y61A6
        JWlC8suzhUjOf3JLWPyv3lSwtVTaBVE=
X-Google-Smtp-Source: ABdhPJygFq/wAwVEmmGyNGHD6tEd0pB/Sve3VonZlYrccyTtdRzzfTv52tPrSXGNwozvRoNleeRkSmZptgY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a5b:ed2:: with SMTP id a18mr9410758ybs.466.1619225231008;
 Fri, 23 Apr 2021 17:47:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:07 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 05/43] KVM: x86: Split out CR0/CR4 MMU role change detectors
 to separate helpers
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

Split out the post-CR0/CR4 MMU role change detectors to separate helpers,
they will be used during vCPU RESET/INIT to conditionally reset the MMU
in a future patch.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3bf52ba5f2bb..0bc783fc6c9b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -823,16 +823,21 @@ bool pdptrs_changed(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(pdptrs_changed);
 
+static bool kvm_cr0_mmu_role_changed(unsigned long old_cr0, unsigned long cr0)
+{
+	unsigned long mmu_role_bits = X86_CR0_PG | X86_CR0_WP;
+
+	return (cr0 ^ old_cr0) & mmu_role_bits;
+}
+
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
-	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
-
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
 	}
 
-	if ((cr0 ^ old_cr0) & update_bits)
+	if (kvm_cr0_mmu_role_changed(old_cr0, cr0))
 		kvm_mmu_reset_context(vcpu);
 
 	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
@@ -1009,13 +1014,18 @@ bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 }
 EXPORT_SYMBOL_GPL(kvm_is_valid_cr4);
 
-void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
+static bool kvm_cr4_mmu_role_changed(unsigned long old_cr4, unsigned long cr4)
 {
 	unsigned long mmu_role_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
 				      X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE;
 
-	if (((cr4 ^ old_cr4) & mmu_role_bits) ||
-	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
+	return (((cr4 ^ old_cr4) & mmu_role_bits) ||
+	       (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)));
+}
+
+void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
+{
+	if (kvm_cr4_mmu_role_changed(old_cr4, cr4))
 		kvm_mmu_reset_context(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
-- 
2.31.1.498.g6c1eba8ee3d-goog

