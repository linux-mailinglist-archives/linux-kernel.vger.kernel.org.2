Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98F3E09CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhHDVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:03:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:50993 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhHDVDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:03:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235972196"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="235972196"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 14:03:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512230737"
Received: from bguvendi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 14:03:05 -0700
Subject: Re: [PATCH v5 11/12] x86/tdx: Don't write CSTAR MSR on Intel
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrdFLPaUnC8Q5bn@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4c1ee7b9-9941-fdc4-73f5-3d2ef0530556@linux.intel.com>
Date:   Wed, 4 Aug 2021 14:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQrdFLPaUnC8Q5bn@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 11:31 AM, Sean Christopherson wrote:
>> On Intel CPUs writing the CSTAR MSR is not really needed. Syscalls
>> from 32bit work using SYSENTER and 32bit SYSCALL is an illegal opcode.
>> But the kernel did write it anyways even though it was ignored by
>> the CPU. Inside a TDX guest this actually leads to a #GP. While the #GP
>> is caught and recovered from, it prints an ugly message at boot.
>> Do not write the CSTAR MSR on Intel CPUs.
> Not that it really matters, but...
> 
> Is #GP the actual TDX-Module behavior?  If so, isn't that a contradiction with

No, #GP is triggered by guest.

> respect to the TDX-Module architecture?  It says:
> 
>    guest TD access violations to MSRs can cause a #GP(0) in most cases where the
>    MSR is enumerated as inaccessible by the Intel TDX module via CPUID
>    virtualization.  In other cases, guest TD access violations to MSRs can cause
>    a #VE.
> 
> Given that there is no dedicated CPUID flag for CSTAR and CSTAR obviously exists
> on Intel CPUs, I don't see how the TDX-Module can possible enumerate CSTAR as
> being inaccessible.
> 
> Regardless of #GP versus #VE, "Table 16.2 MSR Virtualization" needs to state the
> actual behavior.

Even in this case, it will trigger #VE. But since CSTAR MSR is not supported, write
to it will fail and leads to #VE fault.

File: arch/x86/kernel/traps.c

1183 DEFINE_IDTENTRY(exc_virtualization_exception)
1201         if (!ret)
1202                 ret = tdg_handle_virtualization_exception(regs, &ve);
1203         /*
1204          * If tdg_handle_virtualization_exception() could not process
1205          * it successfully, treat it as #GP(0) and handle it.
1206          */
1207         if (ret)
1208                 ve_raise_fault(regs, 0);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
