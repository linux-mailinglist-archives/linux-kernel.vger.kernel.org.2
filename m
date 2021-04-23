Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FF3689A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbhDWAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhDWAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:07:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D36C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:50 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h23-20020a05620a0537b02902e08ab174dbso13242496qkh.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=04rMnX1KRluyYRhHfvRETT5XQnHF/bHP++SHNJjdrlM=;
        b=qRjkpnEEYcV15FkcVmKDDr/KwpIYnoIkmVvlHvx60fCBdYj9SitM6Pownm0tBklXjD
         XtTyostQC2Cap5js+E8toPDKK7/1tblNPx7krQ4PA2IodSW3y9ZcomiUikmtL5jbBXSu
         Y1yiKMNSDJbs+qn5W8lQuC5+cntTXNQunhD/OkgMIUJFq3/WZtKF/OYjfy8SG90h1wdM
         EM3LYdxh28p1erpuR9M8Gi/YtDcUnBNfwVVYXxSeR4joc7uAfrm/WkOgVo1588JL3ZKw
         hjDVTnEz3p2/hF/jThXrMbVnd0P+zcA2XVAToI1VwxKnwcqItGmTI8410Iby4xk9MFD+
         wUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=04rMnX1KRluyYRhHfvRETT5XQnHF/bHP++SHNJjdrlM=;
        b=LARzMr5dJK2ZVFH+3q5ZeEbOZBzpJauIIGLgcsL8lxtPu0MhNN1lQJIgoz02w4KHLX
         vsJMiX9owTDZw3Wmt67gme9KD3YU5Ao366WSS7yq2D3ka4qTRPkThxyLXUZc3P1YbQ6p
         4bmm5E8VbYaLZAecql9leK+mG70WrutY5UcfR48NUy4I4OX/P8Jt3+bHuuC5I1HXsxpX
         7brp5IyFzls+5JTenDNAqZqP1xsy+uNlch/B39owpH7WZw5ndMWgLskVJnWd7kdt+P9P
         JGvx3Q8+sWlsj918DXI2obH9CSk+aVel4+nuWGW+mttJLj8VAPt0USOoapR3/jtHNdyw
         Rg3A==
X-Gm-Message-State: AOAM532OFFWbkE6x95Nw22KyikPzw33DJV3CqyoT45bktPvudRONTH/4
        hQq0VDmM35KAqH9eBPLrf5JePxvIFTA=
X-Google-Smtp-Source: ABdhPJzpZZnf0lX1geWBYLTLNkLtH9hnPjIogk27b3aa01i0VhjhX50Emrk8zl+xOAgk8VTupLhUJ+6BMj0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a0c:f349:: with SMTP id e9mr1258441qvm.12.1619136409419;
 Thu, 22 Apr 2021 17:06:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 22 Apr 2021 17:06:37 -0700
In-Reply-To: <20210423000637.3692951-1-seanjc@google.com>
Message-Id: <20210423000637.3692951-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210423000637.3692951-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 4/4] KVM: x86: Unexport kvm_read_guest_page_mmu()
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

Unexport kvm_read_guest_page_mmu(), its only current user is for loading
PDPTRs, and with luck, KVM will not have to support similar insanity in
the future.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ---
 arch/x86/kvm/x86.c              | 7 +++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 30e95c52769c..be271fdf584e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1614,9 +1614,6 @@ void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
-int kvm_read_guest_page_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			    gfn_t gfn, void *data, int offset, int len,
-			    u32 access);
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d099d6e54a6f..06bc59c3abb9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -732,9 +732,9 @@ EXPORT_SYMBOL_GPL(kvm_require_dr);
  * running guest. The difference to kvm_vcpu_read_guest_page is that this function
  * can read from guest physical or from the guest's guest physical memory.
  */
-int kvm_read_guest_page_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			    gfn_t ngfn, void *data, int offset, int len,
-			    u32 access)
+static int kvm_read_guest_page_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+				   gfn_t ngfn, void *data, int offset, int len,
+				   u32 access)
 {
 	struct x86_exception exception;
 	gfn_t real_gfn;
@@ -749,7 +749,6 @@ int kvm_read_guest_page_mmu(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
 	return kvm_vcpu_read_guest_page(vcpu, real_gfn, data, offset, len);
 }
-EXPORT_SYMBOL_GPL(kvm_read_guest_page_mmu);
 
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
-- 
2.31.1.498.g6c1eba8ee3d-goog

