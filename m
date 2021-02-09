Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0B314746
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBIEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230051AbhBIDmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612842031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DElgAKnXxGi8roylqPYAKEl/MuVnVKXjV89e67/IzUs=;
        b=AmvLA8n/w5sZlD75q2hR4qgUVncSempWrPj2FU59XySzyWh3fRcgD1Lbf0O088tBEn4IjV
        p16s8OauUX5Sk/GUVdYJ/p8/DvdxqWD0kKtOobnIqpJDdVl2T6ZnlADu9asvLvCxSRLaLe
        sGNVohJY8o1aWxf8hY5Tt+WuNTCFyUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-EkIbA_6xNSmNEdhguYfIFg-1; Mon, 08 Feb 2021 22:28:43 -0500
X-MC-Unique: EkIbA_6xNSmNEdhguYfIFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF8F8030C1;
        Tue,  9 Feb 2021 03:28:42 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 972DE19727;
        Tue,  9 Feb 2021 03:28:39 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 12/21] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET hypercall
Date:   Tue,  9 Feb 2021 11:27:24 +0800
Message-Id: <20210209032733.99996-13-gshan@redhat.com>
In-Reply-To: <20210209032733.99996-1-gshan@redhat.com>
References: <20210209032733.99996-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_{PRIVATE, SHARED}_RESET. They are used by the
guest to purge the private or shared SDEI events, which are registered
previously.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 3fb33258b494..62efee2b67b8 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -582,6 +582,29 @@ static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_reset(struct kvm_vcpu *vcpu,
+					      bool private)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int mask = private ? (1 << SDEI_EVENT_TYPE_PRIVATE) :
+				      (1 << SDEI_EVENT_TYPE_SHARED);
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+	kvm_sdei_remove_kvm_events(kvm, mask, false);
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -626,8 +649,14 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		break;
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+		ret = SDEI_NOT_SUPPORTED;
+		break;
 	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		ret = kvm_sdei_hypercall_reset(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		ret = kvm_sdei_hypercall_reset(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

