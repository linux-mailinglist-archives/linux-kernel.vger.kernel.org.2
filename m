Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF6319FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBLNUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhBLNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1457064DBA;
        Fri, 12 Feb 2021 13:19:46 +0000 (UTC)
Date:   Fri, 12 Feb 2021 13:19:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v13 6/7] arm64: mte: Report async tag faults before
 suspend
Message-ID: <20210212131944.GB7718@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-7-vincenzo.frascino@arm.com>
 <20210212120015.GA18281@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212120015.GA18281@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:00:15PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 11, 2021 at 03:33:52PM +0000, Vincenzo Frascino wrote:
> > +void mte_suspend_enter(void)
> > +{
> > +	if (!system_supports_mte())
> > +		return;
> > +
> > +	/*
> > +	 * The barriers are required to guarantee that the indirect writes
> > +	 * to TFSR_EL1 are synchronized before we report the state.
> > +	 */
> > +	dsb(nsh);
> > +	isb();
> > +
> > +	/* Report SYS_TFSR_EL1 before suspend entry */
> > +	mte_check_tfsr_el1();
> > +}
> > +
> >  void mte_suspend_exit(void)
> >  {
> >  	if (!system_supports_mte())
> >  		return;
> >  
> >  	update_gcr_el1_excl(gcr_kernel_excl);
> > +
> > +	/* Clear SYS_TFSR_EL1 after suspend exit */
> > +	write_sysreg_s(0, SYS_TFSR_EL1);
> 
> AFAICS it is not needed, it is done already in __cpu_setup() (that is
> called by cpu_resume on return from cpu_suspend() from firmware).
> 
> However, I have a question. We are relying on context switch to set
> sctlr_el1_tfc0 right ? If that's the case, till the thread resuming from
> low power switches context we are running with SCTLR_EL1_TCF0 not
> reflecting the actual value.

I think you have a point here, though not for SCTLR_EL1 as it is already
restored. GCR_EL1 is only updated after some C code has run and may mess
up stack tagging when/if we ever support it. Anyway, something to worry
about later, I think even the boot path gets this wrong.

-- 
Catalin
