Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC83C74CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhGMQhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhGMQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:37:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17844C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x15-20020a25ce0f0000b029055bb0981111so27836585ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CgrSZBstNZwFy9Uo6jdcpFw84xBpoqNrT77cRxMhd+E=;
        b=dIYjzPGsJ6TLn2wVcO+Ux1e9QGqStPI+HZp8nyXUUAtU47hnu0NRDZeyBPGX0xFdOO
         CXTsHUJY33F6lOorYUZ0Llq6fkPEaeM4tReHGBoya2vw8YVLMng/27ngwKQy82UJdyvq
         41l7qU7Vk53muwMcq7TtV5Zh1c4lwHBklW7C9ce/5AfBsbN+9oAHO5/C60HoBLd8np7H
         K/rngvmcWlQFtWxii1lpF4dxVsiOTrn6nxvHagBhdOuPiTMMRZs7CM3/jFZazKs2aWkV
         G0kawCHRm+J0IE3KlcNr1SEAFRDRvWLkCRIksCBe0P6T4ZNiuZ0wsS2VYZwSWvUzLt0z
         qa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CgrSZBstNZwFy9Uo6jdcpFw84xBpoqNrT77cRxMhd+E=;
        b=j8nuahKTaGk++JNzAuRY7n5+tuF9UqxvnNHAGbXKMFZM/DinaIhBNQ6Y6KF+d5Hv8c
         idUz8Rx0OObADqkrQYD9wjUv3dyzQ+Mo4tlLEwUbSmkKMvD67h4RFfazWF/PeQ6cGmvr
         Dqh1IvrfRrZBseQnPwTjIsbYbI4b2RTlGUC4HaFSHCPObgw+7SaOJmLcR1VJ9tVOQHW7
         NKafuBJ71keFn8ObqO3B0RhwZfGsJ1QRiAJ5h2/EcUNv8yFP1lyohwZN1ouW2YjhVpv7
         /nTF895h5tzrfL4xkhHeK5wIENeJYwHdZX8li4R9EuHmVCWeOa30dL7njJ8RXqbMofPt
         dn4w==
X-Gm-Message-State: AOAM532gFkpqBWR63rUjapEAX+Z/XN1kvnrQkOWO1c3fqVKfkFkFcycr
        6bsRh+vj3XtGjpzy1ugXnmMaild7280=
X-Google-Smtp-Source: ABdhPJyAx6+D/2SdrYQx5dm7fHrEFUIbnOPmhfqtgcFzKyqmQ1LUZK792ZNmUj9molVy3SElH+EwUtvhOuY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:258:: with SMTP id 85mr7222066ybc.109.1626194061338;
 Tue, 13 Jul 2021 09:34:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:03 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-26-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 25/46] KVM: VMX: Pull GUEST_CR3 from the VMCS iff CR3 load
 exiting is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak the logic for grabbing vmcs.GUEST_CR3 in vmx_cache_reg() to look
directly at the execution controls, as opposed to effectively inferring
the controls based on vCPUs.  Inferring the controls isn't wrong, but it
creates a very subtle dependency between the caching logic, the state of
vcpu->arch.cr0 (via is_paging()), and the behavior of vmx_set_cr0().

Using the execution controls doesn't completely eliminate the dependency
in vmx_set_cr0(), e.g. neglecting to cache CR3 before enabling
interception would still break the guest, but it does reduce the
code dependency and mostly eliminate the logical dependency (that CR3
loads are intercepted in certain scenarios).  Eliminating the subtle
read of vcpu->arch.cr0 will also allow for additional cleanup in
vmx_set_cr0().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 58c6d7b98624..d632c0a16f12 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2262,8 +2262,11 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 		vcpu->arch.cr0 |= vmcs_readl(GUEST_CR0) & guest_owned_bits;
 		break;
 	case VCPU_EXREG_CR3:
-		if (is_unrestricted_guest(vcpu) ||
-		    (enable_ept && is_paging(vcpu)))
+		/*
+		 * When intercepting CR3 loads, e.g. for shadowing paging, KVM's
+		 * CR3 is loaded into hardware, not the guest's CR3.
+		 */
+		if (!(exec_controls_get(to_vmx(vcpu)) & CPU_BASED_CR3_LOAD_EXITING))
 			vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
 		break;
 	case VCPU_EXREG_CR4:
-- 
2.32.0.93.g670b81a890-goog

