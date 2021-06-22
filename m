Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34E3B0C62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhFVSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhFVSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:06:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DBC06114D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:58 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v134-20020a37618c0000b02902fa5329f2b4so4597708qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7ggmnZk0ZzA95oYgw0v8Eh/QeJL7koCtTmvSi5/Mn+Y=;
        b=GSPSKBn/mQa9joamTAFl6zMOdhYEESRbgOqd8UHPNjOXCoC9+Z1jdQ4U/r5IvhektS
         MLuT3lGf/XSxaElBtNmnnrySdVZu1INpWQValxhEfHROzGlKnz2yen8L7mtACUKRr8iD
         A0/OOst/h6JBkoE/FScuXq8Tq/o6/ZKTJfBelTvAIwLgymmPYiQSb8fNqOfOVJTiUO37
         nIk6jAqWv7TjYZdswnskjommFAq4N4g4Vr5u6gVHwsOjQ0q/WUjHbRcT+SIGl/YwYsDK
         hzx+CNhm0FqMv2dDXXQZ8pjFeMFxT1MK2JrEywcLQitJNttAe9Ith9Knta4EJC3WpZip
         6I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7ggmnZk0ZzA95oYgw0v8Eh/QeJL7koCtTmvSi5/Mn+Y=;
        b=ZynhUgu4/ZhZIFHBs+jNEwG1dM3dVFcGFUJaYV8ILr30G9EqAqyoidl9MPs9/4nxMw
         D6y8WmNAqnJx8C3bHRKTZQfQw76YJM0JMyCLshRdAGgPoIIOts5QVgiueyeCBHJAIxRn
         2rfzySXxdrKB06c14sGXiV/jyc7l+8RObVncs6953LYHRlaH/QYUBTH9TtUjKsXFwAI/
         u+ZncBtz5vYxTPiukbF/uAlMHO0PPizOwVhbiFENm3v1+Q/95lTIbpqisLlrQFYCDWhX
         SIQLTjc/TGKnzWRMXmFa+ABiIZ4TFjLPzgHhurcnoIL8P7Aipj3UYbzuafuECZCjmGFb
         W8hQ==
X-Gm-Message-State: AOAM530KZ77ooNf2cC0ahNYqOD848Q0LJwnJcyEWOg/EmAA/te8HxfjE
        R71oXLQBP/FogJ6KQl8/2soP7pHgSd0=
X-Google-Smtp-Source: ABdhPJysNMvdkS/WTlKJMwsHbXLxcAJ6RVqXZDGyfoX7iGnHKFJcn3s93O9i2ByNOSLGPeju8fo4etFNxnU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:2d41:: with SMTP id s1mr6221176ybe.120.1624384797315;
 Tue, 22 Jun 2021 10:59:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:38 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-54-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 53/54] KVM: x86/mmu: Get CR4.SMEP from MMU, not vCPU, in
 shadow page fault
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the current MMU instead of vCPU state to query CR4.SMEP when handling
a page fault.  In the nested NPT case, the current CR4.SMEP reflects L2,
whereas the page fault is shadowing L1's NPT, which uses L1's hCR4.
Practically speaking, this is a nop a NPT walks are always user faults,
i.e. this code will never be reached, but fix it up for consistency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 260a9c06d764..a79353fc6efd 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -903,7 +903,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 		 * then we should prevent the kernel from executing it
 		 * if SMEP is enabled.
 		 */
-		if (kvm_read_cr4_bits(vcpu, X86_CR4_SMEP))
+		if (is_cr4_smep(vcpu->arch.mmu))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 
-- 
2.32.0.288.g62a8d224e6-goog

