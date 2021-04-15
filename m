Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E5361565
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhDOWWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbhDOWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:58 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86970C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:32 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s16-20020a05621412d0b029019a42aa64f7so2774320qvv.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=UAC36Umw1y4N2XTzBeWJ62cig8EoZ7urvgIOFbPyNVs=;
        b=hdBoKyZq93hljglLeFSOkjraFuyeHrftvH1IWOLFybaQggYb39Eo+yBxuHDX7vMCY8
         28tqvfYRRtbAeKfKSSeCXch5CIe3N/nwduJM+oCpYz97tWxFJIYJYTf//FC6kmn4js2r
         JRnGFw72gnQCiGlQudymiLyL6pB03MEjdIRxghqW+xi2N1UcgRFR4SnNd5ot1g1cbQBB
         x0Kg871VTPiSbOhxn1deKmo9nvQXwCXxBT6swl0sAWqLVjQnObaggeFQanPPkOYiFDn7
         9Mx0RIfNwQoA4imUxNHEqpQ8Z8raJjJprLXKEcGYRwGDZ+80dN91NCI1SvkLNLuPjxg8
         VHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=UAC36Umw1y4N2XTzBeWJ62cig8EoZ7urvgIOFbPyNVs=;
        b=B4eC3v+0jhKzDOcnGJpKZjzpuEr09a8LrsIyQQ5KPNJ/6LK2kI1txnfCH+oM9jB0TQ
         l/6+DTA9YN2z3/Fg4w99cv0W8U6oqpXSczi1t+enliJVrjaenb5Ww794i/rymLgS9yZG
         BKkl8XnQpYDgEOMlPaPLmuN7N96LWLFWNrKbT9PBny6wlqR7bp2BiGj/JJoI6uKjSDzz
         oqzDxBq7fxDrNtYtKPS83GU2zig2YTWLyLcMEs2MS5qQGvJQS/1DFQWR13skO9N/wB1z
         46Zh1dmy7R1L4cHQkBOfohgu6+Fw5y6K7OIZV4TEX+A4gIp9PHYGsKXwZegGuW6+frXr
         iLwA==
X-Gm-Message-State: AOAM532u9Py0MG9lEwqIL4mAdxq8wEHCtsMcTZ/dI4jm7aF1slyrQXUo
        mEgPBQ8RPi/9z4fUYPHCZLM39MiJEvE=
X-Google-Smtp-Source: ABdhPJwUZIGHXwDCmD9Ec2vGqDNqiOgbzXxuMPLd6Y1HUTcMEki9QsgPmUp+XAYk4F9XG/4mMf5xt6XbAWk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1c45:: with SMTP id
 if5mr5551635qvb.48.1618525291699; Thu, 15 Apr 2021 15:21:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:21:05 -0700
In-Reply-To: <20210415222106.1643837-1-seanjc@google.com>
Message-Id: <20210415222106.1643837-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210415222106.1643837-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 8/9] KVM: x86: Consolidate guest enter/exit logic to common helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enter/exit logic in {svm,vmx}_vcpu_enter_exit() to common
helpers.  Opportunistically update the somewhat stale comment about the
updates needing to occur immediately after VM-Exit.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 46 ++-----------------------------------
 arch/x86/kvm/vmx/vmx.c | 46 ++-----------------------------------
 arch/x86/kvm/x86.h     | 52 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 88 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bb2aa0dde7c5..0677595d07e5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3713,25 +3713,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	/*
-	 * VMENTER enables interrupts (host state), but the kernel state is
-	 * interrupts disabled when this is invoked. Also tell RCU about
-	 * it. This is the same logic as for exit_to_user_mode().
-	 *
-	 * This ensures that e.g. latency analysis on the host observes
-	 * guest mode as interrupt enabled.
-	 *
-	 * guest_enter_irqoff() informs context tracking about the
-	 * transition to guest mode and if enabled adjusts RCU state
-	 * accordingly.
-	 */
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	instrumentation_end();
-
-	guest_enter_irqoff();
-	lockdep_hardirqs_on(CALLER_ADDR0);
+	kvm_guest_enter_irqoff();
 
 	if (sev_es_guest(vcpu->kvm)) {
 		__svm_sev_es_vcpu_run(svm->vmcb_pa);
@@ -3745,31 +3727,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 		vmload(__sme_page_pa(sd->save_area));
 	}
 
