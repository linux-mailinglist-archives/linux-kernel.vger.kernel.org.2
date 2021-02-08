Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E805312F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhBHKcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhBHKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:21:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rpDDO6jVmzHowbcsi+/ymkIfpV51Uww6OPP3edq882A=; b=qj/HGbkwaAe6YwP4rTtO8zGezl
        kPceUDl5YNKoBtO2Z6CNtJckX0y3nh0v4Fp0UeNlV9w2aaSBwulMe+b3u/clXk+rYTfZg0FDT//6X
        XFW28NIuZuTB6i9D5YXp74TUAAqd6+5Oh9a+jhga9pkjJx2ATepPAhISFHoW5Fd5DvceC/9ArO3Wl
        PRhYr+SvD5WvACYsLlJmS9T0TF3+J/y/YDX2rbZN1WzVJOHeGqT/pRbZ5gAEOtgis78OsmzsGP0ch
        lOQHCOxWY5BkeL9C0NaVBM0gIMjVh0lMfskqkpe8oP5FxcC4I+xOkYe2nEY+1q1RRzaRAi4xSUnux
        q/es/bmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l93f7-0006Ik-Tb; Mon, 08 Feb 2021 10:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5327A3010D2;
        Mon,  8 Feb 2021 11:20:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 380352BF248CF; Mon,  8 Feb 2021 11:20:56 +0100 (CET)
Date:   Mon, 8 Feb 2021 11:20:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:38:22PM -0800, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The TDX module injects #VE exception to the guest TD in cases of
> disallowed instructions, disallowed MSR accesses and subset of CPUID
> leaves. Also, it's theoretically possible for CPU to inject #VE
> exception on EPT violation, but the TDX module makes sure this does
> not happen, as long as all memory used is properly accepted using
> TDCALLs. You can find more details about it in, Guest-Host-Communication
> Interface (GHCI) for Intel Trust Domain Extensions (Intel TDX)
> specification, sec 2.3.
> 
> Add basic infrastructure to handle #VE. If there is no handler for a
> given #VE, since its a unexpected event (fault case), treat it as a
> general protection fault and handle it using do_general_protection()
> call.
> 
> TDCALL[TDGETVEINFO] provides information about #VE such as exit reason.
> 
> More details on cases where #VE exceptions are allowed/not-allowed:
> 
> The #VE exception do not occur in the paranoid entry paths, like NMIs.
> While other operations during an NMI might cause #VE, these are in the
> NMI code that can handle nesting, so there is no concern about
> reentrancy. This is similar to how #PF is handled in NMIs.
> 
> The #VE exception also cannot happen in entry/exit code with the
> wrong gs, such as the SWAPGS code, so it's entry point does not
> need "paranoid" handling.

All of the above are arranged by using the below secure EPT for init
text and data?

> Any memory accesses can cause #VE if it causes an EPT
> violation.  However, the VMM is only in direct control of some of the
> EPT tables.  The Secure EPT tables are controlled by the TDX module
> which guarantees no EPT violations will result in #VE for the guest,
> once the memory has been accepted.

Which is supposedly then set up to avoid #VE during the syscall gap,
yes? Which then results in #VE not having to be IST.

> +#ifdef CONFIG_INTEL_TDX_GUEST
> +DEFINE_IDTENTRY(exc_virtualization_exception)
> +{
> +	struct ve_info ve;
> +	int ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	/* Consume #VE info before re-enabling interrupts */

So what happens if NMI happens here, and triggers a nested #VE ?

> +	ret = tdx_get_ve_info(&ve);
> +	cond_local_irq_enable(regs);
> +	if (!ret)
> +		ret = tdx_handle_virtualization_exception(regs, &ve);
> +	/*
> +	 * If #VE exception handler could not handle it successfully, treat
> +	 * it as #GP(0) and handle it.
> +	 */
> +	if (ret)
> +		do_general_protection(regs, 0);
> +	cond_local_irq_disable(regs);
> +}
> +#endif
