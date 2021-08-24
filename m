Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094AE3F6377
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhHXQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHXQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:55:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B302C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:54:33 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11440049ee8a07127e6a59.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:49ee:8a07:127e:6a59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 104521EC04D1;
        Tue, 24 Aug 2021 18:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629824068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oucuOJ/6VvgUop2x1OI+HAFbSiUqa9pO9eiBxTDjqDU=;
        b=PNEDFxELl/eP785dgUGCkCL/yDSv4Uo0/Rl1JC8Eu0NqLPFsnSOJ+Q+m1oGl+c29okCpDn
        EXyBrlRojKbgqSvZGqwfTpkMep3+tae08RF6aIF6VwerwELWPpa/7uYP8qPa8pS04UnRqh
        enUQNP6+Cp7riAoIVAghu8QXIfRDQmI=
Date:   Tue, 24 Aug 2021 18:55:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/12] x86/tdx: Add MSR support for TDX guest
Message-ID: <YSUkaUQtUpqAXCVd@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-11-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-11-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:27AM -0700, Kuppuswamy Sathyanarayanan wrote:
>  int tdg_handle_virtualization_exception(struct pt_regs *regs,
>  					struct ve_info *ve)
>  {
> +	unsigned long val;
> +	int ret = 0;
> +
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_HLT:
>  		tdg_halt();
>  		break;
> +	case EXIT_REASON_MSR_READ:
> +		val = tdg_read_msr_safe(regs->cx, (unsigned int *)&ret);
> +		if (!ret) {
> +			regs->ax = val & UINT_MAX;

			regs->ax = (u32)val;

> +			regs->dx = val >> 32;
> +		}
> +		break;
> +	case EXIT_REASON_MSR_WRITE:
> +		ret = tdg_write_msr_safe(regs->cx, regs->ax, regs->dx);
> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EFAULT;
>  	}
>  
>  	/* After successful #VE handling, move the IP */
> -	regs->ip += ve->instr_len;
> +	if (!ret)
> +		regs->ip += ve->instr_len;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  void __init tdx_early_init(void)
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
