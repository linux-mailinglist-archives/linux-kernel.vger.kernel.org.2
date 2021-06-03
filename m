Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C263239A9DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFCSQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:16:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:16:48 -0400
Received: from zn.tnic (p200300ec2f13850035eef6c5c121f5ff.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:35ee:f6c5:c121:f5ff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B54F21EC03D2;
        Thu,  3 Jun 2021 20:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622744102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kx0OAKkw1klNUzUluYcU/zlfxxVfF0w1lDAx39xMFpw=;
        b=RIfrOm/Wtr/34B7EiBhchmwLqL9cQU0prPtM4BFTDgnp3UvAboHuk0fPElY8uW6CvvI7YU
        mHKLOJkQtju64dNS0y5KxjQfY6hS2EBeSCJFG1RJjpZ2h/oLF3EURf3mcT+e8P3WX/bU6E
        gn2rcMj/5UkF19L3rsxuS1LwB52Sya8=
Date:   Thu, 3 Jun 2021 20:14:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
Message-ID: <YLkcIuL2qvo0hviU@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:14:17PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..303dfba81d52
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_PROTECTED_GUEST_H
> +#define _LINUX_PROTECTED_GUEST_H 1
> +
> +#include <linux/mem_encrypt.h>
> +
> +/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
> +
> +/* Support for guest encryption */
> +#define VM_MEM_ENCRYPT			0x100
> +/* Encryption support is active */
> +#define VM_MEM_ENCRYPT_ACTIVE		0x101
> +/* Support for unrolled string IO */
> +#define VM_UNROLL_STRING_IO		0x102
> +/* Support for host memory encryption */
> +#define VM_HOST_MEM_ENCRYPT		0x103
> +/* Support for shared mapping initialization (after early init) */
> +#define VM_SHARED_MAPPING_INIT		0x104

Ok, a couple of things:

first of all, those flags with that VM_ prefix make me think of
"virtual memory" instead of "virtual machine". So they should be
something else, like, say

PR_G_... for Protected Guest or so. Or PR_GUEST or ...

(yeah, good namespaces are all taken. )

Then, about the function name length, I'm fine if we did:

	prot_guest_has()

or something even shorter, if you folks have a good suggestion.

Anyway, below is a diff ontop of your tree with what I think the
barebones of this should be.

As a reply to this message I went and converted sme_active() to use
protected_guest_has() too.

Comments, complaints?

Thx.

---
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 1492b0eb29d0..9c80c68d75b5 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -56,8 +56,6 @@ bool sev_es_active(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
-bool amd_protected_guest_has(unsigned long flag);
-
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -88,8 +86,6 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
-static inline bool amd_protected_guest_has(unsigned long flag) { return false; }
-
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa5cd05d3b5b..f09996c6a272 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/pgtable_types.h>
 
 #define GHCB_PROTO_OUR		0x0001UL
 #define GHCB_PROTOCOL_MAX	1ULL
@@ -81,12 +82,15 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+bool sev_protected_guest_has(unsigned long flag);
+
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline bool sev_protected_guest_has(unsigned long flag) { return false; }
 #endif
 
-#endif
+#endif /* __ASM_ENCRYPTED_STATE_H */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f7a743d122eb..01a224fdb897 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1402,3 +1402,14 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+bool sev_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case VM_MEM_ENCRYPT:
+	case VM_MEM_ENCRYPT_ACTIVE:
+		return true;
+	}
+
+	return false;
+}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ced658e79753..49d11bb6e02a 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -391,18 +391,6 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
-bool amd_protected_guest_has(unsigned long flag)
-{
-	switch (flag) {
-	case VM_MEM_ENCRYPT:
-	case VM_MEM_ENCRYPT_ACTIVE:
-		return true;
-	}
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(amd_protected_guest_has);
-
 /* Override for DMA direct allocation check - AMD specific initialization */
 bool amd_force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 6855d5b3e244..bb4b1a06b21f 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_PROTECTED_GUEST_H
 #define _LINUX_PROTECTED_GUEST_H 1
 
-#include <linux/mem_encrypt.h>
+#include <asm/processor.h>
+#include <asm/tdx.h>
+#include <asm/sev.h>
 
 /* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
 
@@ -20,23 +22,18 @@
 #define VM_DISABLE_UNCORE_SUPPORT	0x105
 
 #if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
-
-#include <asm/tdx.h>
-
 static inline bool protected_guest_has(unsigned long flag)
 {
 	if (is_tdx_guest())
 		return tdx_protected_guest_has(flag);
-	else if (mem_encrypt_active())
-		return amd_protected_guest_has(flag);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return sev_protected_guest_has(flag);
 
 	return false;
 }
 
 #else
-
 static inline bool protected_guest_has(unsigned long flag) { return false; }
-
 #endif
 
-#endif
+#endif /* _LINUX_PROTECTED_GUEST_H */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
