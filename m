Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6B311840
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBFCbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBFCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:30:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9EC033268
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:42:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 78so5451319ybn.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=/uKdxO7FbPiBVeLTlxl1CfT/Z9yqVnQz43NlcHgsGl4=;
        b=mgWuoDzKopp0TTA8rmgl4BKF9dbWHGsAISViQKsZV+FpaNv8jWFglKIcXKTrzgFB69
         kNHOOomBoBsz9/2bptFdvSLjwDtei0F+iDq20PqSNjdH9s9W2BCCswgtg1Oit+V2Z5C4
         cwLFOFb/IdcYnOicBwydv9W29TEIap1qs23mJtlwzmZV0VwQURljouLQaMubOP/SRULq
         H/9nsKNjKbNGzNfsfA0KS2rc1aUaRjHbW7rPalnIS4VaKcSTZEbEx6kl1kTJTcewCWoR
         BAyU8NRyX9tyHJoBUrLy1xKVjbcmdzasRMv9Zjz+v+caOPcW4gGHtTrHmRtXQiTeVrcQ
         yS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=/uKdxO7FbPiBVeLTlxl1CfT/Z9yqVnQz43NlcHgsGl4=;
        b=o1DHuiOPFpEIYDy+tcWtAf8I24o686yC3pAdgxX3/jJ74kAq/ZD7gnCG8Fzgchu2F9
         p9mH03FefVoP8jx325FplOOB2e5kKRyKtmr28K6l1EKQElQtHsXFzzHsYJt/4YB4zdYp
         rAJDsPj0I2Mvidn0lODlQQsx4RZRENPo5lhlilZy81n2/v4Gm8bdVDO37rZuB3qI06O0
         1KjZa1pNl7sosDxl7J9k7HjK4yLvSFcn/bITnGE/OOhqdWpcYjkGNrl08q0QaOxOksPZ
         ikO+2q/5cqS/PGAlISTWwZ84hPoChXqTpEsTcgb8WxQhvqul0rB9lHYab/M3LBO/YE4h
         Npsw==
X-Gm-Message-State: AOAM5335Rb8JfV4qrx0478fbc1yPWbcZAE9Ot/lHADCDFd+K8UiLNeSe
        Kv1rqKfttgRNN65qprpWr/bf/zh8t1A=
X-Google-Smtp-Source: ABdhPJx9PBagDThm3MGgi0E+HsklXIC0Oj8sYJAfylwTidtK3vM6ARhOOlcdB+sI6KDQltE+hHnREPZebQc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:d169:a9f7:513:e5])
 (user=seanjc job=sendgmr) by 2002:a25:24c:: with SMTP id 73mr9515183ybc.362.1612572143209;
 Fri, 05 Feb 2021 16:42:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Feb 2021 16:42:18 -0800
Message-Id: <20210206004218.312023-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [RFC PATCH] KVM: x86: Set PF_VCPU when processing IRQs to fix
 tick-based accounting
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Temporarily set PF_VCPU while processing IRQ VM-Exits so that a tick IRQ
accounts the time slice to the guest.  Tick-based accounting of guest
time is currently broken as PF_VCPU is only set during the relatively
short VM-Enter sequence, which runs entirely with IRQs disabled, and IRQs
that occur in the guest are processed well after PF_VCPU is cleared.

Keep PF_VCPU set across both VMX's processing of already-acked IRQs
(handle_exit_irqoff()) and the explicit IRQ window (SVM's processing,
plus ticks that occur immediately after VM-Exit on both VMX and SVM).

Fixes: 87fa7f3e98a1 ("x86/kvm: Move context tracking where it belongs")
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

This is quite obnoxious, hence the RFC, but I can't think of a clever,
less ugly way to fix the accounting.

 arch/x86/kvm/x86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9f931c63293..6ddf341cd755 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9118,6 +9118,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	smp_wmb();
 
+	/*
+	 * Temporarily pretend this task is running a vCPU when potentially
+	 * processing an IRQ exit, including the below opening of an IRQ
+	 * window.  Tick-based accounting of guest time relies on PF_VCPU
+	 * being set when the tick IRQ handler runs.
+	 */
+	current->flags |= PF_VCPU;
 	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
 
 	/*
@@ -9132,6 +9139,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	++vcpu->stat.exits;
 	local_irq_disable();
 	kvm_after_interrupt(vcpu);
+	current->flags &= ~PF_VCPU;
 
 	if (lapic_in_kernel(vcpu)) {
 		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;
-- 
2.30.0.478.g8a0d178c01-goog

