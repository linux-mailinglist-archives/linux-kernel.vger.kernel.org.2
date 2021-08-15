Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164A23EC643
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhHOAQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhHOAP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sW1X3gp7m/GFtVG+z9c8/k60gef/0uXdphaW+9SFdnQ=;
        b=eFdzhEejphhI3KvYKil9Tt8dk1JUtPNFWi3mK/VeOus4DF5+CZ1vlDT+u8UYbnxm5mpFvo
        rsEH2qiNJabTPcmvnwzeP3G3FJiDJyDsjgLf9Pk0z2jMRmePEbTR3Fwq1JGJPUjX6vjno/
        70w3MhiN41IW8fyQn/ceJEH53LBo35s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-XoiDwPOUOyaoGvvTFvid5w-1; Sat, 14 Aug 2021 20:15:27 -0400
X-MC-Unique: XoiDwPOUOyaoGvvTFvid5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E897187122E;
        Sun, 15 Aug 2021 00:15:25 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C70DD10016FF;
        Sun, 15 Aug 2021 00:15:22 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 15/21] KVM: arm64: Support SDEI event notifier
Date:   Sun, 15 Aug 2021 08:13:46 +0800
Message-Id: <20210815001352.81927-16-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The owner of the SDEI event, like asynchronous page fault, need
know the state of injected SDEI event. This supports SDEI event
state updating by introducing notifier mechanism. It's notable
the notifier (handler) should be capable of migration.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h      | 12 +++++++
 arch/arm64/include/uapi/asm/kvm_sdei.h |  1 +
 arch/arm64/kvm/sdei.c                  | 45 +++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 7f5f5ad689e6..19f2d9b91f85 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -16,6 +16,16 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+struct kvm_vcpu;
+
+typedef void (*kvm_sdei_notifier)(struct kvm_vcpu *vcpu,
+				  unsigned long num,
+				  unsigned int state);
+enum {
+	KVM_SDEI_NOTIFY_DELIVERED,
+	KVM_SDEI_NOTIFY_COMPLETED,
+};
+
 struct kvm_sdei_event {
 	struct kvm_sdei_event_state		state;
 	struct kvm				*kvm;
@@ -112,6 +122,8 @@ KVM_SDEI_FLAG_FUNC(enabled)
 void kvm_sdei_init_vm(struct kvm *kvm);
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
+int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
+			       kvm_sdei_notifier notifier);
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vm(struct kvm *kvm);
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
index 8928027023f6..4ef661d106fe 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -23,6 +23,7 @@ struct kvm_sdei_event_state {
 	__u8	type;
 	__u8	signaled;
 	__u8	priority;
+	__u64	notifier;
 };
 
 struct kvm_sdei_kvm_event_state {
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 1e8e213c9d70..5f7a37dcaa77 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -314,9 +314,11 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
 	struct kvm_sdei_kvm_event *kske = NULL;
 	struct kvm_sdei_vcpu_event *ksve = NULL;
 	struct kvm_sdei_vcpu_regs *regs;
+	kvm_sdei_notifier notifier;
 	unsigned long ret = SDEI_SUCCESS;
 	int index;
 
@@ -349,6 +351,13 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
 	*vcpu_cpsr(vcpu) = regs->pstate;
 	*vcpu_pc(vcpu) = regs->pc;
 
+	/* Notifier */
+	kske = ksve->kske;
+	kse = kske->kse;
+	notifier = (kvm_sdei_notifier)(kse->state.notifier);
+	if (notifier)
+		notifier(vcpu, kse->state.num, KVM_SDEI_NOTIFY_COMPLETED);
+
 	/* Inject interrupt if needed */
 	if (resume)
 		kvm_inject_irq(vcpu);
@@ -358,7 +367,6 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
 	 * event state as it's not destroyed because of the reference
 	 * count.
 	 */
-	kske = ksve->kske;
 	ksve->state.refcount--;
 	kske->state.refcount--;
 	if (!ksve->state.refcount) {
@@ -746,6 +754,35 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+int kvm_sdei_register_notifier(struct kvm *kvm,
+			       unsigned long num,
+			       kvm_sdei_notifier notifier)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	int ret = 0;
+
+	if (!ksdei) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	kse = kvm_sdei_find_event(kvm, num);
+	if (!kse) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	kse->state.notifier = (unsigned long)notifier;
+
+unlock:
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -755,6 +792,7 @@ void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
 	struct kvm_sdei_kvm_event *kske = NULL;
 	struct kvm_sdei_vcpu_event *ksve = NULL;
 	struct kvm_sdei_vcpu_regs *regs = NULL;
+	kvm_sdei_notifier notifier;
 	unsigned long pstate;
 	int index = 0;
 
@@ -826,6 +864,11 @@ void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) = pstate;
 	*vcpu_pc(vcpu) = kske->state.entries[index];
 
+	/* Notifier */
+	notifier = (kvm_sdei_notifier)(kse->state.notifier);
+	if (notifier)
+		notifier(vcpu, kse->state.num, KVM_SDEI_NOTIFY_DELIVERED);
+
 unlock:
 	spin_unlock(&vsdei->lock);
 }
-- 
2.23.0

