Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EB45ECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351099AbhKZLxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:53:01 -0500
Received: from foss.arm.com ([217.140.110.172]:32862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhKZLvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:51:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F311A1FB;
        Fri, 26 Nov 2021 03:47:46 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.34.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD033F66F;
        Fri, 26 Nov 2021 03:47:45 -0800 (PST)
Date:   Fri, 26 Nov 2021 11:47:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: lib/atomic64.c:82:5: warning: no previous prototype for
 'generic_atomic64_and_return'
Message-ID: <YaDJWgwqdzNeCFLW@FVFF77S0Q05N>
References: <202111120712.RtQHZohY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111120712.RtQHZohY-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 07:08:19AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   debe436e77c72fcee804fb867f275e6d31aa999c
> commit: 1bdadf46eff6804ace5fa46b6856da4799f12b5c locking/atomic: atomic64: support ARCH_ATOMIC
> date:   6 months ago
> config: arc-randconfig-r032-20211109 (attached as .config)
> compiler: arc-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bdadf46eff6804ace5fa46b6856da4799f12b5c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 1bdadf46eff6804ace5fa46b6856da4799f12b5c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

> >> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]

> >> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]

> >> lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]

Ah, there are not meant to be return forms of the and/or/xor operations, so
we're pointlessly building code that cannot be used (but this is not otherwise
harmful).

That said, I think this is nothing to do with commit:

  1bdadf46eff6804a ("locking/atomic: atomic64: support ARCH_ATOMIC")

... and is in fact a latent issue introduced by commit:

  28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")

... where we accidentally left the:

   ATOMIC64_OP_RETURN(op, c_op)

... line for the and/or/xor atomics, even though that wasn't necessary.

This is trivial to avoid, so I'll send a patch shortly.

Thanks,
Mark.
