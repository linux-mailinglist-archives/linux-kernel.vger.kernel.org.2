Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6ED3C74B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhGMQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhGMQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F47C0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 132-20020a25158a0000b029055791ebe1e6so27978880ybv.20
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xu9lt7ml4nTWe9cpEWKdb0fo86g2MaNZbmfwbHMDB9k=;
        b=fvcTCZaP7A7KM7+eVBkJ3b6bqoSUEtZ9Q4kaNDtWYRCWlGiQW1TfaVXqXxNra1YNAk
         3m1x2PMNDOodqjQEvqFbGqj6rmIJe5ICcVTgxeDlgTorX+fCJvENw3/5Lh2uOQAkO/6i
         DxK2XwqqlRjL1sx+zC2vlVjq4RYlbIHTXCgE4Wdafy4UgSRpCofV86xw0AZH1IPVGMzf
         Hz3EewbfVTtRvY+H0ae9dtfNm0bpZgtAmCvwdrbG4a+OyRh5PG5qBNdw6fmvBQv1kVkT
         ESWi9enkzktooOyXyBqI7YYaM3n022F4bsMGGfF02JlavaWBk9/qjpUbUnss58H1NBXS
         M1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xu9lt7ml4nTWe9cpEWKdb0fo86g2MaNZbmfwbHMDB9k=;
        b=Kj9d7f3WVwF+OoulAT2MKZAq2ovWZnt4NFtM+NQT7EAt9XjwWy/DKObsDBWJLoLxd3
         TjjsCtGapd82Y+ooccc4TuCT4vTn7gn+uo1YHSNMQUNP6j8m3ANCLanaO4IlXRHgHRZ7
         aAuDywd1c4f4Ubu9q2S+LdJGQwU32FM9F7/V8UBcnsgytLcnL6vBZp3eUy0yllvfye3P
         jrla5SsYpNOzkQwFLDK3wCZcmNo0AM7O8sgPACCCW2lmWCtxYY3ovTaqt1utBZpBTRR8
         RiCVUTWz02Ur9kP9mLXj2pLuHXHSj/SuZqdFitKPKofv0aUMnsL+oYoUTUFVopeoAFJH
         5o+Q==
X-Gm-Message-State: AOAM532D7/XLHHJ0afieqScxYVHlpGGwdHLUdiZfcVxHZd1mHVv1qXt4
        YObl2G7ze08SgNqokLECzAIcq4qn/PE=
X-Google-Smtp-Source: ABdhPJyUk7ZBK00HqxMu16yC3TPRFg54XBhrFFpZfREhXqq8Th4XViilePl3UFmAj6aEj+O6jCUueIaSxSo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:bcd2:: with SMTP id l18mr6659895ybm.66.1626194037119;
 Tue, 13 Jul 2021 09:33:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:50 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 12/46] KVM: x86: Remove defunct BSP "update" in local APIC reset
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a BSP APIC update in kvm_lapic_reset() that is a glorified and
confusing nop.  When the code was originally added, kvm_vcpu_is_bsp()
queried kvm->arch.bsp_vcpu, i.e. the intent was to set the BSP bit in the
BSP vCPU's APIC.  But, stuffing the BSP bit at INIT was wrong since the
guest can change its BSP(s); this was fixed by commit 58d269d8cccc ("KVM:
x86: BSP in MSR_IA32_APICBASE is writable").

In other words, kvm_vcpu_is_bsp() is now purely a reflection of
vcpu->arch.apic_base.MSR_IA32_APICBASE_BSP, thus the update will always
set the current value and kvm_lapic_set_base() is effectively a nop if
the new and old values match.  The RESET case, which does need to stuff
the BSP for the reset vCPU, is handled by vendor code (though this will
soon be moved to common code).

No functional change intended.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index add4dd1e3528..a24ce8fe93e5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2367,9 +2367,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	apic->highest_isr_cache = -1;
 	update_divide_count(apic);
 	atomic_set(&apic->lapic_timer.pending, 0);
-	if (kvm_vcpu_is_bsp(vcpu))
-		kvm_lapic_set_base(vcpu,
-				vcpu->arch.apic_base | MSR_IA32_APICBASE_BSP);
+
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
 	if (vcpu->arch.apicv_active) {
-- 
2.32.0.93.g670b81a890-goog

