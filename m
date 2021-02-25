Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859FA325837
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhBYU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhBYUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:50:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165DC061223
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 6so7631067ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=vlCRN623gt7WQ4CgADd84aZE0eu5FTtehsLF+FT0cRA=;
        b=ghOmLvcrZVthjGf0A+WfKMW7VLqxkfQ5HfZK84uCDcKf+GNxCaNwVmClQC6CvMjTYQ
         R+63XORdE7+aH0V5aJqzeJB4E93oPDFaffOlZ3WGu17pFbhxWpwCpGtKOsf1QrVICYRe
         6b1cFx+oLZn+g0sPEIUXdtZb6sBBN1R+bPrsTlH6pL+3jljZcGP8biDq37+TYCj62Ag9
         3rOAOaTBD45lE9ZlI4+wvFQiAm9o7ntU6v0EZ4XVgme3wtus24fd11hzVkqGk3qg99F/
         nurJKzHXXAGlbQfChPtejQ0b9hH5/epr1LqgbCJE1Q8MkNLjC8juiTOEJYxzJczQ1z/J
         7hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=vlCRN623gt7WQ4CgADd84aZE0eu5FTtehsLF+FT0cRA=;
        b=lpmHSqhNtHY241btvInBX3mLNwICYESrCCGO3PnTF7KH2UPlYKzMcBb28sD0323/R4
         VqfpypNGHlcwmG9IgAKPy8lXPh0cLptMe1OeImIvPuraVW1Bq9wXNIlyt+ZYobo3MClt
         4zNo/L53aezcJ0xUSOC5INEAgkzaYkZqBsWZNHUs2rzGdbUQ8ZnFtu4JR/F0eJOC9sk3
         ynIA2lhasP1zDchdd1iN6WXBfmaDmWtM2CA+Ng9YKt2mWe0iEPBA2CrNdgLnbpJqESaz
         WTnvmrPz8HG9nxqjzo8gD6PdzlJ5pSyr1Xf2T6mi/AX5gKjfkifwZn8TQatlUzU3QX38
         /ezQ==
X-Gm-Message-State: AOAM533NAqJmvt2J+mzM9ZtmK9BtdvxKBttcaH70A9iy9JxBD/EB44h3
        9P7ktxriQFh/OwMdj8Qb1ClA9miCeYI=
X-Google-Smtp-Source: ABdhPJy7Mv43HPZwyY2zTeimmWraFim1Yy296hnyS10CZBgDUOOk+n5MdkAvQgFB3SfnPLUUiB3fgmOJXz8=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:bc4f:: with SMTP id d15mr6702552ybk.41.1614286104714;
 Thu, 25 Feb 2021 12:48:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:35 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 10/24] KVM: x86/mmu: Stop using software available bits to
 denote MMIO SPTEs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop tagging MMIO SPTEs with specific available bits and instead detect
MMIO SPTEs by checking for their unique SPTE value.  The value is
guaranteed to be unique on shadow paging and NPT as setting reserved
physical address bits on any other type of SPTE would consistute a KVM
bug.  Ditto for EPT, as creating a WX non-MMIO would also be a bug.

Note, this approach is also future-compatibile with TDX, which will need
to reflect MMIO EPT violations as #VEs into the guest.  To create an EPT
violation instead of a misconfig, TDX EPTs will need to have RWX=0,  But,
MMIO SPTEs will also be the only case where KVM clears SUPPRESS_VE, so
MMIO SPTEs will still be guaranteed to have a unique value within a given
MMU context.

The main motivation is to make it easier to reason about which types of
SPTEs use which available bits.  As a happy side effect, this frees up
two more bits for storing the MMIO generation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h      |  2 +-
 arch/x86/kvm/mmu/mmu.c  |  2 +-
 arch/x86/kvm/mmu/spte.c | 11 ++++++-----
 arch/x86/kvm/mmu/spte.h | 10 ++++------
 arch/x86/kvm/svm/svm.c  |  2 +-
 arch/x86/kvm/vmx/vmx.c  |  3 ++-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c68bfc3e2402..00f4a541e04d 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -59,7 +59,7 @@ static __always_inline u64 rsvd_bits(int s, int e)
 	return ((2ULL << (e - s)) - 1) << s;
 }
 
-void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 access_mask);
+void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 
 void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ced412f90b7d..f92571b786a2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5726,7 +5726,7 @@ static void kvm_set_mmio_spte_mask(void)
 	else
 		mask = 0;
 
-	kvm_mmu_set_mmio_spte_mask(mask, ACC_WRITE_MASK | ACC_USER_MASK);
+	kvm_mmu_set_mmio_spte_mask(mask, mask, ACC_WRITE_MASK | ACC_USER_MASK);
 }
 
 static bool get_nx_auto_mode(void)
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index e4ef3267f9ac..b2379094a8c1 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -23,6 +23,7 @@ u64 __read_mostly shadow_user_mask;
 u64 __read_mostly shadow_accessed_mask;
 u64 __read_mostly shadow_dirty_mask;
 u64 __read_mostly shadow_mmio_value;
