Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC90325831
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhBYU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhBYUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:49:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81EC06121F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p136so7623195ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=F0eh9ylPJtSN4o5lYqN1SeY0/rJOFsJfLsPIo1Pupz8=;
        b=SFlQq5dFvBgj2J0+Jqc8nAq1vFDpNsrCAgZdo7CnGM0JUX9pgq6RC2kR/H4KF51R4H
         BF2igNp4At4zh5epKOeIkGLVHnxJB3ZS5RxI16DKPLlB/GntMUL89QrQ6LpItibaIVj4
         V9BuS5W/eEXyK2osPIIix51xjoZqt6t8TrOD3LLjFV6bSunArGSL6wM9XRe6WVd+x27J
         kan84s1LjotT4s1OAwkI+Gh4Xtmc6q50W06A5PfSvYb3GUJto0LvThi5CnaD+jqEZCQV
         plwyIJKaa492WzerGv5jrHiCpS2HriyP5K8fSjF9uVxYrQPbu6gPwQ8X82sPlNKe5ImW
         q6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=F0eh9ylPJtSN4o5lYqN1SeY0/rJOFsJfLsPIo1Pupz8=;
        b=Mc+Hbs/tcu3cywJ4PBo//5hZd4XDJRfz+Gw3JYRhG9Y65L0vEj4t/TrmkypAQEEYLk
         e/bjNwpgqJ0j6v3hcqpLFyyEvWWVFfbkWbhb1dzTjkEQL+FTl4Ld+Be0VWWqW0F0vGzk
         2bFRTT/qxkc65e5nyELiIZrMPESWutMTFrqk846Q0lp9Jo7bWUQUe9rppHEAF8OB1ygG
         JU5uJjLxN28Izvw9L8derIcasaNNex5xkqwlxzOl8PVNiki0afV2P2XykhyTk2QMKdiy
         Jao5TghhVjSPfV2LbL/YvMJOyfgHIF/ThY76SsbSCpEg/9BVPnBWIyNpkVU1t9YuzbF5
         6cHg==
X-Gm-Message-State: AOAM5324nItJv8P5bOK+JjItkAgtEqJkwG26yHAkrLDZloent3lUK9lE
        1ZlnvPfFmyRgAkdBk918xwD76O+Es7g=
X-Google-Smtp-Source: ABdhPJx3w04ypNexMcAliwGECnbLKlW0y3JTQsT0wE66V6WzKtiGvpxXGgLwGA12LK/s+jUC+eaKDpDhjAg=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:aae2:: with SMTP id t89mr7485713ybi.63.1614286101914;
 Thu, 25 Feb 2021 12:48:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:34 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 09/24] KVM: x86/mmu: Rename 'mask' to 'spte' in MMIO SPTE helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value returned by make_mmio_spte() is a SPTE, it is not a mask.
Name it accordingly.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c  |  6 +++---
 arch/x86/kvm/mmu/spte.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4a24beefff94..ced412f90b7d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -215,10 +215,10 @@ bool is_nx_huge_page_enabled(void)
 static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
 			   unsigned int access)
 {
-	u64 mask = make_mmio_spte(vcpu, gfn, access);
+	u64 spte = make_mmio_spte(vcpu, gfn, access);
 
-	trace_mark_mmio_spte(sptep, gfn, mask);
-	mmu_spte_set(sptep, mask);
+	trace_mark_mmio_spte(sptep, gfn, spte);
+	mmu_spte_set(sptep, spte);
 }
 
 static gfn_t get_mmio_spte_gfn(u64 spte)
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index dcba9c1cbe29..e4ef3267f9ac 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -48,18 +48,18 @@ static u64 generation_mmio_spte_mask(u64 gen)
 u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 {
 	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
-	u64 mask = generation_mmio_spte_mask(gen);
+	u64 spte = generation_mmio_spte_mask(gen);
 	u64 gpa = gfn << PAGE_SHIFT;
 
 	WARN_ON_ONCE(!shadow_mmio_value);
 
 	access &= shadow_mmio_access_mask;
-	mask |= shadow_mmio_value | access;
-	mask |= gpa | shadow_nonpresent_or_rsvd_mask;
-	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
+	spte |= shadow_mmio_value | access;
+	spte |= gpa | shadow_nonpresent_or_rsvd_mask;
+	spte |= (gpa & shadow_nonpresent_or_rsvd_mask)
 		<< SHADOW_NONPRESENT_OR_RSVD_MASK_LEN;
 
-	return mask;
+	return spte;
 }
 
 static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
-- 
2.30.1.766.gb4fecdf3b7-goog

