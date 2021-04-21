Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601F8366ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhDUPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhDUPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:09:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D139C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q2so4780104pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=af+kuX5IM9/ZKYVjVnI7LjXEfOZ4xyP6ZjkXRID/xIA=;
        b=SvXM4Lb0TVCmO/z6VC48S00IVLOXPoYoaCKvGS7g9jhmB8/9IsUhriuHSRj0x/NtAe
         +pkF+/OCSJaTEvGkvlF7AzREkFqINzx365lUQEXCK9gQ5Iv+81GafrOGQFAf4b0FdA0v
         yhGMpvEIfgom6cAdCfDEbTzwcnciNV6lT4ado=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=af+kuX5IM9/ZKYVjVnI7LjXEfOZ4xyP6ZjkXRID/xIA=;
        b=g7q4cr7Lh2utcnYRAcesSdcgQIqLX2i0KImLd/Xd1EwiiZAxaGeW29/ZFnZNvscR4C
         Lf46vJFD6vHbfCL/yfQUM/89LVF6M62OFvbTNEfFlwwsAT+SIZXif4dpCPaJkwTlvtcG
         5QcP9KirUI6zuUcZbVAQyyMzEXJT4uCQMIVa6l+u5i4bfPVrTTA1DcAWzTaL3U1JgdYQ
         UsElyqs7PTHnOcPA5jFgu2tG0+0vVFZNBHgeqs7IBXfQZpyIeuN7CUU3eCKqoqfa/5Ha
         sDGEdN4yJb+Nbz8utU2zT8VDZa1stZUIa6eUjb/ud7+ZeGvgnnA/26dHbivzOfOgVK8t
         k1qQ==
X-Gm-Message-State: AOAM531LGiprTZYJfqz7FriPxg+9iPuP00OG+JOEcZwaACf1Xfi3m/FC
        qZWJ3M5HvIMy4A5ZJZmIY9liFg==
X-Google-Smtp-Source: ABdhPJwGgVGZL8yWSsfnrmEEVfVeiBPBSiLz/US1pP2NhReKJ4SUxGmkcSXZXpCx1z87zyFacFsmkQ==
X-Received: by 2002:a63:5a55:: with SMTP id k21mr21989045pgm.312.1619017727203;
        Wed, 21 Apr 2021 08:08:47 -0700 (PDT)
Received: from haraichi.dnlocal (113x36x239x145.ap113.ftth.ucom.ne.jp. [113.36.239.145])
        by smtp.googlemail.com with ESMTPSA id f3sm5432553pjo.3.2021.04.21.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:08:46 -0700 (PDT)
From:   Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pl@sslab.ics.keio.ac.jp,
        kono@sslab.ics.keio.ac.jp,
        Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
Subject: [RFC PATCH 2/2] Boost vCPUs based on IPI-sender and receiver information
Date:   Thu, 22 Apr 2021 00:08:31 +0900
Message-Id: <20210421150831.60133-3-kentaishiguro@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
References: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit monitors IPI communication between vCPUs and leverages the
relationship between vCPUs to select boost candidates.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
---
 arch/x86/kvm/lapic.c     | 14 ++++++++++++++
 arch/x86/kvm/vmx/vmx.c   |  2 ++
 include/linux/kvm_host.h |  5 +++++
 virt/kvm/kvm_main.c      | 26 ++++++++++++++++++++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cc369b9ad8f1..c8d967ddecf9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1269,6 +1269,18 @@ void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
 }
 EXPORT_SYMBOL_GPL(kvm_apic_set_eoi_accelerated);
 
+static void mark_ipi_receiver(struct kvm_lapic *apic, struct kvm_lapic_irq *irq)
+{
+	struct kvm_vcpu *dest_vcpu;
+	u64 prev_ipi_received;
+
+	dest_vcpu = kvm_get_vcpu_by_id(apic->vcpu->kvm, irq->dest_id);
+	if (READ_ONCE(dest_vcpu->sched_outed)) {
+		prev_ipi_received = READ_ONCE(dest_vcpu->ipi_received);
+		WRITE_ONCE(dest_vcpu->ipi_received, prev_ipi_received | (1 << apic->vcpu->vcpu_id));
+	}
+}
+
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
 {
 	struct kvm_lapic_irq irq;
@@ -1287,6 +1299,8 @@ void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
 
 	trace_kvm_apic_ipi(icr_low, irq.dest_id);
 
+	mark_ipi_receiver(apic, &irq);
+
 	kvm_irq_delivery_to_apic(apic->vcpu->kvm, apic, &irq, NULL);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 29b40e092d13..ced50935a38b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6718,6 +6718,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmcs_write32(PLE_WINDOW, vmx->ple_window);
 	}
 
+	WRITE_ONCE(vcpu->ipi_received, 0);
+
 	/*
 	 * We did this in prepare_switch_to_guest, because it needs to
 	 * be within srcu_read_lock.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1b65e7204344..6726aeec03e7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -320,6 +320,11 @@ struct kvm_vcpu {
 #endif
 	bool preempted;
 	bool ready;
+	bool sched_outed;
+	/*
+	 * The current implementation of strict boost supports up to 64 vCPUs
+	 */
+	u64 ipi_received;
 	struct kvm_vcpu_arch arch;
 	struct kvm_dirty_ring dirty_ring;
 };
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..08e629957e7e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -413,6 +413,10 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->preempted = false;
 	vcpu->ready = false;
+
+	vcpu->sched_outed = false;
+	vcpu->ipi_received = 0;
+
 	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
 }
 
@@ -3011,6 +3015,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 	int try = 3;
 	int pass;
 	int i;
+	u64 prev_ipi_received;
 
 	kvm_vcpu_set_in_spin_loop(me, true);
 	/*
@@ -3031,12 +3036,25 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 				continue;
 			if (vcpu == me)
 				continue;
+			prev_ipi_received = READ_ONCE(vcpu->ipi_received);
+			if (!READ_ONCE(vcpu->preempted) &&
+			    !(prev_ipi_received & (1 << me->vcpu_id))) {
+				WRITE_ONCE(vcpu->ipi_received,
+					   prev_ipi_received | (1 << me->vcpu_id));
+				continue;
+			}
 			if (rcuwait_active(&vcpu->wait) &&
 			    !vcpu_dy_runnable(vcpu))
 				continue;
 			if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
-				!kvm_arch_vcpu_in_kernel(vcpu))
-				continue;
+				!kvm_arch_vcpu_in_kernel(vcpu)) {
+				prev_ipi_received = READ_ONCE(vcpu->ipi_received);
+				if (!(prev_ipi_received & (1 << me->vcpu_id))) {
+					WRITE_ONCE(vcpu->ipi_received,
+						   prev_ipi_received | (1 << me->vcpu_id));
+					continue;
+				}
+			}
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
 
@@ -4859,6 +4877,9 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
 	WRITE_ONCE(vcpu->preempted, false);
 	WRITE_ONCE(vcpu->ready, false);
 
+	WRITE_ONCE(vcpu->sched_outed, false);
+	WRITE_ONCE(vcpu->ipi_received, 0);
+
 	__this_cpu_write(kvm_running_vcpu, vcpu);
 	kvm_arch_sched_in(vcpu, cpu);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -4873,6 +4894,7 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}
+	WRITE_ONCE(vcpu->sched_outed, true);
 	kvm_arch_vcpu_put(vcpu);
 	__this_cpu_write(kvm_running_vcpu, NULL);
 }
-- 
2.30.2

