Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B52376054
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhEGGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234664AbhEGGdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qv6I3logkEqrFKBHAcTSKZ8CXuHzBhGguNUvVqUgdvc=;
        b=Wi2BTsXSO9VTbOoWB8pp1FrUBky3Y2OwISQYJX/FTXHQOM0mUgMcDS3ftFT6jW8bnD78GH
        RbA4niSuFID+VTKabdPVKlLomm14SL8ECoC/a4vCuJjRat26kynX4cWCtPYp9eCljAsITX
        9zyVN2tKQYqUNJ+t9i2DCRGTlIKF6pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-tNYanZKgNaO8rTBcC7itNA-1; Fri, 07 May 2021 02:32:11 -0400
X-MC-Unique: tNYanZKgNaO8rTBcC7itNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E4BD1006C81;
        Fri,  7 May 2021 06:32:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0C05D9DE;
        Fri,  7 May 2021 06:32:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 10/21] KVM: arm64: Support SDEI_EVENT_ROUTING_SET hypercall
Date:   Fri,  7 May 2021 16:31:13 +0800
Message-Id: <20210507083124.43347-11-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
guest to set route mode and affinity for the registered KVM event.
It's only valid for the shared events. It's not allowed to do so
when the corresponding event has been raised to the guest.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 5dfa74b093f1..458695c2394f 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -489,6 +489,68 @@ static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long route_mode = smccc_get_arg2(vcpu);
+	unsigned long route_affinity = smccc_get_arg3(vcpu);
+	int index = 0;
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
+	/* Check if the KVM event has been registered */
+	spin_lock(&ksdei->lock);
+	kske = kvm_sdei_find_kvm_event(kvm, event_num);
+	if (!kske) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Validate KVM event state */
+	kse = kske->kse;
+	if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	if (!kvm_sdei_is_registered(kske, index) ||
+	    kvm_sdei_is_enabled(kske, index)     ||
+	    kske->state.refcount) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Update state */
+	kske->state.route_mode     = route_mode;
+	kske->state.route_affinity = route_affinity;
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
@@ -523,6 +585,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_info(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+		ret = kvm_sdei_hypercall_route(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_PE_MASK:
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
-- 
2.23.0

