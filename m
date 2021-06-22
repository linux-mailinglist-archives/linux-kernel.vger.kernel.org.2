Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A123B0C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhFVSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhFVSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:03:36 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE33C0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q20-20020a0cf5d40000b029027498137223so6723683qvm.15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=pzt94mBjAG5NVEqIJH/e3eGoUXo6CRdbPK68D1RlOck=;
        b=S6ljFFisciTpz8XtZ9DaEnAmz/WsqJMw/G/PenaFoUXrWQ31VdmW9pLplT3Ucxpbr2
         OUem4tgqlxMyHsj/U71bi6OgoeDbwOO+YJGCXfNSBlCUcPQ3/EUKrTRxWTnnOU4eBzBO
         +XvH71S6P+KpnSFGyvWDBY6JohbsyssS+ozxvXtxzA1nepcHelQt95SeVNYLoooA/Dgv
         Fb6/+jRKrtCY7pMxVLRZuzvUoTAL+jISE4C8swVyjewc2siprSXpq5yWvgmgTZWPjeGK
         ghfhkdFA4x2dMnupI8PW5ItSoTHubgJcNfQ4fZa9MOFdP3WqH+TsB7Q6oF9rGuU2eUgM
         hR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=pzt94mBjAG5NVEqIJH/e3eGoUXo6CRdbPK68D1RlOck=;
        b=l94Ppkrhwc0+ssmxqcOSuHMeYCOu2vAcihQcxNoy5+iY6pRqGVE7dSyOE1SjOsywrx
         zz7bj8ZtohXEqYurGuL0F7txhoPZQBlAgtY6n3iQk4FvF3IffGQ6UCzbDAuaMfIRHkA7
         Gsak/vimKWsvIFupivdVGRh42anEBDxJoUSE9zPXO6Qfy6NnwjXx1r92JvBWSDghAPrM
         XH0JnSLe1CYdbYoLIZIzJpzCqZUURPUdYh9+A75W3KgacaNqN7VWPyy+36+1+jtSO2UJ
         WDHI4j6t2t0pdEQe08ipEYyit3058dDvcbh/LlU3LPLYySKNQ7vDdhGncT5w82rVQsDJ
         U7xg==
X-Gm-Message-State: AOAM533a+mbRiGPIatpnck5pjCe38oGuxvVpmyqnQrrfNM54KAMbZno3
        M6uc/nIEtaym7buSmNjY5dWj43CwgIE=
X-Google-Smtp-Source: ABdhPJxl9IUuzOPn0PO+cg+1H7HMcPFz89sz+AqtX6+aZFX/T5wmXNljGTtXZNeta93u69xedNrf9ehyy4Y=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:2315:: with SMTP id j21mr6102427ybj.37.1624384754058;
 Tue, 22 Jun 2021 10:59:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:19 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-35-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 34/54] KVM: x86/mmu: Use MMU's roles to compute last non-leaf level
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

Use the MMU's role to get CR4.PSE when determining the last level at
which the guest _cannot_ create a non-leaf PTE, i.e. cannot create a
huge page.

Note, the existing logic is arguably wrong when considering 5-level
paging and the case where 1gb pages aren't supported.  In practice, the
logic is confusing but not broken, because except for 32-bit non-PAE
paging, the PAGE_SIZE bit is reserved when a huge page isn't supported at
that level.  I.e. PAGE_SIZE=1 will terminate the guest walk one way or
another.  Furthermore, last_nonleaf_level is only consulted after KVM has
verified there are no reserved bits set.

All that confusion will be addressed in a future patch by dropping
last_nonleaf_level entirely.  For now, massage the code to continue the
march toward using mmu_role for (almost) all MMU computations.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dcde7514358b..67aa19ab628d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4504,12 +4504,12 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 	}
 }
 
-static void update_last_nonleaf_level(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
+static void update_last_nonleaf_level(struct kvm_mmu *mmu)
 {
 	unsigned root_level = mmu->root_level;
 
 	mmu->last_nonleaf_level = root_level;
-	if (root_level == PT32_ROOT_LEVEL && is_pse(vcpu))
+	if (root_level == PT32_ROOT_LEVEL && is_cr4_pse(mmu))
 		mmu->last_nonleaf_level++;
 }
 
@@ -4666,7 +4666,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 
 	update_permission_bitmask(context, false);
 	update_pkru_bitmask(context);
-	update_last_nonleaf_level(vcpu, context);
+	update_last_nonleaf_level(context);
 	reset_tdp_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -4724,7 +4724,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 		reset_rsvds_bits_mask(vcpu, context);
 		update_permission_bitmask(context, false);
 		update_pkru_bitmask(context);
-		update_last_nonleaf_level(vcpu, context);
+		update_last_nonleaf_level(context);
 	}
 	context->shadow_root_level = new_role.base.level;
 
@@ -4831,7 +4831,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->direct_map = false;
 
 	update_permission_bitmask(context, true);
-	update_last_nonleaf_level(vcpu, context);
+	update_last_nonleaf_level(context);
 	update_pkru_bitmask(context);
 	reset_rsvds_bits_mask_ept(vcpu, context, execonly);
 	reset_ept_shadow_zero_bits_mask(vcpu, context, execonly);
@@ -4929,7 +4929,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 
 	update_permission_bitmask(g_context, false);
 	update_pkru_bitmask(g_context);
-	update_last_nonleaf_level(vcpu, g_context);
+	update_last_nonleaf_level(g_context);
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
-- 
2.32.0.288.g62a8d224e6-goog

