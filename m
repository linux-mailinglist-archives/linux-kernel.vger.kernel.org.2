Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCFD37FBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhEMQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:42:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:9154 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233941AbhEMQl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:41:56 -0400
IronPort-SDR: 4QmGe2EnWjRKVslWrby4pJ+dkXoQISkLjUPyZdos+B9oviSVjaB4bM6s7rsSzuPqP62yFf+T6F
 EMJozLtVvGiw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187406427"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187406427"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 09:40:39 -0700
IronPort-SDR: t3lGb3KeyBG+L8wO4yBM45lrlCHXZuWJrTJHRox+TXI3YDJ2KEIV59ddHcR6gCQzEC33E2QgdC
 hmOHnQFmuwfA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437727386"
Received: from dleves-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.146.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 09:40:38 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
Date:   Thu, 13 May 2021 09:40:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJv6EWJmDYQL4Eqt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 8:53 AM, Sean Christopherson wrote:
> On Wed, May 12, 2021, Dave Hansen wrote:
>> On 5/12/21 6:08 AM, Kirill A. Shutemov wrote:
>>>> That's not an excuse to have a bunch of AMD (or Intel) feature-specific
>>>> code in a file named "common".  I'd make an attempt to keep them
>>>> separate and then call into the two separate functions *from* the common
>>>> function.
>>> But why? What good does the additional level of inderection brings?
>>>
>>> It's like saying arch/x86/kernel/cpu/common.c shouldn't have anything AMD
>>> or Intel specific. If a function can cover both vendors I don't see a
>>> point for additinal complexity.
>>
>> Because the code is already separate.  You're actually going to some
>> trouble to move the SEV-specific code and then combine it with the
>> TDX-specific code.
>>
>> Anyway, please just give it a shot.  Should take all of ten minutes.  If
>> it doesn't work out in practice, fine.  You'll have a good paragraph for
>> the changelog.
> 
> Or maybe wait to see how Boris' propose protected_guest_has() pans out?  E.g. if
> we can do "protected_guest_has(MEMORY_ENCRYPTION)" or whatever, then the truly
> common bits could be placed into common.c without any vendor-specific logic.

How about following abstraction? This patch was initially created to enable us use
is_tdx_guest() outside of arch/x86 code. But extended it to support bitmap flags.

commit 188bdd3c97e49020b2bda9efd992a22091423b85
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed May 12 11:35:13 2021 -0700

     tdx: Introduce generic protected_guest abstraction

     Add a generic way to check if we run with an encrypted guest,
     without requiring x86 specific ifdefs. This can then be used in
     non architecture specific code. Enablethis when running under
     TDX/SEV.

     Also add helper functions to set/test encrypted guest feature
     flags.

     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..98c30312555b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -956,6 +956,9 @@ config HAVE_ARCH_NVRAM_OPS
  config ISA_BUS_API
  	def_bool ISA

+config ARCH_HAS_PROTECTED_GUEST
+	bool
+
  #
  # ABI hall of shame
  #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 07fb4df1d881..001487c21874 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -882,6 +882,7 @@ config INTEL_TDX_GUEST
  	select PARAVIRT_XL
  	select X86_X2APIC
  	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_PROTECTED_GUEST
  	help
  	  Provide support for running in a trusted domain on Intel processors
  	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
@@ -1537,6 +1538,7 @@ config AMD_MEM_ENCRYPT
  	select ARCH_USE_MEMREMAP_PROT
  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
  	select INSTRUCTION_DECODER
+	select ARCH_HAS_PROTECTED_GUEST
  	help
  	  Say yes to enable support for the encryption of system memory.
  	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ccab6cf91283..8260893c34ae 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -21,6 +21,7 @@
  #include <linux/usb/xhci-dbgp.h>
  #include <linux/static_call.h>
  #include <linux/swiotlb.h>
+#include <linux/protected_guest.h>

  #include <uapi/linux/mount.h>

@@ -107,6 +108,10 @@ static struct resource bss_resource = {
  	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
  };

+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+DECLARE_BITMAP(protected_guest_flags, PROTECTED_GUEST_BITMAP_LEN);
+EXPORT_SYMBOL(protected_guest_flags);
+#endif

  #ifdef CONFIG_X86_32
  /* CPU data as detected by the assembly code in head_32.S */
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 04a780abb512..45b848ec8325 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -19,6 +19,7 @@
  #include <linux/memblock.h>
  #include <linux/kernel.h>
  #include <linux/mm.h>
+#include <linux/protected_guest.h>

  #include <asm/cpu_entry_area.h>
  #include <asm/stacktrace.h>
@@ -680,6 +681,9 @@ static void __init init_ghcb(int cpu)

  	data->ghcb_active = false;
  	data->backup_ghcb_active = false;
+
+	set_protected_guest_flag(GUEST_TYPE_SEV);
+	set_protected_guest_flag(MEMORY_ENCRYPTION);
  }

  void __init sev_es_init_vc_handling(void)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 4dfacde05f0c..d0207b990fe4 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
  #include <asm/vmx.h>

  #include <linux/cpu.h>
+#include <linux/protected_guest.h>

  static struct {
  	unsigned int gpa_width;
@@ -92,6 +93,9 @@ void __init tdx_early_init(void)

  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

+	set_protected_guest_flag(GUEST_TYPE_TDX);
+	set_protected_guest_flag(MEMORY_ENCRYPTION);
+
  	tdg_get_info();

  	pr_info("TDX guest is initialized\n");
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..44e8c642654c
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,37 @@
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
+
+#define PROTECTED_GUEST_BITMAP_LEN	128
+
+/* Protected Guest vendor types */
+#define GUEST_TYPE_TDX			(1)
+#define GUEST_TYPE_SEV			(2)
+
+/* Protected Guest features */
+#define MEMORY_ENCRYPTION		(20)
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+extern DECLARE_BITMAP(protected_guest_flags, PROTECTED_GUEST_BITMAP_LEN);
+
+static bool protected_guest_has(unsigned long flag)
+{
+	return test_bit(flag, protected_guest_flags);
+}
+
+static inline void set_protected_guest_flag(unsigned long flag)
+{
+	__set_bit(flag, protected_guest_flags);
+}
+
+static inline bool is_protected_guest(void)
+{
+	return ( protected_guest_has(GUEST_TYPE_TDX) |
+		 protected_guest_has(GUEST_TYPE_SEV) );
+}
+#else
+static inline bool protected_guest_has(unsigned long flag) { return false; }
+static inline void set_protected_guest_flag(unsigned long flag) { }
+static inline bool is_protected_guest(void) { return false; }
+#endif
+
+#endif


> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
