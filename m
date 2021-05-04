Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B094372EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhEDRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEDRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:18:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:17:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a250cc10000b02904ee21d0e583so12647937ybm.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=j0hBscA0403vKyQ6SIWuUyRenydWaHr9yEWTv+u3OUs=;
        b=ViGRM4AJOU518/+fjRX9OlnzW/83aCiR1KgihpFq073sjX7H1DBYYHGZqylYb5Y7Q2
         Uy/gi/efm0nM4Dc+A9bK5CQp8VswRZeS/3eOIoB/umJuYp/pxlaKPQ0qUPtfPdg4BPyu
         VR/9ZeJTs0uJ2ZYBElFK2p5be4z5mcspDhD+eai1dmzNGh9xlgZzEP6q0lCUmX4jfrGN
         CbOUQlh9p82oQfrxYXtz7dtIOi4BMLqhiECO5oENxRneRyHKxSCkyZeGHq0AGq3YXHKB
         9rybb4wVz7MsGHzg+JHNFfgmol3G3HWFHN7OE/ioX13Q5FuXARrTtE6NxnlmRGOlEVvb
         qycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=j0hBscA0403vKyQ6SIWuUyRenydWaHr9yEWTv+u3OUs=;
        b=l0LVnI6cZxvL7JM6FaldIHM38/D62YiGG7nmbifwAuRFZL/QAA/S8PGRtU8WamGsJd
         hp6gqHOg7B+VMKARfbEtvnixn+bLVjhalsZzRquzJiGDB/LmzCel4QrxJMyBIGVTRzRS
         RjZ/qFFxHFtXwKQMqDH1ufHz8NVRgrAz5TXOdeWTuXOse9R0f8HQ1+hRCwOYq0aJM+AE
         yY2kz+TgpLOKBADIxnEdCpLK/yX/IqxO2kvXQAWyMEHtXonYT9VKqdv33XZ0UYZO1Pmp
         J1Orh5c/MNmY4clwVTRl5rkQPbmVgBrj6D4M4LzwAWrFulKf9ROR2+vkw2T2j9Jp2lua
         Ogow==
X-Gm-Message-State: AOAM530TZ4sWfwoIO0KFN9nIFv1ao/JUPNMt+T20JZ/OOita+Ukjua0x
        Sjvr1r68Uvl4ElbK1htc4hHpdCSnu0g=
X-Google-Smtp-Source: ABdhPJwry1A6z/xjHiq7OfswGhOeDlb9iJLLC5CJCuD7yr/gYHfb7E3S+/lNHAndjUQOSs8wYttrWfkEfes=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1349:: with SMTP id
 g9mr18387086ybu.30.1620148669369; Tue, 04 May 2021 10:17:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 10:17:22 -0700
In-Reply-To: <20210504171734.1434054-1-seanjc@google.com>
Message-Id: <20210504171734.1434054-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intercept RDTSCP to inject #UD if RDTSC is disabled in the guest.

Note, SVM does not support intercepting RDPID.  Unlike VMX's
ENABLE_RDTSCP control, RDTSCP interception does not apply to RDPID.  This
is a benign virtualization hole as the host kernel (incorrectly) sets
MSR_TSC_AUX if RDTSCP is supported, and KVM loads the guest's MSR_TSC_AUX
into hardware if RDTSCP is supported in the host, i.e. KVM will not leak
the host's MSR_TSC_AUX to the guest.

But, when the kernel bug is fixed, KVM will start leaking the host's
MSR_TSC_AUX if RDPID is supported in hardware, but RDTSCP isn't available
for whatever reason.  This leak will be remedied in a future commit.

Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7271f31df47..8f2b184270c0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1100,7 +1100,9 @@ static u64 svm_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 	return svm->vmcb->control.tsc_offset;
 }
 
-static void svm_check_invpcid(struct vcpu_svm *svm)
+/* Evaluate instruction intercepts that depend on guest CPUID features. */
+static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu,
+					      struct vcpu_svm *svm)
 {
 	/*
 	 * Intercept INVPCID if shadow paging is enabled to sync/free shadow
@@ -1113,6 +1115,13 @@ static void svm_check_invpcid(struct vcpu_svm *svm)
 		else
 			svm_clr_intercept(svm, INTERCEPT_INVPCID);
 	}
+
+	if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP)) {
+		if (guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
+			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
+		else
+			svm_set_intercept(svm, INTERCEPT_RDTSCP);
+	}
 }
 
 static void init_vmcb(struct kvm_vcpu *vcpu)
@@ -1248,7 +1257,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_clr_intercept(svm, INTERCEPT_PAUSE);
 	}
 
-	svm_check_invpcid(svm);
+	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/*
 	 * If the host supports V_SPEC_CTRL then disable the interception
@@ -3084,6 +3093,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_STGI]				= stgi_interception,
 	[SVM_EXIT_CLGI]				= clgi_interception,
 	[SVM_EXIT_SKINIT]			= skinit_interception,
+	[SVM_EXIT_RDTSCP]			= kvm_handle_invalid_op,
 	[SVM_EXIT_WBINVD]                       = kvm_emulate_wbinvd,
 	[SVM_EXIT_MONITOR]			= kvm_emulate_monitor,
 	[SVM_EXIT_MWAIT]			= kvm_emulate_mwait,
@@ -4007,8 +4017,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
 			     guest_cpuid_has(vcpu, X86_FEATURE_NRIPS);
 
-	/* Check again if INVPCID interception if required */
-	svm_check_invpcid(svm);
+	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
 	if (sev_guest(vcpu->kvm)) {
-- 
2.31.1.527.g47e6f16901-goog

