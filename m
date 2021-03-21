Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F94343623
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCVBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:10:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:27902 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhCVBKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:10:25 -0400
IronPort-SDR: 55UUZsv09CsPedOutbj3PoCAAU9G+D8a1cuUV9TGZJ5Jy8ytlXl9N/pPdpTUfCFMUFOu9/O3m1
 lc8+YJIXB8JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="187852293"
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="gz'50?scan'50,208,50";a="187852293"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 18:10:24 -0700
IronPort-SDR: 70ykWbe3ezubTAoEJzvCnRkYjtUBaLgBpxhqdPYuEVCIPdiySwn7rdgjUn54C2ROGeozNUNBp3
 aQN0ZpJLDobA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,266,1610438400"; 
   d="gz'50?scan'50,208,50";a="380815333"
Received: from lkp-server01.sh.intel.com (HELO cf98f15ee95b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Mar 2021 18:10:22 -0700
Received: from kbuild by cf98f15ee95b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lO95J-000072-IH; Mon, 22 Mar 2021 01:10:21 +0000
Date:   Sun, 21 Mar 2021 19:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/signal_32.c:484:54: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202103211900.qscC7IgK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   812da4d39463a060738008a46cfc9f775e4bfcf6
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   7 months ago
config: sh-randconfig-s031-20210321 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-277-gc089cd2d-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/signal_32.c:484:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/signal_32.c:484:54: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/signal_32.c:484:54: sparse:     got unsigned long
   arch/sh/kernel/signal_32.c:486:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/signal_32.c:486:54: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/signal_32.c:486:54: sparse:     got unsigned long
   arch/sh/kernel/signal_32.c:424:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/signal_32.c:424:54: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/signal_32.c:424:54: sparse:     got unsigned long
--
>> arch/sh/kernel/traps.c:138:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/traps.c:138:38: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/traps.c:138:38: sparse:     got unsigned long
   arch/sh/kernel/traps.c:155:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/traps.c:155:38: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/traps.c:155:38: sparse:     got unsigned long
--
>> arch/sh/mm/cache-sh2a.c:43:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/cache-sh2a.c:43:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2a.c:43:9: sparse:     got unsigned long
>> arch/sh/mm/cache-sh2a.c:136:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2a.c:136:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2a.c:136:17: sparse:     got unsigned int
>> arch/sh/mm/cache-sh2a.c:136:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2a.c:136:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2a.c:136:17: sparse:     got unsigned int
   arch/sh/mm/cache-sh2a.c:170:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2a.c:170:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2a.c:170:17: sparse:     got unsigned int
   arch/sh/mm/cache-sh2a.c:170:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2a.c:170:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2a.c:170:17: sparse:     got unsigned int
--
   kernel/futex.c:1993:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr1 @@
   kernel/futex.c:1993:31: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:1993:31: sparse:     got unsigned int [noderef] [usertype] __user *uaddr1
>> kernel/futex.c:1993:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:1993:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:1993:31: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:2647:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:2647:23: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:2647:23: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:2647:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:2647:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:2647:23: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:2955:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:2955:13: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:2955:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:2955:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:2955:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:2955:13: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:3428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:3428:13: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:3428:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:3428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:3428:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3428:13: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:3566:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   kernel/futex.c:3566:13: sparse:     expected long const *__gu_addr
   kernel/futex.c:3566:13: sparse:     got long [noderef] __user *
>> kernel/futex.c:3566:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   kernel/futex.c:3566:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3566:13: sparse:     got long const *__gu_addr
   kernel/futex.c: note: in included file (through arch/sh/include/asm/futex.h):
   arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:1544:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex.c: note: in included file:
   arch/sh/include/asm/futex.h:36:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex.h:36:23: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex.h:36:23: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex.h:36:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex.h:36:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex.h:36:23: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c: note: in included file (through arch/sh/include/asm/futex.h):
   arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:1708:25: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex.c:1990:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
   kernel/futex.c:2453:9: sparse: sparse: context imbalance in 'fixup_pi_state_owner' - unexpected unlock
   kernel/futex.c:2561:13: sparse: sparse: context imbalance in 'futex_wait_queue_me' - unexpected unlock
   kernel/futex.c:2662:9: sparse: sparse: context imbalance in 'futex_wait_setup' - different lock contexts for basic block
   kernel/futex.c:2943:12: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
   kernel/futex.c:3218:29: sparse: sparse: context imbalance in 'futex_wait_requeue_pi' - unexpected unlock
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
--
>> arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:27:26: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:36:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:46:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7201.c:56:21: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7201.c:414:9: sparse:     got unsigned int
--
   fs/aio.c:589:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:589:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:589:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:756:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kioctx_cpu *cpu @@     got struct kioctx_cpu [noderef] __percpu * @@
   fs/aio.c:756:18: sparse:     expected struct kioctx_cpu *cpu
   fs/aio.c:756:18: sparse:     got struct kioctx_cpu [noderef] __percpu *
   fs/aio.c:803:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:803:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:803:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:908:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:908:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:908:16: sparse:     got struct kioctx_cpu *
   fs/aio.c:926:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:926:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:926:16: sparse:     got struct kioctx_cpu *
   fs/aio.c:1055:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   fs/aio.c:1055:13: sparse:     expected unsigned int const *__gu_addr
   fs/aio.c:1055:13: sparse:     got unsigned int [noderef] __user *
>> fs/aio.c:1055:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/aio.c:1055:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1055:13: sparse:     got unsigned int const *__gu_addr
   fs/aio.c:1318:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *ctxp @@
   fs/aio.c:1318:15: sparse:     expected unsigned long const *__gu_addr
   fs/aio.c:1318:15: sparse:     got unsigned long [noderef] [usertype] __user *ctxp
>> fs/aio.c:1318:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   fs/aio.c:1318:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1318:15: sparse:     got unsigned long const *__gu_addr
   fs/aio.c:1939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct iocb [noderef] __user *const *__gu_addr @@     got struct iocb [noderef] __user *[noderef] __user * @@
   fs/aio.c:1939:21: sparse:     expected struct iocb [noderef] __user *const *__gu_addr
   fs/aio.c:1939:21: sparse:     got struct iocb [noderef] __user *[noderef] __user *
>> fs/aio.c:1939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct iocb [noderef] __user *const *__gu_addr @@
   fs/aio.c:1939:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1939:21: sparse:     got struct iocb [noderef] __user *const *__gu_addr
   fs/aio.c:2017:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   fs/aio.c:2017:13: sparse:     expected unsigned int const *__gu_addr
   fs/aio.c:2017:13: sparse:     got unsigned int [noderef] __user *
   fs/aio.c:2017:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/aio.c:2017:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:2017:13: sparse:     got unsigned int const *__gu_addr
--
   kernel/sched/core.c:610:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:610:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:610:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1697:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1697:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:1697:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1697:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1697:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:1697:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3987:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3987:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:3987:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4420:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4420:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:4420:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4879:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4879:17: sparse:    struct task_struct *
   kernel/sched/core.c:4879:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5079:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:5079:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5079:22: sparse:    struct task_struct *
   kernel/sched/core.c:5623:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   kernel/sched/core.c:5623:15: sparse:     expected unsigned int const *__gu_addr
   kernel/sched/core.c:5623:15: sparse:     got unsigned int [noderef] __user *
>> kernel/sched/core.c:5623:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/sched/core.c:5623:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:5623:15: sparse:     got unsigned int const *__gu_addr
   kernel/sched/core.c:8437:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8437:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:8437:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1688:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1689:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1690:37: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1688:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1833:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1833:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1688:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1833:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1839:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1688:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1833:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1839:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1688:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1833:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1833:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1839:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1839:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1688:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1688:25: sparse:    struct task_struct *
--
   ipc/msg.c:958:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   ipc/msg.c:958:13: sparse:     expected long const *__gu_addr
   ipc/msg.c:958:13: sparse:     got long [noderef] __user *
>> ipc/msg.c:958:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   ipc/msg.c:958:13: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/msg.c:958:13: sparse:     got long const *__gu_addr
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
   drivers/firewire/core-cdev.c:1088:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/firewire/core-cdev.c:1088:21: sparse:     expected unsigned int const *__gu_addr
   drivers/firewire/core-cdev.c:1088:21: sparse:     got unsigned int [noderef] __user *
>> drivers/firewire/core-cdev.c:1088:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/firewire/core-cdev.c:1088:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firewire/core-cdev.c:1088:21: sparse:     got unsigned int const *__gu_addr
--
   sound/core/control.c:776:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:776:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:796:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1462:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1565:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ptr @@
   sound/core/control.c:1565:13: sparse:     expected int const *__gu_addr
   sound/core/control.c:1565:13: sparse:     got int [noderef] __user *ptr
>> sound/core/control.c:1565:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/control.c:1565:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1565:13: sparse:     got int const *__gu_addr
--
   sound/core/pcm.c:92:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:92:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:92:29: sparse:     got int [noderef] __user *
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:92:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:92:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:112:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm.c:112:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:112:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:112:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:114:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:114:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:114:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:114:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm.c:119:29: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:119:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:119:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:155:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:155:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:155:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:155:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:999:9: sparse: sparse: context imbalance in 'snd_pcm_detach_substream' - different lock contexts for basic block
--
   sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1010:20: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:1010:20: sparse:     got unsigned int [noderef] [usertype] __user *
>> sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:1010:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1010:20: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1036:20: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int [noderef] [usertype] __user *
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:1036:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:2944:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:2944:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:2944:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:2944:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3037:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3037:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3038:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3038:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3039:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_arg @@
   sound/core/pcm_native.c:3087:13: sparse:     expected int const *__gu_addr
   sound/core/pcm_native.c:3087:13: sparse:     got int [noderef] __user *_arg
>> sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm_native.c:3087:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3087:13: sparse:     got int const *__gu_addr
   sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3153:13: sparse:     expected unsigned long const *__gu_addr
   sound/core/pcm_native.c:3153:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
>> sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3153:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3153:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3169:13: sparse:     expected unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3169:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3203:21: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3203:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:188:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1186:52: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1257:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
   sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:654:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/rawmidi.c:654:13: sparse:     got unsigned int [noderef] __user *
>> sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/rawmidi.c:654:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:654:13: sparse:     got unsigned int const *__gu_addr
   sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:656:13: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:656:13: sparse:     got int [noderef] __user *
>> sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:656:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:656:13: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:658:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int [noderef] __user *
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/rawmidi.c:658:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:836:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:836:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:836:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:874:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:874:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:874:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:889:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:889:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:889:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:923:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:923:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:923:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:945:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:945:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:945:21: sparse:     got int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int [noderef] __user *arg
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int [noderef] __user *p
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int const *__gu_addr
--
   drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:683:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int [noderef] __user *
>> drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:683:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:781:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:781:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:782:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:782:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/tty/tty_io.c:2189:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/tty_io.c:2189:13: sparse:     expected char const *__gu_addr
   drivers/tty/tty_io.c:2189:13: sparse:     got char [noderef] __user *p
>> drivers/tty/tty_io.c:2189:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/tty_io.c:2189:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2189:13: sparse:     got char const *__gu_addr
   drivers/tty/tty_io.c:2330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/tty/tty_io.c:2330:13: sparse:     expected int const *__gu_addr
   drivers/tty/tty_io.c:2330:13: sparse:     got int [noderef] __user *p
>> drivers/tty/tty_io.c:2330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/tty_io.c:2330:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2330:13: sparse:     got int const *__gu_addr
   drivers/tty/tty_io.c:2448:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user *p @@
   drivers/tty/tty_io.c:2448:18: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/tty_io.c:2448:18: sparse:     got unsigned int [noderef] __user *p
>> drivers/tty/tty_io.c:2448:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/tty_io.c:2448:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2448:18: sparse:     got unsigned int const *__gu_addr
--
   drivers/tty/tty_jobctrl.c:77:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:77:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:77:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:80:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:120:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:120:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:120:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:122:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:122:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:122:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:131:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:131:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:131:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:152:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:152:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:152:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:161:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:161:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:163:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:163:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:163:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:200:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:200:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:200:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:208:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:208:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:208:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:219:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:219:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:219:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:281:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:281:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:281:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:284:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:284:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:284:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:293:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:293:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:293:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:309:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:309:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:309:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:484:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] [usertype] __user *p @@
   drivers/tty/tty_jobctrl.c:484:13: sparse:     expected int const *__gu_addr
   drivers/tty/tty_jobctrl.c:484:13: sparse:     got int [noderef] [usertype] __user *p
