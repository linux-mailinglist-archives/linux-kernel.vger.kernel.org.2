Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8839B2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDGul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:50:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4346 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFDGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:50:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxCtp2bjyz68ZN;
        Fri,  4 Jun 2021 14:45:06 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:48:49 +0800
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:48:48 +0800
From:   Shenming Lu <lushenming@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <lushenming@huawei.com>
Subject: [PATCH] KVM: arm64: vgic: Communicate a change of the IRQ state via vgic_queue_irq_unlock
Date:   Fri, 4 Jun 2021 14:48:28 +0800
Message-ID: <20210604064828.1497-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Some time ago, you suggested that we should communicate a change
of the IRQ state via vgic_queue_irq_unlock [1], which needs to
include dropping the IRQ from the VCPU's ap_list if the IRQ is
not pending or enabled but on the ap_list. And I additionally
add a case where the IRQ has to be migrated to another ap_list.

(maybe you forget this...)
Does this patch match your thought at the time?

[1] https://lore.kernel.org/patchwork/patch/1371884/

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 arch/arm64/kvm/vgic/vgic.c | 116 ++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 15b666200f0b..9b88d49aa439 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -326,8 +326,9 @@ static bool vgic_validate_injection(struct vgic_irq *irq, bool level, void *owne
 
 /*
  * Check whether an IRQ needs to (and can) be queued to a VCPU's ap list.
- * Do the queuing if necessary, taking the right locks in the right order.
- * Returns true when the IRQ was queued, false otherwise.
+ * Do the queuing, dropping or migrating if necessary, taking the right
+ * locks in the right order. Returns true when the IRQ was queued, false
+ * otherwise.
  *
  * Needs to be entered with the IRQ lock already held, but will return
  * with all locks dropped.
@@ -335,49 +336,38 @@ static bool vgic_validate_injection(struct vgic_irq *irq, bool level, void *owne
 bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 			   unsigned long flags)
 {
+	struct kvm_vcpu *target_vcpu;
 	struct kvm_vcpu *vcpu;
+	bool ret = false;
 
 	lockdep_assert_held(&irq->irq_lock);
 
 retry:
-	vcpu = vgic_target_oracle(irq);
-	if (irq->vcpu || !vcpu) {
+	target_vcpu = vgic_target_oracle(irq);
+	vcpu = irq->vcpu;
+	if (target_vcpu == vcpu) {
 		/*
-		 * If this IRQ is already on a VCPU's ap_list, then it
-		 * cannot be moved or modified and there is no more work for
+		 * If this IRQ's state is consistent with whether on
+		 * the right ap_lsit or not, there is no more work for
 		 * us to do.
-		 *
-		 * Otherwise, if the irq is not pending and enabled, it does
-		 * not need to be inserted into an ap_list and there is also
-		 * no more work for us to do.
 		 */
 		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
-
-		/*
-		 * We have to kick the VCPU here, because we could be
-		 * queueing an edge-triggered interrupt for which we
-		 * get no EOI maintenance interrupt. In that case,
-		 * while the IRQ is already on the VCPU's AP list, the
-		 * VCPU could have EOI'ed the original interrupt and
-		 * won't see this one until it exits for some other
-		 * reason.
-		 */
-		if (vcpu) {
-			kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
-			kvm_vcpu_kick(vcpu);
-		}
-		return false;
+		goto out;
 	}
 
 	/*
 	 * We must unlock the irq lock to take the ap_list_lock where
-	 * we are going to insert this new pending interrupt.
+	 * we are going to insert/drop this IRQ.
 	 */
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	/* someone can do stuff here, which we re-check below */
 
-	raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	if (target_vcpu)
+		raw_spin_lock_irqsave(&target_vcpu->arch.vgic_cpu.ap_list_lock,
+				      flags);
+	if (vcpu)
+		raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 	raw_spin_lock(&irq->irq_lock);
 
 	/*
@@ -392,30 +382,74 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 	 * In both cases, drop the locks and retry.
 	 */
 
-	if (unlikely(irq->vcpu || vcpu != vgic_target_oracle(irq))) {
+	if (unlikely(target_vcpu != vgic_target_oracle(irq) ||
+		     vcpu != irq->vcpu)) {
 		raw_spin_unlock(&irq->irq_lock);
-		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock,
-					   flags);
+		if (target_vcpu)
+			raw_spin_unlock_irqrestore(&target_vcpu->arch.vgic_cpu.ap_list_lock,
+						   flags);
+		if (vcpu)
+			raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock,
+						   flags);
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		goto retry;
 	}
 
-	/*
-	 * Grab a reference to the irq to reflect the fact that it is
-	 * now in the ap_list.
-	 */
-	vgic_get_irq_kref(irq);
-	list_add_tail(&irq->ap_list, &vcpu->arch.vgic_cpu.ap_list_head);
-	irq->vcpu = vcpu;
+	if (!vcpu && target_vcpu) {
+		/*
+		 * Insert this new pending interrupt.
+		 * Grab a reference to the irq to reflect the fact that
+		 * it is now in the ap_list.
+		 */
+		vgic_get_irq_kref(irq);
+		list_add_tail(&irq->ap_list,
+			      &target_vcpu->arch.vgic_cpu.ap_list_head);
+		irq->vcpu = target_vcpu;
+		ret = true;
+	} else if (vcpu && !target_vcpu) {
+		/*
+		 * This IRQ is not pending or enabled but on the ap_list,
+		 * drop it from the ap_list.
+		 */
+		list_del(&irq->ap_list);
+		irq->vcpu = NULL;
+		raw_spin_unlock(&irq->irq_lock);
+		vgic_put_irq(vcpu->kvm, irq);
+		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock,
+					   flags);
+		goto out;
+	} else {
+		/* This IRQ looks like it has to be migrated. */
+		list_del(&irq->ap_list);
+		list_add_tail(&irq->ap_list,
+			      &target_vcpu->arch.vgic_cpu.ap_list_head);
+		irq->vcpu = target_vcpu;
+	}
 
 	raw_spin_unlock(&irq->irq_lock);
-	raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	if (target_vcpu)
+		raw_spin_unlock_irqrestore(&target_vcpu->arch.vgic_cpu.ap_list_lock,
+					   flags);
+	if (vcpu)
+		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 
-	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
-	kvm_vcpu_kick(vcpu);
+out:
+	/*
+	 * Even for the already queuing rightly case we have
+	 * to kick the VCPU, because we could be queueing an
+	 * edge-triggered interrupt for which we get no EOI
+	 * maintenance interrupt. In that case, while the IRQ
+	 * is already on the VCPU's AP list, the VCPU could
+	 * have EOI'ed the original interrupt and won't see
+	 * this one until it exits for some other reason.
+	 */
+	if (target_vcpu) {
+		kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
+		kvm_vcpu_kick(target_vcpu);
+	}
 
-	return true;
+	return ret;
 }
 
 /**
-- 
2.19.1

