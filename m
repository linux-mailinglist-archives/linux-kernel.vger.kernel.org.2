Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD33908D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhEYSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:23:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:36958 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhEYSW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:22:56 -0400
IronPort-SDR: hKiSgcVorZ71RVYQoyF8alGbVQE/6mpgCw2cwGdwhBaHzYrrfyqkJ3m1eSTTgLcf2BPL1n6ct2
 /lmd9uB+uWrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="223440090"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="223440090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 11:21:26 -0700
IronPort-SDR: 9hkujfQK4bjreWkXMwzMTQupDq3hjBa6ME8RuCJuoaNETJABPw1AZT3fcCHKH1/16RkzmWLOVA
 XizIz6fVYnYg==
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="476540674"
Received: from asewani-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.113.233])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 11:21:24 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
References: <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic> <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
Date:   Tue, 25 May 2021 11:21:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/21 2:14 PM, Tom Lendacky wrote:
> 
> 
> On 5/21/21 1:49 PM, Borislav Petkov wrote:
>> On Fri, May 21, 2021 at 11:19:15AM -0500, Tom Lendacky wrote:
>>> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
>>> when SEV support was added), we do:
>>> 	if (sev_active())
>>> 		swiotlb_force = SWIOTLB_FORCE;
>>>
>>> TDX should be able to do a similar thing without having to touch
>>> arch/x86/kernel/pci-swiotlb.c.
>>>
>>> That would remove any confusion over SME being part of a
>>> protected_guest_has() call.
>>
>> Even better.
>>
>>> I kinda like the separate function, though.
>>
>> Only if you clean it up and get rid of the inverted logic and drop that
>> silly switch-case.
>>
>>> Except mem_encrypt_active() covers both SME and SEV, so
>>> protected_guest_has() would be confusing.
>>
>> I don't understand - the AMD-specific function amd_protected_guest_has()
>> would return sme_me_mask just like mem_encrypt_active() does and we can
>> get rid of latter.
>>
>> Or do you have a problem with the name protected_guest_has() containing
>> "guest" while we're talking about SME here?
> 
> The latter.
> 
>>
>> If so, feel free to suggest a better one - the name does not have to
>> have "guest" in it.
> 
> Let me see if I can come up with something that will make sense.
> 
> Thanks,
> Tom
> 
>>
>> Thx.
>>
>>

Following is the sample implementation. Please let me know your
comments.

     tdx: Introduce generic protected_guest abstraction

     Add a generic way to check if we run with an encrypted guest,
     without requiring x86 specific ifdefs. This can then be used in
     non architecture specific code.

     is_protected_guest() helper function can be implemented using
     arch specific CPU feature flags.

     protected_guest_has() is used to check for protected guest
     feature flags.

     Originally-by: Andi Kleen <ak@linux.intel.com>
     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..98c30312555b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -956,6 +956,9 @@ config HAVE_ARCH_NVRAM_OPS
  config ISA_BUS_API
         def_bool ISA

+config ARCH_HAS_PROTECTED_GUEST
+       bool
+
  #
  # ABI hall of shame
  #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bc91c4aa7ce4..2f31613be965 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,6 +879,7 @@ config INTEL_TDX_GUEST
         select X86_X2APIC
         select SECURITY_LOCKDOWN_LSM
         select X86_MEM_ENCRYPT_COMMON
+       select ARCH_HAS_PROTECTED_GUEST
         help
           Provide support for running in a trusted domain on Intel processors
           equipped with Trusted Domain eXtenstions. TDX is a new Intel
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..b2838e58ce94
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_PROTECTED_GUEST
+#define _ASM_PROTECTED_GUEST 1
+
+#include <asm/cpufeature.h>
+#include <asm/tdx.h>
+
+/* Only include through linux/protected_guest.h */
+
+static inline bool is_protected_guest(void)
+{
+       return boot_cpu_has(X86_FEATURE_TDX_GUEST);
+}
+
+static inline bool protected_guest_has(unsigned long flag)
+{
+       if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+               return tdx_protected_guest_has(flag);
+
+       return false;
+}
+
+#endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 175cebb7bf94..d894111f49ea 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -147,6 +147,7 @@ do {                                                                        \
  extern phys_addr_t tdg_shared_mask(void);
  extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
                                 enum tdx_map_type map_type);
+bool tdx_protected_guest_has(unsigned long flag);

  #else // !CONFIG_INTEL_TDX_GUEST

@@ -167,6 +168,11 @@ static inline int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
  {
         return -ENODEV;
  }
+
+static inline bool tdx_protected_guest_has(unsigned long flag)
+{
+       return false;
+}
  #endif /* CONFIG_INTEL_TDX_GUEST */

  #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index c613c89d0d6a..cbb893412b43 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -11,6 +11,7 @@
  #include <linux/sched/signal.h> /* force_sig_fault() */
  #include <linux/swiotlb.h>
  #include <linux/security.h>
+#include <linux/protected_guest.h>

  #include <linux/cpu.h>

@@ -122,6 +123,23 @@ bool is_tdx_guest(void)
  }
  EXPORT_SYMBOL_GPL(is_tdx_guest);

+bool tdx_protected_guest_has(unsigned long flag)
+{
+       if (!is_tdx_guest())
+               return false;
+
+       switch (flag) {
+       case VM_MEM_ENCRYPT:
+       case VM_MEM_ENCRYPT_ACTIVE:
+       case VM_UNROLL_STRING_IO:
+       case VM_HOST_MEM_ENCRYPT:
+               return true;
+       }
+
+       return false;
+}
+EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
+
  /* The highest bit of a guest physical address is the "sharing" bit */
  phys_addr_t tdg_shared_mask(void)
  {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..f362eea39bd8
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
+
+/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
+
+/* Support for guest encryption */
+#define VM_MEM_ENCRYPT                 0x100
+/* Encryption support is active */
+#define VM_MEM_ENCRYPT_ACTIVE          0x101
+/* Support for unrolled string IO */
+#define VM_UNROLL_STRING_IO            0x102
+/* Support for host memory encryption */
+#define VM_HOST_MEM_ENCRYPT            0x103
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+#include <asm/protected_guest.h>
+#else
+static inline bool is_protected_guest(void) { return false; }
+static inline bool protected_guest_has(unsigned long flag) { return false; }
+#endif
+
+#endif


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
