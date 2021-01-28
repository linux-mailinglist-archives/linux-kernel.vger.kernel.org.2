Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743C1307CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhA1RpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:45:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:16768 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhA1Roi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:44:38 -0500
IronPort-SDR: dy4myhAHGRzpyFfYhz38AlXOkO/YQ1lNbC+bzwuJWAw35lEc5MKQ1FIqgHj3eDR7kKexfKqFh6
 TFXgi9NihMgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="199115195"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="199115195"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:43:53 -0800
IronPort-SDR: bHzDr4KVfojn+jzni5nYFplQaM5auMhTIKsKDG6rUoV1f94Wuphi1lCXpWg4TuU5G3j6oO34S7
 xN16GtSC8QnA==
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="363886580"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:43:53 -0800
Date:   Thu, 28 Jan 2021 09:43:52 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     x86@kernel.org, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH] x86/fault: Send SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210128174352.GA33283@agluck-desk2.amr.corp.intel.com>
References: <20210128194326.71895e92.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128194326.71895e92.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 07:43:26PM +0800, Aili Yao wrote:
> when one page is already hwpoisoned by AO action, process may not be
> killed, the process mapping this page may make a syscall include this
> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
> mode it may be fixed by fixup_exception, current code will just return
> error code to user process.

Shouldn't the AO action that poisoned the page have also unmapped it?
> 
> This is not suffient, we should send a SIGBUS to the process and log the
> info to console, as we can't trust the process will handle the error
> correctly.

I agree with this part ... few apps check for -EFAULT and do the right
thing.  But I'm not sure how this happens. Can you provide a bit more
detail on the steps

-Tony

P.S. Typo: s/suffient/sufficient/

> 
> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  arch/x86/mm/fault.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f1f1b5a0956a..36d1e385512b 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -662,7 +662,16 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>  		 * In this case we need to make sure we're not recursively
>  		 * faulting through the emulate_vsyscall() logic.
>  		 */
> +#ifdef CONFIG_MEMORY_FAILURE
> +		if (si_code == BUS_MCEERR_AR && signal == SIGBUS)
> +			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> +				current->comm, current->pid, address);
> +
> +		if ((current->thread.sig_on_uaccess_err && signal) ||
> +			(si_code == BUS_MCEERR_AR && signal == SIGBUS)) {
> +#else
>  		if (current->thread.sig_on_uaccess_err && signal) {
> +#endif
>  			sanitize_error_code(address, &error_code);
>  
>  			set_signal_archinfo(address, error_code);
> @@ -927,7 +936,14 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  {
>  	/* Kernel mode? Handle exceptions or die: */
>  	if (!(error_code & X86_PF_USER)) {
> +#ifdef CONFIG_MEMORY_FAILURE
> +		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
> +			no_context(regs, error_code, address, SIGBUS, BUS_MCEERR_AR);
> +		else
> +			no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> +#else
>  		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> +#endif
>  		return;
>  	}
>  
> -- 
> 2.25.1
> 
