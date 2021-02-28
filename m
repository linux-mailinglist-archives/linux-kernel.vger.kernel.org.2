Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961AD327052
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 06:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhB1FGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 00:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhB1FGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:06:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A5A64DE5;
        Sun, 28 Feb 2021 05:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614488726;
        bh=0PhQHrTVWy8EOWak0zCV/vRS98kEATx24AyepPCBNEQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qde+1oUcHZgyG2MDxeziYyTSIMcGgmfp88hiRs+6GDyJ0W9uVA1UjxPd5qsh4hoD4
         VDis9wYbZV/Pe5qZs3RTPX6pAPPw6GV/wfO/1RiHDWo4/gHRzwbFsLyulJyssc9FK/
         oSdQecynA1knrwgXRjICHITavmv11YutXn5aRaNkMpC5f6pM84yGpLWjrLNwKNcW06
         muFa+DkJHQ25bk4vsm5IomigGqJNDWhLqqRgmPALpa9eRQRmi+MWP+DiYy4fF5V2Kr
         DY+qiqgynqkO2OitlU7YfM7Py1NiiKGXdUnUmGjx0t1svqr7RpFgKHC54RMRn2QevM
         v1C7uV1bw1/Jg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0B1DB35239CF; Sat, 27 Feb 2021 21:05:26 -0800 (PST)
Date:   Sat, 27 Feb 2021 21:05:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot
 reach schedule_timeout_uninterruptible
Message-ID: <20210228050526.GD2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202102281205.3F9aEA0G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102281205.3F9aEA0G-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 12:08:08PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5695e51619745d4fe3ec2506a2f0cd982c5e27a4
> commit: 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f refperf: Rename refperf.c to refscale.c and change internal names
> date:   8 months ago
> config: parisc-randconfig-s031-20210228 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-241-geaceeafa-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

I must confess that I have no idea what I can do about these errors.

Did the kernel maybe grow larger than can be handled by the PA-RISC
toolchain?

							Thanx, Paul

>    hppa64-linux-ld: init/main.o(.init.text+0xdd8): cannot reach rest_init
>    init/main.o: in function `arch_call_rest_init':
>    (.init.text+0xdd8): relocation truncated to fit: R_PARISC_PCREL22F against symbol `rest_init' defined in .ref.text section in init/main.o
>    hppa64-linux-ld: init/main.o(.init.text+0x13d8): cannot reach build_all_zonelists
>    init/main.o: in function `start_kernel':
>    (.init.text+0x13d8): relocation truncated to fit: R_PARISC_PCREL22F against symbol `build_all_zonelists' defined in .ref.text section in mm/page_alloc.o
>    hppa64-linux-ld: init/main.o(.init.text+0x176c): cannot reach profile_init
>    (.init.text+0x176c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `profile_init' defined in .ref.text section in kernel/profile.o
>    hppa64-linux-ld: init/main.o(.init.text+0x1ac0): cannot reach wait_for_completion
>    init/main.o: in function `kernel_init_freeable':
>    (.init.text+0x1ac0): relocation truncated to fit: R_PARISC_PCREL22F against symbol `wait_for_completion' defined in .sched.text section in kernel/sched/completion.o
>    hppa64-linux-ld: init/main.o(.ref.text+0x1c): cannot reach rcu_scheduler_starting
>    init/main.o: in function `rest_init':
>    (.ref.text+0x1c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `rcu_scheduler_starting' defined in .init.text section in kernel/rcu/srcutiny.o
>    hppa64-linux-ld: init/main.o(.ref.text+0x17c): cannot reach unknown
>    init/main.o: in function `kernel_init':
>    (.ref.text+0x17c): relocation truncated to fit: R_PARISC_PCREL22F against `kernel_init_freeable'
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x78): cannot reach unknown
>    arch/parisc/mm/init.o: in function `free_initmem':
>    (.ref.text+0x78): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xa0): cannot reach unknown
>    (.ref.text+0xa0): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>    hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xc4): cannot reach unknown
>    (.ref.text+0xc4): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>    hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x768): cannot reach _raw_spin_lock
>    kernel/printk/printk.o: in function `setup_log_buf':
>    (.init.text+0x768): relocation truncated to fit: R_PARISC_PCREL22F against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/locking/spinlock.o
>    hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7c4): cannot reach _raw_spin_unlock
>    (.init.text+0x7c4): additional relocation overflows omitted from the output
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x228): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x440): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x7a0): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x878): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xad4): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xafc): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/resource.o(.init.text+0x32c): cannot reach _raw_write_lock
>    hppa64-linux-ld: kernel/resource.o(.init.text+0x4f8): cannot reach _raw_write_unlock
>    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1b8): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x208): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/workqueue.o(.init.text+0xa8): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/workqueue.o(.init.text+0x128): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/workqueue.o(.init.text+0x354): cannot reach mutex_lock
>    hppa64-linux-ld: kernel/workqueue.o(.init.text+0x388): cannot reach mutex_unlock
>    hppa64-linux-ld: kernel/user.o(.init.text+0x80): cannot reach _raw_spin_lock_irq
>    hppa64-linux-ld: kernel/user.o(.init.text+0xb8): cannot reach _raw_spin_unlock_irq
> >> hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot reach schedule_timeout_uninterruptible
>    hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x228): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x320): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x170): cannot reach __muldi3
>    hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x214): cannot reach __udivdi3
>    hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x240): cannot reach __udivdi3
>    hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2d4): cannot reach __muldi3
>    hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2ec): cannot reach __udivdi3
>    hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3d4): cannot reach __muldi3
>    hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3ec): cannot reach __udivdi3
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0xe8): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x170): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x288): cannot reach _raw_spin_unlock_irqrestore
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x30c): cannot reach _raw_spin_lock_irqsave
>    hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3d8): cannot reach _raw_spin_unlock_irqrestore
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


