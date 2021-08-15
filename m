Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729443EC629
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhHOAPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234869AbhHOAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubxkg7uim21uCK1vxap6rQ8RNDE8i62rIz2Zup72MRU=;
        b=SGA1s4KN+D+w0QYLg84XEF8zoGK5jiy4QS4MilaAPzKGPvh6gaK5nAq+fGs3CIjwxhQgOB
        bbh85OymtO01Yubgwd7YYAeAOQEjH8vJ7xMmjZXrvL+uN4IlBUpdU2ekAhhciUA6B6Zmff
        Jy8TutycJNxaZ33KoZsvd5oHjDeR0M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-GIXAJF41OueNGIp9a1IrMA-1; Sat, 14 Aug 2021 20:14:36 -0400
X-MC-Unique: GIXAJF41OueNGIp9a1IrMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0E151008062;
        Sun, 15 Aug 2021 00:14:34 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 846B410016FF;
        Sun, 15 Aug 2021 00:14:30 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 04/21] KVM: arm64: Support SDEI_EVENT_REGISTER hypercall
Date:   Sun, 15 Aug 2021 08:13:35 +0800
Message-Id: <20210815001352.81927-5-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_REGISTER hypercall, which is used by guest
to register SDEI events. The SDEI event won't be raised to the guest
or specific vCPU until it's registered and enabled explicitly.

Only those events that have been exported by KVM can be registered.
After the event is registered successfully, the KVM SDEI event (object)
is created or updated because the same KVM SDEI event is shared by
multiple vCPUs if it's a private event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 122 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index aa9485f076a9..d3ea3eee154b 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -21,6 +21,20 @@ static struct kvm_sdei_event_state defined_kse[] = {
 	},
 };
 
+static struct kvm_sdei_event *kvm_sdei_find_event(struct kvm *kvm,
+						  unsigned long num)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_event *kse;
+
+	list_for_each_entry(kse, &ksdei->events, link) {
+		if (kse->state.num == num)
+			return kse;
+	}
+
+	return NULL;
+}
+
 static void kvm_sdei_remove_events(struct kvm *kvm)
 {
 	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
@@ -32,6 +46,20 @@ static void kvm_sdei_remove_events(struct kvm *kvm)
 	}
 }
 
+static struct kvm_sdei_kvm_event *kvm_sdei_find_kvm_event(struct kvm *kvm,
+							  unsigned long num)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_kvm_event *kske;
+
+	list_for_each_entry(kske, &ksdei->kvm_events, link) {
+		if (kske->state.num == num)
+			return kske;
+	}
+
+	return NULL;
+}
+
 static void kvm_sdei_remove_kvm_events(struct kvm *kvm,
 				       unsigned int mask,
 				       bool force)
@@ -86,6 +114,98 @@ static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long event_entry = smccc_get_arg2(vcpu);
+	unsigned long event_param = smccc_get_arg3(vcpu);
+	unsigned long route_mode = smccc_get_arg4(vcpu);
+	unsigned long route_affinity = smccc_get_arg5(vcpu);
+	int index = vcpu->vcpu_idx;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	if (!kvm_sdei_is_valid_event_num(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
+	      route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/*
+	 * The KVM event could have been created if it's a private event.
+	 * We needn't create a KVM event in this case.
+	 */
+	spin_lock(&ksdei->lock);
+	kske = kvm_sdei_find_kvm_event(kvm, event_num);
+	if (kske) {
+		kse = kske->kse;
+		index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
+			vcpu->vcpu_idx : 0;
+
+		if (kvm_sdei_is_registered(kske, index)) {
+			ret = SDEI_DENIED;
+			goto unlock;
+		}
+
+		kske->state.route_mode     = route_mode;
+		kske->state.route_affinity = route_affinity;
+		kske->state.entries[index] = event_entry;
+		kske->state.params[index]  = event_param;
+		kvm_sdei_set_registered(kske, index);
+		goto unlock;
+	}
+
+	/* Check if the event number has been registered */
+	kse = kvm_sdei_find_event(kvm, event_num);
+	if (!kse) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Create KVM event */
+	kske = kzalloc(sizeof(*kske), GFP_KERNEL);
+	if (!kske) {
+		ret = SDEI_OUT_OF_RESOURCE;
+		goto unlock;
+	}
+
+	/* Initialize KVM event state */
+	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
+		vcpu->vcpu_idx : 0;
+	kske->state.num            = event_num;
+	kske->state.refcount       = 0;
+	kske->state.route_mode     = route_affinity;
+	kske->state.route_affinity = route_affinity;
+	kske->state.entries[index] = event_entry;
+	kske->state.params[index] = event_param;
+	kvm_sdei_set_registered(kske, index);
+
+	/* Initialize KVM event */
+	kske->kse = kse;
+	kske->kvm = kvm;
+	list_add_tail(&kske->link, &ksdei->kvm_events);
+
+unlock:
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -97,6 +217,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_version(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+		ret = kvm_sdei_hypercall_register(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
-- 
2.23.0

