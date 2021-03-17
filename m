Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247CA33F82A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhCQSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhCQSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:33:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A25C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:33:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 6so45970642ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=iN3Yk4BT6E8ODsBE6/6lbV/Wds9PkzZtmaKSlaFBXSg=;
        b=r6eLaYgWxze95fVtYa0g4OzhFwOnQmabn7JZN+0rni/lK5uQLjf/oJBfQQw+QLm+99
         JD4M4ntztfXhabG7K0dnBSWqsmlMw6gQ/YLGiW4Mf4oj4hIbdx5Dyek3fQShuh4KHbAD
         34yZQrvMYH7ZsIMjyLNqNRnhwf+zg9HONEQ+j36iOcc5aHFsaN3odnB87j64/PWtImRx
         HDBhZAfmr0hzCB7qgOSwB+ikgmLVCRVO7OMm5PcM+tfFIxULSHpKDNkczV/pBQlWaGpk
         dXNoThYEiPWy4AXjSsZMGfvdR8P3QVfLeIMGU+F+88iUtHGtrsJS6KsYOsS4CY1bjd8C
         bv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=iN3Yk4BT6E8ODsBE6/6lbV/Wds9PkzZtmaKSlaFBXSg=;
        b=Kd7nagRIj4Jv1oRrLGdvnP//pTdk0N44d7eP694QKVCWY33B8emKKhKS6GJII/99b3
         cGGbJiE7RXfxWs/7Dvdf2KYALpRN4xZ541u2xdzOz9I0baGwVyZarO4AArpD9Qhhzg9A
         LQZ+LwDgMHN4nvLpRJIHMUcI9+wrD3m4uYgCH+r5jtBMxD/y+i4BTKsour1RmYaJEzSM
         n+DnmGXqr17Qv8Ir6j1k2TZPmc4zcbVLKbyJl3O6UY6jPogVVJMaNb1/ZxI4WuzLO3R9
         UXY2ZZ7Dv5wlgyby4acEcuhlx5akhQVmH4csFAAArGZCTzHVE5JXdZsslhvfngWRU06L
         OiyQ==
X-Gm-Message-State: AOAM532kesmeHP8n2E9ajzrlojrqGxb5clzSAXG8R/1upMpQsw2vaKZf
        MGrknAZMScSpsV62OdivtDauc4hU4MQ=
X-Google-Smtp-Source: ABdhPJz/+zOjt2CPHPIoQuvlD0TfU/npOvQdS8SYZblCWWMVEJnNdnq91g8Vv/ct//C/AV3ce2SGdesb2mM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
 (user=seanjc job=sendgmr) by 2002:a25:cc44:: with SMTP id l65mr4952924ybf.150.1616005985351;
 Wed, 17 Mar 2021 11:33:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 17 Mar 2021 11:32:43 -0700
Message-Id: <20210317183243.2904919-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] x86/cpu/AMD: Adjust x86_phys_bits to account for reduced PA
 in SEV-* guests
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always reduce x86_phys_bits per CPUID.0x8000001f[11:6] for SEV-* guests;
the existing flow that queries X86_FEATURE_SEV may or may not trigger
depending on what the VMM emulates, e.g. the VMM likely does not emulate
MSR_K8_SYSCFG.

Print a somewhat scary message and override x86_phys_bits if the VMM
doesn't omit the C-bit from MAXPHYADDR, which can be done either by
enumerating a lower MAXPHYADDR or by enumerating a non-zero
PhysAddrReduction.

Failure to adjust x86_phys_bits results in a false positive for
phys_addr_valid() if the address sets the C-bit, and may also result in
false positives for virt_addr_valid().  This is likely benign for a well-
functioning kernel+drivers, but it's nearly impossible to confidently
audit all users of the *_addr_valid() helpers, so who knows.

Opportunistically force clearing of SME, SEV, and SEV_ES in this case,
as the kernel and KVM treat those feature flags as host capabilities, not
guest capabilities.  This is likely a nop for most deployments, e.g. KVM
doesn't emulate MSR_K8_SYSCFG.

Note, early kernel boot code for SEV-*, e.g. get_sev_encryption_bit(),
_requires_ the SEV feature flag to be set in CPUID in order to identify
SEV (this requirement comes from the SEV-ES GHCB standard).  But, that
requirement does not mean the kernel must also "advertise" SEV in its own
CPU features array.

Fixes: d8aa7eea78a1 ("x86/mm: Add Secure Encrypted Virtualization (SEV) support")
Cc: stable@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Regarding clearing SME, SEV, SEV_ES, etc..., it's obviously not required,
but to avoid false postives, identifying "SEV guest" within the kernel
must be done with sev_active().  And if we want to display support in
/proc/cpuinfo, IMO it should be a separate synthetic feature so that
userspace sees "sev_guest" instead of "sev".

 arch/x86/kernel/cpu/amd.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384dc9ab..0f7f8c905226 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/cpu.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
+#include <asm/mem_encrypt.h>
 #include <asm/numa.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -575,10 +576,33 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	resctrl_cpu_detect(c);
 }
 
+#define SEV_CBIT_MSG "SEV: C-bit (bit %d), overlaps MAXPHYADDR (%d bits).  VMM is buggy or malicious, overriding MAXPHYADDR to %d.\n"
+
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 {
 	u64 msr;
 
+	/*
+	 * When running as an SEV guest of any flavor, update the physical
+	 * address width to account for the C-bit and clear all of the SME/SVE
+	 * feature flags.  As far as the kernel is concerned, the SEV flags
+	 * enumerate what features can be used by the kernel/KVM, not what
+	 * features have been activated by the VMM.
+	 */
+	if (sev_active()) {
+		int c_bit = ilog2(sme_me_mask);
+
+		BUG_ON(!sme_me_mask);
+
+		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+
+		if (c_bit < c->x86_phys_bits) {
+			pr_crit_once(SEV_CBIT_MSG, c_bit, c->x86_phys_bits, c_bit);
+			c->x86_phys_bits = c_bit;
+		}
+		goto clear_all;
+	}
+
 	/*
 	 * BIOS support is required for SME and SEV.
 	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
@@ -612,13 +636,13 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			goto clear_sev;
 
 		return;
+	}
 
 clear_all:
-		setup_clear_cpu_cap(X86_FEATURE_SME);
+	setup_clear_cpu_cap(X86_FEATURE_SME);
 clear_sev:
-		setup_clear_cpu_cap(X86_FEATURE_SEV);
-		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
-	}
+	setup_clear_cpu_cap(X86_FEATURE_SEV);
+	setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
 }
 
 static void early_init_amd(struct cpuinfo_x86 *c)
-- 
2.31.0.rc2.261.g7f71774620-goog

