Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92D1369E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbhDXAv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244185AbhDXAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:49:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A13C061361
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so4616155ybp.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=DJN/sqIDywz/2FMtb4bxhM2j3upE+B1Quag3pNmQ3Oo=;
        b=sZAszlVUTvzyfXu+nPT1sSpYj6JD1dvWEsBo7Fa8ZOaVrztp8j1FjXhNAEl4UsxQ4v
         G/v6zCJjgHHEdEBvvS+vhX8kL6jFFT07f8xMpxv76fFAXUdyPYTzD6nOltl/cvLoRAOr
         JUW3K2I9ThxLa4WbtspdveKg8Gi7Ieiddv+pYVuaIXGh8GGSGjMmAan01ASS5CYd58xP
         zG3NGAxWnobFVYq6Kny++rrHoILQoqRVbhLTi+WY1v3NRLFU2/jNF3HLsbc2Kc6kYlhn
         cU2HcA9iXhu/gjXtmgoSZsgSV7fz6XGFe1wuMMyH984RXLdSOKKAl/O4X3A59SPATJgC
         hEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=DJN/sqIDywz/2FMtb4bxhM2j3upE+B1Quag3pNmQ3Oo=;
        b=hbAnQ8sZxlO0eRbXavg2iQVkhHxFT3ulKCyAr+W6lcRQjqZaCTDKflVAVHg22udcUB
         gR/8i6BoCH2eLTkmEm/rnsPONio0u2uy5PQBsPmh0WqNGAD0wbedwlpSvXc66jmZdlL8
         joIb0qaxjLZDowT8HfY4qFhIxauCtgwEu8KR+WybnEGiNo75aG2r/YyA3+SWAGATQ3lw
         fxD7gyBxm12Glufohp4ApL2hJ2OjoK0ZjPuwlK2Va2B3mDg6wAzHFlFTo0q0wh3DoTfh
         88aLyqvkp+OPsOF+xtdwO5KqqZ3Vt3M7VYXFfr0+e8O2b1zEQxbQM+AF8ysMhoz4qpkH
         uUQw==
X-Gm-Message-State: AOAM530RM4vDY0b/Rh/LNZtcriBkDjcNz/GFdtYlWl6r56RYqwunO96T
        TkW3wZ2exXHk8IUoAweoHbQuZyZK8Qw=
X-Google-Smtp-Source: ABdhPJw0zRN1qcjD7Mnma6hjavDzMn15lGBDX8VMfnGjsOTOnPpDJVLjMSbAtG6YvEXrlSOY/lTLS1NAABg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:4946:: with SMTP id w67mr9609876yba.141.1619225257191;
 Fri, 23 Apr 2021 17:47:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:19 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-18-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 17/43] KVM: x86: Open code necessary bits of
 kvm_lapic_set_base() at vCPU RESET
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
index b088f6984b37..b1366df46d1d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2305,7 +2305,6 @@ EXPORT_SYMBOL_GPL(kvm_apic_update_apicv);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	u64 msr_val;
 	int i;
 
 	if (!apic)
@@ -2315,10 +2314,13 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
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
+		apic->base_address = MSR_IA32_APICBASE_ENABLE;
+
 		kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
 	}
 	kvm_apic_set_version(apic->vcpu);
@@ -2461,11 +2463,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
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
2.31.1.498.g6c1eba8ee3d-goog

