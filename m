Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61AA396729
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhEaRey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:34:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:54132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhEaRe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:34:28 -0400
IronPort-SDR: p1i2PqwCpfT4ZLeiyT7MvjltxJtFc91b0IFpvdy7Fvjcaygxj6DlBHra7VZvRwsDECUpEKJSnH
 NQaVpeQWYIpg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190508158"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="190508158"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 10:32:48 -0700
IronPort-SDR: 1vlLnX9MYXFLxiXoYRE+zmueK4JDBB/5KtsS1mO++zvAUwWZ8UUhq7bvOTR5ORy8O7qTQzXVjE
 u74VxzV4hPCg==
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="616588635"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.152.221])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 10:32:47 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
References: <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic> <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
 <YLT9AGodkvct8YTO@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
Date:   Mon, 31 May 2021 10:32:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLT9AGodkvct8YTO@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/21 8:13 AM, Borislav Petkov wrote:
> On Tue, May 25, 2021 at 11:21:21AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Following is the sample implementation. Please let me know your
>> comments.
> 
> Doesn't look like what I suggested here:
> 
> https://lkml.kernel.org/r/YKfPLlulaqwypNkO@zn.tnic

IIUC, following are your design suggestions:

1. Define generic flags.

I think following flags are defined as you have suggested.

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

2. Define generic functions and allow calls to arch specific implementations.

For above requirement, instead of calling arch specific functions from 
include/linux/protected_guest.h, I have directly included the arch specific file in 
linux/protected_guest.h

+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+#include <asm/protected_guest.h>
+#else
+static inline bool is_protected_guest(void) { return false; }
+static inline bool protected_guest_has(unsigned long flag) { return false; }
+#endif

3. Implement arch specific implementations respond to protected_guest_has() calls right?

I think above requirement is satisfied in following implementation.

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

Did I misunderstand anything ? Please let me know your comments.



> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
