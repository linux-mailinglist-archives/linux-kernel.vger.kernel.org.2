Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E4376047
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhEGGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234546AbhEGGcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toYzNZZUsbLVhs2/hMzVNhADr0F7QBQqkE7WJWgA228=;
        b=iR6vVqjQAAgJRaC/Apbi34DsPZdjqHG9i34AKkrAoCe5pbjfIONY8lMdCgSB/pnzhZIt67
        OKiyNZksjAYgPiMd8iW39WFIGZ7ibF7U4h61oBHD6+t5iJniQYfmyU6V6dvzEyQCfgR45X
        wpBfvSww/8uFbkK2eLyGARZfF8Cmk2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-ZBJolDUiN6-tQF2KJIApIw-1; Fri, 07 May 2021 02:31:45 -0400
X-MC-Unique: ZBJolDUiN6-tQF2KJIApIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05BFB195D561;
        Fri,  7 May 2021 06:31:44 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 062E25D9CA;
        Fri,  7 May 2021 06:31:40 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        pbonzini@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
        Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v3 03/21] KVM: arm64: Support SDEI_VERSION hypercall
Date:   Fri,  7 May 2021 16:31:06 +0800
Message-Id: <20210507083124.43347-4-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_VERSION hypercall by returning v1.0.0 simply
when the functionality is supported on the VM and vCPU.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index ab330b74a965..aa9485f076a9 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -70,6 +70,22 @@ static void kvm_sdei_remove_vcpu_events(struct kvm_vcpu *vcpu)
 	}
 }
 
+static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned long ret = SDEI_NOT_SUPPORTED;
+
+	if (!(ksdei && vsdei))
+		return ret;
+
+	/* v1.0.0 */
+	ret = (1UL << SDEI_VERSION_MAJOR_SHIFT);
+
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -78,6 +94,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 
 	switch (func) {
 	case SDEI_1_0_FN_SDEI_VERSION:
+		ret = kvm_sdei_hypercall_version(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
 	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
-- 
2.23.0

