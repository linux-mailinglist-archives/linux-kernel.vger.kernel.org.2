Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E943117F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBFAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBEKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:05:12 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29FC061221
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:04:01 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c132so4201767pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC2QNWrsviuW49vH66X38HKXHrsgTnzDfoKNb+X8LdE=;
        b=1s/b1HqHxzpBnf2PB93OczXUYXJG6q/GyUoy/kuh8AcVvSYCkk7O1Wjs1Y4f85D596
         aN9gsFdBWYxz/wG+mjswPfAlgBK2JPjIKR+viON6bYq+FH3/62K058ppH68ihOgauCnS
         EQWdPDV154cJxO4HFkW80/C/BYnHEpOn60fo8OqbS8gT2X72/5E3u1Jtd5x7W1ocD6Kp
         +aipViAbOBeROIu2Iefc1njBoyNtjIpE+tVH6+G07k1Q5ICGDnYbGDB+5+M4c+nvLTSY
         7LcGypSFGy7JMt8UUxrvYEucDYT/3UjtegDSGy+koIrThPRqmF/+Z5L7XA/e0/l2utbY
         NDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC2QNWrsviuW49vH66X38HKXHrsgTnzDfoKNb+X8LdE=;
        b=tZEqtrGuRigMQnVIxiJ/BofuY6iwNvrXRGRk4yZaU9+bEq3ijysTTqX8/RoRaczyxa
         zHtFZdr+22GyX5kPpHfHsPfj5Au2li9vYMbWUG5Jjkuq2UtD+x+eXJlcKybaf8HgkkUF
         7slhfO41p8ImUF8y3Z1SFzinL8+kIb8q8qU9+e8bC2jHDgJaSIxPY4I30ASjUfb95Jb7
         gN+iZgi4TIVEAmXgENb99DitBGw1JuCDVTuczpIwB1ibrm1bTg2yKsqfJ6qN6JxGMrSc
         1tEHfh9ISww0+RGly3zqCy6KlGzHXCl1T1x3L+C0tkoiLHJBOa97M9o60i49ivYUIbfM
         FMhw==
X-Gm-Message-State: AOAM530GCQM2WkRPOfphLBrY59Z5bY2tyRHVavPztxYYig6ygMIt9Ter
        xW/DYVouHoKoBr/Sdc8w9ccpjw==
X-Google-Smtp-Source: ABdhPJy/VsIsFlwktXzo6Tnx2RQLugENjrdS/2ECxhSWrqiEXLIPa0Q78hUVvA2Q7EpNe/dm6BusPg==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr3653133pgg.293.1612519440810;
        Fri, 05 Feb 2021 02:04:00 -0800 (PST)
Received: from C02CC49MMD6R.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id l12sm8142562pjg.54.2021.02.05.02.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 02:04:00 -0800 (PST)
From:   Zhimin Feng <fengzhimin@bytedance.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        fweisbec@gmail.com, zhouyibo@bytedance.com,
        zhanghaozhong@bytedance.com, Zhimin Feng <fengzhimin@bytedance.com>
Subject: [RFC: timer passthrough 5/9] KVM: vmx: use tsc_adjust to enable tsc_offset timer passthrough
Date:   Fri,  5 Feb 2021 18:03:13 +0800
Message-Id: <20210205100317.24174-6-fengzhimin@bytedance.com>
X-Mailer: git-send-email 2.24.1 (Apple Git-126)
In-Reply-To: <20210205100317.24174-1-fengzhimin@bytedance.com>
References: <20210205100317.24174-1-fengzhimin@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when in vm:
rdtsc = host_tsc * (TSC multiplier) + tsc_offset(<0)
so when vm write tsc_deadline_msr the value always less than
tsc stampcounter msr value, the irq never be triggered.

the tsc_adjust msr use as below, host execute
rdtsc = host_tsc + tsc_adjust

when vmentry, we set the tsc_adjust equal tsc_offset and vmcs
tsc offset filed equal 0, so the vm execute rdtsc the result like this:
rdtsc = host_tsc + tsc_adjust + 0
the tsc_deadline_msr value will equal tsc stampcounter msr and
the irq will trigger success.

Signed-off-by: Zhimin Feng <fengzhimin@bytedance.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/vmx.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index be8fc230f7c4..7971c9e755a4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -534,6 +534,7 @@ struct tick_device {
 struct timer_passth_info {
 	u64 host_tscd;
 	bool host_in_tscdeadline;
+	u64 host_tsc_adjust;
 	struct clock_event_device *curr_dev;
 
 	void (*orig_event_handler)(struct clock_event_device *dev);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f824ee46e2d3..44b2fd59587e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6659,6 +6659,27 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
 
+static void vmx_adjust_tsc_offset(struct kvm_vcpu *vcpu, bool to_host)
+{
+	u64 tsc_adjust;
+	struct timer_passth_info *local_timer_info;
+
+	local_timer_info = &per_cpu(passth_info, smp_processor_id());
+
+	if (to_host) {
+		tsc_adjust = local_timer_info->host_tsc_adjust;
+		wrmsrl(MSR_IA32_TSC_ADJUST, tsc_adjust);
+		vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
+	} else {
+		rdmsrl(MSR_IA32_TSC_ADJUST, tsc_adjust);
+		local_timer_info->host_tsc_adjust = tsc_adjust;
+
+		wrmsrl(MSR_IA32_TSC_ADJUST, tsc_adjust + vcpu->arch.tsc_offset);
+		vmcs_write64(TSC_OFFSET, 0);
+
+	}
+}
+
 static void vmx_host_lapic_timer_offload(struct kvm_vcpu *vcpu)
 {
 	struct timer_passth_info *local_timer_info;
@@ -6690,6 +6711,7 @@ static void vmx_host_lapic_timer_offload(struct kvm_vcpu *vcpu)
 				PIN_BASED_VMX_PREEMPTION_TIMER);
 	}
 
+	vmx_adjust_tsc_offset(vcpu, false);
 	wrmsrl(MSR_IA32_TSCDEADLINE, 0);
 	if (vcpu->arch.tscd > guest_tscl) {
 		wrmsrl(MSR_IA32_TSCDEADLINE, vcpu->arch.tscd);
@@ -6711,6 +6733,7 @@ static void vmx_restore_passth_timer(struct kvm_vcpu *vcpu)
 	u64 guest_tscd;
 
 	if (vcpu->arch.timer_passth_enable) {
+		vmx_adjust_tsc_offset(vcpu, true);
 		local_timer_info = &per_cpu(passth_info, smp_processor_id());
 		host_tscd = local_timer_info->host_tscd;
 		rdmsrl(MSR_IA32_TSC_DEADLINE, guest_tscd);
-- 
2.11.0

