Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF7343E75E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1Rdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:33:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:65345 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Rdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:33:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229209213"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="229209213"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 09:50:24 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="597872778"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 09:50:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mg8bL-001oMI-GL;
        Thu, 28 Oct 2021 19:50:03 +0300
Date:   Thu, 28 Oct 2021 19:50:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <YXrUu8swbM3BL/4C@smile.fi.intel.com>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net>
 <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028162810.GB470146@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:28:10AM -0700, Guenter Roeck wrote:
> On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 28, 2021 at 08:30:55AM -0700, Guenter Roeck wrote:
> > > On Wed, Oct 27, 2021 at 06:03:24PM +0300, Andy Shevchenko wrote:
> > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > especially when there are circular dependencies are involved.
> > > > 
> > > > Replace kernel.h inclusion with the list of what is really being used.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > In next-20211028:
> > > 
> > > Building riscv32:defconfig ... failed
> > > --------------
> > > Error log:
> > > arch/riscv/lib/delay.c: In function '__delay':
> > > arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> > > 
> > > Building riscv:defconfig ... failed
> > > --------------
> > > Error log:
> > > arch/riscv/lib/delay.c: In function '__delay':
> > > arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> > > 
> > > Building s390:defconfig ... failed
> > > --------------
> > > Error log:
> > > <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> > > In file included from arch/s390/pci/pci_insn.c:12:
> > > arch/s390/include/asm/facility.h: In function '__stfle':
> > > arch/s390/include/asm/facility.h:98:22: error: implicit declaration of function 'min_t'
> > > 
> > > bisect to this patch. Probably more, but it is difficult to find out
> > > since -next is too badly broken and has build failures all over the place.
> > 
> > Thanks for the report!

I'll send the fix for above soon. Hope it will reduce amount of failures.

> > I have run it on x86_64 with `kcbench -m ...` and no failures.
> > 
> > Can you share all build errors you found so far? I believe none of them related
> > to x86* code.
> > 
> > Above just revealed the problematic places in the first place. Why the
> > programmers rely on delay.h to include full bloated header pile?! (Yeah, this
> > is rhetorical, so please share the errors, I'll try to address them)
> 
> The ones listed above are the ones I was able to identify. As I said, there
> are so many compile and runtime failures in linux-next that it is difficult
> to track down individual failures.

Yeah, for example, I looked into this: https://kerneltests.org/builders/next-mips-next/builds/698/steps/buildcommand/logs/stdio

I can't see how my patch is related to this...

> Just to give you an idea (this is for
> next-20211028):
> 
> Build results:
> 	total: 153 pass: 115 fail: 38
> Failed builds:
> 	alpha:allmodconfig
> 	arm:allmodconfig
> 	arm:omap2plus_defconfig
> 	arm:davinci_all_defconfig
> 	arm64:defconfig
> 	arm64:allmodconfig
> 	csky:allmodconfig
> 	h8300:allnoconfig
> 	h8300:tinyconfig
> 	h8300:edosk2674_defconfig
> 	h8300:h8300h-sim_defconfig
> 	h8300:h8s-sim_defconfig
> 	m68k:allmodconfig
> 	mips:defconfig
> 	mips:allmodconfig
> 	mips:allnoconfig
> 	mips:tinyconfig
> 	mips:bcm47xx_defconfig
> 	mips:bcm63xx_defconfig
> 	mips:ath79_defconfig
> 	mips:ar7_defconfig
> 	mips:e55_defconfig
> 	mips:cavium_octeon_defconfig
> 	mips:malta_defconfig
> 	mips:rt305x_defconfig
> 	nds32:allmodconfig
> 	parisc:allmodconfig
> 	parisc:generic-32bit_defconfig
> 	parisc64:generic-64bit_defconfig
> 	powerpc:allmodconfig
> 	riscv32:defconfig
> 	riscv32:allmodconfig
> 	riscv:defconfig
> 	riscv:allmodconfig
> 	s390:defconfig
> 	s390:allmodconfig
> 	sparc64:allmodconfig
> 	xtensa:allmodconfig
> Qemu test results:
> 	total: 480 pass: 315 fail: 165
> Failed tests:
> 	<too many to list them all>
> 
> Build and boot logs are as always at https://kerneltests.org/builders
> in the 'next' column in case you want to do some digging yourself.

-- 
With Best Regards,
Andy Shevchenko


