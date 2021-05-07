Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1840237604C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEGGdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234570AbhEGGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkw3mJqS3pBDC+aanz8yHsGj1AbHq5g++Wkg6vpucq8=;
        b=IgwZ9k64kfmQF7Y+I3gbO3ilKKOfXbJLLSuQ0tnGoutRcMhxQMfutAkpEWxnOfKS4rnRdt
        ik602hbRZXF6543vZVjz3jYb1qqUHNIpjerWMJA7ggWx+HJ4gtROdsZY8nKibYDn9Ka1KX
        g91Uwj1BdI2n5A8ibjaJphbi6S7fPMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-PgY7dkPlN3GJfqZLDpyntA-1; Fri, 07 May 2021 02:31:52 -0400
X-MC-Unique: PgY7dkPlN3GJfqZLDpyntA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E120800D62;
        Fri,  7 May 2021 06:31:51 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1655F5D9CA;
        Fri,  7 May 2021 06:31:47 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 05/21] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE} hypercall
Date:   Fri,  7 May 2021 16:31:08 +0800
Message-Id: <20210507083124.43347-6-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_{ENABLE, DISABLE} hypercall. After SDEI
event is registered by guest, it won't be delivered to the guest
until it's enabled. On the other hand, the SDEI event won't be
raised to the guest or specific vCPU if it's has been disabled
on the guest or specific vCPU.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index d3ea3eee154b..b022ce0a202b 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -206,6 +206,70 @@ static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
+					       bool enable)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
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
+	/* Check if the KVM event exists */
+	spin_lock(&ksdei->lock);
+	kske = kvm_sdei_find_kvm_event(kvm, event_num);
+	if (!kske) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Check if there is pending events */
+	if (kske->state.refcount) {
+		ret = SDEI_PENDING;
+		goto unlock;
+	}
+
+	/* Check if it has been registered */
+	kse = kske->kse;
+	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
+		vcpu->vcpu_idx : 0;
+	if (!kvm_sdei_is_registered(kske, index)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Verify its enablement state */
+	if (enable == kvm_sdei_is_enabled(kske, index)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Update enablement state */
+	if (enable)
+		kvm_sdei_set_enabled(kske, index);
+	else
+		kvm_sdei_clear_enabled(kske, index);
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
@@ -220,7 +284,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_register(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+		ret = kvm_sdei_hypercall_enable(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+		ret = kvm_sdei_hypercall_enable(vcpu, false);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
-- 
2.23.0

