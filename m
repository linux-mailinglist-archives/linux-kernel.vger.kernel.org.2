Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DA32747D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhB1Uxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:53:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:48037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhB1Uxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614545511;
        bh=76V3Udpca0o2cZtD3Q1fIAgn/TuXZJOKraHG0FuanmY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g9ErbFVV8+ZywAMxR58GZqj5J3jyWscqrdr1A7576itYDbbPv9Uwi2+nPSHuSHVFw
         RO/GwCDTFYMVv5m+YwZRpVMHUtPS4hEz4Jl7Hb8AjxA8mOdaok+Ki8oF8Ul+0GirEW
         4MF9YGrgljiUFyldXNUwu8GDUEXHrOOyhOn92P1o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.133.97]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1lmnBj3RDJ-00cx9d; Sun, 28
 Feb 2021 21:51:50 +0100
Subject: Re: hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot
 reach schedule_timeout_uninterruptible
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>,
        linux-parisc <linux-parisc@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel
References: <202102281205.3F9aEA0G-lkp@intel.com>
 <20210228050526.GD2696@paulmck-ThinkPad-P72>
From:   Helge Deller <deller@gmx.de>
Message-ID: <d14b90db-4052-544a-9743-748c653f3ad7@gmx.de>
Date:   Sun, 28 Feb 2021 21:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228050526.GD2696@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DpXbs+5n5XRtrjn6JAAEJ0wVoJaw/DUSw8JCHqQn3ueGdgSkPf/
 fWSTYlRZaJzClO0QRzQy2ohVUxvxVUOZUY/3NpLG7A8Cx1f1vRb2fhWEzvIDDZ2HdtupE3E
 VmuLT68Gw38v6pJ6qKCmlrFzSwBhsWdZ4V/40YldVqn0g9J/RZq+4h1uc0pXAvUxMMhHnKK
 1RVvf0ApR6wUyO4zfht5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WlcdHD5Nk28=:7OnTnPvqLnZlHym7e3WhQX
 qsKBTr4iaAl8ta0hrKK/Tx5lV+11TBGdtgGRugmqPIBreF2EPPh0Gy7al7Xqp/mg46hMdSLEZ
 yPc+xU5KQM9oddoldYrajrOvADUUNrxZwfAx/GprAhkG33F0fKEdVu01FEeiDJFxVRpi7Gt4N
 wE3purdPRG6Xt7YQGNK9fpLhPi78zlkoF4mFPtHoTzgA6p9jkxZza/5nz2YV27rdt/RahfWtt
 ALFiNMJkNsZbiPU3OVz06ffF+N0fEWqP19MEIrJZg7NqVifC7j8U8Efp2PlJWMVwop4tjx2qU
 61HtGet3XCBZisWs6bf4S8UT6ZqqKBnB3LwY11rOBh5FIko7kLbV/YtxRIhBnzLun8+vYbUMg
 5bp+vh3WDGYg5kPJN86cuxwQsOa1wvy22Zv1wNQjMq+z0DFOb2mDf+2YW+wMHT0id86cVuitL
 TcYIVc4Ypm/L1woq8VFOfO7iuV3stCB4obOTajhICsJacMiMjcRQGUiLA+fXz9T6nXBwj6N7x
 W+2vqU2e7CZcyFqY3GvoVWq/4iT9fNjVR1BWg3G9uiYAqohn4YHBraogvNyMDCeDB66SpoiAG
 PHyTWb1WJIActH/ISPUPrGEsXXYBWUZK0fhownDsAjzyy2pLK0BdP6qZ/LnCFEPytBNz4gPhI
 gpGN1VH6ulyX4nz1WAhrPwi6jT5L9U+YmpEAmdnZyF9gmivylVUw3lEpPy3gg4oylbU9mXEDY
 2/LNEvHEvQM/h6rEWkXOncyoIKzyG+63dOaUMqhUZepcg/8FTfD0NHMIYR+/NpBGX0hPNZm5o
 paDa7QrfyDRgqTnzFka8ggg1SQhvnoeGZhlRAFdCxjUc7GC1+vsB8jbp7Sa2KARXyESsrFPq3
 yhYKRe4ovFXDziwozujA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding parisc-parisc mailing list...

