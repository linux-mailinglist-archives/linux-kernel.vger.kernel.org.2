Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9C3EC62A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhHOAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234603AbhHOAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkw3mJqS3pBDC+aanz8yHsGj1AbHq5g++Wkg6vpucq8=;
        b=bOvfdpAws91hk7kkn/N0F6iO+Thc9ulY8A0FM7HcwA/BEv3v8g0xqtGdXwlUpufSG5xznW
        yGExSthZBKgzheF0AudtYfgQis64vyXa2PeSUpdE0/VjwPufRN6noMMk7WOCVQOYstq6iC
        BY3QJNlat5W2e9W1phXZKOGotfwQe0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-X54qic6NOzuKUcFWJQGk6Q-1; Sat, 14 Aug 2021 20:14:41 -0400
X-MC-Unique: X54qic6NOzuKUcFWJQGk6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3691082921;
        Sun, 15 Aug 2021 00:14:40 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D65610016FF;
        Sun, 15 Aug 2021 00:14:35 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 05/21] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE} hypercall
Date:   Sun, 15 Aug 2021 08:13:36 +0800
Message-Id: <20210815001352.81927-6-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

