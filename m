Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1D3331A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhCIWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhCIWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:42:17 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 14:42:16 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e6so11575994qte.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jqjq7puvtL0+ga0HuFQpzwZNP4hDc6vknhUQK/X+oMw=;
        b=I0eo+9L92BVeyfv6dDH7KjilCQ4pfCjUMQHAfM5t8DT+rxH8lYDLUma2uZVpo2Br97
         7p7DtEumdV6Tmo+usLGGhysXjKj6dRROfrOYx+b15g54qb42SaQqwB/wcP+eV7TFghU9
         bTM0Gura1XQVSv7L5/xTQf/u4kQyqRI+1OvG5TsLh9mhwT+fKRMYL7yxTeYZDdCgz0j2
         f8+ceYieNVEM1BMTYu2x1nAkiMGuxC8LCuoegDLlGrYbhVXz+11U6Lr66dpyiU6aR0MM
         nQah7i1eTWSkctvdaop1gcfQ7Te9gnZaQ1BBonICq2HkuEVeudCJp9JbQA7HErhb62Q9
         hzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jqjq7puvtL0+ga0HuFQpzwZNP4hDc6vknhUQK/X+oMw=;
        b=Z3mjOguohKGb1tc6VUb+M752tC344kjrP3ACgWa41VoCiRhP0+HCSRpq+wDOjfsyTh
         S1IKiskZSjqgExVS88F/NJ6az9Qp8ofdg4EZIe9cWTkhFtnEah5u9zRXY68i0/7BfZIC
         yIYMOA1DFBIBJsBUCdh7BfMZMzxym0iPELJlvcwbB+2kzJYxvrQxBuPTNajQZIeOu4JH
         bPDP1qLpRZSTrzUsMrqlH4hcOY6Wcw0vVfPM7pfkrcnix0sJx2mwZ6FZNl9iseRUIi23
         rcnUWaLLGdPzoBM23jIl113MHYlf1JvFO8gH0IdcOmHC2kBJpMM6UIOIbF2/1SJVb55L
         2kIQ==
X-Gm-Message-State: AOAM533GEjFeiqh8N9lNLN09rgLtnDXD1VK2FnaXDA3ibKPvL70+t2IP
        vcCyKegFY6ZC3d1DAeadWUpq4qUSO/k=
X-Google-Smtp-Source: ABdhPJwllIw+8NYZW3YKP9LbR1K0QGHsG4bfAG2l3fxbO2x2sl1+nVYjajHPSfEmZX67pEmhYIhAz+ospwA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e4dd:6c31:9463:f8da])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1744:: with SMTP id
 dc4mr351626qvb.40.1615329736032; Tue, 09 Mar 2021 14:42:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Mar 2021 14:42:04 -0800
In-Reply-To: <20210309224207.1218275-1-seanjc@google.com>
Message-Id: <20210309224207.1218275-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210309224207.1218275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 1/4] KVM: x86: Fixup "Get active PCID only when writing a
 CR3 value"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Fix a merge conflict gone bad.

Fixes: a16241ae56fa ("KVM: x86: Get active PCID only when writing a CR3 value")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7876ddf896b8..58f4dc0e7864 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3907,7 +3907,7 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long cr3;
 
-	cr3 = __sme_set(root_hpa);
+	root_hpa = __sme_set(root_hpa);
 	if (npt_enabled) {
 		svm->vmcb->control.nested_cr3 = root_hpa;
 		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
@@ -3916,6 +3916,12 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
 			return;
 		cr3 = vcpu->arch.cr3;
+	} else if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
+		cr3 = root_hpa | kvm_get_active_pcid(vcpu);
+	} else {
+		/* PCID in the guest should be impossible with a 32-bit MMU. */
+		WARN_ON_ONCE(kvm_get_active_pcid(vcpu));
+		cr3 = root_hpa;
 	}
 
 	svm->vmcb->save.cr3 = cr3;
-- 
2.30.1.766.gb4fecdf3b7-goog

