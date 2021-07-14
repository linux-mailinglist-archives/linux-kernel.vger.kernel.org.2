Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531773C91C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbhGNUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:07:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240317AbhGNT6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:58:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9375FD6E;
        Wed, 14 Jul 2021 12:55:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE00E3F774;
        Wed, 14 Jul 2021 12:55:41 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:55:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [peterz-queue:locking/core 21/21] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x253ac): Section mismatch in reference from the
 function __set_bit() to the variable .init.data:initcall_level_names
Message-ID: <20210714195538.GC28555@C02TD0UTHF1T.local>
References: <202107140904.leaDN2j0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107140904.leaDN2j0-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 14, 2021 at 09:08:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> head:   ceb71d863ae0bfca14303c189bbf5903a02ff95a
> commit: ceb71d863ae0bfca14303c189bbf5903a02ff95a [21/21] locking/atomic: add generic arch_*() bitops
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=ceb71d863ae0bfca14303c189bbf5903a02ff95a
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue locking/core
>         git checkout ceb71d863ae0bfca14303c189bbf5903a02ff95a
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text.unlikely+0x253ac): Section mismatch in reference from the function __set_bit() to the variable .init.data:initcall_level_names
> The function __set_bit() references
> the variable __initdata initcall_level_names.

I can reproduce this with the kernel.org cross toolchain:

https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/9.3.0/x86_64-gcc-9.3.0-nolibc-xtensa-linux.tar.gz

... but the warning looks to be bogus; __set_bit() doesn't use that
symbol, and where that symbol is defined it looks to be used safely.

On the prior commit there was a similarly bogus warning in place of this
one:

| WARNING: modpost: vmlinux.o(.text.unlikely+0x24a10): Section mismatch in reference from the function bfq_pos_tree_add_move() to the variable .init.data:initcall_level_names
| The function bfq_pos_tree_add_move() references
| the variable __initdata initcall_level_names.
| This is often because bfq_pos_tree_add_move lacks a __initdata
| annotation or the annotation of initcall_level_names is wrong.

... so I think there is a latent bug here with the section mismatch
warning, and this commit has simply changed the bogus symbol it reports.

Given that, I think we should ignore this.

Thanks,
Mark.
