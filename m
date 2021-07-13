Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2F3C74F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhGMQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhGMQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D337C061341
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h1-20020a255f410000b02905585436b530so27743161ybm.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5yZvKb3rht26ruASUkfQQVLesQhgsV9e0Ri724OAElc=;
        b=qI6F9hUh/CIx4LeAR6ngfn6eVtHvGqm10D3gtey8+kdr/skmewXwWVwQypgbry8aat
         H4jh6mB2yjq1zF/qWDWutJnIJe1IkGQ7YgGi57lmF0ThEgAIHCU+jX6Ehc5p61pJU9Js
         e/g+1WPVMy/Yi0b93O99Uh9KBMTuxVG1iw6qrskti3nuECQvYuzYPaE18bz+hXnixVt+
         bFuRxdI9Ev9fD7hV/Ky+Ob8N6gI5qdhShSTYIsj3V5OJaRnBXvRvB66h2qX3u+7hnhc+
         gWpcCwuIVKA3BalSVBMcSh+Jw2hu03YyuiM8aeylpByUHy1sEXRmL/snVSafAN9B5Nmd
         2lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5yZvKb3rht26ruASUkfQQVLesQhgsV9e0Ri724OAElc=;
        b=WaunAJkKVN2Jf6669It4fnXakQHI5XoJrUe606Weq8/CKTycVf1QPvwgTZinLnX0Kq
         zuBHFL8pvSSvP+z+Hp87gfxClyOQRdyn+XnpSmSRaGzIU5d3lNJqPIdXLLLfvDnZT9dU
         ok77hq+LPXsVsqONQAnFZTgzUZDDDYEW0h0N5ZsP16p4awrEd/+tOYdc0A6jgkreswyB
         p/FQ4XKQXNUxiK2J/wavGjIul8XJiuJ0uqiOHwZzzSHshB7AFCU8APA8c14EYJPrZOs2
         kygfHynr8j0uHwZ4Gzjgrw0xpDN5Skrt4ypyfPIJmhGetQd+zb+fn6SAhSYMgHVNf4H1
         ljFg==
X-Gm-Message-State: AOAM532vQfJB7qwtoJcXBMY2g9OnGI85kURpPVE5xaENQHE6U7zQ3N3+
        7WexYytmxnZIV+Yl6wioEmSYLPJ3Eqo=
X-Google-Smtp-Source: ABdhPJxViBAl8YwtovSKDcDwK19KFAhg1ewICGm5+/+qj/Chcc16EfHW9/j+T1IxW1o2ZrX6X0U2NUbFKGU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:8b12:: with SMTP id i18mr6611742ybl.162.1626194091791;
 Tue, 13 Jul 2021 09:34:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:18 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-41-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 40/46] KVM: VMX: Remove unnecessary initialization of msr_bitmap_mode
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

Don't bother initializing msr_bitmap_mode to 0, all of struct vcpu_vmx is
zero initialized.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d5a174ff20f9..bc09a2f7cb5f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6835,7 +6835,6 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
 	}
-	vmx->msr_bitmap_mode = 0;
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 
-- 
2.32.0.93.g670b81a890-goog

