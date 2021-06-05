Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF839CAC9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 21:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFETq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 15:46:59 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33860 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFETq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 15:46:57 -0400
Date:   Sat, 5 Jun 2021 22:45:06 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: hppa64-linux-ld: kernel/sched/psi.o(.text+0x730): cannot reach
 mutex_unlock
Message-ID: <20210605194506.qad6cxyrv72pqtcq@mobilestation>
References: <202106051133.syZ3wwK0-lkp@intel.com>
 <CAHp75VfFVBhNqe4W4fuTUmPVejpxEf0VRpFdJt1xSvLgXWs_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VfFVBhNqe4W4fuTUmPVejpxEf0VRpFdJt1xSvLgXWs_kg@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 12:37:13PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 5, 2021 at 6:02 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   ff6091075a687676d76b3beb24fa77389b387b00
> 
> > commit: 06cfadb8c51b05c6b91c2d43e0fe72b3d643dced spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
> 
> How is this relevant?

The same question popped up in my mind.)

> 
> > date:   1 year ago
> > config: parisc-randconfig-r003-20210605 (attached as .config)
> > compiler: hppa64-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06cfadb8c51b05c6b91c2d43e0fe72b3d643dced
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 06cfadb8c51b05c6b91c2d43e0fe72b3d643dced
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x261c): cannot reach _raw_spin_lock_irq
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x270c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x282c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2840): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x287c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2960): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2a38): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2dd4): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2eac): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2f10): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2f40): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2f70): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2fa4): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x2fec): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3100): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x31e0): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3210): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3240): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3274): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x32bc): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3590): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x35c0): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x35f0): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3624): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x366c): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3a98): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3ac8): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3af8): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3b2c): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3b74): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3cfc): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3d2c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3d5c): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3d90): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x3dd8): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4284): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x42b4): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x42e4): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4318): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4360): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x43d8): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x440c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x443c): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4470): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x44b8): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4850): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4884): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x48b4): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x48e8): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4930): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4ad4): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4b04): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4b34): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4b68): cannot reach $$mulI
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4bb0): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4d24): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4d44): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4eec): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4f40): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4f58): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x4f90): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x55b4): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x55d4): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5624): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5654): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x57c8): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5b28): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5b48): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5b6c): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5b84): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5cc8): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x5cf0): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x60ac): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x60c8): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6150): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6294): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x62ac): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6320): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x64d8): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x65e4): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6644): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6688): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x66c0): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6724): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x67a0): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x67e0): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x68a4): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6a04): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6c8c): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6d50): cannot reach _raw_spin_trylock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6d8c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x6de8): cannot reach __muldi3
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x7108): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x72b0): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/fair.o(.text+0x7354): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/topology.o(.text+0xb28): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/topology.o(.text+0xd58): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/topology.o(.text+0x2ec8): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/sched/topology.o(.text+0x2ef4): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0x6d4): cannot reach mutex_lock
> > >> hppa64-linux-ld: kernel/sched/psi.o(.text+0x730): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0x934): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0xa00): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0xaa4): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0xd94): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0xe24): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0x109c): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/sched/psi.o(.text+0x1524): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/irq/irqdesc.o(.ref.text+0x17c): cannot reach arch_dynirq_lower_bound
> >    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): cannot reach mutex_unlock
> >    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1c0): cannot reach mutex_lock
> >    hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x210): cannot reach mutex_unlock
> >    hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `serial_init_chip':
> >    (.init.text+0xc4): undefined reference to `iosapic_serial_irq'
> >    hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o(.init.text+0xc4): cannot reach iosapic_serial_irq
> >    hppa64-linux-ld: drivers/input/serio/gscps2.o(.exit.text+0x20): cannot reach unregister_parisc_driver
> >    hppa64-linux-ld: drivers/input/serio/gscps2.o(.exit.text+0xd0): cannot reach iounmap
> >    hppa64-linux-ld: kernel/softirq.o(.text+0x2d8): cannot reach yield
> >    hppa64-linux-ld: kernel/softirq.o(.text+0x520): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/softirq.o(.text+0xbf8): cannot reach __do_softirq
> >    hppa64-linux-ld: kernel/softirq.o(.softirqentry.text+0x26c): cannot reach unknown
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x2c): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x84): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x38c): cannot reach _raw_spin_unlock_irq
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xa28): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xa84): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xb08): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xb30): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xb94): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xbac): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xc80): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xc98): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xe44): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0xe58): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x13e4): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x1438): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x1784): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x17d4): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x17f4): cannot reach schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x18bc): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x1c84): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x1c9c): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x1ce4): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x2068): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x207c): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x2130): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x2148): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x261c): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x262c): cannot reach unknown
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x263c): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x29ac): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x29d8): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3068): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3314): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3334): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x33a0): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x33ec): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x34d4): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3548): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x35f8): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3890): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x38a4): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3a14): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3a2c): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3c00): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3c18): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3c84): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3c98): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3cd0): cannot reach schedule_hrtimeout
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3e50): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3ec8): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3f54): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3f68): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3f90): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x3fa0): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x41dc): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4200): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4364): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x43bc): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x44d0): cannot reach __udivdi3
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4550): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x46d8): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x46ec): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4850): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4b4c): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4bdc): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4c2c): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4cd8): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4cec): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4ec0): cannot reach _raw_spin_lock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x4f44): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x5014): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x5044): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x5068): cannot reach unknown
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x51e4): cannot reach _raw_spin_unlock
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x52b0): cannot reach preempt_schedule
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x63f0): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x6424): cannot reach _raw_spin_unlock_irqrestore
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x68c4): cannot reach _raw_spin_lock_irqsave
> >    hppa64-linux-ld: kernel/sched/core.o(.text+0x68dc): cannot reach _raw_spin_lock
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
