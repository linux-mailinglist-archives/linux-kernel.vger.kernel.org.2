Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46C33B0BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFVSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhFVSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:00:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF171C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:57:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 14-20020a37060e0000b02903aad32851d2so19098083qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/fL0eFtMViaI+pLQ+p/yxMkgCYrB50jqMM8EallIziw=;
        b=nfBQWmOotSk7zxmjZWsTw0TdrpqnnpN7Mk4+o9aBj2MGa+i8KJo9kDkR2iRFtVu/Lz
         FQUjoo4VZdCyUlWnaEhS8uuPWIWxreUkQ9W/byttwTBhO0LrFxar3ZBR2fEGW4OqAB9N
         8RnBmaRwCloVv6biWAjgn1Exzc/WF3gCOLCIAz1Xkr36Fb8eErIl8gegRAv7ZjKHl6IW
         QhmR5MgSx87RqqqKuZZcwp15yFwfxg4sbYv8XUiFqwzZ+RUYl7GuqtLrqIFAn4ams/P7
         TpBNApCmwQMZYAOfE0/2/L9kSEyrDs7pQrW0OHcPx+PNWTRJyVFMkqjPxzZAu8YF8b9E
         iEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/fL0eFtMViaI+pLQ+p/yxMkgCYrB50jqMM8EallIziw=;
        b=JVqjjWzn6uZ3jCtDdETHWJ4FnSBRfJy+49GYfLJGwZacOQ3VgOPqhq3tt2nb1z/dQB
         yQ0zebbDXCPHMcVHmUHZRLU6rzZ1j659o2fQGL32ilwFNykq/58jq573CmzaXLpEVHhG
         Hi7Y5jQeJSowx1zMlM8hKudwy+jOXrq+QOJJqXZ1WNcrk0v78QG/Bqdi5jAykzL3Xh6p
         tb6Kz51ZlvLNXBf+/KZ2z6bv1JU4dGflOQHAvTTVBTGFrWPtYwKh/v4IYOI1T2sljSdz
         SPeTrk1z3x6BYLeLhF6oxmclNzofunE1DYENNhRWg2LE2IdmeH6yhxuHhqQVHO+vyyua
         Vggg==
X-Gm-Message-State: AOAM533GK8ZVHqalSGRIykNEapwj8qKzqd0r4lYMtJcvF2t5Ijas/nb8
        mLCcMk9IBVCRrJ/Qdif+23fO4YNRLdM=
X-Google-Smtp-Source: ABdhPJy4HSUsMUGD9BPsLjOhafmF0KpL3oWnLoJm6r7xjntV1mYlUiPhpGggjjRIEdQIALyvDbjOxgoaJrU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:2e43:: with SMTP id b3mr6234041ybn.152.1624384678162;
 Tue, 22 Jun 2021 10:57:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:56:46 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 01/54] KVM: x86/mmu: Remove broken WARN that fires on 32-bit
 KVM w/ nested EPT
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

Remove a misguided WARN that attempts to detect the scenario where using
a special A/D tracking flag will set reserved bits on a non-MMIO spte.
The WARN triggers false positives when using EPT with 32-bit KVM because
of the !64-bit clause, which is just flat out wrong.  The whole A/D
tracking goo is specific to EPT, and one of the big selling points of EPT
is that EPT is decoupled from the host's native paging mode.

Drop the WARN instead of trying to salvage the check.  Keeping a check
specific to A/D tracking bits would essentially regurgitate the same code
that led to KVM needed the tracking bits in the first place.

A better approach would be to add a generic WARN on reserved bits being
set, which would naturally cover the A/D tracking bits, work for all
flavors of paging, and be self-documenting to some extent.

Fixes: 8a406c89532c ("KVM: x86/mmu: Rename and document A/D scheme for TDP SPTEs")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 66d43cec0c31..8e8e8da740a0 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -102,13 +102,6 @@ int make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
 	else if (kvm_vcpu_ad_need_write_protect(vcpu))
 		spte |= SPTE_TDP_AD_WRPROT_ONLY_MASK;
 
-	/*
-	 * Bits 62:52 of PAE SPTEs are reserved.  WARN if said bits are set
-	 * if PAE paging may be employed (shadow paging or any 32-bit KVM).
-	 */
-	WARN_ON_ONCE((!tdp_enabled || !IS_ENABLED(CONFIG_X86_64)) &&
-		     (spte & SPTE_TDP_AD_MASK));
-
 	/*
 	 * For the EPT case, shadow_present_mask is 0 if hardware
 	 * supports exec-only page table entries.  In that case,
-- 
2.32.0.288.g62a8d224e6-goog

