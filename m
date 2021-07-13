Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5D3C74B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhGMQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhGMQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE0C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w13-20020ac843cd0000b0290251f0b91196so8008402qtn.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EX4D+eojcaFEJw7uYtuJ66OnM1pg9jtwgYRDkvzAZPk=;
        b=v5skcrT3HKZ7xQ2i5ono4qCe9BI8iCx1TyHGuIg8UDLy05+b783LKDIH4rcFkL6xzJ
         3KtS0KgaiO5t4nVn7u39gDjZ58gPjSGiDmJKw+lcQDMDGTFKJ8ZVn4wl9fXEKfVBk/Cd
         Btv1eAVs1kbUS19V1NvXCCfHgbc4WAkmBfEtmVmJn4Lv2kQAE/IzKR52ksbjENONv8A4
         GyELtmDz3eZM7sB3agX/9IPiFDiOROnfGFGmWLP60HjKV2qv6xJ1KwANcfan2eyF9WiL
         ge9TpONOShlUc+p/zl5A8mOogVdIGFRtdprH9m/URPDQWdnD7lI3NJUIzsBz0QuYSPrN
         w47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EX4D+eojcaFEJw7uYtuJ66OnM1pg9jtwgYRDkvzAZPk=;
        b=jukXvvwDEJuyQvLT3iCvA3f4Rk9B3IszfFJUml5mE9hFiLcTfe2M8AjX/H3FijlJ3A
         XwHiZsWUyx7xCvbVuxYAYlBU2Nqv2UMqTAMVb3/q4uhbSF6dsNDROpzlhV2F5ieuX6FF
         AQNMyZ+1oHcPLgBdKrT3F8S+sa5BiS4bQ78wqPi5vbf61IkB3bv/xTPNtJwaA2tixTDw
         tKjHx+Y5c6F8KwkmbevQPRjt/kM/zKqO3dsVj8Iy+gTlyRHnU6PR2KCosU/Bx24rR4Qy
         w5PX7F+ijdWffGwaolAmJoEJXX61uQ6XIDYhmT+Y5DX3BXN4AEod1g6uv9t8jJfnzia0
         hn9g==
X-Gm-Message-State: AOAM531TbjuKQCP5oWzzdWGm6QKtwjjaHm6dNF21dReThxw1VSQiHX04
        Hs3mvk0ni2cDBmyx7Htx6NKpt6Gfw0k=
X-Google-Smtp-Source: ABdhPJx8f/UWJyCjWFmOihdukFJMFY7Cz4y+bbrOY9mCxlOBAzT5ppdpIqlNGyDPoqZF0KDpBM6E3EcgXNs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a0c:d68f:: with SMTP id k15mr5823187qvi.14.1626194031709;
 Tue, 13 Jul 2021 09:33:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:47 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 09/46] KVM: SVM: Drop a redundant init_vmcb() from svm_create_vcpu()
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

Drop an extra init_vmcb() from svm_create_vcpu(), svm_vcpu_reset() is
guaranteed to call init_vmcb() and there are no consumers of the VMCB
data between ->vcpu_create() and ->vcpu_reset().  Keep the call to
svm_switch_vmcb() as sev_es_create_vcpu() touches the current VMCB, but
hoist it up a few lines to associate the switch with the allocation of
vmcb01.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 44248548be7d..cef9520fe77f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1431,15 +1431,13 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
+	svm_switch_vmcb(svm, &svm->vmcb01);
 
 	if (vmsa_page)
 		svm->vmsa = page_address(vmsa_page);
 
 	svm->guest_state_loaded = false;
 
-	svm_switch_vmcb(svm, &svm->vmcb01);
-	init_vmcb(vcpu);
-
 	svm_init_osvw(vcpu);
 	vcpu->arch.microcode_version = 0x01000065;
 
-- 
2.32.0.93.g670b81a890-goog

