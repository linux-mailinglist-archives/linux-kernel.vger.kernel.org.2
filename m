Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E9376061
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhEGGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234642AbhEGGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsTTJbp1DyGK5mxmZon/51Lz6Vw1IzXQeBZl7pYv8ac=;
        b=ORy9OH6dg6Me/1trREyIKvITo3MWFcuMx/RJTsQzUawTSxavjxyMDosWtw1mEdyUdmbf3N
        /Qk0FD4AD50/zrhEUF/OQrqedjNKD6kRk6d9N7MxhxUy+YjTYntChOZW+XsEPiaSwr0PWk
        S9I6q/sDWtcFM9byVVuurZRp1FA781A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-0bLupSLHMHqapf8upvSrqg-1; Fri, 07 May 2021 02:32:23 -0400
X-MC-Unique: 0bLupSLHMHqapf8upvSrqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8EBA64149;
        Fri,  7 May 2021 06:32:20 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC8D5D9CA;
        Fri,  7 May 2021 06:32:17 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 13/21] KVM: arm64: Impment SDEI event delivery
Date:   Fri,  7 May 2021 16:31:16 +0800
Message-Id: <20210507083124.43347-14-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implement kvm_sdei_deliver() to support SDEI event delivery.
The function is called when the request (KVM_REQ_SDEI) is raised.
The following rules are taken according to the SDEI specification:

   * x0 - x17 are saved. All of them are cleared except the following
     registered:
     x0: number SDEI event to be delivered
     x1: parameter associated with the SDEI event
     x2: PC of the interrupted context
     x3: PState of the interrupted context

   * PC is set to the handler of the SDEI event, which was provided
     during its registration. PState is modified accordingly.

   * SDEI event with critical priority can preempt those with normal
     priority.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/kvm_sdei.h |  1 +
 arch/arm64/kvm/arm.c              |  3 ++
 arch/arm64/kvm/sdei.c             | 84 +++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b66126853041..94570924ae96 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -46,6 +46,7 @@
 #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
 #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
+#define KVM_REQ_SDEI		KVM_ARCH_REQ(5)
 
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index b0abc13a0256..7f5f5ad689e6 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -112,6 +112,7 @@ KVM_SDEI_FLAG_FUNC(enabled)
 void kvm_sdei_init_vm(struct kvm *kvm);
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
+void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1faae4e38c13..345083dc5144 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -680,6 +680,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
 			kvm_reset_vcpu(vcpu);
 
+		if (kvm_check_request(KVM_REQ_SDEI, vcpu))
+			kvm_sdei_deliver(vcpu);
+
 		/*
 		 * Clear IRQ_PENDING requests that were made to guarantee
 		 * that a VCPU sees new virtual interrupts.
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 62efee2b67b8..b5d6d1ed3858 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -671,6 +671,90 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+	struct kvm_sdei_vcpu_regs *regs = NULL;
+	unsigned long pstate;
+	int index = 0;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei))
+		return;
+
+	/* The critical event can't be preempted */
+	spin_lock(&vsdei->lock);
+	if (vsdei->critical_event)
+		goto unlock;
+
+	/*
+	 * The normal event can be preempted by the critical event.
+	 * However, the normal event can't be preempted by another
+	 * normal event.
+	 */
+	ksve = list_first_entry_or_null(&vsdei->critical_events,
+			struct kvm_sdei_vcpu_event, link);
+	if (!ksve && !vsdei->normal_event) {
+		ksve = list_first_entry_or_null(&vsdei->normal_events,
+				struct kvm_sdei_vcpu_event, link);
+	}
+
+	if (!ksve)
+		goto unlock;
+
+	kske = ksve->kske;
+	kse = kske->kse;
+	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL) {
+		vsdei->critical_event = ksve;
+		vsdei->state.critical_num = ksve->state.num;
+		regs = &vsdei->state.critical_regs;
+	} else {
+		vsdei->normal_event = ksve;
+		vsdei->state.normal_num = ksve->state.num;
+		regs = &vsdei->state.normal_regs;
+	}
+
+	/* Save registers: x0 -> x17, PC, PState */
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		regs->regs[index] = vcpu_get_reg(vcpu, index);
+
+	regs->pc = *vcpu_pc(vcpu);
+	regs->pstate = *vcpu_cpsr(vcpu);
+
+	/*
+	 * Inject SDEI event: x0 -> x3, PC, PState. We needn't take lock
+	 * for the KVM event as it can't be destroyed because of its
+	 * reference count.
+	 */
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		vcpu_set_reg(vcpu, index, 0);
+
+	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
+		vcpu->vcpu_idx : 0;
+	vcpu_set_reg(vcpu, 0, kske->state.num);
+	vcpu_set_reg(vcpu, 1, kske->state.params[index]);
+	vcpu_set_reg(vcpu, 2, regs->pc);
+	vcpu_set_reg(vcpu, 3, regs->pstate);
+
+	pstate = regs->pstate;
+	pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT);
+	pstate &= ~PSR_MODE_MASK;
+	pstate |= PSR_MODE_EL1h;
+	pstate &= ~PSR_MODE32_BIT;
+
+	vcpu_write_sys_reg(vcpu, regs->pstate, SPSR_EL1);
+	*vcpu_cpsr(vcpu) = pstate;
+	*vcpu_pc(vcpu) = kske->state.entries[index];
+
+unlock:
+	spin_unlock(&vsdei->lock);
+}
+
 void kvm_sdei_init_vm(struct kvm *kvm)
 {
 	struct kvm_sdei_kvm *ksdei;
-- 
2.23.0

