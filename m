Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64330E838
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhBDADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhBDACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:02:50 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9CC061794
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:01:36 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m9so1017105qka.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=HKjbtuBA/eMiKbQylYWdN0UmPc2knJZyYHV6onJRrSE=;
        b=tKmh60HZSWWVEmyGmZ76W2xuc+7QEcKSoF1SNpBozpX10Sd2ISZVq3+eaBndPw24EQ
         W/bCqhaG8UM8UvE5JJdjSyZx5uP7X3fRCVnKyja/iR2t+/WwJK2tS3DS201XNJ5raThl
         MifndWRhCgs20ldB04DP83AHJCkOlC9EeVVJetB9bVs3NioH6r/NwhCw+JvcE2+0WB8n
         V775araQj2jYOaLC+wgm9BtvpXbsoSYSVq/ku6jjWXueR0T9ZVLLlJ6FqA4AlTgZILEJ
         ocub0lhVzYbniTpzRjeEGz95iXyIWIlB/32xpW5jSf/fKuUtM/Br18923QefZKbfOCF5
         Fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=HKjbtuBA/eMiKbQylYWdN0UmPc2knJZyYHV6onJRrSE=;
        b=kdipW+kwaGNUhc1D+1pZVVa++VOHMub5glCMCUcddnh4jGvUEGxqslAq/2EAsQjml4
         m3q5MOjYKyROwKRxYazcsKUgcRM6RJIO70WKAhTKnXqVICpFuYZhHDtzD2LDvdAe/hDx
         m3B2xUr029aWQd74VmjE+FIsGHDEzNpwtYb3fZVgCCUKzf0v9zAx2xSPwPPHfN7+kCHr
         oBvjY2tQI1VQiAoq491k0U/xSiiCPPQoQqNWS9yBQwVgtRxM2jvjhOiaapiXzUkSFmHB
         FrXVZEjfiviExm9kwn+mXN/4+1zq3EQcXXqkG/uZCY7AE+JFXWlLzhveIi8fZ+NWgMp+
         cvsA==
X-Gm-Message-State: AOAM532Q/A+vACJBmzXjnpd2Nt9FmNut1DSfnh/dGdT//++DB9C9vx7G
        Tyvfji8y3G0onKVHq7Eaf1sZR4Czvrg=
X-Google-Smtp-Source: ABdhPJyt/Fu978qG4Zyz/Z6m87/XlaKn/iXwiDUTG8SqfSmyu7hZ4+kAqVn3luzKzVZzYTCIQzhdqmucKZ4=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
 (user=seanjc job=sendgmr) by 2002:ad4:5bc8:: with SMTP id t8mr5453989qvt.36.1612396895418;
 Wed, 03 Feb 2021 16:01:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Feb 2021 16:01:09 -0800
In-Reply-To: <20210204000117.3303214-1-seanjc@google.com>
Message-Id: <20210204000117.3303214-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210204000117.3303214-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 04/12] KVM: x86: Add a helper to handle legal GPA with an
 alignment requirement
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to genericize checking for a legal GPA that also must
conform to an arbitrary alignment, and use it in the existing
page_address_valid().  Future patches will replace open coded variants
in VMX and SVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 674d61079f2d..a9d55ab51e3c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -46,9 +46,15 @@ static inline bool kvm_vcpu_is_illegal_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	return !kvm_vcpu_is_legal_gpa(vcpu, gpa);
 }
 
+static inline bool kvm_vcpu_is_legal_aligned_gpa(struct kvm_vcpu *vcpu,
+						 gpa_t gpa, gpa_t alignment)
+{
+	return IS_ALIGNED(gpa, alignment) && kvm_vcpu_is_legal_gpa(vcpu, gpa);
+}
+
 static inline bool page_address_valid(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
-	return PAGE_ALIGNED(gpa) && kvm_vcpu_is_legal_gpa(vcpu, gpa);
+	return kvm_vcpu_is_legal_aligned_gpa(vcpu, gpa, PAGE_SIZE);
 }
 
 struct cpuid_reg {
-- 
2.30.0.365.g02bc693789-goog

