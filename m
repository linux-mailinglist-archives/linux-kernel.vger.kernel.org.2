Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3537605A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhEGGdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234665AbhEGGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIDwCkL9mTzseLSOiYSJi53v9LCFA/ZgcOnwxmcbcnA=;
        b=LPyNDrH8fVAKkes5i+rrYdAXtuB13WL5ccVisYOo1abYfEcGNqIMnFqRnHsQ5Ar2PJrTV0
        y9MBrKPp2ZYrICVtMWcBcolzoZWJybVECKSVsEycvXYenXXddjbF4fv7BEoT8E1bAxegj2
        SSuUEOIefdF5Em9S+ZUzdx+TI48ptVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-IGdj0MP5OrSa06Vd3W50IA-1; Fri, 07 May 2021 02:32:15 -0400
X-MC-Unique: IGdj0MP5OrSa06Vd3W50IA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DAD4195D560;
        Fri,  7 May 2021 06:32:13 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACC25D9DE;
        Fri,  7 May 2021 06:32:09 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 11/21] KVM: arm64: Support SDEI_PE_{MASK, UNMASK} hypercall
Date:   Fri,  7 May 2021 16:31:14 +0800
Message-Id: <20210507083124.43347-12-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_PE_{MASK, UNMASK} hypercall. They are used by
the guest to stop the specific vCPU from receiving SDEI events.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 458695c2394f..3fb33258b494 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -551,6 +551,37 @@ static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
+					     bool mask)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	spin_lock(&vsdei->lock);
+
+	/* Check the state */
+	if (mask == vsdei->state.masked) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Update the state */
+	vsdei->state.masked = mask ? 1 : 0;
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
@@ -588,7 +619,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_route(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_PE_MASK:
+		ret = kvm_sdei_hypercall_mask(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+		ret = kvm_sdei_hypercall_mask(vcpu, false);
+		break;
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
 	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
-- 
2.23.0

