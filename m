Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8231D7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBQKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:50:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:60484 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBQKt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:49:59 -0500
IronPort-SDR: iPXgHtsJFrTfJmI7wo/z9/6qkKRbpiqOQCX3tRdoPmJ0dSL56FW9pa8auSzO/KsZpVLKsigfDu
 VHBwYAAKkgQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170296960"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="170296960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 02:49:18 -0800
IronPort-SDR: 3sfKgOsUN6Zs2IyTpqCK3b+SC6MHxopB4GmzgPiA7pM+PkRAyE7hesT3KknnV2o0wG8mFoDNvt
 1fA7GDy4p0/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="385073665"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2021 02:49:16 -0800
Date:   Wed, 17 Feb 2021 18:49:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
Message-ID: <20210217104915.GB44989@shbuild999.sh.intel.com>
References: <202101051834.FGH835Vs-lkp@intel.com>
 <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
 <20210205100821.GA71063@shbuild999.sh.intel.com>
 <87lfbouzgd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfbouzgd.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Feb 16, 2021 at 08:36:02PM +1100, Michael Ellerman wrote:
> Feng Tang <feng.tang@intel.com> writes:
> > Hi Christophe and Michael,
> >
> > On Mon, Jan 18, 2021 at 10:24:08PM +0800, Christophe Leroy wrote:
> >> 
> >> Le 05/01/2021 ? 11:58, kernel test robot a 閏rit :
> >> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> > head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> >> > commit: 8b8319b181fd9d6821703fef1228b4dcde613a16 powerpc/44x: Don't support 440 when CONFIG_PPC_47x is set
> >> 
> >> I see no link with that commit. Looks like the problem has been existing for some time.
> >> It exists on the commit before that one, it exists on v5.9 and it exists on v5.10 with that commit
> >> reverted.
> >  
> > Yes, this seems to be a long-standing issue, and we just double checked
> > this compile error. 
> >
> > It happend when compiling arch/powerpc/platforms/44x/fsp2.c, macro
> > 'mfdcr' requirs an instant number as parameter, while is not met by
> > show_plbopb_regs(). Changing show_plbopb_regs() from function to
> > a macro fixes the error, as the patch below:
> >
> > Thanks,
> > Feng
> >
> >
> > From 3bcb9638afc873d0e803aea1aad4f77bf1c2f6f6 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Fri, 5 Feb 2021 16:08:43 +0800
> > Subject: [PATCH] powerpc/44x/fsp2: fix a compiling error regarding macro
> >  'mdfcr'
> >
> > 0day's kbuild test found error:
> >
> > "
> >   CC      arch/powerpc/platforms/44x/fsp2.o
> >
> >   {standard input}:577: Error: unsupported relocation against base
> >   {standard input}:580: Error: unsupported relocation against base
> >   {standard input}:583: Error: unsupported relocation against base
> > "
> >
> > The reason is macro 'mfdcr' requirs an instant number as parameter,
> > which is not met by show_plbopb_regs().
> 
> It doesn't require a constant, it checks if the argument is constant:

Aha, seems my grep found the wrong target: arch/powerpc/boot/dcr.h,
which has  

#define mfdcr(rn) \
	({	\
		unsigned long rval; \
		asm volatile("mfdcr %0,%1" : "=r"(rval) : "i"(rn)); \
		rval; \
	})

> #define mfdcr(rn)						\
> 	({unsigned int rval;					\
> 	if (__builtin_constant_p(rn) && rn < 1024)		\
> 		asm volatile("mfdcr %0," __stringify(rn)	\
> 		              : "=r" (rval));			\
> 	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
> 		rval = mfdcrx(rn);				\
> 	else							\
> 		rval = __mfdcr(rn);				\
> 	rval;})
> 
> But the error you're seeing implies the compiler is choosing the first
> leg of the if, even when rn == "base + x", which is surprising.

Yes, it might be related to compiler (though myself isn't faimiliar
with it). As show_plbopb_regs() was introduced by commit 7813043e1bbc
("powerpc/44x/fsp2: Add irq error handlers") back in 2017, while it
was just reported.

> We've had cases in the past of __builtin_constant_p() returning false
> for things that a human can see are constant at build time, but I've
> never seen the reverse.
> 
> cheers


Thanks,
Feng
