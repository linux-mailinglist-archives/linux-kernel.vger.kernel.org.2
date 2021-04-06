Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B094355A29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbhDFRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346836AbhDFRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:18:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6681C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:18:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so14656131ybh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=PjN3/+CiJF7LjddLu0WlwqBKWxCNAjyRsPNQzrdepeU=;
        b=KRWA6BOSF919JQ+Gdji4g50Dz2V9xSb2Dz+VjpOND2wNu73lE8WKJuek0AZ5JLOZBJ
         xkcCFkR3+ZrlR14quktT2Y1+pS7gvmFSGwCdlD6nraBZe0nyLyOVFQeBgJ+U3sACOM+c
         VWm85UyLNAQv4NCXE0AAbU1LLlw8+MpF/mHHhaZKL6Qo6eKvp1m7741PAtHgHmANGGf2
         B2a8zvvSCL9v2apY0sK+o1w9XAFh7xXXJX0+4SJY0F90lSMGBHEqWbnROt/phL5qKXpI
         pZAbJQk5LOV1wqngr1bvkHByNk94YI53wVWjGKQpGFw8UoPmLCB5Qw4OZwW7MntOY4E8
         GaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=PjN3/+CiJF7LjddLu0WlwqBKWxCNAjyRsPNQzrdepeU=;
        b=XbT2bCkZV8TLPLB9lgmCCqV0/pQmCGPpP3OXzNDD8Z42w8XpQkOmnbXYCkz+h52pJb
         l15T6sjSAz8+V1e4lcd6ZGOjJcbpVBjv3CXQaTK+/dsoRk+igidxaAX0NXA6g+f3vO1W
         Hx5ZHLMqE0Vi4/BVVLpMxR/k3PRF9B4j7YwS3tAuRe1jaSQF4MUnA6B9lsgh0PmrmC6t
         wIrZIFQZ326b2f9h1nPxrubm64VpqJ3fuT9D+3QbonNWf2amOoTSRG2sQWQIuDspUZHo
         OaQtNUCSbGxgSRfIGEcuLF0uREObDVTYNfn1Ljnxmo7eoTm7r152+mmLASGVRRt3UtSo
         4lEg==
X-Gm-Message-State: AOAM533hgDzaU+EnPFtkKWe+qEnDEWDT8hR1XIWzUqq0O8Zfq4+XPBmr
        RTehv5KQDJD4YxrDGo1CvS5NkWB+41s=
X-Google-Smtp-Source: ABdhPJyoaJnUQ+rpKHVGbmB0BKh1rZ4am9NKg94pOuxpWVA8sQL+f7DaycWHql6NCffKq0QOYvewHEbZ93Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:24a1:90fb:182b:777c])
 (user=seanjc job=sendgmr) by 2002:a25:d07:: with SMTP id 7mr25050822ybn.135.1617729501092;
 Tue, 06 Apr 2021 10:18:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  6 Apr 2021 10:18:10 -0700
In-Reply-To: <20210406171811.4043363-1-seanjc@google.com>
Message-Id: <20210406171811.4043363-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210406171811.4043363-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 3/4] KVM: SVM: Add a comment to clarify what vcpu_svm.vmcb
 points at
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment above the declaration of vcpu_svm.vmcb to call out that it
is simply a shorthand for current_vmcb->ptr.  The myriad accesses to
svm->vmcb are quite confusing without this crucial detail.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2173fe985104..b230950c1aa6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -111,6 +111,7 @@ struct svm_nested_state {
 
 struct vcpu_svm {
 	struct kvm_vcpu vcpu;
+	/* vmcb always points at current_vmcb->ptr, it's purely a shorthand. */
 	struct vmcb *vmcb;
 	struct kvm_vmcb_info vmcb01;
 	struct kvm_vmcb_info *current_vmcb;
-- 
2.31.0.208.g409f899ff0-goog

