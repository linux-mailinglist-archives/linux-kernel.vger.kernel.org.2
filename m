Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B71376062
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhEGGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234688AbhEGGdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQxS0kckLLfXMTmiHSupr8pIZHxkprJHnPvr3AyAtsA=;
        b=F/doexzgi0EJEo4HOsH95EHKZBeGYQ5zRds3uRf58J98vhS8MuMVy5UqoqYLRuDZ/YNhOo
        sQlupqN064BFpqN3JgLm5FTB0tR6Oe+SsNp0aqke6KR0OmMmaUaY0OIO1c42tw5NDe6XYG
        NH6r1aDLvwCroGsnRoryYXl+gPFmgwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-F3pcjmGtN_6KcuC4TOW6lA-1; Fri, 07 May 2021 02:32:30 -0400
X-MC-Unique: F3pcjmGtN_6KcuC4TOW6lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD91107ACF3;
        Fri,  7 May 2021 06:32:29 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A71785D9CA;
        Fri,  7 May 2021 06:32:21 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 14/21] KVM: arm64: Support SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall
Date:   Fri,  7 May 2021 16:31:17 +0800
Message-Id: <20210507083124.43347-15-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
They are used by the guest to notify the completion of the SDEI
event in the handler. The registers are changed according to the
SDEI specification as below:

   * x0 - x17, PC and PState are restored to what values we had in
     the interrupted context.

   * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
     is injected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/hyp/exception.c       |  7 +++
 arch/arm64/kvm/inject_fault.c        | 27 ++++++++++
 arch/arm64/kvm/sdei.c                | 75 ++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index f612c090f2e4..0ef213b715a5 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_irq(struct kvm_vcpu *vcpu);
 void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 94570924ae96..8944176efa94 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -425,6 +425,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
 #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
+#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
 /* For AArch64: */
 #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 73629094f903..c1e9bdb67b37 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -309,6 +309,9 @@ void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		case KVM_ARM64_EXCEPT_AA32_DABT:
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
 			break;
+		case KVM_ARM64_EXCEPT_AA32_IRQ:
+			enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 4);
+			break;
 		default:
 			/* Err... */
 			break;
@@ -319,6 +322,10 @@ void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		      KVM_ARM64_EXCEPT_AA64_EL1):
 			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
 			break;
+		case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+		      KVM_ARM64_EXCEPT_AA64_EL1):
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
+			break;
 		default:
 			/*
 			 * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index b47df73e98d7..3a8c55867d2f 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
 }
 
+static void inject_irq64(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
+			     KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 #define DFSR_FSC_EXTABT_LPAE	0x10
 #define DFSR_FSC_EXTABT_nLPAE	0x08
 #define DFSR_LPAE		BIT(9)
@@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
 			     KVM_ARM64_PENDING_EXCEPTION);
 }
 
+static void inject_irq32(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 /*
  * Modelled after TakeDataAbortException() and TakePrefetchAbortException
  * pseudocode.
@@ -160,6 +173,20 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 		inject_undef64(vcpu);
 }
 
+/**
+ * kvm_inject_irq - inject an IRQ into the guest
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_irq(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_el1_is_32bit(vcpu))
+		inject_irq32(vcpu);
+	else
+		inject_irq64(vcpu);
+}
+
 void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b5d6d1ed3858..1e8e213c9d70 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -308,6 +308,75 @@ static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
+						 bool resume)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+	struct kvm_sdei_vcpu_regs *regs;
+	unsigned long ret = SDEI_SUCCESS;
+	int index;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	spin_lock(&vsdei->lock);
+	if (vsdei->critical_event) {
+		ksve = vsdei->critical_event;
+		regs = &vsdei->state.critical_regs;
+		vsdei->critical_event = NULL;
+		vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
+	} else if (vsdei->normal_event) {
+		ksve = vsdei->normal_event;
+		regs = &vsdei->state.normal_regs;
+		vsdei->normal_event = NULL;
+		vsdei->state.normal_num = KVM_SDEI_INVALID_NUM;
+	} else {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Restore registers: x0 -> x17, PC, PState */
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		vcpu_set_reg(vcpu, index, regs->regs[index]);
+
+	*vcpu_cpsr(vcpu) = regs->pstate;
+	*vcpu_pc(vcpu) = regs->pc;
+
+	/* Inject interrupt if needed */
+	if (resume)
+		kvm_inject_irq(vcpu);
+
+	/*
+	 * Update state. We needn't take lock in order to update the KVM
+	 * event state as it's not destroyed because of the reference
+	 * count.
+	 */
+	kske = ksve->kske;
+	ksve->state.refcount--;
+	kske->state.refcount--;
+	if (!ksve->state.refcount) {
+		list_del(&ksve->link);
+		kfree(ksve);
+	}
+
+	/* Make another request if there is pending event */
+	if (!(list_empty(&vsdei->critical_events) &&
+	      list_empty(&vsdei->normal_events)))
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -628,7 +697,13 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_context(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+		has_result = false;
+		ret = kvm_sdei_hypercall_complete(vcpu, false);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+		has_result = false;
+		ret = kvm_sdei_hypercall_complete(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = kvm_sdei_hypercall_unregister(vcpu);
 		break;
-- 
2.23.0

