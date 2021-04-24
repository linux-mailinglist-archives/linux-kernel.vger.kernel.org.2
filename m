Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89443369E26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbhDXAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbhDXAwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:52:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFBC06137E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:04 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f7-20020a0562141d27b029019a6fd0a183so19560322qvd.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8FPjB9kODcd44RP7aC0zZao6wso5dTHmRwxsyhm3GIU=;
        b=ozB2Ag/eEMci6Fo+7ypR3EpsxZvT2N3jckC41JPYLCyLZwWueyWwAysuxItZ2uzeKk
         dpjozZ5Nl/F2ZREDDjmNT8iq3zQb2GESNIkIBQG5Dwrf+mYRNAvaLnDCV/7DJiD44wBv
         YC2PMSKYAIOVLxE48ilkyk3/LA3WyNk6B9Jng9Sgwn/WOMIVOrU8Dm7fBiLo0XQO61f3
         EQxbHW1IJS+ehHCIvH06rMTYNo11dvUqMKFaf4eQ0c3CD7SAgujPQmMRdCm1ovOPxaOn
         IGJaOgkSTQEq2VrAL0BtxRe3J1J3zMrNtWainJ6cQo+NbgUMoSqVmShRfLKLmFQMc0Mb
         wL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8FPjB9kODcd44RP7aC0zZao6wso5dTHmRwxsyhm3GIU=;
        b=uY2Y7Qt06lQ3ABv66inUxJZQy/8QkZuLECdfEGq0zaJgJd/EO+9vG3U13poH9ywKjG
         h7OSDFzAzw9F5NSc70QahAKcZ1WSd2TzZZ0NwOKVXp/5JOFs3EeLh1s3YzhDe57MTDyT
         STWRlmRdUt3FqTPGOI1yp68RPbVrC1pG7G2EKHH6VnI2WHitsqrdMCKuMnBTdJl/7G8G
         CILfTOZBFSgHj4xyzkNLYl9J6czWf+O4YAp/kuGgK5fvKXVvPU9Ket8vYjJuB3p/6xZU
         m75zRbE6PWsHLSk29XEQTNiOV1vwJkzJF+am+HxuHTs7LzPjVyryU2Isc+WO2Dl3Zfrg
         J8qw==
X-Gm-Message-State: AOAM533i7tyDYEc5JC5hOFJ/1DvkPH58jsx9AP+OQmFiyYl5f2lHfcO3
        A371KMyMzn/VexDb1hUBxV1l2gHB87s=
X-Google-Smtp-Source: ABdhPJwIe4aMtREwCdKlN8Ejc4nv8qWnmoGL1M73/G1IxtPwJ/CZeAKF0LNUA6wkJbNTrlSMirS4uyZ9p+w=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:ad4:4e01:: with SMTP id dl1mr7170885qvb.9.1619225284120;
 Fri, 23 Apr 2021 17:48:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:31 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-30-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 29/43] KVM: SVM: Tweak order of cr0/cr4/efer writes at RESET/INIT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
index 4ea100c08cb3..88d34fa93d8b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1204,18 +1204,13 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
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
2.31.1.498.g6c1eba8ee3d-goog

