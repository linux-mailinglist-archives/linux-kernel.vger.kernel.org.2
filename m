Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE33B0BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhFVSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhFVSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:00:20 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E59C061766
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r15-20020a0562140c4fb0290262f40bf4bcso18346916qvj.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=w16oYt0iKSKWOMspUVtVlE9oFeOTkC9A/TBUaesRgr0=;
        b=wCOY/2V6r5LJo6VUNy2t44U0CjXGUf3gp6SBDvliT/3aYksK7+5EpnjfV9JSvomODP
         PWWEKUodU01x8l/Vvcph3qX209E0sO2Er0XB2uhDIJamudunocqSTJLI6Xpjl4bsWwDs
         MyIDrG0HlvNBZmPuqCT+D8pGut1jyt33Pltp2xkYpwAWfxnNyFbX5Xd8Ake35zHAFuri
         KeGgu+iC6tX8yKIKY9uUPKrTSDAa0B8HTEtI7dAIkvW1NNBikB5TecyW9aChHYvWollr
         5MWTYG6E5bRRagwBcZueQPspSBil5B/Rlgs9CA22GODgovTWQA+WrDkZl6G2DK/8jsoH
         970Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=w16oYt0iKSKWOMspUVtVlE9oFeOTkC9A/TBUaesRgr0=;
        b=joMzVapz7nL1e812AJKqaxyLPXO9SKm5PjOEsxwJRf5h22brjA+f3UO94vNIrSZtjy
         x3GdVR3vmlO4YnDzwXHZLzAjADSzk1B+3mStYRNZY76dXikDnPWXfiArSrYID/q3693i
         urUG1T+kSBeKGSeelOOogiEKIaR+CYJw5JYgRadWUzsne/IiFlvljmp34UbjnrupEJAD
         RFVvYpDneKWaIBjIMgYJey1FyNJRh6LCUS+/QYkGtEpnxlDv1JnyOW2rA8b6MR5mi0SW
         L2UlURX2NyUbD6yEpDS0S+p0BllOXUkQJ2xb3CT+1DOB67jlFL8vNvqkTnS6i9M14vaM
         XzfQ==
X-Gm-Message-State: AOAM530po47O5SruNQ1W486IdIhpouziPBWMm9vhhW6qyI3JzXWJJiMt
        Hfgp9GP0hZ4b1BuU+A4UAf6KLC7siJ8=
X-Google-Smtp-Source: ABdhPJzhjd9weDitq99P+aWf5UUwgjWeiPEDbkdiLCgMwTr/Xsn4umcE0nX1tvL+mom4QsYOUvRMv1sS6PY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:ab6b:: with SMTP id u98mr6473219ybi.98.1624384682743;
 Tue, 22 Jun 2021 10:58:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:56:48 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 03/54] KVM: x86: Properly reset MMU context at vCPU RESET/INIT
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

Reset the MMU context at vCPU INIT (and RESET for good measure) if CR0.PG
was set prior to INIT.  Simply re-initializing the current MMU is not
sufficient as the current root HPA may not be usable in the new context.
E.g. if TDP is disabled and INIT arrives while the vCPU is in long mode,
KVM will fail to switch to the 32-bit pae_root and bomb on the next
VM-Enter due to running with a 64-bit CR3 in 32-bit mode.

This bug was papered over in both VMX and SVM, but still managed to rear
its head in the MMU role on VMX.  Because EFER.LMA=1 requires CR0.PG=1,
kvm_calc_shadow_mmu_root_page_role() checks for EFER.LMA without first
checking CR0.PG.  VMX's RESET/INIT flow writes CR0 before EFER, and so
an INIT with the vCPU in 64-bit mode will cause the hack-a-fix to
generate the wrong MMU role.

In VMX, the INIT issue is specific to running without unrestricted guest
since unrestricted guest is available if and only if EPT is enabled.
Commit 8668a3c468ed ("KVM: VMX: Reset mmu context when entering real
mode") resolved the issue by forcing a reset when entering emulated real
mode.

In SVM, commit ebae871a509d ("kvm: svm: reset mmu on VCPU reset") forced
a MMU reset on every INIT to workaround the flaw in common x86.  Note, at
the time the bug was fixed, the SVM problem was exacerbated by a complete
lack of a CR4 update.

The vendor resets will be reverted in future patches, primarily to aid
bisection in case there are non-INIT flows that rely on the existing VMX
logic.

Because CR0.PG is unconditionally cleared on INIT, and because CR0.WP and
all CR4/EFER paging bits are ignored if CR0.PG=0, simply checking that
CR0.PG was '1' prior to INIT/RESET is sufficient to detect a required MMU
context reset.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 76dae88cf524..42608b515ce4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10735,6 +10735,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
+	unsigned long old_cr0 = kvm_read_cr0(vcpu);
+
 	kvm_lapic_reset(vcpu, init_event);
 
 	vcpu->arch.hflags = 0;
@@ -10803,6 +10805,17 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.ia32_xss = 0;
 
 	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
+
+	/*
+	 * Reset the MMU context if paging was enabled prior to INIT (which is
+	 * implied if CR0.PG=1 as CR0 will be '0' prior to RESET).  Unlike the
+	 * standard CR0/CR4/EFER modification paths, only CR0.PG needs to be
+	 * checked because it is unconditionally cleared on INIT and all other
+	 * paging related bits are ignored if paging is disabled, i.e. CR0.WP,
+	 * CR4, and EFER changes are all irrelevant if CR0.PG was '0'.
+	 */
+	if (old_cr0 & X86_CR0_PG)
+		kvm_mmu_reset_context(vcpu);
 }
 
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
-- 
2.32.0.288.g62a8d224e6-goog

