Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ECC4004F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbhICSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:36:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:5386 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhICSgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:36:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206607021"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206607021"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 11:35:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692399667"
Received: from lkkolkin-mobl1.amr.corp.intel.com (HELO [10.209.121.88]) ([10.209.121.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 11:35:50 -0700
Subject: Re: [PATCH v6 11/11] x86/tdx: Handle CPUID via #VE
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <24d0fe72-78b4-6550-e5d8-dd511dcbfef3@intel.com>
Date:   Fri, 3 Sep 2021 11:35:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210903172812.1097643-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 10:28 AM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> TDX has three classes of CPUID leaves: some CPUID leaves are always
> handled by the CPU, others are handled by the TDX module, and some
> others are handled by the VMM. Since the VMM cannot directly intercept
> the instruction these are reflected with a #VE exception to the guest,
> which then converts it into a hypercall to the VMM, or handled
> directly.

Does this patch do any of the "handled directly" leaves?  If not, why
mention it?

It would also be nice to mention that this applies to both kernel and
userspace use of CPUID.  It talks a bit about early kernel use, which
makes it seem like this is kernel-only.

I also think it's a mistake to talk about TDX-module handling.  For
*this* patch, it doesn't matter.

Here's a reformatted replacement changelog:

--

When running virtualized, the CPUID instruction is handled differently
based on the leaf being accessed.  The behavior depends only on on the
leaf and applies equally to both kernel/ring-0 and userspace/ring-3
execution of CPUID. Historically, there are two basic classes:

 * Leaves handled transparently to the guest
 * Leaves handled by the VMM

In a typical guest without TDX, "handled by the VMM" leaves cause a
VMEXIT.  TDX replaces these VMEXITs with a #VE exception in the guest.
The guest typically handles the #VE by making a hypercall to the VMM.

The TDX module spec talks about a few more classes of CPUID handling.
But, for the purposes of this patch, the "handled transparently" CPUID
leaves are all lumped together because the guest handling is the same.

--

> The TDX module specification [1], sec 16.2 has a full list of CPUID

				     ^ I think we can spare the extra four bytes to make "sec" ->
"section".

I also opened up the pdf from [1] an searched for "16.2". I found:

	16.2. Branch Prediction Side Channel Attacks Mitigation
	Mechanisms

There is, however, a:

	18.2. CPUID Virtualization

section.  Did you, perhaps, mean to reference that instead?

Which kinda argues for not using these section numbers at *all*.
Perhaps you should just mention the section titles, as they're obviously
less volatile.  That's probably a comment that applies to *ALL* of your
changelogs across *ALL* TDX patches.  This just proves that the section
numbers are worthless.

> leaves which are handled natively or by the TDX module. Only unknown

Just in terms of nice writing, it would be great to use the same
language when you refer to the same concept.  Earlier you called this
"handled by the CPU".  But, here you refer to it as being "handled
natively".  Neither is wrong, but this puts a burden on the reader to
make a connection rather than doing it for them as the writer.

> CPUIDs are handled by the #VE method. In practice this typically only
> applies to the hypervisor-specific CPUIDs unknown to the native CPU.
> 
> Therefore there is no risk of causing this in early CPUID code which
> runs before the #VE handler is set up because it will never access
> those exotic CPUID leaves.

This never actually makes a transition from background to telling what
the patch does.  I think this needs at least this:

	Allow the the #VE code to handle any CPUID leaves which cause a
	#VE.  Unconditionally make a TDCALL to the VMM.

> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 5c52dde4a5fd..c65c117aff5f 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -150,6 +150,21 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
>  	return ret ? -EIO : 0;
>  }
>  
> +static u64 tdx_handle_cpuid(struct pt_regs *regs)
> +{
> +	struct tdx_hypercall_output out = {0};
> +	u64 ret;
> +
> +	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
> +
> +	regs->ax = out.r12;
> +	regs->bx = out.r13;
> +	regs->cx = out.r14;
> +	regs->dx = out.r15;

This probably needs a comment about why this is shuffling registers
around like this.

> +	return ret;
> +}
> +
>  unsigned long tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out = {0};
> @@ -193,6 +208,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
>  	case EXIT_REASON_MSR_WRITE:
>  		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
>  		break;
> +	case EXIT_REASON_CPUID:
> +		ret = tdx_handle_cpuid(regs);
> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EFAULT;
> 

