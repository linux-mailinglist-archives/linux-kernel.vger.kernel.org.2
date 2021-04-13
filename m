Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE535E671
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbhDMSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347819AbhDMSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:30:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E03C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:29:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t9so6562600ybd.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZLBo4g8Ay3j59zTWAeAVK1AEJcKiEUGCOtGCkug1Xm8=;
        b=AaD3yleh8mz8kgSJJgqPAiZzvg6sryX2ta9uwSnAsRDcOcNyBAbY6KGhgzO1rlhZBk
         11s8XkfFEJZlnp8hq6zog+bkCHpC1mn1LqL072WlJoBjJps9nBO25CktotduMpIWW42P
         +26fZ5B1q4UHwQZ03a8ZOZHEXU/wZ7TS+4UiaRSR4AaacU0iDirwJlg2swGqzp1U5QO4
         5i0+2mdrYyoIVyZJgfVttKgwtzIOH8soEck0FTGklOL7GtKvwrVKHnXlGXeh46xptfAQ
         2rZgtnvJI3SifCu2tSfdEDQjj0Aqup16XyOP85/CBIB32dYa9W6QT4FyVkW9E/HDUFGG
         4kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZLBo4g8Ay3j59zTWAeAVK1AEJcKiEUGCOtGCkug1Xm8=;
        b=W3MIwck4gNA96DQ0NN99YCqS0AyouARxa8C1kfhCXDBRyFlaMgbqM5TF3MTbVpx1cP
         IahK15vle+RJWbGGaVhR5JFn4p6s3Pg/Qq2fF4ypgUfb9jd75s8BSpF7NNIL2vA+pBuy
         EyZBT3OHzhGePyOwtpsvRz5gFPFVB2obgQoNif1OoRxf7/nQ4HOFGmBkSt6qEicMiQDr
         rN8ox1X49Z1cuQiP2bD4C9jZSgLSRWLPpJl6b5sjZZrDxsIxSB7ClmTPp1DE6mF3f4RN
         wvNby9k6Acj+vA9iZayGkqofqtc5cAvIrmPB4ai0EBHC2HHNEvWx4b5xuF7UXHAVQIL/
         W26g==
X-Gm-Message-State: AOAM5319+s7/g0gpHZP+dO0FJ62MtExCxG1ccceTB+Ir1yjm1oHVQrkA
        iyLuLV5q+g2zMMsHOdRf1Xr2CHzQOoY=
X-Google-Smtp-Source: ABdhPJzgDbopp2o77po8l7A/S0LFZa5mDiEt8CIMZnU2TNFpHgkoh9deOcwEfKMMMuWk2+TVZO+w/WwC2bU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f031:9c1c:56c7:c3bf])
 (user=seanjc job=sendgmr) by 2002:a25:ba87:: with SMTP id s7mr45194375ybg.222.1618338596029;
 Tue, 13 Apr 2021 11:29:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Apr 2021 11:29:33 -0700
In-Reply-To: <20210413182933.1046389-1-seanjc@google.com>
Message-Id: <20210413182933.1046389-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210413182933.1046389-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [RFC PATCH 7/7] KVM: x86: Defer tick-based accounting 'til after IRQ handling
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using tick-based accounting, defer the call to account guest time
until after servicing any IRQ(s) that happened in the guest (or
immediately after VM-Exit).  When using tick-based accounting, time is
accounted to the guest when PF_VCPU is set when the tick IRQ handler
runs.  The current approach of unconditionally accounting time in
kvm_guest_exit_irqoff() prevents IRQs that occur in the guest from ever
being processed with PF_VCPU set, since PF_VCPU ends up being set only
during the relatively short VM-Enter sequence, which runs entirely with
IRQs disabled.

Fixes: 87fa7f3e98a131 ("x86/kvm: Move context tracking where it belongs")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 8 ++++++++
 arch/x86/kvm/x86.h | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 16fb39503296..096bbf50b7a9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9230,6 +9230,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	local_irq_disable();
 	kvm_after_interrupt(vcpu);
 
+	/*
+	 * When using tick-based account, wait until after servicing IRQs to
+	 * account guest time so that any ticks that occurred while running the
+	 * guest are properly accounted to the guest.
+	 */
+	if (!IS_ENABLED(CONFIG_VIRT_CPU_ACCOUNTING_GEN))
+		kvm_vtime_account_guest_exit();
+
 	if (lapic_in_kernel(vcpu)) {
 		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;
 		if (delta != S64_MIN) {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 74ef92f47db8..039a7d585925 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -38,15 +38,18 @@ static __always_inline void kvm_guest_exit_irqoff(void)
 	 * have them in state 'on' as recorded before entering guest mode.
 	 * Same as enter_from_user_mode().
 	 *
-	 * guest_exit_irqoff() restores host context and reinstates RCU if
-	 * enabled and required.
+	 * context_tracking_guest_exit_irqoff() restores host context and
+	 * reinstates RCU if enabled and required.
 	 *
 	 * This needs to be done before the below as native_read_msr()
 	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
 	 * into world and some more.
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	guest_exit_irqoff();
+	context_tracking_guest_exit_irqoff();
+
+	if (IS_ENABLED(CONFIG_VIRT_CPU_ACCOUNTING_GEN))
+		kvm_vtime_account_guest_exit();
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
-- 
2.31.1.295.g9ea45b61b8-goog

