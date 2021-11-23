Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D545A346
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhKWMxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:53:37 -0500
Received: from first.geanix.com ([116.203.34.67]:37668 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237135AbhKWMxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:53:25 -0500
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 32EBAE1C24;
        Tue, 23 Nov 2021 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1637671814; bh=4tmbN6eLrnaQYFaDckhRieSB7/+V2AgHnKlniPtk7/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OZoAyGrbeK1/0zWqoIs2K0MVQKI73w+Rw3ggiz+NAEe+NVPAunma2GQBPpxr5TDwc
         /GvwIiJiQ3UNaCdWLbHKl23ZXoRM9PCQKLKN4D9jN6RY+H5Ui+qXHSXr4TiccoGvSq
         EcBiXdNaKCAeTqB0p47B69Nwc3aH+BBSqOjMQm7wgFa00fj4dJ2XWBSp+UODQHXM1q
         EmtO19gfu+6UalPEwxyOc2V7+dl52XCi5Bn3vDxfjw37rMba0Q+0YfWiVYf6qpbNll
         t2hQ6gy70FAuOeQaFvvNXrhRjjKqhhsRnfw59nlSDcNKCB0P2YoYuSYHHoXklhl8mA
         Hii3s4oselSYw==
Date:   Tue, 23 Nov 2021 13:50:12 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
References: <20211102110204.3334609-1-sean@geanix.com>
 <20211102110204.3334609-4-sean@geanix.com>
 <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
 <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
X-Spam-Status: No, score=-0.4 required=4.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:03:52PM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 02.11.2021 12:02, Sean Nyekjaer wrote:
> > Prevent MTD access while in a suspended state. Also
> > prevent suspending a device which is still currently in use.
> >
> > Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> > rawnand layer to return errors rather than waiting in a blocking wait.
> >
> > Tested on a iMX6ULL.
> >
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> This patch landed recently in linux-next as commit 9d6abd489e70 ("mtd: 
> core: protect access to MTD devices while in suspend"). I found that it 
> triggers the following warning on my test systems:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 1606 Comm: reboot Not tainted 5.16.0-rc1+ #4165
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x0/0x1ac
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x8c/0xb8
>   dump_stack+0x18/0x34
>   register_lock_class+0x4a0/0x4cc
>   __lock_acquire+0x78/0x20cc
>   lock_acquire.part.0+0xe0/0x230
>   lock_acquire+0x68/0x84
>   down_write+0x64/0xe0
>   physmap_flash_shutdown+0x60/0x140
>   platform_shutdown+0x28/0x40
>   device_shutdown+0x160/0x340
>   __do_sys_reboot+0x1f8/0x2a0
>   __arm64_sys_reboot+0x28/0x34
>   invoke_syscall+0x48/0x114
>   el0_svc_common.constprop.0+0x60/0x11c
>   do_el0_svc_compat+0x1c/0x50
>   el0_svc_compat+0x4c/0x100
>   el0t_32_sync_handler+0x90/0x140
>   el0t_32_sync+0x1a4/0x1a8
> Flash device refused suspend due to active operation (state 20)
> ------------[ cut here ]------------
> DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner 
> = 0xffff588b4547c740, curr 0xffff588b4547c740, list not empty
> WARNING: CPU: 1 PID: 1606 at kernel/locking/rwsem.c:1322 
> up_write+0x144/0x1a0
> Modules linked in: bluetooth ecdh_generic ecc rfkill ipv6
> CPU: 1 PID: 1606 Comm: reboot Not tainted 5.16.0-rc1+ #4165
> Hardware name: linux,dummy-virt (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : up_write+0x144/0x1a0
> lr : up_write+0x144/0x1a0
> sp : ffff8000109ebbd0
> x29: ffff8000109ebbd0 x28: ffff588b4547c740 x27: 0000000000000000
> x26: ffffce0238d56470 x25: 0000000000000008 x24: ffffce0239bba030
> x23: ffff588b451938b0 x22: 0000000000000000 x21: ffff588b44046c80
> x20: ffffce02397a2000 x19: ffff588b451938b0 x18: 0000000000000030
> x17: 0000000000000000 x16: 0000000000000000 x15: ffffffffffffffff
> x14: 0000000000000005 x13: ffffce02397c5198 x12: 0000000000000390
> x11: 0000000000000130 x10: ffffce023981d198 x9 : 00000000fffff000
> x8 : ffffce02397c5198 x7 : ffffce023981d198 x6 : 0000000000000000
> x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff588b4547c740
> Call trace:
>   up_write+0x144/0x1a0
>   physmap_flash_shutdown+0x13c/0x140
>   platform_shutdown+0x28/0x40
>   device_shutdown+0x160/0x340
>   __do_sys_reboot+0x1f8/0x2a0
>   __arm64_sys_reboot+0x28/0x34
>   invoke_syscall+0x48/0x114
>   el0_svc_common.constprop.0+0x60/0x11c
>   do_el0_svc_compat+0x1c/0x50
>   el0_svc_compat+0x4c/0x100
>   el0t_32_sync_handler+0x90/0x140
>   el0t_32_sync+0x1a4/0x1a8
> irq event stamp: 2541
> hardirqs last  enabled at (2541): [<ffffce02382d94c8>] 
> _raw_spin_unlock_irq+0x44/0x90
> hardirqs last disabled at (2540): [<ffffce02382d98cc>] 
> _raw_spin_lock_irq+0xac/0xb0
> softirqs last  enabled at (2278): [<ffffce0237210470>] _stext+0x470/0x5e8
> softirqs last disabled at (2273): [<ffffce023729d904>] 
> __irq_exit_rcu+0x180/0x1ac
> ---[ end trace d06160a193b668c2 ]---
> Flash device refused suspend due to active operation (state 20)
> 
> 
> Reverting $subject patch on top of linux-next hides the warning. The 
> above log has been gathered on QEMU/arm64 'virt' machine, during the 
> reboot operation. If you need more information how to reproduce it, let 
> me know.
> 
>

Hi,

Thanks Marek :)

@Boris do we need to do something similar here to what we did with the
mtdconcat stuff?

/Sean
