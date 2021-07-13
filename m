Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD323C74DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhGMQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGMQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160BC05BD40
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:32 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u40-20020a0cb9280000b0290290c3a9f6f1so17699078qvf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=g4KLbj+QdWVACsUllh3wnqDquVHXBzm/Vor2zYtx/bc=;
        b=VkYmfhAjybA7UVH++QHLbtB2zXv3ANgGvddIZcUFdBilVfldY6hi4Yx0m0vawC/nV7
         ExC2v2DD8RWEYCg/4MQX/PJ9fueketZaoP3CTkmKMh7uk3c1IulHKU2W1eFQwXDJRp4F
         7H3QxLOpX1tTrIk2iMxYOEosylHJC33I3V6EiydySNGCd5/ZpLOUVU/vKTv3JrifL3KS
         M8zRn+lpVIROZGnURtdwRA+/8rIL7AjHyxB15fd1rI7g5ZdvYYyULK5plKFU/EJIY2uK
         pFU4eEGy/vDJEMKSwQ0tqJgnFmZu96rDNu4Sq7wh7Q3Kz8A5Nk6Can7lL8+ODLlTN8OF
         JCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=g4KLbj+QdWVACsUllh3wnqDquVHXBzm/Vor2zYtx/bc=;
        b=Pz57mVzX6vwLiRlKKrq/Pvn/NH3ZRWfkWW5ijbmBBQ4hZco1pptt9RY2AXLO/7Hwhj
         n5ayIU4wDWn7plSCdzllMbhgQ5+v3JpKYRI+RUU4IGG8iyqkDWJXvFra9VPgneNIhBvP
         BRwqdkrDOt+ZpNN+xmkJLoR1MzY+9CIBNtWxLVlKASuKmlMXhHN+YEK1hOiqsp+7ps84
         MXynxNHXVvMMCpurFFJNEI+U8apmGHL7IiNrXB8A2/5ekx7nqidhIr2AIkMov7kGGGm5
         ezL2iwq6ee+KNtuXqMDV1mcOQkNVWUYg5LpJq8oveAwQAKc/5MFOdULmsq0uYaeskgeZ
         3Yng==
X-Gm-Message-State: AOAM53202TIFwIulh+HfVTou1kuzKTXS46w9YEv9pJ+YB79ohPezblWS
        pk/MqP4vr0/fuQMJhpPA3xZADDGqYDo=
X-Google-Smtp-Source: ABdhPJzfAdfd5DYONg/CglEPN79CjRHf972Neu6xnVDPfEjPMPpTHH12YI8YjGso85YNoBNdm286wXZC1NQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:4102:: with SMTP id
 kc2mr821831qvb.44.1626194071222; Tue, 13 Jul 2021 09:34:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:08 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-31-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 30/46] KVM: SVM: Tweak order of cr0/cr4/efer writes at RESET/INIT
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

Hoist svm_set_cr0() up in the sequence of register initialization during
vCPU RESET/INIT, purely to match VMX so that a future patch can move the
sequences to common x86.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0101646e42e0..875d68c4cb9b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1262,18 +1262,13 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
 
+	svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
 	svm_set_cr4(vcpu, 0);
 	svm_set_efer(vcpu, 0);
 	save->dr6 = 0xffff0ff0;
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
 
-	/*
-	 * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
-	 * It also updates the guest-visible cr0 value.
-	 */
-	svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
-
 	save->cr4 = X86_CR4_PAE;
 
 	if (npt_enabled) {
-- 
2.32.0.93.g670b81a890-goog

