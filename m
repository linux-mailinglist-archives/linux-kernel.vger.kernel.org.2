Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56931472A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBIDoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230392AbhBIDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612841494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAcXwo0Oru0ZxTATfw4I2VSKoXfBLIT/f+dSWdjupcA=;
        b=GmDX2sStC7dbqBO+9R4PqxjbHMm7Ini76gi3EiU3ZXtWMOUw7T6lYS605mFSUBBIwloS0g
        V1uXZHZkIg/ExZeMvpHNdaGw+2d/ctXpPKeDwJ3OayiEmBc+2u1dvseYyzgIh3EPLTQjWz
        u7Cm/V0bY8H7GoiUN/MG7rNsrrtYSaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-NCdWv4KwOj2_o0NG7VVE0Q-1; Mon, 08 Feb 2021 22:28:02 -0500
X-MC-Unique: NCdWv4KwOj2_o0NG7VVE0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6682192D789;
        Tue,  9 Feb 2021 03:28:00 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 532B319C66;
        Tue,  9 Feb 2021 03:27:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 01/21] KVM: arm64: Introduce template for inline functions
Date:   Tue,  9 Feb 2021 11:27:13 +0800
Message-Id: <20210209032733.99996-2-gshan@redhat.com>
In-Reply-To: <20210209032733.99996-1-gshan@redhat.com>
References: <20210209032733.99996-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline functions used to get the SMCCC parameters have same
layout. It means the logical functionality can be presented by
a template, to make the code simplified. Besides, this adds more
similar inline functions like smccc_get_arg{4,5,6,7,8}() to visit
more SMCCC arguments, which are required by SDEI virtualization
support.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/kvm/arm_hypercalls.h | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 0e2509d27910..1120eff7aa28 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,27 +6,21 @@
 
 #include <asm/kvm_emulate.h>
 
-int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
-
-static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 0);
+#define SMCCC_DECLARE_GET_FUNCTION(type, name, reg)		\
+static inline type smccc_get_##name(struct kvm_vcpu *vcpu)	\
+{								\
+	return vcpu_get_reg(vcpu, (reg));			\
 }
 
-static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 1);
-}
-
-static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 2);
-}
-
-static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 3);
-}
+SMCCC_DECLARE_GET_FUNCTION(u32,           function, 0)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg1,     1)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg2,     2)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg3,     3)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg4,     4)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg5,     5)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg6,     6)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg7,     7)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg8,     8)
 
 static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 				    unsigned long a0,
@@ -40,4 +34,6 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 	vcpu_set_reg(vcpu, 3, a3);
 }
 
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
+
 #endif
-- 
2.23.0

