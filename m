Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC5457B93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhKTE4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhKTEyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE623C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id y18-20020a634952000000b002ecc060ccc8so5039321pgk.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IyXttzViF+EKA3KhGB9+yBuyqNGYCcO0tszuN7QfJJs=;
        b=CBVGUeybvOBWqP5tSJP4MGoV7wNbSUtar/Uw9BTnPFPfADwoZ9PvbDiqHhWuQmM5wp
         niwo3Yw3th0a8ophhAlDog+xj1xwK3e+LkgjgMtmx5n4ksDKqPriX88F/UEjx2MDAT2r
         CZyxs00DrtgvmBXeC0eJRZlHtcGtoxtm9bGgZT67AGI4AsMKuIAlOMec6IxOVrhOO2fV
         KQm3UzOZcOLXVHa/APpcw/9bNIfB6uPrnLDVIALmh7EN+PctusPj2LidMJPhQFV/0PyW
         BeFbP7gFoM+nzMheTscm/et4w0hIcLISJX3O+OazeFh2Ord5QWOIb0M667wzCzXRFUCB
         tuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IyXttzViF+EKA3KhGB9+yBuyqNGYCcO0tszuN7QfJJs=;
        b=xTRDq00Frmj5vi7wnuAN7Sm0Z8qefB/lesq9Fkw7cZdgC9iX/Gcl10Z0WNjyS5jxRr
         sAeZThY1FLwXHHlVc6zsUUI+s0NlW2jq4m33pcXg9hAfwqvNSupzgWbLkNg+J/4V1009
         nsPreZVUdC/2Z2HwmofNq7+g7qZs5Md+Z+oFsCGJyO6ixr59gDiPlzHjR1qTaZTBnmQO
         xmMTyGRkNagdcjOO6klUVOSICOQ04zZt2+KODpEDpFDgaKvZ7ReqwntvN4cqPaoayHDD
         HWnir6rtlELBfhj66zfPXmD1ekCBScUI3uQeEaAZplnW/3PfP61dQWid0CHoxWmFzORG
         npcA==
X-Gm-Message-State: AOAM530STX6Uev4c0My40XRi5AydjnQwEy704TbBHnf6SyE7YW9XIUlR
        uqnKyypKZKRLKw+hRRPhDig24z7eUmw=
X-Google-Smtp-Source: ABdhPJy+BPD4vcAmVvlzIaEsidnbgRoZXFJ+/dD6AJnyOF1/UbeaoLmV+bA/ThCDGW81MyCX6ZunZwqEs0k=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3e85:: with SMTP id
 rj5mr6793643pjb.172.1637383871528; Fri, 19 Nov 2021 20:51:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:29 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-12-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 11/28] KVM: x86/mmu: Check for !leaf=>leaf, not PFN change, in
 TDP MMU SP removal
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look for a !leaf=>leaf conversion instead of a PFN change when checking
if a SPTE change removed a TDP MMU shadow page.  Convert the PFN check
into a WARN, as KVM should never change the PFN of a shadow page (except
when its being zapped or replaced).

From a purely theoretical perspective, it's not illegal to replace a SP
with a hugepage pointing at the same PFN.  In practice, it's impossible
as that would require mapping guest memory overtop a kernel-allocated SP.
Either way, the check is odd.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 138c7dc41d2c..8e446ef03022 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -489,9 +489,12 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
-	 * the paging structure.
+	 * the paging structure.  Note the WARN on the PFN changing without the
+	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
+	 * pages are kernel allocations and should never be migrated.
 	 */
-	if (was_present && !was_leaf && (pfn_changed || !is_present))
+	if (was_present && !was_leaf &&
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_tdp_mmu_page(kvm,
 				spte_to_child_pt(old_spte, level), shared);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

