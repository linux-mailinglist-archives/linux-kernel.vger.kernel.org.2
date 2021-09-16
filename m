Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63D40D498
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhIPIeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhIPIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:34:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064CC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:32:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d21so8089916wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dme-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oprU1kxT1w+DveU6YstsbHcV6buDq4T0SEU6UEPXwXk=;
        b=dWP7giWss8w4Nf4bfLGks7tEKukq+zNQndkbn8VaE2ayRDnqpWB8papY0UgiSPyQz8
         5Bwqs4FZAvbaivxYjssEq6K6TSv1XzI8LP7MK0RHljzmtcFPtkx02BUXcvuKR8gg9NO3
         2/TzgGGvxlsYM33DkDUXuesTbTsoplpMQRERYlN3zQmv2NK5H2DjrHT0lGnjzfONGPPb
         coRaa43WHNg/ZtiIQKU/5jVKLiYXoZTz69/oJ3E2kWlfgM4ZGVyjAmkkutKrDXaUl6/K
         PlUK1XTpnro9+GEoJTgwf7e5JjahuqORl+AmpvLrzzohFail1R1CgCmX6tFD36pKoIGQ
         AjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oprU1kxT1w+DveU6YstsbHcV6buDq4T0SEU6UEPXwXk=;
        b=WZ3TGq7df+JXkN2zL/DSLhGltUDdcnd7/zFhkmOuJ36ObXahH6v3KG3+Eb8Q09AY5z
         kmeYViPmR0+PZZSjfJ4+hIcn/L62iReHTbM6blWQ89SMP8cjF/TWdGW5V/m2kB3F/pfq
         sCg4J3uUn/nVY3fA4EehPtQg8MK46CAiPUXhTeBI9b0b7JQiGiWXGRPEUUSz+86zNn/3
         8Fq2EbVClzCgEHH+v9le/S1uFDphweq1SJAQiaY079lHEJ17FFeZHc/qkF83MM2/uJXH
         9Y8zCucLGqr3pkFMBzyDxjNRThSlCUHfYIGwLF+/k6xPQE8TCN7TGETb6+zW/avIH8Eo
         syDA==
X-Gm-Message-State: AOAM531GoNVhpZ4EPuD8mCJl8Zr6DOghc9awoOstqM0lUNazEVveZpsr
        TKEXPi7hwsQKtqPutkTBFU0xyQ==
X-Google-Smtp-Source: ABdhPJy0XJHLfFqtq0nt9PUm1XzqvVUR6OWx7pgxtH3ReT/m9lyKNev+Tzf6qrgmE+ELMOlP1lROvw==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr4610888wrw.192.1631781162579;
        Thu, 16 Sep 2021 01:32:42 -0700 (PDT)
Received: from disaster-area.hh.sledj.net ([2001:8b0:bb71:7140:64::1])
        by smtp.gmail.com with ESMTPSA id c135sm6760024wme.6.2021.09.16.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:32:42 -0700 (PDT)
From:   David Edmondson <dme@dme.org>
X-Google-Original-From: David Edmondson <david.edmondson@oracle.com>
Received: from localhost (disaster-area.hh.sledj.net [local])
        by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 5640c2e7;
        Thu, 16 Sep 2021 08:32:39 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        David Edmondson <david.edmondson@oracle.com>
Subject: [PATCH v5 2/4] KVM: x86: Get exit_reason as part of kvm_x86_ops.get_exit_info
Date:   Thu, 16 Sep 2021 09:32:37 +0100
Message-Id: <20210916083239.2168281-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916083239.2168281-1-david.edmondson@oracle.com>
References: <20210916083239.2168281-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the get_exit_info static call to provide the reason for the VM
exit. Modify relevant trace points to use this rather than extracting
the reason in the caller.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 arch/x86/include/asm/kvm_host.h | 7 ++++---
 arch/x86/kvm/svm/svm.c          | 8 +++++---
 arch/x86/kvm/trace.h            | 9 +++++----
 arch/x86/kvm/vmx/nested.c       | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 6 ++++--
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8f48a7ec577..d22bbeb48f66 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1405,10 +1405,11 @@ struct kvm_x86_ops {
 	void (*write_tsc_multiplier)(struct kvm_vcpu *vcpu, u64 multiplier);
 
 	/*
-	 * Retrieve somewhat arbitrary exit information.  Intended to be used
-	 * only from within tracepoints to avoid VMREADs when tracing is off.
+	 * Retrieve somewhat arbitrary exit information.  Intended to
+	 * be used only from within tracepoints or error paths.
 	 */
-	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2,
+	void (*get_exit_info)(struct kvm_vcpu *vcpu, u32 *reason,
+			      u64 *info1, u64 *info2,
 			      u32 *exit_int_info, u32 *exit_int_info_err_code);
 
 	int (*check_intercept)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 05e8d4d27969..a902a767f722 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3272,11 +3272,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 	return svm_exit_handlers[exit_code](vcpu);
 }
 
