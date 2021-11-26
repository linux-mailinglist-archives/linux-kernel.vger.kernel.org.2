Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD43245EDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbhKZM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:29:05 -0500
Received: from foss.arm.com ([217.140.110.172]:33220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237112AbhKZM1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:27:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05AE711D4;
        Fri, 26 Nov 2021 04:23:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.34.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B7003F66F;
        Fri, 26 Nov 2021 04:23:50 -0800 (PST)
Date:   Fri, 26 Nov 2021 12:23:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [mark:arm64/stacktrace/arch-stack-walk 9/11]
 arch/arm64/kernel/time.c:49:9: error: implicit declaration of function
 'arch_stack_walk'
Message-ID: <YaDR1MXFkwFYEwHU@FVFF77S0Q05N>
References: <202111241909.UDKmhCqg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111241909.UDKmhCqg-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 07:37:58PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/arch-stack-walk
> head:   e982ef8a4c9b8bc2f92b7cdafbae70aa31b679d1
> commit: 36fa81ac0d771ba0080197745a39dbe94562c615 [9/11] arm64: Make profile_pc() use arch_stack_walk()
> config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20211124/202111241909.UDKmhCqg-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=36fa81ac0d771ba0080197745a39dbe94562c615
>         git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>         git fetch --no-tags mark arm64/stacktrace/arch-stack-walk
>         git checkout 36fa81ac0d771ba0080197745a39dbe94562c615
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm64/kernel/time.c: In function 'profile_pc':
> >> arch/arm64/kernel/time.c:49:9: error: implicit declaration of function 'arch_stack_walk' [-Werror=implicit-function-declaration]
>       49 |         arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
>          |         ^~~~~~~~~~~~~~~
>    arch/arm64/kernel/time.c: At top level:
>    arch/arm64/kernel/time.c:55:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
>       55 | void __init time_init(void)
>          |             ^~~~~~~~~
>    cc1: some warnings being treated as errors

The problem here is that arch_stack_walk() is defined in <linux/stacktrace.h>,
but we only include <asm/stacktrace.h>.

The same is true for other files in arm64, but we happen to get a transitive
include of <linux/stacktrace.h> by chance; I'll go fix the whole series...

Thanks,
Mark.
