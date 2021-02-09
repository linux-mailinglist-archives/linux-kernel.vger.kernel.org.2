Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4131473D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBIDzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhBIDmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612842031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvASVFEoex4JnXDKzf0ovFVwCoPdtiB3PLpDgJFis5c=;
        b=fsyqWbnYMNbbIWUSLK44uuZCaxsGNUSw/tNontLBVJJeHm3I+rGMPVNUV/UbhN8ywrUWSY
        /cAfGSMuwoCGXw6Zvsn48z7xTaYwcrjia3MVREwOLbcmWm5xGY8XCCYVLkaRlfYscjnk5Y
        w2QiabBk1MDRL5haDJZ4jhr0L58Sm40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-xjEHec92PRyD0YRXaoikNQ-1; Mon, 08 Feb 2021 22:28:46 -0500
X-MC-Unique: xjEHec92PRyD0YRXaoikNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2C556AA5;
        Tue,  9 Feb 2021 03:28:45 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE2019C66;
        Tue,  9 Feb 2021 03:28:42 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 13/21] KVM: arm64: Impment SDEI event delivery
Date:   Tue,  9 Feb 2021 11:27:25 +0800
Message-Id: <20210209032733.99996-14-gshan@redhat.com>
In-Reply-To: <20210209032733.99996-1-gshan@redhat.com>
References: <20210209032733.99996-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index b2d51c6d055c..30e850257ef4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -47,6 +47,7 @@
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
index a7ae16df3df7..e243bd5ad730 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -668,6 +668,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
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

