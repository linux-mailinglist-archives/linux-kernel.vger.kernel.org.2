Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8223C396813
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhEaSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:47:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:34493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhEaSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:47:25 -0400
IronPort-SDR: Ok0YDylm7h1mxN2s6cvVxdVELk3quZOnKrJ1p7jKXD311HMu5hIPLqusRL+TEu1btIX1rGF71B
 5q02xm1eSXZg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190763030"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="190763030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 11:45:42 -0700
IronPort-SDR: fnFuQmT91kZAG44h98dzGgalB8CuzVfMS9sa3zqNAPh03psxpvr9Ux6GCASDj/UX5ac8W0Ab5q
 XSt/9ToNubfA==
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="616602078"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.152.221])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 11:45:41 -0700
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
References: <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic> <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
 <YLT9AGodkvct8YTO@zn.tnic>
 <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
 <YLUjCqdPu/8eWuB+@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <280669ec-d43a-83af-55ba-ad03411538b5@linux.intel.com>
Date:   Mon, 31 May 2021 11:45:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLUjCqdPu/8eWuB+@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/21 10:55 AM, Borislav Petkov wrote:
> On Mon, May 31, 2021 at 10:32:44AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> I think above requirement is satisfied in following implementation.
> 
> Well, I suggested a single protected_guest_has() function which does:
> 
>          if (AMD)
>                  amd_protected_guest_has(...)
>          else if (Intel)
>                  intel_protected_guest_has(...)
>          else
>                  WARN()
> 
> where amd_protected_guest_has() is implemented in arch/x86/kernel/sev.c
> and intel_protected_guest_has() is implemented in, as far as I can
> follow your paths in the diff, in arch/x86/kernel/tdx.c.
> 
> No is_protected_guest() 

is_protected_guest() is a helper function added to check for VM guest type
(protected or normal). Andi is going to add some security hardening code in
virto and other some other generic drivers. He wants a helper function to
selective enable them for all protected guests. Since these are generic
drivers we need generic (non arch specific) helper call. is_protected_guest()
is proposed for this purpose.

We can also use protected_guest_has(VM_VIRTIO_SECURE_FIX) or something
similar for this purpose. Andi, any comments?

> and no ARCH_HAS_PROTECTED_GUEST.

IMHO, its better to use above generic config option in common header
file (linux/protected_guest.h). Any architecture that implements
protected guest feature can enable it. This will help is hide arch
specific config options in arch specific header file.

This seems to be a cleaner solution than including ARCH specific
CONFIG option options in common header file (linux/protected_guest.h)

#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
#include <asm/protected_guest.h>
#else
blah
#endif

is better than

#ifdef (AMD)
amd_call()
#endif

#ifdef (INTEL)
intel_call()
#endif

#ifdef (ARM)
arm_call()
#endif


> 
> Just the above controlled by CONFIG_INTEL_TDX_GUEST or whatever
> the TDX config item is gonna end up being and on the AMD side by
> CONFIG_AMD_MEM_ENCRYPT.
> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
