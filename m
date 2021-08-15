Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF17F3EC63D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhHOAQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234734AbhHOAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCbS7qRJkXwtXTweMfCEBwqKoyLH3IhRHr47SvYqe9g=;
        b=E52odQMbxS3nj94rf+p233FSmltMI+1+YcALBh0YpctQhsAQVb8PltUCaMo4TcuLLasLdZ
        mseKi2ZonJApYp39/Mzu7KzMKxWk/wfvzYAswFmvRziToit+z3xC860Ni2+KrK/9DE31QR
        K1CmI2C/qW18L4l+uoSC8IelQqlXNXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-f45sO173PNyenFrKo1rTdw-1; Sat, 14 Aug 2021 20:15:01 -0400
X-MC-Unique: f45sO173PNyenFrKo1rTdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E631008062;
        Sun, 15 Aug 2021 00:14:59 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A53BC1036D2E;
        Sun, 15 Aug 2021 00:14:55 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 09/21] KVM: arm64: Support SDEI_EVENT_GET_INFO hypercall
Date:   Sun, 15 Aug 2021 08:13:40 +0800
Message-Id: <20210815001352.81927-10-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_GET_INFO hypercall. It's used by the guest
to retrieve various information about the supported (exported) events,
including type, signaled, route mode and affinity for the shared
events.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b95b8c4455e1..5dfa74b093f1 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -415,6 +415,80 @@ static unsigned long kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long event_info = smccc_get_arg2(vcpu);
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
+	/*
+	 * Check if the KVM event exists. The event might have been
+	 * registered, we need fetch the information from the registered
+	 * event in that case.
+	 */
+	spin_lock(&ksdei->lock);
+	kske = kvm_sdei_find_kvm_event(kvm, event_num);
+	kse = kske ? kske->kse : NULL;
+	if (!kse) {
+		kse = kvm_sdei_find_event(kvm, event_num);
+		if (!kse) {
+			ret = SDEI_INVALID_PARAMETERS;
+			goto unlock;
+		}
+	}
+
+	/* Retrieve the requested information */
+	switch (event_info) {
+	case SDEI_EVENT_INFO_EV_TYPE:
+		ret = kse->state.type;
+		break;
+	case SDEI_EVENT_INFO_EV_SIGNALED:
+		ret = kse->state.signaled;
+		break;
+	case SDEI_EVENT_INFO_EV_PRIORITY:
+		ret = kse->state.priority;
+		break;
+	case SDEI_EVENT_INFO_EV_ROUTING_MODE:
+	case SDEI_EVENT_INFO_EV_ROUTING_AFF:
+		if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
+			ret = SDEI_INVALID_PARAMETERS;
+			break;
+		}
+
+		if (event_info == SDEI_EVENT_INFO_EV_ROUTING_MODE) {
+			ret = kske ? kske->state.route_mode :
+				     SDEI_EVENT_REGISTER_RM_ANY;
+		} else {
+			ret = kske ? kske->state.route_affinity : 0;
+		}
+
+		break;
+	default:
+		ret = SDEI_INVALID_PARAMETERS;
+	}
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
@@ -446,6 +520,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_status(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+		ret = kvm_sdei_hypercall_info(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
 	case SDEI_1_0_FN_SDEI_PE_MASK:
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
-- 
2.23.0