On 2/28/21 6:05 AM, Paul E. McKenney wrote:
> On Sun, Feb 28, 2021 at 12:08:08PM +0800, kernel test robot wrote:
>> Hi Paul,
>>
>> First bad commit (maybe !=3D root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
>> head:   5695e51619745d4fe3ec2506a2f0cd982c5e27a4
>> commit: 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f refperf: Rename refper=
f.c to refscale.c and change internal names
>> date:   8 months ago
>> config: parisc-randconfig-s031-20210228 (attached as .config)
>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-241-geaceeafa-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.c=
ross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dparisc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>
> I must confess that I have no idea what I can do about these errors.
>
> Did the kernel maybe grow larger than can be handled by the PA-RISC
> toolchain?

No, I assume it's because the function calls from the .init section are
located too far away from the other code. Reason is probably because
huge pages are selected and thus I tried to pack the init section so that
it can get discarded after bootup.

I'll look into it now...

Helge

>
> 							Thanx, Paul
>
>>     hppa64-linux-ld: init/main.o(.init.text+0xdd8): cannot reach rest_i=
nit
>>     init/main.o: in function `arch_call_rest_init':
>>     (.init.text+0xdd8): relocation truncated to fit: R_PARISC_PCREL22F =
against symbol `rest_init' defined in .ref.text section in init/main.o
>>     hppa64-linux-ld: init/main.o(.init.text+0x13d8): cannot reach build=
_all_zonelists
>>     init/main.o: in function `start_kernel':
>>     (.init.text+0x13d8): relocation truncated to fit: R_PARISC_PCREL22F=
 against symbol `build_all_zonelists' defined in .ref.text section in mm/p=
age_alloc.o
>>     hppa64-linux-ld: init/main.o(.init.text+0x176c): cannot reach profi=
le_init
>>     (.init.text+0x176c): relocation truncated to fit: R_PARISC_PCREL22F=
 against symbol `profile_init' defined in .ref.text section in kernel/prof=
ile.o
>>     hppa64-linux-ld: init/main.o(.init.text+0x1ac0): cannot reach wait_=
for_completion
>>     init/main.o: in function `kernel_init_freeable':
>>     (.init.text+0x1ac0): relocation truncated to fit: R_PARISC_PCREL22F=
 against symbol `wait_for_completion' defined in .sched.text section in ke=
rnel/sched/completion.o
>>     hppa64-linux-ld: init/main.o(.ref.text+0x1c): cannot reach rcu_sche=
duler_starting
>>     init/main.o: in function `rest_init':
>>     (.ref.text+0x1c): relocation truncated to fit: R_PARISC_PCREL22F ag=
ainst symbol `rcu_scheduler_starting' defined in .init.text section in ker=
nel/rcu/srcutiny.o
>>     hppa64-linux-ld: init/main.o(.ref.text+0x17c): cannot reach unknown
>>     init/main.o: in function `kernel_init':
>>     (.ref.text+0x17c): relocation truncated to fit: R_PARISC_PCREL22F a=
gainst `kernel_init_freeable'
>>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x78): cannot reac=
h unknown
>>     arch/parisc/mm/init.o: in function `free_initmem':
>>     (.ref.text+0x78): relocation truncated to fit: R_PARISC_PCREL22F ag=
ainst `map_pages'
>>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xa0): cannot reac=
h unknown
>>     (.ref.text+0xa0): relocation truncated to fit: R_PARISC_PCREL22F ag=
ainst `map_pages'
>>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xc4): cannot reac=
h unknown
>>     (.ref.text+0xc4): relocation truncated to fit: R_PARISC_PCREL22F ag=
ainst `map_pages'
>>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x768): cannot r=
each _raw_spin_lock
>>     kernel/printk/printk.o: in function `setup_log_buf':
>>     (.init.text+0x768): relocation truncated to fit: R_PARISC_PCREL22F =
against symbol `_raw_spin_lock' defined in .spinlock.text section in kerne=
l/locking/spinlock.o
>>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7c4): cannot r=
each _raw_spin_unlock
>>     (.init.text+0x7c4): additional relocation overflows omitted from th=
e output
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x228): cannot r=
each mutex_lock
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x440): cannot r=
each mutex_unlock
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x7a0): cannot r=
each mutex_lock
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x878): cannot r=
each mutex_unlock
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xad4): cannot r=
each mutex_lock
>>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xafc): cannot r=
each mutex_unlock
>>     hppa64-linux-ld: kernel/resource.o(.init.text+0x32c): cannot reach =
_raw_write_lock
>>     hppa64-linux-ld: kernel/resource.o(.init.text+0x4f8): cannot reach =
_raw_write_unlock
>>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): cannot=
 reach mutex_lock
>>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): cannot=
 reach mutex_unlock
>>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1b8): canno=
t reach mutex_lock
>>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x208): canno=
t reach mutex_unlock
>>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0xa8): cannot reach =
mutex_lock
>>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x128): cannot reach=
 mutex_unlock
>>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x354): cannot reach=
 mutex_lock
>>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x388): cannot reach=
 mutex_unlock
>>     hppa64-linux-ld: kernel/user.o(.init.text+0x80): cannot reach _raw_=
spin_lock_irq
>>     hppa64-linux-ld: kernel/user.o(.init.text+0xb8): cannot reach _raw_=
spin_unlock_irq
>>>> hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot reac=
h schedule_timeout_uninterruptible
>>     hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x228): canno=
t reach _raw_spin_lock_irqsave
>>     hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x320): canno=
t reach _raw_spin_unlock_irqrestore
>>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x170): canno=
t reach __muldi3
>>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x214): canno=
t reach __udivdi3
>>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x240): canno=
t reach __udivdi3
>>     hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2d4): cann=
ot reach __muldi3
>>     hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x2ec): cann=
ot reach __udivdi3
>>     hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3d4): cann=
ot reach __muldi3
>>     hppa64-linux-ld: arch/parisc/kernel/cache.o(.init.text+0x3ec): cann=
ot reach __udivdi3
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3c): ca=
nnot reach _raw_spin_lock_irqsave
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0xe8): ca=
nnot reach _raw_spin_unlock_irqrestore
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x170): c=
annot reach _raw_spin_lock_irqsave
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x288): c=
annot reach _raw_spin_unlock_irqrestore
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x30c): c=
annot reach _raw_spin_lock_irqsave
>>     hppa64-linux-ld: arch/parisc/kernel/firmware.o(.init.text+0x3d8): c=
annot reach _raw_spin_unlock_irqrestore
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>

