Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A453A12BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhFIL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238767AbhFIL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:29:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB89261364;
        Wed,  9 Jun 2021 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623238073;
        bh=4WJpXLFKQti9BHVRMa0Ik+rm/Abh/O7WH2yaXGpwWM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oElFNQ7EJ3+JXsxOytsR4nnp+4ajArTXZ/mfOlg4QU1jR4PFm/4+K8MvATKR2+3Ne
         TkwK+s1GyabjgV/uwihYD8eEYxCB9FEy+jPzDRXqg0UPfnzY8HUMko/O8opqe/z+Ru
         aLmQ8W9vbytnyZ0uwjeMgri4zxLGM4h0Eh4ZEnvIBQnxA6LuMaSSRQ2IvRUYeziFW+
         oX8Pp8Vtyw7Av8v5hGLlcd1A3IT0wZQ4CbDXiDe1hTltJMH3xNA4OEs7DAYO12XB3h
         5l6t+hRdJPP3KloKCuVrhKIW1F4/GoKMt/DItgRMsAIRoz7hAMdC04BVaJZ9kD7A22
         LgiapdfL4fRhw==
Date:   Wed, 9 Jun 2021 13:27:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <20210609112750.GC104634@lothringen>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
 <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
 <YL94/8cSr2R2wiTa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL94/8cSr2R2wiTa@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 04:04:47PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 08, 2021 at 03:55:09PM +0200, Peter Zijlstra wrote:
> > Urgh, would something like this work?
> > 
> > ---
> >  kernel/Kconfig.preempt | 64 ++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 51 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > index bd7c4147b9a8..43c68a806e4e 100644
> > --- a/kernel/Kconfig.preempt
> > +++ b/kernel/Kconfig.preempt
> > @@ -1,11 +1,25 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  
> > +config PREEMPT_COUNT
> > +       bool
> > +
> > +config PREEMPTION
> > +       bool
> > +       select PREEMPT_COUNT
> > +
> > +config PREEMPT_DYNAMIC_OPTION
> > +	bool
> > +	help
> > +	  Symbol that gates availablility of PREEMPT_DYNAMIC, selected
> > +	  by preemption models that can be dynamically selected.
> > +
> >  choice
> >  	prompt "Preemption Model"
> > +	default PREEMPT_TYPE_NONE
> >  
> > +config PREEMPT_TYPE_NONE
> >  	bool "No Forced Preemption (Server)"
> > +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
> >  	help
> >  	  This is the traditional Linux preemption model, geared towards
> >  	  throughput. It will still provide good latencies most of the
> > @@ -17,9 +31,10 @@ config PREEMPT_NONE
> >  	  raw processing power of the kernel, irrespective of scheduling
> >  	  latencies.
> >  
> > +config PREEMPT_TYPE_VOLUNTARY
> >  	bool "Voluntary Kernel Preemption (Desktop)"
> >  	depends on !ARCH_NO_PREEMPT
> > +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
> >  	help
> >  	  This option reduces the latency of the kernel by adding more
> >  	  "explicit preemption points" to the kernel code. These new
> > @@ -35,12 +50,10 @@ config PREEMPT_VOLUNTARY
> >  
> >  	  Select this if you are building a kernel for a desktop system.
> >  
> > -config PREEMPT
> > +config PREEMPT_TYPE_FULL
> >  	bool "Preemptible Kernel (Low-Latency Desktop)"
> >  	depends on !ARCH_NO_PREEMPT
> > +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
> >  	help
> >  	  This option reduces the latency of the kernel by making
> >  	  all kernel code (that is not executing in a critical section)
> > @@ -75,15 +88,24 @@ config PREEMPT_RT
> >  
> >  endchoice
> >  
> > +# default model for PREEMPT_DYNAMIC
> >  
> > +config PREEMPT_DYNAMIC_NONE
> > +	bool
> >  
> > +config PREEMPT_DYNAMIC_VOLUNTARY
> > +	bool
> > +
> > +config PREEMPT_DYNAMIC_FULL
> >  	bool
> > +
> > +config PREEMPT_DYNAMIC
> > +	bool "Dynamic Preemption Mode"
> > +	depends on PREEMPT_DYNAMIC_OPTION
> > +	select PREEMPT
> > +	select PREEMPT_DYNAMIC_NONE if PREEMPT_TYPE_NONE
> > +	select PREEMPT_DYNAMIC_VOLUNTARY if PREEMPT_TYPE_VOLUNTARY
> > +	select PREEMPT_DYNAMIC_FULL if PREEMPT_TYPE_FULL
> 
> Arguably PREEMPT_DYNAMIC_{NONE,VOLUNTARY,FULL} are superfluous and the
> default selection can use PREEMPT_TYPE_*.

Right, I'll try that.

Thanks.
