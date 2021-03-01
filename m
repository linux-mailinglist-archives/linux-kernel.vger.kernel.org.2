Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB51329FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574730AbhCBDtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:49:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:38787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237163AbhCAVgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614634478;
        bh=eBbcE4/VN3KrGiyr/gi3blaQM63oqz38xBAshLMrfeA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O89NNRwfLAEovgTRVXQWB8MPi1o0B/OiCuEF5zxhAvtSUh9Xn5roz6bZdzXSUBQmn
         lufXrE6dQpUbqT6HndegBZDd/OJ5Z6K0ykW5oNqkdsc5KZjj3JmE3+Ed4OGVy4EzPC
         mPYSf7BJWMaxuV6X5OkQNC5eqT9hcOnUjhyakjlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.147.178]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1l36fQ0Ruw-00ExJY; Mon, 01
 Mar 2021 22:34:38 +0100
Subject: Re: hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot
 reach schedule_timeout_uninterruptible
To:     paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102281205.3F9aEA0G-lkp@intel.com>
 <20210228050526.GD2696@paulmck-ThinkPad-P72>
 <d14b90db-4052-544a-9743-748c653f3ad7@gmx.de>
 <20210228223302.GE2696@paulmck-ThinkPad-P72>
From:   Helge Deller <deller@gmx.de>
Message-ID: <f2534985-89f3-1d00-0b72-13cd208d5201@gmx.de>
Date:   Mon, 1 Mar 2021 22:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228223302.GE2696@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LjH39XiikZPMckRhK0W6YNt0B+eiUEH8a7goMBOE9/63uI9NJO4
 INiIed7vDXA5/RFkg4xIbTXmPnd8V+MaNp1PkEaSOped/oYQ2+6nM5VQo0SV7Et0mBKpjXG
 hgYiF+kemqPRWCcyV0t19uzqUaP7RzRA4qNtjLvXFWuZCCS4efI9M+voS/E0TSY9h7MFK+2
 7vQuecN1KF6K8+g4Bt+4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:60ViuUQzcvo=:LIRAUZgx7o3w0JRNzk19aG
 1Hda09xr3UNI9aqXinmP+H+qg2X+JNA+8CRtOp9F/w7YNHWnfrcC50oV9ocf+HlG8X0EmN/4w
 rT44P2UfmkdgjzPcIfPqyYRRW2ZaTreXsrjXpM1QHQUS7khmoRTRalY2G76ndUtCU+0ODopUT
 22v2zJuCWHShM12/wwkxsXzIOkUJHh89RSFFLn2G3ykctFcucF7z2kckN2zDzE/Vu+qcexlOg
 t2tudHVRM+xkDuupWYtR4O9ZiOR58lwRJDPfRybJsorKTfbwc18xTyt7go/f/+XNng76oldTY
 It6Lna3Pkvaw/XDXsS24sd4dHkKJ4ZaXOUhoU5g1f69otYqpREVD96j+hIjub1FFVvxZCS9yy
 /pUPMLK//qTrjGaW9DgxLxR0U9wZTORxHzD3fB7eYh7+U7gfXSDeuQ3jdc77DO1xGvTrCm/Wf
 GTEKtRnPSLP8gHAqUsYl0I8DGREINYqXUuUs48NDzVcbV1AQQRIrB+EtjqrzYc260TgJHfIxw
 p4Ui55+dxR6j06hdhZD5QLI6eYKA0RzCr4PbCT/D4rtz/IlHxEs8TRb9RydC1WCeQCwakcvBk
 mFWQRcWbjSFLtMadYYJ0JzqFYAflZg+bdqMMDh7X7zYGS+VHcV2vYYksqSATxHtDpJve1lDWG
 +7wQjINRJm+5N8mAwgPEKKGCg8keYyHNMX9hW/FTi8hfaf7zmH4HiqJ6QsfFg8CxIDn5BJhWe
 9JM4WyfSmEiWwgsin/qOhD/JOE8giISBNoRnUWKDn1Cud7SHi8xCNCpLy5QCenXnRfKhRHcDC
 L6O4VDDOT9ofjld70DRu0uzD+p2B5RONyGfozskCTtAHMh94jT1QwFVFN0JUwwuc2LqLQ+Dm2
 SUdO1YTLuJ+S4MAC6sLQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/21 11:33 PM, Paul E. McKenney wrote:
> On Sun, Feb 28, 2021 at 09:51:35PM +0100, Helge Deller wrote:
>> Adding parisc-parisc mailing list...
>>
>> On 2/28/21 6:05 AM, Paul E. McKenney wrote:
>>> On Sun, Feb 28, 2021 at 12:08:08PM +0800, kernel test robot wrote:
>>>> Hi Paul,
>>>>
>>>> First bad commit (maybe != root cause):
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   5695e51619745d4fe3ec2506a2f0cd982c5e27a4
>>>> commit: 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f refperf: Rename refperf.c to refscale.c and change internal names
>>>> date:   8 months ago
>>>> config: parisc-randconfig-s031-20210228 (attached as .config)
>>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>>> reproduce:
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # apt-get install sparse
>>>>           # sparse version: v0.6.3-241-geaceeafa-dirty
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>
>>> I must confess that I have no idea what I can do about these errors.
>>>
>>> Did the kernel maybe grow larger than can be handled by the PA-RISC
>>> toolchain?
>>
>> No, I assume it's because the function calls from the .init section are
>> located too far away from the other code. Reason is probably because
>> huge pages are selected and thus I tried to pack the init section so that
>> it can get discarded after bootup.
>>
>> I'll look into it now...

