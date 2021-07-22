Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719D13D2D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGVTZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhGVTZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:25:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9E8260EB1;
        Thu, 22 Jul 2021 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626984365;
        bh=1LkSKYpfu6NVE1xWN2RXUJAc2AosOhIKQ1f+dRhrMGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX5/lEwmxll7z5zQ/GAPyasPEn1saMYrUyvSuakYZTRSvkqYBu3q6fAkMQTjzPjVh
         fLnviCsC/5lmHA+ZXwfEh19ExTWjcuDjmmNPiYhNR42/k6YL+YqGJXb1wNVdVXyHbp
         iuuug/btndpTdqGpLyOAPo3qQtCq6dO/BQPPY2lBvcB6HIyMNYMfJ0/UhOyBSyvMYQ
         waEPqeqWfgMJ6UbTY0i5GITPRHtZiSH1peMmeDQSqXldSTysgmUO8N4pwVoQy+SaPo
         XOyJ7qdYo79ubpZxba5YuePwUldhBgPMPJ7wYhljtnmGTw5B2p6ty14cecRSJo8c4/
         YZTME0U64LxxA==
Date:   Thu, 22 Jul 2021 13:05:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-ID: <YPnPp9grFPTFrn4c@archlinux-ax161>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czzeg5ep.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 09:01:34PM +0100, Thomas Gleixner wrote:
> On Sat, Dec 12 2020 at 13:26, Marco Elver wrote:
> > On Thu, Mar 07, 2019 at 10:14AM +0100, Arnd Bergmann wrote:
> >> -static void __init futex_detect_cmpxchg(void)
> >> +static noinline void futex_detect_cmpxchg(void)
> >>  {
> >>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >>  	u32 curval;
> >
> > What ever happened to this patch?
> 
> It obviously fell through the cracks. 
> 
> > I'm seeing this again with the attached config + next-20201211 (for
> > testing https://bugs.llvm.org/show_bug.cgi?id=48492). Had to apply this
> > patch to build the kernel.
> 
> What really bothers me is to remove the __init from a function which is
> clearly only used during init. And looking deeper it's simply a hack.
> 
> This function is only needed when an architecture has to runtime
> discover whether the CPU supports it or not. ARM has unconditional
> support for this, so the obvious thing to do is the below.
> 
> Thanks,
> 
>         tglx
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -86,6 +86,7 @@ config ARM
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>  	select HAVE_IDE if PCI || ISA || PCMCIA
> 
> 

Hi Thomas,

Did this ever get sent along as a formal patch? I just ran into another
issue that seems to be similar to the one Arnd sent the initial patch in
this thread for and it is resolved by this change.

Cheers,
Nathan
