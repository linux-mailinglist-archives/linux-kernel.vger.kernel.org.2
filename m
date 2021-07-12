Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8D3C5E61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhGLOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:34:45 -0400
Received: from foss.arm.com ([217.140.110.172]:56486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234869AbhGLOeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:34:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98391FB;
        Mon, 12 Jul 2021 07:31:55 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A683F774;
        Mon, 12 Jul 2021 07:31:54 -0700 (PDT)
Date:   Mon, 12 Jul 2021 15:31:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: include/linux/atomic-arch-fallback.h:60:32: error: implicit
 declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'?
Message-ID: <20210712143151.GB94622@C02TD0UTHF1T.local>
References: <202107110643.63fELxVr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107110643.63fELxVr-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 06:44:47AM +0800, kernel test robot wrote:
> Hi Mark,
> 
> FYI, the error/warning still remains.

I thought we'd already identified that this was an existing bug, and all that
has changed is the specific error that manifests.

In v5.13 this would fail with:

|   CC      drivers/iommu/io-pgtable-arm.o
| In file included from ./include/linux/atomic.h:84,
|                  from drivers/iommu/io-pgtable-arm.c:12:
| drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
| ./include/linux/atomic-fallback.h:60:27: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]
|    60 | #define cmpxchg64_relaxed cmpxchg64
|       |                           ^~~~~~~~~
| drivers/iommu/io-pgtable-arm.c:320:8: note: in expansion of macro 'cmpxchg64_relaxed'
|   320 |  old = cmpxchg64_relaxed(ptep, curr, new);
|       |        ^~~~~~~~~~~~~~~~~

... which has the same underlying problem -- the architecture has not provided
a cmpxchg64() implementation, but the IO pagetable code depends upon
cmpxchg64().

Thanks,
Mark.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1e16624d7b4376797ede36e3c955375cf0f23298
> commit: bccf1ec369ac126b0997d01a6e1deae00e2cf6b3 locking/atomics: atomic-instrumented: simplify ifdeffery
> date:   6 weeks ago
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bccf1ec369ac126b0997d01a6e1deae00e2cf6b3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout bccf1ec369ac126b0997d01a6e1deae00e2cf6b3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/atomic.h:80,
>                     from drivers/iommu/io-pgtable-arm.c:12:
>    drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
> >> include/linux/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
>       60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
>          |                                ^~~~~~~~~~~~~~
>    include/asm-generic/atomic-instrumented.h:1261:2: note: in expansion of macro 'arch_cmpxchg64_relaxed'
>     1261 |  arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>          |  ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/iommu/io-pgtable-arm.c:320:8: note: in expansion of macro 'cmpxchg64_relaxed'
>      320 |  old = cmpxchg64_relaxed(ptep, curr, new);
>          |        ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +60 include/linux/atomic-arch-fallback.h
> 
> 37f8173dd84936 Peter Zijlstra 2020-01-24  56  
> 37f8173dd84936 Peter Zijlstra 2020-01-24  57  #ifndef arch_cmpxchg64_relaxed
> 37f8173dd84936 Peter Zijlstra 2020-01-24  58  #define arch_cmpxchg64_acquire arch_cmpxchg64
> 37f8173dd84936 Peter Zijlstra 2020-01-24  59  #define arch_cmpxchg64_release arch_cmpxchg64
> 29f006fdefe6f8 Peter Zijlstra 2020-08-29 @60  #define arch_cmpxchg64_relaxed arch_cmpxchg64
> 37f8173dd84936 Peter Zijlstra 2020-01-24  61  #else /* arch_cmpxchg64_relaxed */
> 37f8173dd84936 Peter Zijlstra 2020-01-24  62  
> 
> :::::: The code at line 60 was first introduced by commit
> :::::: 29f006fdefe6f88abde973a0b0f20d2704e93fd4 asm-generic/atomic: Add try_cmpxchg() fallbacks
> 
> :::::: TO: Peter Zijlstra <peterz@infradead.org>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