>> drivers/tty/tty_jobctrl.c:484:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/tty_jobctrl.c:484:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:484:13: sparse:     got int const *__gu_addr
   drivers/tty/tty_jobctrl.c:18:41: sparse: sparse: dereference of noderef expression
--
   drivers/tty/pty.c:163:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:163:13: sparse:     expected int const *__gu_addr
   drivers/tty/pty.c:163:13: sparse:     got int [noderef] __user *arg
>> drivers/tty/pty.c:163:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/pty.c:163:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:163:13: sparse:     got int const *__gu_addr
   drivers/tty/pty.c:183:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:183:13: sparse:     expected int const *__gu_addr
   drivers/tty/pty.c:183:13: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:183:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/pty.c:183:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:183:13: sparse:     got int const *__gu_addr
--
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file (through arch/sh/include/cpu-sh2a/cpu/watchdog.h, arch/sh/include/asm/watchdog.h):
>> arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     got unsigned int
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
--
   kernel/trace/trace.c:1450:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1450:15: sparse:     expected char const *__gu_addr
   kernel/trace/trace.c:1450:15: sparse:     got char const [noderef] __user *
>> kernel/trace/trace.c:1450:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/trace/trace.c:1450:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1450:15: sparse:     got char const *__gu_addr
   kernel/trace/trace.c:1464:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1464:31: sparse:     expected char const *__gu_addr
   kernel/trace/trace.c:1464:31: sparse:     got char const [noderef] __user *
   kernel/trace/trace.c:1464:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/trace/trace.c:1464:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1464:31: sparse:     got char const *__gu_addr
   kernel/trace/trace.c:1489:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1489:23: sparse:     expected char const *__gu_addr
   kernel/trace/trace.c:1489:23: sparse:     got char const [noderef] __user *
   kernel/trace/trace.c:1489:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/trace/trace.c:1489:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1489:23: sparse:     got char const *__gu_addr
   kernel/trace/trace.c:2649:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2649:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2649:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:2846:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:2846:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:2846:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:2860:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:2860:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:2860:33: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:3108:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct trace_buffer_struct * @@
   kernel/trace/trace.c:3108:46: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3108:46: sparse:     got struct trace_buffer_struct *
   kernel/trace/trace.c:3124:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/trace/trace.c:3124:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3124:9: sparse:     got int *
   kernel/trace/trace.c:3124:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/trace/trace.c:3124:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3124:9: sparse:     got int *
   kernel/trace/trace.c:3124:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/trace/trace.c:3124:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3124:9: sparse:     got int *
   kernel/trace/trace.c:3124:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/trace/trace.c:3124:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3124:9: sparse:     got int *
   kernel/trace/trace.c:3124:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/trace/trace.c:3124:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace.c:3124:9: sparse:     got int *
   kernel/trace/trace.c:3134:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_buffer_struct *buffers @@     got struct trace_buffer_struct [noderef] __percpu * @@
   kernel/trace/trace.c:3134:17: sparse:     expected struct trace_buffer_struct *buffers
   kernel/trace/trace.c:3134:17: sparse:     got struct trace_buffer_struct [noderef] __percpu *
   kernel/trace/trace.c: note: in included file:
   kernel/trace/trace.h:1499:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.h:1499:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.h:1499:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:2798:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:2798:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:2798:9: sparse:    struct trace_export *
   kernel/trace/trace.c:2813:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:2813:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:2813:9: sparse:    struct trace_export *
