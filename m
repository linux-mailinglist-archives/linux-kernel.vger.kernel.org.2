Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFD38873A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhESGFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:05:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:9625 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhESGFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:05:37 -0400
IronPort-SDR: rzPtYo1SryYM/CJcJd69MkXmkB60fhWhOWIiBi1usEYtUcTdLu22Xzs5fU5QetXCKGRe3zSfBp
 o02KC9PUBVFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197807631"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="197807631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 23:04:18 -0700
IronPort-SDR: Ylgna6bP6ppFyurVtpIwaLwUdBnv3B+9ps6L8c9qsmmaXkhrbblOeV7tC8/5GUH+E57QrJK8+H
 FtsO9MVbgVaQ==
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="439817278"
Received: from dwchow-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.41.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 23:04:17 -0700
Subject: Re: [RFC v2-fix-v1 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
 <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <226b5406-510b-5f18-dc52-10b65bfb7551@linux.intel.com>
Date:   Tue, 18 May 2021 23:04:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/18/21 10:58 PM, Kuppuswamy Sathyanarayanan wrote:
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like vmcall, vmlaunch, etc. However, with TDX, VMEXITs no longer
> expose guest state to the host.  This prevents the old hypercall
> mechanisms from working. So to communicate with VMM, TDX
> specification defines a new instruction called "tdcall".
> 
> In TDX based VM, since VMM is an untrusted entity, a intermediary
> layer (TDX module) exists between host and guest to facilitate the
> secure communication. And "tdcall" instruction  is used by the guest
> to request services from TDX module. And a variant of "tdcall"
> instruction (with specific arguments as defined by GHCI) is used by
> the guest to request services from  VMM via the TDX module.
> 
> Implement common helper functions to communicate with the TDX Module
> and VMM (using TDCALL instruction).
>     
> __tdx_hypercall()    - function can be used to request services from
> 		       the VMM.
> __tdx_module_call()  - function can be used to communicate with the
> 		       TDX Module.
> 
> Also define two additional wrappers, tdx_hypercall() and
> tdx_hypercall_out_r11() to cover common use cases of
> __tdx_hypercall() function. Since each use case of
> __tdx_module_call() is different, we don't need such wrappers for it.
> 
> Implement __tdx_module_call() and __tdx_hypercall() helper functions
> in assembly.
> 
> Rationale behind choosing to use assembly over inline assembly are,
> 
> 1. Since the number of lines of instructions (with comments) in
> __tdx_hypercall() implementation is over 70, using inline assembly
> to implement it will make it hard to read.
>     
> 2. Also, since many registers (R8-R15, R[A-D]X)) will be used in
> TDCALL operation, if all these registers are included in in-line
> assembly constraints, some of the older compilers may not
> be able to meet this requirement.
> 
> Also, just like syscalls, not all TDVMCALL/TDCALLs use cases need to
> use the same set of argument registers. The implementation here picks
> the current worst-case scenario for TDCALL (4 registers). For TDCALLs
> with fewer than 4 arguments, there will end up being a few superfluous
> (cheap) instructions.  But, this approach maximizes code reuse. The
> same argument applies to __tdx_hypercall() function as well.
> 
> Current implementation of __tdx_hypercall() includes error handling
> (ud2 on failure case) in assembly function instead of doing it in C
> wrapper function. The reason behind this choice is, when adding support
> for in/out instructions (refer to patch titled "x86/tdx: Handle port
> I/O" in this series), we use alternative_io() to substitute in/out
> instruction with  __tdx_hypercall() calls. So use of C wrappers is not
> trivial in this case because the input parameters will be in the wrong
> registers and it's tricky to include proper buffer code to make this
> happen.
> 
> For registers used by TDCALL instruction, please check TDX GHCI
> specification, sec 2.4 and 3.
> 
> https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
> 
> Originally-by: Sean Christopherson<seanjc@google.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>

I did send it as in-reply-to message id 3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com (your
last reply mail id), but for some reason its not detected as reply to original patch
"[RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper functions".

I am not sure whats going on, but please review as reply to original patch.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
