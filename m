Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8081400599
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbhICTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:15:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:8712 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244110AbhICTPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:15:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="217636974"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="217636974"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 12:14:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="462505560"
Received: from nadeshpa-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.188.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 12:14:50 -0700
Subject: Re: [PATCH v6 11/11] x86/tdx: Handle CPUID via #VE
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <24d0fe72-78b4-6550-e5d8-dd511dcbfef3@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <26e79e8f-ba96-9087-04dd-283eadd8c693@linux.intel.com>
Date:   Fri, 3 Sep 2021 12:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <24d0fe72-78b4-6550-e5d8-dd511dcbfef3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/21 11:35 AM, Dave Hansen wrote:
> On 9/3/21 10:28 AM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> TDX has three classes of CPUID leaves: some CPUID leaves are always
>> handled by the CPU, others are handled by the TDX module, and some
>> others are handled by the VMM. Since the VMM cannot directly intercept
>> the instruction these are reflected with a #VE exception to the guest,
>> which then converts it into a hypercall to the VMM, or handled
>> directly.
> 
> Does this patch do any of the "handled directly" leaves?  If not, why
> mention it?

It was added to give more information about CPUID leaves handling. Since
it has nothing to do with this patch, I can remove it.

> 
> It would also be nice to mention that this applies to both kernel and
> userspace use of CPUID.  It talks a bit about early kernel use, which
> makes it seem like this is kernel-only.
> 
> I also think it's a mistake to talk about TDX-module handling.  For
> *this* patch, it doesn't matter.
> 
> Here's a reformatted replacement changelog:
> 
> --
> 
> When running virtualized, the CPUID instruction is handled differently
> based on the leaf being accessed.  The behavior depends only on on the
> leaf and applies equally to both kernel/ring-0 and userspace/ring-3
> execution of CPUID. Historically, there are two basic classes:
> 
>   * Leaves handled transparently to the guest
>   * Leaves handled by the VMM
> 
> In a typical guest without TDX, "handled by the VMM" leaves cause a
> VMEXIT.  TDX replaces these VMEXITs with a #VE exception in the guest.
> The guest typically handles the #VE by making a hypercall to the VMM.
> 
> The TDX module spec talks about a few more classes of CPUID handling.
> But, for the purposes of this patch, the "handled transparently" CPUID
> leaves are all lumped together because the guest handling is the same.
> 
> --

Thanks. I will use above commit log in next version.

> 
>> The TDX module specification [1], sec 16.2 has a full list of CPUID
> 
> 				     ^ I think we can spare the extra four bytes to make "sec" ->
> "section".
> 
> I also opened up the pdf from [1] an searched for "16.2". I found:
> 
> 	16.2. Branch Prediction Side Channel Attacks Mitigation
> 	Mechanisms
> 
> There is, however, a:
> 
> 	18.2. CPUID Virtualization
> 
> section.  Did you, perhaps, mean to reference that instead?

It looks like I have been using previous version of the TDX module spec
(Sep 2020). In the newer version, it is changed to 18.2.

To avoid confusion I will use the section title for reference.
> 
> Which kinda argues for not using these section numbers at *all*.
> Perhaps you should just mention the section titles, as they're obviously
> less volatile.  That's probably a comment that applies to *ALL* of your
> changelogs across *ALL* TDX patches.  This just proves that the section
> numbers are worthless.

Makes sense. I will fix it in all TDX patch series.

> 
>> leaves which are handled natively or by the TDX module. Only unknown
> 
> Just in terms of nice writing, it would be great to use the same
> language when you refer to the same concept.  Earlier you called this
> "handled by the CPU".  But, here you refer to it as being "handled
> natively".  Neither is wrong, but this puts a burden on the reader to
> make a connection rather than doing it for them as the writer.

Ok. I will keep this in mind for future submissions. For this patch
your commit log refactor fixes this issue.

> 
>> CPUIDs are handled by the #VE method. In practice this typically only
>> applies to the hypervisor-specific CPUIDs unknown to the native CPU.
>>
>> Therefore there is no risk of causing this in early CPUID code which
>> runs before the #VE handler is set up because it will never access
>> those exotic CPUID leaves.
> 
> This never actually makes a transition from background to telling what
> the patch does.  I think this needs at least this:
> 
> 	Allow the the #VE code to handle any CPUID leaves which cause a
> 	#VE.  Unconditionally make a TDCALL to the VMM.
> 
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 5c52dde4a5fd..c65c117aff5f 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -150,6 +150,21 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
>>   	return ret ? -EIO : 0;
>>   }
>>   
>> +static u64 tdx_handle_cpuid(struct pt_regs *regs)
>> +{
>> +	struct tdx_hypercall_output out = {0};
>> +	u64 ret;
>> +
>> +	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
>> +
>> +	regs->ax = out.r12;
>> +	regs->bx = out.r13;
>> +	regs->cx = out.r14;
>> +	regs->dx = out.r15;
> 
> This probably needs a comment about why this is shuffling registers
> around like this.

I will add the ABI details here and also spell out what we are getting
in R12-R15 registers.


> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