--
   fs/fuse/dev.c:2231:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/fuse/dev.c:2231:22: sparse:     expected unsigned int const *__gu_addr
   fs/fuse/dev.c:2231:22: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/fuse/dev.c:2231:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/fuse/dev.c:2231:22: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fuse/dev.c:2231:22: sparse:     got unsigned int const *__gu_addr
--
   fs/orangefs/file.c:118:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_write @@     got restricted fmode_t @@
   fs/orangefs/file.c:118:32: sparse:     expected int open_for_write
   fs/orangefs/file.c:118:32: sparse:     got restricted fmode_t
   fs/orangefs/file.c:119:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_read @@     got restricted fmode_t @@
   fs/orangefs/file.c:119:31: sparse:     expected int open_for_read
   fs/orangefs/file.c:119:31: sparse:     got restricted fmode_t
   fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/orangefs/file.c:424:21: sparse:     expected int const *__gu_addr
   fs/orangefs/file.c:424:21: sparse:     got int [noderef] __user *
>> fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/orangefs/file.c:424:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/file.c:424:21: sparse:     got int const *__gu_addr
--
   kernel/events/core.c:578:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
   kernel/events/core.c:1461:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1461:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1461:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1474:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1474:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1474:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3372:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3372:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3372:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3373:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3373:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3373:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3415:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3415:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3415:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3416:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3416:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3416:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4533:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4533:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4533:25: sparse:    struct perf_event_context *
   kernel/events/core.c:5793:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5793:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5793:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5269:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
   kernel/events/core.c:11340:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
