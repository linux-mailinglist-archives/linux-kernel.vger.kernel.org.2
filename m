Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B743A86CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFOQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhFOQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:47:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0AC061280
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so20652623ybf.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=XJacYOCj9BZGvWs61g7748RC1H4h4/tN+J594W0xPcg=;
        b=T8v/HLtZvU81tX+n01GbDL/U0aO2OQ+BoapIR2tZ3hbBHS9DoFqeukZBnu9NEgy+y7
         zS+E16VAsGkLv+8ZKU0s0oU4iEY87LIo/qszXU+1jtmAqBTncaWQXhER7+lOn6JHFEWz
         EsOdZhs6b2ywtBt152/0M8XyVn1ikUIYxYYG0B8Ddrh3a1AO/UJ3NLn44dZoSGulUaaN
         2camCjJgNk9N0o1+cNk+wZBPmjKj+RJSQGMh68FaF7YGfzBHtwcqb6+yuwwDCy4dtE4C
         v9WYIKxZk9FyAJVtJdp9OztS9A0LVDpq6rVtjQDexRJv4DZRtMEfaKgQrRANMNMYBnim
         1A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=XJacYOCj9BZGvWs61g7748RC1H4h4/tN+J594W0xPcg=;
        b=W3GTBmvUfDEovljknUS3IitRFZevjBuoi7XDZ6EH4hJP6pHpyFFH0LDNYPxUWhpWkd
         AyNzv6wbIOeJMNYhWHZRNx1VcOPcPrrqmWMij5IeP72QKpJOM4NSd4ePlvwtDmgCvUPj
         oUQsJELp0etWZd3igURzZ0pv+MOiZY88KHRhqydon25WxwdRxVCV0FLa5xXGFD808cl2
         obRpt4LSnkXsgajQxA77KXY85Ck9UamnJaweW3VBAmfS8Hsudj53mpgGuqB3HiQIMeu9
         4vyz/byn+iW+9mBsuhWz0XqBvBFEqOCXxDTwmshMBj1kDYYb7+f083KSrydbvnxiS4Ls
         M6qQ==
X-Gm-Message-State: AOAM532TaZS1+f++6wPlA9CLBec/V/my3NYSEEsvGmmhhvRbRCydbhhV
        k43ffr0Ray2ujkHx8t0ZJm+zKWAmc7Y=
X-Google-Smtp-Source: ABdhPJypTRjYIvyklZyabwZOPiUD8X5oGr7ScObtZ7Ya9rN8bbMDwVz84LxCjAoYj4FpMU1/HMGoGNFluxc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:13fc:a8bd:9d6b:e5])
 (user=seanjc job=sendgmr) by 2002:a25:aac7:: with SMTP id t65mr16428ybi.501.1623775547658;
 Tue, 15 Jun 2021 09:45:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Jun 2021 09:45:35 -0700
In-Reply-To: <20210615164535.2146172-1-seanjc@google.com>
Message-Id: <20210615164535.2146172-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210615164535.2146172-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 4/4] KVM: x86: Simplify logic to handle lack of host NX support
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

Use boot_cpu_has() to check for NX support now that KVM requires
host_efer.NX=1 if NX is supported.  Opportunistically avoid the guest
CPUID lookup in cpuid_fix_nx_cap() if NX is supported, which is by far
the common case.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b4da665bb892..786f556302cd 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -208,16 +208,14 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_mmu_reset_context(vcpu);
 }
 
-static int is_efer_nx(void)
-{
-	return host_efer & EFER_NX;
-}
-
 static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
 {
 	int i;
 	struct kvm_cpuid_entry2 *e, *entry;
 
+	if (boot_cpu_has(X86_FEATURE_NX))
+		return;
+
 	entry = NULL;
 	for (i = 0; i < vcpu->arch.cpuid_nent; ++i) {
 		e = &vcpu->arch.cpuid_entries[i];
@@ -226,7 +224,7 @@ static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
 			break;
 		}
 	}
-	if (entry && cpuid_entry_has(entry, X86_FEATURE_NX) && !is_efer_nx()) {
+	if (entry && cpuid_entry_has(entry, X86_FEATURE_NX)) {
 		cpuid_entry_clear(entry, X86_FEATURE_NX);
 		printk(KERN_INFO "kvm: guest NX capability removed\n");
 	}
@@ -401,7 +399,6 @@ static __always_inline void kvm_cpu_cap_mask(enum cpuid_leafs leaf, u32 mask)
 
 void kvm_set_cpu_caps(void)
 {
-	unsigned int f_nx = is_efer_nx() ? F(NX) : 0;
 #ifdef CONFIG_X86_64
 	unsigned int f_gbpages = F(GBPAGES);
 	unsigned int f_lm = F(LM);
@@ -515,7 +512,7 @@ void kvm_set_cpu_caps(void)
 		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SYSCALL) |
 		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
 		F(PAT) | F(PSE36) | 0 /* Reserved */ |
-		f_nx | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
+		F(NX) | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
 		F(FXSR) | F(FXSR_OPT) | f_gbpages | F(RDTSCP) |
 		0 /* Reserved */ | f_lm | F(3DNOWEXT) | F(3DNOW)
 	);
-- 
2.32.0.272.g935e593368-goog

