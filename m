Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C33C74C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhGMQhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhGMQhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:37:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85CCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:08 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z6-20020a05622a0606b029025368c044d9so8586497qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=W278OFdK/P/bNFpq0Bb1OSbV6D8FalgDucUvoRZi8RY=;
        b=gCgBVGbHo73p6nEJ4i0JrquqLSNvkwfArAZEZi51w/FOuHl22eFS3N9ImBvFd/wizJ
         4MSic2vK7XjZNoMyVNMLEEGLAPwg0YecQAEEYhC3SFIC3ut0A0+sT3W31Uu//Ycaongz
         gPOeB9d7tgg50J7Axm5OpgxtjQYFPM+W2RSrKYZNbJ/JHJkkgz4HLEnvcX/YztiuiwOI
         blOCCnayoP5Wq9QLoQAY+O9Ktl/tC/3NFZw4WWXV86NlhbtJeixsIhrC/J5r2QuqVSDC
         rXAkBSkDf4K3x9TWnIUE1u9Lv5u526aBkM8iLsv8dhPfT73SaZ37h3THsBUsAteGAUi3
         xX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=W278OFdK/P/bNFpq0Bb1OSbV6D8FalgDucUvoRZi8RY=;
        b=Sy+joPtuU1rB7quFHS3CB1NF4iyznb2p7n8aXp1JVcXNk24O+2VqowQD4KhdHyyJtT
         2aes3i8DB6v2goU7uYwS2YiZfYoyAVsc4twfENcT67lRkGr5AHC3fQyURyDw2z+liuHO
         lO0WsNdCY8VGYc2S+nYbGwB3jr2nwdYrOqRpwEKCOBQEaogNTdiMz0Cb6qY6GEmtDZNl
         FDKnE1Fa+SqUQ5pljM6nDH+PC21jNsWt/qvdhsznHf8s49Ka6xkeYt9/SUV0h4+HflEN
         61URP/oUpN5JmYQ3oesmsiUV9pZS8FaEGMJrXSVMkv7qrwjUifbBtXRRdBSWmAsZnv71
         yCmQ==
X-Gm-Message-State: AOAM531YSYQi1L/cnkT03CEG8mM4VJ2gRZJOHuGnF+jLgyfbByOIPJXY
        cbZp/Y+hqeQVCowN2TdPYu18E7VmyXA=
X-Google-Smtp-Source: ABdhPJzQxKY8FMJLMHKrBNfxNicKU/xgg+E8+T+bUXp6E5XFpnGiGnGsZEMWXFBEbVq4NfVdCVOAhO/+0wg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:dce:: with SMTP id
 14mr5690015qvt.40.1626194047885; Tue, 13 Jul 2021 09:34:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:56 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-19-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 18/46] KVM: x86: Consolidate APIC base RESET initialization code
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the APIC base RESET logic, which is currently spread out
across both x86 and vendor code.  For an in-kernel APIC, the vendor code
is redundant.  But for a userspace APIC, KVM relies on the vendor code
to initialize vcpu->arch.apic_base.  Hoist the vcpu->arch.apic_base
initialization above the !apic check so that it applies to both flavors
of APIC emulation, and delete the vendor code.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c   | 14 ++++++++------
 arch/x86/kvm/svm/svm.c |  6 ------
 arch/x86/kvm/vmx/vmx.c |  7 -------
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 295a9d02a9a5..76fb00921203 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2323,18 +2323,20 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	int i;
 
-	if (!apic)
-		return;
-
-	/* Stop the timer in case it's a reset to an active apic */
-	hrtimer_cancel(&apic->lapic_timer.timer);
-
 	if (!init_event) {
 		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 				       MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
 			vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
+	}
 
+	if (!apic)
+		return;
+
+	/* Stop the timer in case it's a reset to an active apic */
+	hrtimer_cancel(&apic->lapic_timer.timer);
+
+	if (!init_event) {
 		apic->base_address = APIC_DEFAULT_PHYS_BASE;
 
 		kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cef9520fe77f..f7486b1645de 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1349,12 +1349,6 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	svm->spec_ctrl = 0;
 	svm->virt_spec_ctrl = 0;
 
-	if (!init_event) {
-		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
-				       MSR_IA32_APICBASE_ENABLE;
-		if (kvm_vcpu_is_reset_bsp(vcpu))
-			vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
-	}
 	init_vmcb(vcpu);
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6cc389ec697..ff82c05b948b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4406,13 +4406,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vmx->hv_deadline_tsc = -1;
 	kvm_set_cr8(vcpu, 0);
 
-	if (!init_event) {
-		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
-				       MSR_IA32_APICBASE_ENABLE;
-		if (kvm_vcpu_is_reset_bsp(vcpu))
-			vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
-	}
-
 	vmx_segment_cache_clear(vmx);
 
 	seg_setup(VCPU_SREG_CS);
-- 
2.32.0.93.g670b81a890-goog

