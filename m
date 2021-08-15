Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB83EC626
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhHOAO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234251AbhHOAOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLRRRYPCMnK7Bg53hGYpQIyTZPSr6CtdF6RdNjSbfic=;
        b=ewcfxz7IteRV0xf4vhdSleye8glSVXVpZ56MF+8qskGP8hz5mBe8GRi2Okt3Iiy7L+C7BL
        uNfrRLrhV/Ur7P61ooWTc4z630kvOEG0KSzlpB+g+7U6MG0/7+6dNWOEpSkdkby5pLsCKQ
        ZPu+qeZsT88Y0GCc96pElVmGq4Mac3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-DF4XyEFyN3qWyiqDmXpDEQ-1; Sat, 14 Aug 2021 20:14:21 -0400
X-MC-Unique: DF4XyEFyN3qWyiqDmXpDEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C0D81082921;
        Sun, 15 Aug 2021 00:14:20 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2524A10016FF;
        Sun, 15 Aug 2021 00:14:15 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 01/21] KVM: arm64: Introduce template for inline functions
Date:   Sun, 15 Aug 2021 08:13:32 +0800
Message-Id: <20210815001352.81927-2-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline functions used to get the SMCCC parameters have same
layout. It means these functions can be presented by a template,
to make the code simplified. Besides, this adds more similar inline
functions like smccc_get_arg{4,5,6,7,8}() to visit more SMCCC arguments,
which are needed by SDEI virtualization support.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/kvm/arm_hypercalls.h | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 0e2509d27910..ebecb6c68254 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,27 +6,21 @@
 
 #include <asm/kvm_emulate.h>
 
-int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
-
-static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 0);
+#define SMCCC_DECLARE_GET_FUNC(type, name, reg)			\
+static inline type smccc_get_##name(struct kvm_vcpu *vcpu)	\
+{								\
+	return vcpu_get_reg(vcpu, reg);				\
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
+SMCCC_DECLARE_GET_FUNC(u32,           function, 0)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg1,     1)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg2,     2)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg3,     3)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg4,     4)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg5,     5)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg6,     6)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg7,     7)
+SMCCC_DECLARE_GET_FUNC(unsigned long, arg8,     8)
 
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

