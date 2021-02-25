Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D57325807
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhBYUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhBYUtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:49:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB5EC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l10so7669769ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+xZ858irlb6FpgV9qRqhKqfeu+ijlTKA7VlYstFtMqQ=;
        b=PtDP0nkf66ltqftVB5b4R66eJDmEzTvZ/GwTuLwCpuuPlat3uIbiyQaAJ1fJMXbnKB
         ZtMd9SgzJYo2oo+qZ1IHkP3fLqL0yJqHSNO4GE91BkfV2a4HHJ2WDoB1oaN1/Iq93U0b
         pLViuagdt2GdbIbJFTvH3V4IANkCWR4iEA2r3DeD4NEZpy/bPgY0wrEGv2uq8vbQ8lrc
         sQNbL0lHlVNm+Cl6okH/9urblJNrVQ87cis1qqsnxbsz44FigdgIEj52e9VLv9Thw/Gp
         TkAR+PKwI/pfKc/dQpAcAUSU+KcDdA9aAl2O80p1H6BXWkcaQpcgPtEPRg3QyK3jOLGB
         M+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+xZ858irlb6FpgV9qRqhKqfeu+ijlTKA7VlYstFtMqQ=;
        b=dm+3UjVZ2TeEq3+TMCZTnynEIq2UXL3qnAB5A7y13NWc/NeaXf9MpOVPxKrAZj7RP9
         q0/V3nNvnC5yozmp/7YVfonm9xFg6Ob/dk5p/B1TYxiIz1886g0PVrjkKf3hE+3nADcu
         W7IF6+Lo1k6lWTZ9EtGxVv9vLBdB7A3BM6290Dj0Ptj/1fhpK4502IyBm03WRelTqHZv
         Upl6DgTbS5JOMUMksKgdkAtc97U0VglIhz8752O1fCuUyR8f7p3mn2MRY5yIgs5RJ40U
         anvDcSoacMQRNEHmqOLoML4TgxBHhuN5UXcYG0MmFBsZVIEf8QXmwU/XcgRQ3/V/8Z9N
         KfYA==
X-Gm-Message-State: AOAM532Aa+N2LVk78wWv9LQDBwfa71Ke2isFnvxGeFE46UxzPnCcHHvx
        Dmt/jPhd/BoqfKItF92w3z3FS79w+aA=
X-Google-Smtp-Source: ABdhPJwJdk88Cn1vr8QKJWKIAG58De/q53rJRiGSKfR1+pb1TM0+RUkWMxlhQgca2wfVDwGfHCmucILesuU=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:bbd0:: with SMTP id c16mr6531571ybk.23.1614286082831;
 Thu, 25 Feb 2021 12:48:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:27 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 02/24] KVM: x86/mmu: Check for shadow-present SPTE before
 querying A/D status
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

When updating accessed and dirty bits, check that the new SPTE is present
before attempting to query its A/D bits.  Failure to confirm the SPTE is
present can theoretically cause a false negative, e.g. if a MMIO SPTE
replaces a "real" SPTE and somehow the PFNs magically match.

Realistically, this is all but guaranteed to be a benign bug.  Fix it up
primarily so that a future patch can tweak the MMU_WARN_ON checking A/D
status to fire if the SPTE is not-present.

Fixes: f8e144971c68 ("kvm: x86/mmu: Add access tracking for tdp_mmu")
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c926c6b899a1..f46972892a2d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -210,13 +210,12 @@ static int kvm_mmu_page_as_id(struct kvm_mmu_page *sp)
 
 static void handle_changed_spte_acc_track(u64 old_spte, u64 new_spte, int level)
 {
-	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
-
 	if (!is_shadow_present_pte(old_spte) || !is_last_spte(old_spte, level))
 		return;
 
 	if (is_accessed_spte(old_spte) &&
-	    (!is_accessed_spte(new_spte) || pfn_changed))
+	    (!is_shadow_present_pte(new_spte) || !is_accessed_spte(new_spte) ||
+	     spte_to_pfn(old_spte) != spte_to_pfn(new_spte)))
 		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
 }
 
@@ -444,7 +443,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 
 	if (was_leaf && is_dirty_spte(old_spte) &&
-	    (!is_dirty_spte(new_spte) || pfn_changed))
+	    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
 		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
 
 	/*
-- 
2.30.1.766.gb4fecdf3b7-goog

