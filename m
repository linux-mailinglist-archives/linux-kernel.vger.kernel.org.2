Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3767A32AD66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837537AbhCBVru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381231AbhCBS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:56:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8023C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:06 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 4so10405013qtc.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=pDw5a8xkwlwJrFheedicuJ7ZkUuVv2t+v7LNaWJm4Dw=;
        b=Ygk5jcCgeatzea90Rb8bzEwERdMBWJFL7meF/8n+9C1z76ccYNoc3o2KHJs49c9YS9
         +rED1LRhDhhfZQrVJkSnnRdejrl1l/JXRTuDtcFlvwFXdsr6wWnOW/xNRcHG8+WBe4Yb
         WSUWTNcl7oNaDRe8m2fCdRaYBmA1vX0xKIJA/cCqU1oHZ8fnhVJPmR7yDURMfrk9M0z0
         bTdi/oemt2W0JE3Qu6l2YHFXzLd5nJ84yxHKqXrQfB/seJYeJ1osrih0tN+q0gmF6i1r
         1RzQGwI6nk4DVdJ6a1GDGTSLqYs/gkZ2qFom4DxeaJDP3wDuxXgXxo1D0vc0eT6FZ0+L
         byLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=pDw5a8xkwlwJrFheedicuJ7ZkUuVv2t+v7LNaWJm4Dw=;
        b=QYIL+uOsXReDM9JuQYEvENYNfuUYNCCsau2ALLe5fsRCHBwGXRfd3ldEYsRdISB0vl
         yxguhdDZaODQVuDpxgP/rEOFDnXuHou2Dmt1ievUlMoUelu4x43xo3j5ht5g4UgTzS4r
         cj071fdYjR9lIce20D53eXKwym3wqVysM4z6Z9q7hr4mPsnHErz9V/KpQjHmNArXo+NZ
         2xVzU96cZCLZ/e5vuNAZtZuTPSIxhfNk8SUfat4SmNx0jfwhteBznFQVzzYXBKoYVXxS
         rnd9nJpEDkRNDFBbwOA1Q5KUwaWtrcnyR6+z5W7gsXKED48ALKF1pFb6mYJK8dWAzqqb
         7KBg==
X-Gm-Message-State: AOAM531mca6VnQqlWwjCxsMo1jslWs7VWWdsZdVQFBfUP0Imq5MHeJiL
        OJahbm2Xnd3lUoAaaYqVQxa4jZW36Yw=
X-Google-Smtp-Source: ABdhPJy3aPjJhvDHE+DIXi6sA+MkP5OXW5n7T3/Tf9elJsyZ3fz2ZUT3gXs7k0/Itw25dW+LTYzmWA5qGC4=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a0c:b7a1:: with SMTP id l33mr20824163qve.17.1614710766083;
 Tue, 02 Mar 2021 10:46:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:33 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 08/15] KVM: x86/mmu: Set the C-bit in the PDPTRs and LM pseudo-PDPTRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the C-bit in SPTEs that are set outside of the normal MMU flows,
specifically the PDPDTRs and the handful of special cased "LM root"
entries, all of which are shadow paging only.

Note, the direct-mapped-root PDPTR handling is needed for the scenario
where paging is disabled in the guest, in which case KVM uses a direct
mapped MMU even though TDP is disabled.

Fixes: d0ec49d4de90 ("kvm/x86/svm: Support Secure Memory Encryption within KVM")
Cc: stable@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 59b1709a55b4..ddf1845f072e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3251,7 +3251,8 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
-			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
+			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK |
+						      shadow_me_mask;
 		}
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 	} else
@@ -3303,7 +3304,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * or a PAE 3-level page table. In either case we need to be aware that
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
-	pm_mask = PT_PRESENT_MASK;
+	pm_mask = PT_PRESENT_MASK | shadow_me_mask;
 	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

