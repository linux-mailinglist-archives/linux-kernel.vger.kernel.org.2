Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FB45EC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhKZLIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:08:46 -0500
Received: from foss.arm.com ([217.140.110.172]:60770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhKZLGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:06:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349801FB;
        Fri, 26 Nov 2021 03:03:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED0B3F66F;
        Fri, 26 Nov 2021 03:03:31 -0800 (PST)
Date:   Fri, 26 Nov 2021 11:03:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast
 truncates bits from constant value (deadbeef becomes ef)
Message-ID: <YaC++05+X4RYgdLh@FVFF77S0Q05N>
References: <202111240654.4qXNBmtC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111240654.4qXNBmtC-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 24, 2021 at 06:19:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   136057256686de39cc3a07c2e39ef6bc43003ff6
> commit: c7178cdecdbef8321f418fac55f3afaca3bb4c96 locking/atomic: h8300: use asm-generic exclusively
> date:   6 months ago
> config: h8300-randconfig-s031-20211117 (https://download.01.org/0day-ci/archive/20211124/202111240654.4qXNBmtC-lkp@intel.com/config.gz)
> compiler: h8300-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7178cdecdbef8321f418fac55f3afaca3bb4c96
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c7178cdecdbef8321f418fac55f3afaca3bb4c96
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    lib/atomic64_test.c: note: in included file (through arch/h8300/include/generated/asm/cmpxchg.h, include/asm-generic/atomic.h, arch/h8300/include/generated/asm/atomic.h, ...):
> >> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
> >> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
> >> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
> >> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
> >> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
> >> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
> >> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
> >> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)

This is the expected behaviour for the code below. The truncation on line 37 is
when we assign to a u8, and the truncation on line 48 is when we assign to a
u16.

I'm a little confused by the wording of the warning, because there's no cast on
the value being assigned. I'm not sure if that's just misleading wording from
sparse. Would a cast on the right hand side of the assignment be sufficient to
suppress this, e.g.

  *(volatile u8 *)pte = (u8)x;

... because if so, maybe it's worth adding, unless we think this warning would
be useful for when this situation crops up outside of test code (in which case
we should just ignore it for now).

Thanks,
Mark.

> vim +37 include/asm-generic/cmpxchg.h
> 
> b4816afa398670 David Howells 2012-03-28  24  
> b4816afa398670 David Howells 2012-03-28  25  static inline
> b4816afa398670 David Howells 2012-03-28  26  unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
> b4816afa398670 David Howells 2012-03-28  27  {
> b4816afa398670 David Howells 2012-03-28  28  	unsigned long ret, flags;
> b4816afa398670 David Howells 2012-03-28  29  
> b4816afa398670 David Howells 2012-03-28  30  	switch (size) {
> b4816afa398670 David Howells 2012-03-28  31  	case 1:
> b4816afa398670 David Howells 2012-03-28  32  #ifdef __xchg_u8
> b4816afa398670 David Howells 2012-03-28  33  		return __xchg_u8(x, ptr);
> b4816afa398670 David Howells 2012-03-28  34  #else
> b4816afa398670 David Howells 2012-03-28  35  		local_irq_save(flags);
> b4816afa398670 David Howells 2012-03-28  36  		ret = *(volatile u8 *)ptr;
> b4816afa398670 David Howells 2012-03-28 @37  		*(volatile u8 *)ptr = x;
> b4816afa398670 David Howells 2012-03-28  38  		local_irq_restore(flags);
> b4816afa398670 David Howells 2012-03-28  39  		return ret;
> b4816afa398670 David Howells 2012-03-28  40  #endif /* __xchg_u8 */
> b4816afa398670 David Howells 2012-03-28  41  
> b4816afa398670 David Howells 2012-03-28  42  	case 2:
> b4816afa398670 David Howells 2012-03-28  43  #ifdef __xchg_u16
> b4816afa398670 David Howells 2012-03-28  44  		return __xchg_u16(x, ptr);
> b4816afa398670 David Howells 2012-03-28  45  #else
> b4816afa398670 David Howells 2012-03-28  46  		local_irq_save(flags);
> b4816afa398670 David Howells 2012-03-28  47  		ret = *(volatile u16 *)ptr;
> b4816afa398670 David Howells 2012-03-28 @48  		*(volatile u16 *)ptr = x;
> b4816afa398670 David Howells 2012-03-28  49  		local_irq_restore(flags);
> b4816afa398670 David Howells 2012-03-28  50  		return ret;
> b4816afa398670 David Howells 2012-03-28  51  #endif /* __xchg_u16 */
> b4816afa398670 David Howells 2012-03-28  52  
> b4816afa398670 David Howells 2012-03-28  53  	case 4:
> b4816afa398670 David Howells 2012-03-28  54  #ifdef __xchg_u32
> b4816afa398670 David Howells 2012-03-28  55  		return __xchg_u32(x, ptr);
> b4816afa398670 David Howells 2012-03-28  56  #else
> b4816afa398670 David Howells 2012-03-28  57  		local_irq_save(flags);
> b4816afa398670 David Howells 2012-03-28  58  		ret = *(volatile u32 *)ptr;
> b4816afa398670 David Howells 2012-03-28  59  		*(volatile u32 *)ptr = x;
> b4816afa398670 David Howells 2012-03-28  60  		local_irq_restore(flags);
> b4816afa398670 David Howells 2012-03-28  61  		return ret;
> b4816afa398670 David Howells 2012-03-28  62  #endif /* __xchg_u32 */
> b4816afa398670 David Howells 2012-03-28  63  
> 
> :::::: The code at line 37 was first introduced by commit
> :::::: b4816afa3986704d1404fc48e931da5135820472 Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h
> 
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
