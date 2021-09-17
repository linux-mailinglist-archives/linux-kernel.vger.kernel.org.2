Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E077D40FE39
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbhIQQ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:58:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243102AbhIQQ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:58:43 -0400
Received: from zn.tnic (p200300ec2f127e00b6e1989e60a0b7d1.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:7e00:b6e1:989e:60a0:b7d1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 157431EC04D1;
        Fri, 17 Sep 2021 18:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631897836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ow8NfXsPV/RH/ABEITu6Xf5xUpJXfMJH3GB53aeuD34=;
        b=QsiODdpWg8XaIayX6QGoSqspM/74jpKtY5PUZ0ZnQMi1b1sAxhugcMuAaYzDf0AsksOx/O
        gsgoGH+iiyQ6cBV5h0DLUlIKZESC4nqJBRrJgFyYkzPfwFdADesKOZQ4HL2vD/MancmfNY
        QxrqihlfC5aVPZTqCeqZCectQXkRReg=
Date:   Fri, 17 Sep 2021 18:57:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
Message-ID: <YUTI5Vy/fLT/q/Lh@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:39AM -0700, Kuppuswamy Sathyanarayanan wrote:
> cc_platform_has() can be used to check for specific active confidential
> computing attributes, like memory encryption. For Intel platform like
> Trusted Domain eXtensions (TDX) guest has need for using this function
> to protect the TDX specific changes made in generic drivers.
> 
> So, extend cc_platform_has() and add support for Intel architecture
> variant (intel_cc_platform_has())
> 
> This is a preparatory commit needed before adding TDX guest support
> to intel_cc_platform_has().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_cc_platform.h | 15 +++++++++++++++
>  arch/x86/kernel/cc_platform.c            |  5 +++++
>  arch/x86/kernel/cpu/intel.c              |  9 +++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 arch/x86/include/asm/intel_cc_platform.h

I did the below. Will queue the whole pile once -rc2 is out.

Thx.

---
From c2aa317bba1b4e623075139a19b35118de3234b7 Mon Sep 17 00:00:00 2001
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Fri, 17 Sep 2021 11:32:22 +0200
Subject: [PATCH] x86/tdx: Add the Intel version for cc_platform_has()

cc_platform_has() can be used to check for specific active confidential
computing attributes, like memory encryption. For Intel platform like
Trusted Domain eXtensions (TDX) the guest uses this function to protect
the TDX-specific changes made in generic drivers.

So, extend cc_platform_has() and add support for Intel architecture
variant.

 [ bp: Rip out the separate header and the export. ]

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com
---
 arch/x86/include/asm/mem_encrypt.h | 6 ++++++
 arch/x86/kernel/cc_platform.c      | 2 ++
 arch/x86/kernel/cpu/intel.c        | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index ed954aa5c448..a73712b6ee0e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -103,6 +103,12 @@ static inline u64 sme_get_me_mask(void)
 	return sme_me_mask;
 }
 
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
+bool intel_cc_platform_has(enum cc_attr attr);
+#else
+static inline bool intel_cc_platform_has(enum cc_attr attr) { return false; }
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index b43bacdc40da..6037201c8437 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -18,6 +18,8 @@ bool cc_platform_has(enum cc_attr attr)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return amd_cc_platform_has(attr);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return intel_cc_platform_has(attr);
 
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..53756ff12295 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -60,6 +60,13 @@ static u64 msr_test_ctrl_cache __ro_after_init;
  */
 static bool cpu_model_supports_sld __ro_after_init;
 
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool intel_cc_platform_has(enum cc_attr attr)
+{
+	return false;
+}
+#endif
+
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