-	/*
-	 * VMEXIT disables interrupts (host state), but tracing and lockdep
-	 * have them in state 'on' as recorded before entering guest mode.
-	 * Same as enter_from_user_mode().
-	 *
-	 * context_tracking_guest_exit_irqoff() restores host context and
-	 * reinstates RCU if enabled and required.
-	 *
-	 * This needs to be done before the below as native_read_msr()
-	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
-	 * into world and some more.
-	 */
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	context_tracking_guest_exit_irqoff();
-
-	instrumentation_begin();
-	/*
-	 * Account guest time when precise accounting based on context tracking
-	 * is enabled.  Tick based accounting is deferred until after IRQs that
-	 * occurred within the VM-Enter/VM-Exit "window" are handled.
-	 */
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_account_guest_exit();
-	trace_hardirqs_off_finish();
-	instrumentation_end();
+	kvm_guest_exit_irqoff();
 }
 
 static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5ae9dc197048..19b0e25bf598 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6600,25 +6600,7 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					struct vcpu_vmx *vmx)
 {
-	/*
-	 * VMENTER enables interrupts (host state), but the kernel state is
-	 * interrupts disabled when this is invoked. Also tell RCU about
-	 * it. This is the same logic as for exit_to_user_mode().
-	 *
-	 * This ensures that e.g. latency analysis on the host observes
-	 * guest mode as interrupt enabled.
-	 *
-	 * guest_enter_irqoff() informs context tracking about the
-	 * transition to guest mode and if enabled adjusts RCU state
-	 * accordingly.
-	 */
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	instrumentation_end();
-
-	guest_enter_irqoff();
-	lockdep_hardirqs_on(CALLER_ADDR0);
+	kvm_guest_enter_irqoff();
 
 	/* L1D Flush includes CPU buffer clear to mitigate MDS */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
@@ -6634,31 +6616,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vcpu->arch.cr2 = native_read_cr2();
 
-	/*
-	 * VMEXIT disables interrupts (host state), but tracing and lockdep
-	 * have them in state 'on' as recorded before entering guest mode.
-	 * Same as enter_from_user_mode().
-	 *
-	 * context_tracking_guest_exit_irqoff() restores host context and
-	 * reinstates RCU if enabled and required.
-	 *
-	 * This needs to be done before the below as native_read_msr()
-	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
-	 * into world and some more.
-	 */
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	context_tracking_guest_exit_irqoff();
-
-	instrumentation_begin();
-	/*
-	 * Account guest time when precise accounting based on context tracking
-	 * is enabled.  Tick based accounting is deferred until after IRQs that
-	 * occurred within the VM-Enter/VM-Exit "window" are handled.
-	 */
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_account_guest_exit();
-	trace_hardirqs_off_finish();
-	instrumentation_end();
+	kvm_guest_exit_irqoff();
 }
 
 static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index daccf20fbcd5..285953e81777 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,58 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 
+static __always_inline void kvm_guest_enter_irqoff(void)
+{
+	/*
+	 * VMENTER enables interrupts (host state), but the kernel state is
+	 * interrupts disabled when this is invoked. Also tell RCU about
+	 * it. This is the same logic as for exit_to_user_mode().
+	 *
+	 * This ensures that e.g. latency analysis on the host observes
+	 * guest mode as interrupt enabled.
+	 *
+	 * guest_enter_irqoff() informs context tracking about the
+	 * transition to guest mode and if enabled adjusts RCU state
+	 * accordingly.
+	 */
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	instrumentation_end();
+
+	guest_enter_irqoff();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+static __always_inline void kvm_guest_exit_irqoff(void)
+{
+	/*
+	 * VMEXIT disables interrupts (host state), but tracing and lockdep
+	 * have them in state 'on' as recorded before entering guest mode.
+	 * Same as enter_from_user_mode().
+	 *
+	 * context_tracking_guest_exit_irqoff() restores host context and
+	 * reinstates RCU if enabled and required.
+	 *
+	 * This needs to be done immediately after VM-Exit, before any code
+	 * that might contain tracepoints or call out to the greater world,
+	 * e.g. before x86_spec_ctrl_restore_host().
+	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	context_tracking_guest_exit_irqoff();
+
+	instrumentation_begin();
+	/*
+	 * Account guest time when precise accounting based on context tracking
+	 * is enabled.  Tick based accounting is deferred until after IRQs that
+	 * occurred within the VM-Enter/VM-Exit "window" are handled.
+	 */
+	if (vtime_accounting_enabled_this_cpu())
+		vtime_account_guest_exit();
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
 #define KVM_NESTED_VMENTER_CONSISTENCY_CHECK(consistency_check)		\
 ({									\
 	bool failed = (consistency_check);				\
-- 
2.31.1.368.gbe11c130af-goog