-static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2,
+static void svm_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
+			      u64 *info1, u64 *info2,
 			      u32 *intr_info, u32 *error_code)
 {
 	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
 
+	*reason = control->exit_code;
 	*info1 = control->exit_info_1;
 	*info2 = control->exit_info_2;
 	*intr_info = control->exit_int_info;
@@ -3293,7 +3295,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	struct kvm_run *kvm_run = vcpu->run;
 	u32 exit_code = svm->vmcb->control.exit_code;
 
-	trace_kvm_exit(exit_code, vcpu, KVM_ISA_SVM);
+	trace_kvm_exit(vcpu, KVM_ISA_SVM);
 
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!sev_es_guest(vcpu->kvm)) {
@@ -3306,7 +3308,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (is_guest_mode(vcpu)) {
 		int vmexit;
 
-		trace_kvm_nested_vmexit(exit_code, vcpu, KVM_ISA_SVM);
+		trace_kvm_nested_vmexit(vcpu, KVM_ISA_SVM);
 
 		vmexit = nested_svm_exit_special(svm);
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 03ebe368333e..953b0fcb21ee 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -288,8 +288,8 @@ TRACE_EVENT(kvm_apic,
 
 #define TRACE_EVENT_KVM_EXIT(name)					     \
 TRACE_EVENT(name,							     \
-	TP_PROTO(unsigned int exit_reason, struct kvm_vcpu *vcpu, u32 isa),  \
-	TP_ARGS(exit_reason, vcpu, isa),				     \
+	TP_PROTO(struct kvm_vcpu *vcpu, u32 isa),			     \
+	TP_ARGS(vcpu, isa),						     \
 									     \
 	TP_STRUCT__entry(						     \
 		__field(	unsigned int,	exit_reason	)	     \
@@ -303,11 +303,12 @@ TRACE_EVENT(name,							     \
 	),								     \
 									     \
 	TP_fast_assign(							     \
-		__entry->exit_reason	= exit_reason;			     \
 		__entry->guest_rip	= kvm_rip_read(vcpu);		     \
 		__entry->isa            = isa;				     \
 		__entry->vcpu_id        = vcpu->vcpu_id;		     \
-		static_call(kvm_x86_get_exit_info)(vcpu, &__entry->info1,    \
+		static_call(kvm_x86_get_exit_info)(vcpu,		     \
+					  &__entry->exit_reason,	     \
+					  &__entry->info1,		     \
 					  &__entry->info2,		     \
 					  &__entry->intr_info,		     \
 					  &__entry->error_code);	     \
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ccb03d69546c..43ea97b3f8e6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6059,7 +6059,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 		goto reflect_vmexit;
 	}
 
-	trace_kvm_nested_vmexit(exit_reason.full, vcpu, KVM_ISA_VMX);
+	trace_kvm_nested_vmexit(vcpu, KVM_ISA_VMX);
 
 	/* If L0 (KVM) wants the exit, it trumps L1's desires. */
 	if (nested_vmx_l0_wants_exit(vcpu, exit_reason))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0c2c0d5ae873..99f8f7c4a510 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5628,11 +5628,13 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
-static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2,
+static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
+			      u64 *info1, u64 *info2,
 			      u32 *intr_info, u32 *error_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	*reason = vmx->exit_reason.full;
 	*info1 = vmx_get_exit_qual(vcpu);
 	if (!(vmx->exit_reason.failed_vmentry)) {
 		*info2 = vmx->idt_vectoring_info;
@@ -6769,7 +6771,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	if (likely(!vmx->exit_reason.failed_vmentry))
 		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
-	trace_kvm_exit(vmx->exit_reason.full, vcpu, KVM_ISA_VMX);
+	trace_kvm_exit(vcpu, KVM_ISA_VMX);
 
 	if (unlikely(vmx->exit_reason.failed_vmentry))
 		return EXIT_FASTPATH_NONE;
-- 
2.33.0

