Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51023EC640
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhHOAQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235077AbhHOAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DElgAKnXxGi8roylqPYAKEl/MuVnVKXjV89e67/IzUs=;
        b=CMBNbzrSvgbFLHgHqQta1SlwRmrjfrMclAJC6NOmdy8qi792ILmhVlR/fQwmY9KKH90Hmy
        q7yHWl6sG7YMPqM1PyqQW0CPzLIh83/nSnOEbL0UIy3tRuFgnXaCWZqNSNiW3eFBRo5RMY
        85xxZoLPVVQrGCtIBwfUzemMFADcpnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-u7EXkTDYPOCrt3foqR6R_Q-1; Sat, 14 Aug 2021 20:15:12 -0400
X-MC-Unique: u7EXkTDYPOCrt3foqR6R_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7452C801B3D;
        Sun, 15 Aug 2021 00:15:11 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B44B1036D2E;
        Sun, 15 Aug 2021 00:15:08 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 12/21] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET hypercall
Date:   Sun, 15 Aug 2021 08:13:43 +0800
Message-Id: <20210815001352.81927-13-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