>> kernel/events/core.c:11340:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/events/core.c:5499:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5499:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5499:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5635:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5635:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5635:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5668:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5668:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5668:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5725:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5725:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5811:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5811:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5811:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5824:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5824:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5824:14: sparse:    struct perf_buffer *
   kernel/events/core.c:6506:6: sparse: sparse: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?
   kernel/events/core.c:7321:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7321:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7321:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7412:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7412:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7412:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7517:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7517:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7517:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7519:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7519:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7519:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8206:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8206:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8206:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9169:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9169:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9169:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9208:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9208:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9208:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9389:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9389:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:9389:23: sparse:    struct perf_event_context *
   kernel/events/core.c:10576:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12312:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12312:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12312:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12422:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12422:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12422:17: sparse:    struct perf_event_context *
   kernel/events/core.c:12845:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12845:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:12845:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:162:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:170:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:686:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1508:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2800:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4505:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:197:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *src @@
   kernel/events/core.c:9018:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9018:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9018:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9038:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9038:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9038:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9158:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9158:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9158:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9158:16: sparse:    struct swevent_hlist *

vim +484 arch/sh/kernel/signal_32.c

9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  446  
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  447  /*
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  448   * Note that 'init' is a special process: it doesn't get signals it doesn't
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  449   * want to handle. Thus you cannot kill init even with a SIGKILL even by
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  450   * mistake.
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  451   *
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  452   * Note that we go through the signals twice: once to check the signals that
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  453   * the kernel can handle, and then we build all the user-level signal handling
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  454   * stack-frames in one go after that.
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  455   */
9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  456  static void do_signal(struct pt_regs *regs, unsigned int save_r0)
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  457  {
b46e848768acc4 arch/sh/kernel/signal_32.c Richard Weinberger 2013-10-07  458  	struct ksignal ksig;
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  459  
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  460  	/*
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  461  	 * We want the common case to go fast, which
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  462  	 * is why we may in certain cases get here from
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  463  	 * kernel mode. Just return without doing anything
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  464  	 * if so.
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  465  	 */
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  466  	if (!user_mode(regs))
9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  467  		return;
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  468  
b46e848768acc4 arch/sh/kernel/signal_32.c Richard Weinberger 2013-10-07  469  	if (get_signal(&ksig)) {
b46e848768acc4 arch/sh/kernel/signal_32.c Richard Weinberger 2013-10-07  470  		handle_syscall_restart(save_r0, regs, &ksig.ka.sa);
f8b890ab4ca60c arch/sh/kernel/signal_32.c Paul Mundt         2008-09-12  471  
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  472  		/* Whee!  Actually deliver the signal.  */
b46e848768acc4 arch/sh/kernel/signal_32.c Richard Weinberger 2013-10-07  473  		handle_signal(&ksig, regs, save_r0);
c8bfa1fdc84af7 arch/sh/kernel/signal.c    Ryusuke Sakato     2007-02-23  474  		return;
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  475  	}
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  476  
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  477  	/* Did we come from a system call? */
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  478  	if (regs->tra >= 0) {
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  479  		/* Restart the system call - no handlers present */
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  480  		if (regs->regs[0] == -ERESTARTNOHAND ||
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  481  		    regs->regs[0] == -ERESTARTSYS ||
0b8929354cdedd arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  482  		    regs->regs[0] == -ERESTARTNOINTR) {
0b8929354cdedd arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  483  			regs->regs[0] = save_r0;
9d56dd3b083a3b arch/sh/kernel/signal_32.c Paul Mundt         2010-01-26 @484  			regs->pc -= instruction_size(__raw_readw(regs->pc - 4));
0b8929354cdedd arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  485  		} else if (regs->regs[0] == -ERESTART_RESTARTBLOCK) {
9d56dd3b083a3b arch/sh/kernel/signal_32.c Paul Mundt         2010-01-26  486  			regs->pc -= instruction_size(__raw_readw(regs->pc - 4));
0b8929354cdedd arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  487  			regs->regs[3] = __NR_restart_syscall;
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  488  		}
^1da177e4c3f41 arch/sh/kernel/signal.c    Linus Torvalds     2005-04-16  489  	}
9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  490  
56bfc42f6cba3e arch/sh/kernel/signal_32.c Paul Mundt         2009-10-14  491  	/*
56bfc42f6cba3e arch/sh/kernel/signal_32.c Paul Mundt         2009-10-14  492  	 * If there's no signal to deliver, we just put the saved sigmask
56bfc42f6cba3e arch/sh/kernel/signal_32.c Paul Mundt         2009-10-14  493  	 * back.
56bfc42f6cba3e arch/sh/kernel/signal_32.c Paul Mundt         2009-10-14  494  	 */
51a7b448d4134e arch/sh/kernel/signal_32.c Al Viro            2012-05-21  495  	restore_saved_sigmask();
9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  496  }
9f23e7e94f7083 arch/sh/kernel/signal.c    Paul Mundt         2006-09-27  497  

:::::: The code at line 484 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--KsGdsel6WgEHnImy--
