Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2683C74BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhGMQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhGMQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:37:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF51C0613B4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n77-20020a3740500000b02903b496f6f425so17405692qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7YozZGvMSf/jCSN+Qg+5Dz6Wwzwe/H91pLQ2KVU283o=;
        b=BcNiINlWTlRB8Pp+iMlEXO+KNmSi8xP6HR5i/GC4buznyoCiy/utgiSwMW3ALjnRRn
         nIpEH1jUwc+YZ3Yn7PK4UP9oqeU4IW5K/XzzJbfbh6C4bgPmmoMMJkyrpH1ALo1XYynt
         TsXmleEcKm0hBx1rFkAQmUKil57oy5fY7pn8NQo1wt9t66LJ82I4yGg9xJDTSeW5eZEA
         e3j6G1/I9kN/huX6tphK/VyqRlLFn5ejiUgW8+sYFssO7Ma9iQROYOYnEA96gQ1QVZyJ
         U6LH3vNXjiUxmU1AFo1P5pgjw9AnLO4O6iYNFMmf1UhFmTH8D1aEBBk511dVsjh3qTY4
         U5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7YozZGvMSf/jCSN+Qg+5Dz6Wwzwe/H91pLQ2KVU283o=;
        b=k+XXnFOcK0qSftLnhGFPjG8XStoF9aO0UB9/txj6RBwo8I1FHmJYYiBU5nUn+O2sW5
         z9xpf7gXffGq8Ik6lNPfkrGK2/8OAUEGouIT1sQ08IxP/Ts53jQo1sBnQpN0WrnUzaJr
         5lEMZe0pSA1udn67hbERwme+74B9x6X0cU6XL+AOeraZkZ0COWTufmSHCHojn5gAVmHH
         c1ec+Joym03cQuOIYCuWj/uMsR+GbxhqE0fhsOrQ5abDLMDzTh28T85YfD9JwVl1VwpH
         6Qz5A7GY96xqQUBqdXe9JpATQVzgPfqt5wg2BgxFvdEF+f9pcAlqRyW/yefIgwvC7/EA
         BLLA==
X-Gm-Message-State: AOAM531V1NtH+JkGT1JoCno+DMGGbi+e/I43nCYXSldV6U/aS0vcJl2F
        vCu+hIAqBCnOx/eGrcZN6zsNAyODIFI=
X-Google-Smtp-Source: ABdhPJyWcZKsgK+9l2bQEZZgjzvQP/ukF58TgRZwOcnOZ5AVCa0Ry7R87N04oKPrwcnp5PCb7GBdAf3MB0s=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:ca1:: with SMTP id
 s1mr5767467qvs.43.1626194046121; Tue, 13 Jul 2021 09:34:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:55 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-18-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 17/46] KVM: x86: Open code necessary bits of
 kvm_lapic_set_base() at vCPU RESET
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

Stuff vcpu->arch.apic_base and apic->base_address directly during APIC
reset, as opposed to bouncing through kvm_set_apic_base() while fudging
the ENABLE bit during creation to avoid the other, unwanted side effects.

This is a step towards consolidating the APIC RESET logic across x86,
VMX, and SVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0fb282b64c8f..295a9d02a9a5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2321,7 +2321,6 @@ EXPORT_SYMBOL_GPL(kvm_apic_update_apicv);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	u64 msr_val;
 	int i;
 
 	if (!apic)
@@ -2331,10 +2330,13 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	hrtimer_cancel(&apic->lapic_timer.timer);
 
 	if (!init_event) {
-		msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
+		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
+				       MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
-			msr_val |= MSR_IA32_APICBASE_BSP;
-		kvm_lapic_set_base(vcpu, msr_val);
+			vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
+
+		apic->base_address = APIC_DEFAULT_PHYS_BASE;
+
 		kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
 	}
 	kvm_apic_set_version(apic->vcpu);
@@ -2477,11 +2479,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 		lapic_timer_advance_dynamic = false;
 	}
 
-	/*
-	 * APIC is created enabled. This will prevent kvm_lapic_set_base from
-	 * thinking that APIC state has changed.
-	 */
-	vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
 	static_branch_inc(&apic_sw_disabled.key); /* sw disabled at reset */
 	kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
 
-- 
2.32.0.93.g670b81a890-goog