I think the only way to fix this in a clean way is to
enable CONFIG_MLONGCALLS, which lets gcc use -mlong-calls compiler
option and thus creates far calls.

The problem is, that those calls are far more less performant, which one
usually don't want to use in production kernels.
In addition, typical Linux distribution kernels have most
drivers built as modules and as such don't need this option.

One way I can think of to work around that issue is, that if Kconfig detects
that we build a test robot kernel, simply to enable this option.
That way the test robot still builds everything.

Is there a way to detect at compile/build time if the kernel
is configured/built by the test robot? Is there maybe some config option
or environment variable set which could be used?

Maybe someone has another/better idea as well?

Helge


>>>>      hppa64-linux-ld: init/main.o(.init.text+0xdd8): cannot reach rest_init
>>>>      init/main.o: in function `arch_call_rest_init':
>>>>      (.init.text+0xdd8): relocation truncated to fit: R_PARISC_PCREL22F against symbol `rest_init' defined in .ref.text section in init/main.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x13d8): cannot reach build_all_zonelists
>>>>      init/main.o: in function `start_kernel':
>>>>      (.init.text+0x13d8): relocation truncated to fit: R_PARISC_PCREL22F against symbol `build_all_zonelists' defined in .ref.text section in mm/page_alloc.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x176c): cannot reach profile_init
>>>>      (.init.text+0x176c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `profile_init' defined in .ref.text section in kernel/profile.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1ac0): cannot reach wait_for_completion
>>>>      init/main.o: in function `kernel_init_freeable':
>>>>      (.init.text+0x1ac0): relocation truncated to fit: R_PARISC_PCREL22F against symbol `wait_for_completion' defined in .sched.text section in kernel/sched/completion.o
>>>>      hppa64-linux-ld: init/main.o(.ref.text+0x1c): cannot reach rcu_scheduler_starting
>>>>      init/main.o: in function `rest_init':
>>>>      (.ref.text+0x1c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `rcu_scheduler_starting' defined in .init.text section in kernel/rcu/srcutiny.o
>>>>      hppa64-linux-ld: init/main.o(.ref.text+0x17c): cannot reach unknown
>>>>      init/main.o: in function `kernel_init':
>>>>      (.ref.text+0x17c): relocation truncated to fit: R_PARISC_PCREL22F against `kernel_init_freeable'
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x78): cannot reach unknown
>>>>      arch/parisc/mm/init.o: in function `free_initmem':
>>>>      (.ref.text+0x78): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xa0): cannot reach unknown
>>>>      (.ref.text+0xa0): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xc4): cannot reach unknown
>>>>      (.ref.text+0xc4): relocation truncated to fit: R_PARISC_PCREL22F against `map_pages'
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x768): cannot reach _raw_spin_lock
>>>>      kernel/printk/printk.o: in function `setup_log_buf':
>>>>      (.init.text+0x768): relocation truncated to fit: R_PARISC_PCREL22F against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/locking/spinlock.o
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7c4): cannot reach _raw_spin_unlock
>>>>      (.init.text+0x7c4): additional relocation overflows omitted from the output
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x228): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x440): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x7a0): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x878): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xad4): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xafc): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x32c): cannot reach _raw_write_lock
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x4f8): cannot reach _raw_write_unlock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1b8): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x208): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0xa8): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x128): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x354): cannot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x388): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/user.o(.init.text+0x80): cannot reach _raw_spin_lock_irq
>>>>      hppa64-linux-ld: kernel/user.o(.init.text+0xb8): cannot reach _raw_spin_unlock_irq
>>>>>> hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot reach schedule_timeout_uninterruptible
>>>>      hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x228): cannot reach _raw_spin_lock_irqsave
>>>>      hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x320): cannot reach _raw_spin_unlock_irqrestore
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x170): cannot reach __muldi3
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x214): cannot reach __udivdi3
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x240): cannot reach __udivdi3
>>>>      hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2d4): cannot reach __muldi3
>>>>      hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2ec): cannot reach __udivdi3
>>>>      hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3d4): cannot reach __muldi3
>>>>      hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3ec): cannot reach __udivdi3
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3c): cannot reach _raw_spin_lock_irqsave
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0xe8): cannot reach _raw_spin_unlock_irqrestore
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x170): cannot reach _raw_spin_lock_irqsave
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x288): cannot reach _raw_spin_unlock_irqrestore
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x30c): cannot reach _raw_spin_lock_irqsave
>>>>      hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3d8): cannot reach _raw_spin_unlock_irqrestore
>>>>
>>>> ---
>>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>>>
>>>
>>

