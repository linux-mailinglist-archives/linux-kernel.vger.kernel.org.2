Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C243E599
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJ1QBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:01:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:57061 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhJ1QBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:01:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229193082"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="229193082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 08:58:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="448019013"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 08:58:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mg7nB-001niX-Jl;
        Thu, 28 Oct 2021 18:58:13 +0300
Date:   Thu, 28 Oct 2021 18:58:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <YXrIlT+2llnwgRpj@smile.fi.intel.com>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028153055.GA440866@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 08:30:55AM -0700, Guenter Roeck wrote:
> On Wed, Oct 27, 2021 at 06:03:24PM +0300, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> In next-20211028:
> 
> Building riscv32:defconfig ... failed
> --------------
> Error log:
> arch/riscv/lib/delay.c: In function '__delay':
> arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> 
> Building riscv:defconfig ... failed
> --------------
> Error log:
> arch/riscv/lib/delay.c: In function '__delay':
> arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> 
> Building s390:defconfig ... failed
> --------------
> Error log:
> <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> In file included from arch/s390/pci/pci_insn.c:12:
> arch/s390/include/asm/facility.h: In function '__stfle':
> arch/s390/include/asm/facility.h:98:22: error: implicit declaration of function 'min_t'
> 
> bisect to this patch. Probably more, but it is difficult to find out
> since -next is too badly broken and has build failures all over the place.

Thanks for the report!

I have run it on x86_64 with `kcbench -m ...` and no failures.

Can you share all build errors you found so far? I believe none of them related
to x86* code.

Above just revealed the problematic places in the first place. Why the
programmers rely on delay.h to include full bloated header pile?! (Yeah, this
is rhetorical, so please share the errors, I'll try to address them)

-- 
With Best Regards,
Andy Shevchenko


