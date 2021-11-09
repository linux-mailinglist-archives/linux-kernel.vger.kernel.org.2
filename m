Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF644B4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbhKIV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244530AbhKIV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:56:06 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4ECC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:53:19 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so655624pfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6vd3DGBjMKgHuIVV6qkUxLOoHTSHbvX+BJg15aoTeQI=;
        b=diTieMD40CGoRu4+3lEGpGhAB6Wr+tMMmNRGW6KXBS+BsPQdtQj0EZrA5gWHanWPj4
         VfvvSTVysO5ANPcbtu8hNKNsAvXkSfO3zJ7UVSL9TY9rKMh6MX84q1+eshHiGVwvOPRc
         8XN5/dCnjEc1wCZBHNiQT29kiJGpkR57KQP/UD3UK7caOfYznaOFers+RPCuDACC+cnQ
         1/3nTlozWapm5UGFZRUXfPXhcOFGWfJ0zaGVsAOuCY7l4IAxaUyI2P9IENORFZoKlK0n
         kSEQ+JmacF3r9S0skH/NeJDfeYXSbHyE2dnibs0pNjANLE9oujRjfqtyDpaXQYjN6JS9
         dZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6vd3DGBjMKgHuIVV6qkUxLOoHTSHbvX+BJg15aoTeQI=;
        b=GuMVC/2pxS+f5pg2SgxyN9Ng4IMW8we1L+6AtRDh+MlBUnH3ScsII4mKK+mBEVdkyv
         VvoYrNuYDUKXaXzHrhssVlrMHyaTMJo58qH9c2JIQyLUh3IDKFYieIatn2Qg2lSyB78b
         mWHZ9JfpDUr//IOMDiWNkrMh1HFJdnz4keqpDOxqwpF+wfSRnQORfD/7uOUMqPMeC4ok
         cthAewWmVLYfsKBkKIn0iP84H78YlecKNMHj3Sg21tAipWyBn55TiztIAnsKhdzjxk1s
         MJGNtiVAn8FOc4opbfVCtgV8qpxa1nCWEqu3nttgRGm0XHx7L5Zre4cFQIIeqdYNBkcM
         5P8g==
X-Gm-Message-State: AOAM530YAyj+HNjK8dsT3zwfMAEV+pioL4QV4xTgpfuHpO5rckwMjsmm
        IHR8vos49oQ7wHr6eVeVogbkcNiQPQs=
X-Google-Smtp-Source: ABdhPJz/H9kivqJokW0WXLHzd2rmXw2fG7y7tdtT1bugflgLsxBD6Z7SX2aMlCNn/z8n74hPv2a92El7CWA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:807:b0:49f:d6ab:590c with SMTP id
 m7-20020a056a00080700b0049fd6ab590cmr19992594pfk.32.1636494799070; Tue, 09
 Nov 2021 13:53:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 21:50:59 +0000
In-Reply-To: <20211109215101.2211373-1-seanjc@google.com>
Message-Id: <20211109215101.2211373-5-seanjc@google.com>
Mime-Version: 1.0
References: <20211109215101.2211373-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4/6] KVM: SEV: WARN if SEV-ES is marked active but SEV is not
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN if the VM is tagged as SEV-ES but not SEV.  KVM relies on SEV and
SEV-ES being set atomically, and guards common flows with "is SEV", i.e.
observing SEV-ES without SEV means KVM has a fatal bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0d7bbe548ac3..a345f557be4a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -242,7 +242,7 @@ static inline bool sev_es_guest(struct kvm *kvm)
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
-	return sev_guest(kvm) && sev->es_active;
+	return sev->es_active && !WARN_ON_ONCE(!sev->active);
 #else
 	return false;
 #endif
-- 
2.34.0.rc0.344.g81b53c2807-goog

