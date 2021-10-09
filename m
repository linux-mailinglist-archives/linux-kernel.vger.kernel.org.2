Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3342754E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbhJIBDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJIBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:03:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518DC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 18:01:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso10924063ybb.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=SFTOsCD2fLbfCOpXgpJNz0YV7VaZgcPTwQZKs+/RiZg=;
        b=INhEx0aHocRJIKUfy17arUjZbG4Z1fUL01B/tSss7d45qbojh+sJscLUPYCLQOjqKO
         k+bTTPouGSj5oku4lc+lVLEHhXAx05lrJWQZTx18FF/obwXeULeDsYhiBCXq/1bJo6Ib
         G5kNPJlqUtZKWtUUcRgKu19442TbSeGHUHBwnIORDVRyMTeQFnopS5LrKqpLsJfNbc03
         5pOR0tc5VlI82fX6uCx3xWJUUVnTYULT32DIHcttClFyHD2gItVVIXr7Zi5Xkm7elSoN
         ZtrRNcUF31BaBhuUgGb6nYU5v2tI1tH1wl8M9PYYd7XLCIW1FM4m8KQ+4zOEQmKjn6Tk
         3wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=SFTOsCD2fLbfCOpXgpJNz0YV7VaZgcPTwQZKs+/RiZg=;
        b=ko69nigpCtBJFiQl+FyEGlhzjyFWUUm1adxgxA5oWtJFKRZglYhP4BjzaRqUnIJpWT
         bGK35HVqqRKDM1FecbMObmkGkhy6P5/Lgvm49w1V+swUlefz6NqZbaNu59lbI2AwkVJd
         CBkQwYqU3Z3XtPHxqMK1ztjCyHNwDW5CwzD9fC6MVpJtLO/r4bm0AQkYyPcBwzMIn5jM
         /JPpnqleC793lBq6l8ubD9az/Q+lDXMBfQ2/jaOGVgXbro5q68uy64Q4RCCIIKPT+g52
         FHKdLfXNH0ZauzJ0lRgkF1M3EA1nreWDad6k6GopT8PMa7BmcNKiv3WLD3uWS25XiHaB
         ErOg==
X-Gm-Message-State: AOAM532x7aw4Ks/4QVRqCntavhM7O7VzUyb6Whg3/cVvCLKajR/QHxJo
        uLBjJVt/YMV9LWSWRiccj2EYwixEDWY=
X-Google-Smtp-Source: ABdhPJxYynAqY2pZXjNxz5n0Wf5R/VHZFGNQAxKMkEMoM4wxKpMIR8LjH7nMVxQ1ekk9EDonFbnziobBfxY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr7342143ybu.224.1633741301116; Fri, 08 Oct 2021 18:01:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 18:01:34 -0700
In-Reply-To: <20211009010135.4031460-1-seanjc@google.com>
Message-Id: <20211009010135.4031460-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211009010135.4031460-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 1/2] KVM: x86/mmu: Use vCPU's APICv status when handling
 APIC_ACCESS memslot
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query the vCPU's APICv status, not the overall VM's status, when handling
a page fault that hit the APIC Access Page memslot.  If an APICv status
update is pending, using the VM's status is non-deterministic as the
initiating vCPU may or may not have updated overall VM's status.  E.g. if
a vCPU hits an APIC Access page fault with APICv disabled and a different
vCPU is simultaneously performing an APICv update, the page fault handler
will incorrectly skip the special APIC access page MMIO handling.

Using the vCPU's status in the page fault handler is correct regardless
of any pending APICv updates, as the vCPU's status is accurate with
respect to the last VM-Enter, and thus reflects the context in which the
page fault occurred.

Cc: Maxim Levitsky <mlevitsk@redhat.com>
Fixes: 9cc13d60ba6b ("KVM: x86/mmu: allow APICv memslot to be enabled but invisible")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 24a9f4c3f5e7..d36e205b90a5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3853,7 +3853,7 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		 * when the AVIC is re-enabled.
 		 */
 		if (slot && slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT &&
-		    !kvm_apicv_activated(vcpu->kvm)) {
+		    !kvm_vcpu_apicv_active(vcpu)) {
 			*r = RET_PF_EMULATE;
 			return true;
 		}
-- 
2.33.0.882.g93a45727a2-goog

