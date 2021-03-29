Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9146934DC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC2XiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:38:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:7138 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhC2XiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:38:15 -0400
IronPort-SDR: 1Xgwy9UVowDipRNiB/Ckw1JKEe4RNvYmFHysDo7g6ViTNgnBJ2KpxxmEwI/OyYTRNQG+jencIi
 ZZxe6NJqgN8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="179187790"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="179187790"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:38:14 -0700
IronPort-SDR: xG33hah2SmrDi5Jpeqc4pHYxg3JxP1ej1jYt9aK5kYYiuQlhMDAzHG0cNMqVF8u9Y7gu0ZuFf9
 ADKw9sf9GWcg==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="411325022"
Received: from jmwolcot-mobl.amr.corp.intel.com (HELO [10.209.158.84]) ([10.209.158.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:38:13 -0700
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <0356a84a-765e-b20b-2efd-c5d94fc2347e@intel.com>
 <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <3e1c7f86-292b-2ed9-3af8-01b36cb1a4ef@intel.com>
Date:   Mon, 29 Mar 2021 16:38:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 4:16 PM, Kuppuswamy Sathyanarayanan wrote:
> In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> are not supported. So handle #VE due to these instructions
> appropriately.

This misses a key detail:

	"are not supported" ... and other patches have prevented a guest
	from using these instructions.

In other words, they're bad now, and we know it.  We tried to keep the
kernel from using them, but we failed.  Whoops.

> Since the impact of executing WBINVD instruction in non ring-0 mode
> can be heavy, use BUG() to report it. For others, raise a WARNING
> message.

"Heavy" makes it sound like there's a performance impact.



>  	pv_ops.irq.safe_halt = tdg_safe_halt;
> @@ -362,6 +365,32 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>  	case EXIT_REASON_EPT_VIOLATION:
>  		ve->instr_len = tdg_handle_mmio(regs, ve);
>  		break;
> +	case EXIT_REASON_WBINVD:
> +		/*
> +		 * WBINVD is a privileged instruction, can only be executed
> +		 * in ring 0. Since we reached here, the kernel is in buggy
> +		 * state.
> +		 */
> +		pr_err("WBINVD #VE Exception\n");

"#VE Exception" is basically wasted bytes.  It really tells us nothing.
 This, on the other hand:

	"TDX guest used unsupported WBINVD instruction"

gives us the clues that TDX is involved and that the kernel used the
instruction.  The fact that #VE itself is involved is kinda irrelevant.

I also hate the comment.  Don't waste the bytes saying we're in a buggy
state.  That's kinda obvious from the BUG().

Again, it might be nice to mention in the changelog *WHY* we're so sure
that WBINVD won't be called from a TDX guest.  What did we do to
guarantee that?  How could we be sure that someone looking at the splat
that this generates and then reading the comment can go fix the bug in
their kernel?

> +		BUG();
> +		break;
> +	case EXIT_REASON_MONITOR_INSTRUCTION:
> +		/*
> +		 * MONITOR is a privileged instruction, can only be executed
> +		 * in ring 0. So we are not supposed to reach here. Raise a
> +		 * warning message.
> +		 */
> +		WARN(1, "MONITOR unexpected #VE Exception\n");
> +		break;
> +	case EXIT_REASON_MWAIT_INSTRUCTION:
> +		/*
> +		 * MWAIT feature is suppressed in firmware and in
> +		 * tdx_early_init() by clearing X86_FEATURE_MWAIT CPU feature
> +		 * flag. Since we are not supposed to reach here, raise a
> +		 * warning message and return -EFAULT.
> +		 */
> +		WARN(1, "MWAIT unexpected #VE Exception\n");
> +		return -EFAULT;
>  	default:
>  		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>  		return -EFAULT;

This is more of the same.  Don't waste comment bytes telling me we're
not suppose to reach a BUG() or WARN().
