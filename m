Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76C63B0C30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFVSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhFVSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:02:41 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD019C061768
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w1-20020ac87a610000b02902433332a0easo157007qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ekJelZQDtOg2bmuT8yVOm7weMscfRToXO3BLfoIb514=;
        b=FqGLS1J8OlF/+o5Y7PYq2w4GiMjzR2AyNSNlChYwAYHVMM9EvIfRCL2QcJ5cX/o8C5
         L3w0Rl2aj/tTuUaOQT6+3mmlVZfjGOcVZM2bNeVSiNs1VMC3hnWMPIfLHeLBB7SXM7f4
         7FlRQFSCtRfalvPEe9l+Xh5i84VC7dV1Pn/52qtnx76iwQqTYdpaQkD2+7ZXqPfi0sb2
         V4n2Jx+SBbcGcHfyD4jPsIXidHWQ8YN+mbCcSALMWrjkis43g8UFJxDrJQpdiJMWBfYN
         bBZMMTt63jS4xPFv2PQ3kaqe+4NOPwTLDEwcMgkssUHoJ2PFzTrDAM3hzwH++EHpcFT2
         g9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ekJelZQDtOg2bmuT8yVOm7weMscfRToXO3BLfoIb514=;
        b=BKMCfT0gbsWxblN3jkAGrhmowDiCBgwuVzcSs4KVKtykUEiMVKLMj15cIJUs6Wl0oL
         vPHQmBN9sHkS8447fZ6Nzn81Vs8ANveIbb1PrgO/znarMKc/r+ozKpMp3Uz4/sjuGk4v
         tGQ0drN3wLC14OClYoAImJSTCXc2QvPNpnhveBh9xWUQCjTgOS26+5iwVB0C4S+vaZzQ
         32iMCN611BCunLXtb8CNoiMfAokvUNw+yTh/ymLoKZ/inrFblmEhfNQnd1y/IYigz3cT
         3tjEbCFX8oUj2rGBkWmjR6fcWaSmPOAosGN+SLWqtIGTSSg34/QbTcyAx6w5WDA3MI5N
         xbrA==
X-Gm-Message-State: AOAM5301jxjQzIoPqfXhiIXNjdI1CHdzjuZ50n01lAtlStMzckA7jHfN
        +aiWSgLz7IxYHesDRAQNA+NvGSo30us=
X-Google-Smtp-Source: ABdhPJywm8cb6ygkCmprXmzhnEhAs7kBP3Sv3JtWBhBbNtgfJAngkfF78JyNZg4FQWMFwIF0v6eckeqbvJc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:6088:: with SMTP id u130mr6652474ybb.257.1624384742891;
 Tue, 22 Jun 2021 10:59:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:14 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-30-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 29/54] KVM: x86/mmu: Don't grab CR4.PSE for calculating shadow
 reserved bits
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

Unconditionally pass pse=false when calculating reserved bits for shadow
PTEs.  CR4.PSE is only relevant for 32-bit non-PAE paging, which KVM does
not use for shadow paging (including nested NPT).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 337a3e571db6..ffcaede019e4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4281,19 +4281,22 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	 * MMU contexts.  Note, KVM forces EFER.NX=1 when TDP is disabled.
 	 */
 	bool uses_nx = context->nx || !tdp_enabled;
+
+	/* @amd adds a check on bit of SPTEs, which KVM shouldn't use anyways. */
+	bool is_amd = true;
+	/* KVM doesn't use 2-level page tables for the shadow MMU. */
+	bool is_pse = false;
 	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
-	/*
-	 * Passing "true" to the last argument is okay; it adds a check
-	 * on bit 8 of the SPTEs which KVM doesn't use anyway.
-	 */
+	WARN_ON_ONCE(context->shadow_root_level < PT32E_ROOT_LEVEL);
+
 	shadow_zero_check = &context->shadow_zero_check;
 	__reset_rsvds_bits_mask(vcpu, shadow_zero_check,
 				reserved_hpa_bits(),
 				context->shadow_root_level, uses_nx,
 				guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES),
-				is_pse(vcpu), true);
+				is_pse, is_amd);
 
 	if (!shadow_me_mask)
 		return;
@@ -4329,7 +4332,7 @@ reset_tdp_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 					reserved_hpa_bits(),
 					context->shadow_root_level, false,
 					boot_cpu_has(X86_FEATURE_GBPAGES),
-					true, true);
+					false, true);
 	else
 		__reset_rsvds_bits_mask_ept(shadow_zero_check,
 					    reserved_hpa_bits(), false);
-- 
2.32.0.288.g62a8d224e6-goog