+u64 __read_mostly shadow_mmio_mask;
 u64 __read_mostly shadow_mmio_access_mask;
 u64 __read_mostly shadow_present_mask;
 u64 __read_mostly shadow_me_mask;
@@ -163,6 +164,7 @@ int make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
 		spte = mark_spte_for_access_track(spte);
 
 out:
+	WARN_ON(is_mmio_spte(spte));
 	*new_spte = spte;
 	return ret;
 }
@@ -244,7 +246,7 @@ u64 mark_spte_for_access_track(u64 spte)
 	return spte;
 }
 
-void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 access_mask)
+void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask)
 {
 	BUG_ON((u64)(unsigned)access_mask != access_mask);
 	WARN_ON(mmio_value & shadow_nonpresent_or_rsvd_lower_gfn_mask);
@@ -260,10 +262,9 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 access_mask)
 				  SHADOW_NONPRESENT_OR_RSVD_MASK_LEN)))
 		mmio_value = 0;
 
-	if (mmio_value)
-		shadow_mmio_value = mmio_value | SPTE_MMIO_MASK;
-	else
-		shadow_mmio_value = 0;
+	WARN_ON((mmio_value & mmio_mask) != mmio_value);
+	shadow_mmio_value = mmio_value;
+	shadow_mmio_mask  = mmio_mask;
 	shadow_mmio_access_mask = access_mask;
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_mmio_spte_mask);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 6de3950fd704..642a17b9964c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -8,15 +8,11 @@
 #define PT_FIRST_AVAIL_BITS_SHIFT 10
 #define PT64_SECOND_AVAIL_BITS_SHIFT 54
 
-/*
- * The mask used to denote special SPTEs, which can be either MMIO SPTEs or
- * Access Tracking SPTEs.
- */
+/* The mask used to denote Access Tracking SPTEs.  Note, val=3 is available. */
 #define SPTE_SPECIAL_MASK (3ULL << 52)
 #define SPTE_AD_ENABLED_MASK (0ULL << 52)
 #define SPTE_AD_DISABLED_MASK (1ULL << 52)
 #define SPTE_AD_WRPROT_ONLY_MASK (2ULL << 52)
-#define SPTE_MMIO_MASK (3ULL << 52)
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 #define PT64_BASE_ADDR_MASK (physical_mask & ~(u64)(PAGE_SIZE-1))
@@ -98,6 +94,7 @@ extern u64 __read_mostly shadow_user_mask;
 extern u64 __read_mostly shadow_accessed_mask;
 extern u64 __read_mostly shadow_dirty_mask;
 extern u64 __read_mostly shadow_mmio_value;
+extern u64 __read_mostly shadow_mmio_mask;
 extern u64 __read_mostly shadow_mmio_access_mask;
 extern u64 __read_mostly shadow_present_mask;
 extern u64 __read_mostly shadow_me_mask;
@@ -167,7 +164,8 @@ extern u8 __read_mostly shadow_phys_bits;
 
 static inline bool is_mmio_spte(u64 spte)
 {
-	return (spte & SPTE_SPECIAL_MASK) == SPTE_MMIO_MASK;
+	return (spte & shadow_mmio_mask) == shadow_mmio_value &&
+	       likely(shadow_mmio_value);
 }
 
 static inline bool sp_ad_disabled(struct kvm_mmu_page *sp)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c4f2f2f6b945..54610270f66a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -885,7 +885,7 @@ static __init void svm_adjust_mmio_mask(void)
 	 */
 	mask = (mask_bit < 52) ? rsvd_bits(mask_bit, 51) | PT_PRESENT_MASK : 0;
 
-	kvm_mmu_set_mmio_spte_mask(mask, PT_WRITABLE_MASK | PT_USER_MASK);
+	kvm_mmu_set_mmio_spte_mask(mask, mask, PT_WRITABLE_MASK | PT_USER_MASK);
 }
 
 static void svm_hardware_teardown(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 908f7a8af064..8a8423a97f13 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4320,7 +4320,8 @@ static void ept_set_mmio_spte_mask(void)
 	 * EPT Misconfigurations can be generated if the value of bits 2:0
 	 * of an EPT paging-structure entry is 110b (write/execute).
 	 */
-	kvm_mmu_set_mmio_spte_mask(VMX_EPT_MISCONFIG_WX_VALUE, 0);
+	kvm_mmu_set_mmio_spte_mask(VMX_EPT_MISCONFIG_WX_VALUE,
+				   VMX_EPT_RWX_MASK, 0);
 }
 
 #define VMX_XSS_EXIT_BITMAP 0
-- 
2.30.1.766.gb4fecdf3b7-goog

