Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECA3EC62B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhHOAP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235147AbhHOAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmO12IyDy5qzS+T4IY7K2Y+LJ28N9E7M0ofJOxtqPww=;
        b=dX68h4rbliuiuB33xbxFtF1BpDC1QzSSU9/NRR9UaJKTFmkwDwHOki377w+dSDPzkv9k4j
        2Zh2fplf5zSgXw6jqTM9pJVbpDfunMRts3iew3SMvKgtnTpfpBKRHB7m8VZkso/QOQn7v/
        FY4eeXwXrQpKOkzHaiUHbfYDv48AUlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-9WEdRhYoN1KUkZXSz3d9ug-1; Sat, 14 Aug 2021 20:14:45 -0400
X-MC-Unique: 9WEdRhYoN1KUkZXSz3d9ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7438B1008068;
        Sun, 15 Aug 2021 00:14:44 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07F211036D2E;
        Sun, 15 Aug 2021 00:14:40 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Date:   Sun, 15 Aug 2021 08:13:37 +0800
Message-Id: <20210815001352.81927-7-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
to retrieved the original registers (R0 - R17) in its SDEI event
handler. Those registers can be corrupted during the SDEI event
delivery.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b022ce0a202b..b4162efda470 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -270,6 +270,44 @@ static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_regs *regs;
+	unsigned long index = smccc_get_arg1(vcpu);
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	if (index > ARRAY_SIZE(vsdei->state.critical_regs.regs)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/* Check if the pending event exists */
+	spin_lock(&vsdei->lock);
+	if (!(vsdei->critical_event || vsdei->normal_event)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Fetch the requested register */
+	regs = vsdei->critical_event ? &vsdei->state.critical_regs :
+				       &vsdei->state.normal_regs;
+	ret = regs->regs[index];
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -290,6 +328,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_enable(vcpu, false);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+		ret = kvm_sdei_hypercall_context(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
-- 
2.23.0

