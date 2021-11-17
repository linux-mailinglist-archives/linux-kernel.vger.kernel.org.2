Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81D4550E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhKQXHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:07:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:61676 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhKQXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:07:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234312365"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="234312365"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 15:04:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="454820131"
Received: from rsyep-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.140.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 15:04:12 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
 <YZVvdyHhPTzzZbiu@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
Date:   Wed, 17 Nov 2021 15:04:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZVvdyHhPTzzZbiu@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 1:09 PM, Borislav Petkov wrote:
> On Wed, Nov 17, 2021 at 12:54:56PM -0800, Sathyanarayanan Kuppuswamy wrote:
>> It is not only for idle case. We also need to support emulation of
>> normal halt case (which is used in cases like reboot or
>> early_fixup_exception(), etc.).
> 
> This is more of that piecemeal feeding of people asking why. Please sit
> down and explain exactly and in detail why you need this. "We need to
> support emulation" is not nearly good enough.
> 
> I don't think any of the people who replied on this thread *actually*
> know *why* PV support is needed.
> 

We need PV support to handle halt() and safe_halt() cases.

HLT instruction is generally used in cases like reboot, idle and
exception fixup handlers. For the idle case, interrupts will be enabled
(using STI) before the HLT instruction (this is also called
safe_halt()).

In TDX guest, to support HLT instruction, it has to be emulated using
a hypercall (aka TDVMCALL).

We have the following three ways to emulate the HLT instruction:

1. Directly substitute TDVMCALLs in places where we require emulation.
2. Use #VE exception handler to emulate it (In TDX guest, executing HLT
    will lead to #VE exception).
3. Emulate it using pv_ops

Since option#1 is not a scalable approach, it can be ignored. Option #2
is also not preferred because, we cannot differentiate between safe
halt and normal halt use cases in the exception handler. This
differentiation is needed to add STI before the hypercall for safe halt 
use case. That leaves us with using pv_ops, which provides separate
methods to emulate safe and normal halt cases.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
