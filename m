Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1803AE57A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFUJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:02:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52486 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFUJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:02:22 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E6009200D0F;
        Mon, 21 Jun 2021 09:00:04 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E12D3804D5; Mon, 21 Jun 2021 10:59:08 +0200 (CEST)
Date:   Mon, 21 Jun 2021 10:59:08 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
 <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jun 20, 2021 at 09:27:34PM +0300 schrieb Andy Shevchenko:
> On Sun, Jun 20, 2021 at 7:36 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jun 20, 2021 at 2:50 PM Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > > Am Sun, Jun 20, 2021 at 02:19:44PM +0300 schrieb Andy Shevchenko:
> > > > On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
> > > > <linux@dominikbrodowski.net> wrote:
> > > > >
> > > > > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > > > > dereference issue introduced by commit
> > > > >         42e59982917a ("mfd: core: Add support for software nodes")
> > > > > in v5.13-rc1:
> > > > >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> > > > >
> > > > > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > > > > fail due to a NULL pointer dereference on my work laptop,
> > > >
> > > > Can you, please, be more specific? E.g. where may I find the ACPI dump
> > > > of your laptop, along with other information?
> > > > What you may prepare is (all run under root user)
> > > > 1. `acpidump -o laptop-$MODEL.dat` (the *.dat file)
> > > > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > > > 3. `dmesg`
> > > > 4. `cat /proc/iomem /proc/ioport`
> > > > 5. `lspci -nk -vv`
> > > >
> > > > (#2 and #3 are interesting to have in working and non-working cases)
> > > >
> > > > Perhaps a bug on the kernel bugzilla would be a good container for all these.
> > > >
> > > > Also it's not clear what exactly an Oops you have (I don't believe
> > > > it's the same).
> > >
> > > Thanks for taking a look at this issue. As it's actually a panic during
> > > boot which triggers before initramfs is ready, I can only provide the data
> > > for the "working case", i.e. with the patch causing the regression already
> > > reverted:
> > >
> > >         https://bugzilla.kernel.org/show_bug.cgi?id=213511
> > >
> > > With commit 42e59982917a reverted, the system works just fine.
> >
> > Is it possible to have any traces of the panic to be logged / photoed / etc?
> 
> I'm just wondering (based on the idea behind my fix) if the commenting
> out INT3446 ID entry in the intel-lpss-acpi.c will help boot this?

Indeed, that allows booting to proceed as expected.

> If so, you may try to bind it later to the driver and see the Oops.

Binding alone doesn't work, as the driver does not allow for dynamic IDs.
But building just the acpi part as a module allowed me to log the oops:

[   87.695362] intel_lpss_acpi: module verification failed: signature and/or required key missing - tainting kernel
[   87.697932] intel-lpss INT3446:00: Failed to create debugfs entries
[   87.698438] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
[   87.698452] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   87.698456] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   87.698459] #PF: supervisor read access in kernel mode
[   87.698460] #PF: error_code(0x0000) - not-present page
[   87.698462] PGD 0 P4D 0 
[   87.698465] Oops: 0000 [#1] PREEMPT SMP PTI
[   87.698467] CPU: 4 PID: 2249 Comm: insmod Tainted: G            E   T 5.13.0-rc7 #1
[   87.698470] Hardware name: Dell Inc. Latitude 7390/09386V, BIOS 1.9.2 04/03/2019
[   87.698471] RIP: 0010:strlen+0x0/0x20
[   87.698477] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[   87.698479] RSP: 0018:ffffa463c359f990 EFLAGS: 00010246
[   87.698481] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   87.698483] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000000
[   87.698485] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[   87.698486] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   87.698487] R13: 0000000000000000 R14: 0000000000000000 R15: dead000000000100
[   87.698489] FS:  0000701d893a7740(0000) GS:ffff96026d600000(0000) knlGS:0000000000000000
[   87.698491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.698493] CR2: 0000000000000000 CR3: 000000015555a006 CR4: 00000000003706e0
[   87.698494] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   87.698496] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   87.698497] Call Trace:
[   87.698502]  kernfs_name_hash+0x12/0x80
[   87.698509]  kernfs_find_ns+0x51/0x110
[   87.698512]  kernfs_remove_by_name_ns+0x34/0x80
[   87.698515]  software_node_notify+0x7d/0x110
[   87.698519]  device_remove_software_node+0x5b/0x70
[   87.698523]  mfd_add_device+0x3a2/0x520
[   87.698527]  ? dev_printk_emit+0x4e/0x65
[   87.698531]  ? __dev_printk+0x2d/0x69
[   87.698534]  mfd_add_devices+0x6c/0xd0
[   87.698539]  intel_lpss_probe+0x3db/0x510
[   87.698543]  ? preempt_count_sub+0x9b/0xd0
[   87.698546]  platform_probe+0x3f/0x90
[   87.698550]  really_probe+0xed/0x360
[   87.698553]  driver_probe_device+0x56/0xb0
[   87.698556]  device_driver_attach+0xa8/0xb0
[   87.698560]  __driver_attach+0x55/0xc0
[   87.698563]  ? device_driver_attach+0xb0/0xb0
[   87.698565]  bus_for_each_dev+0x7b/0xc0
[   87.698568]  bus_add_driver+0x106/0x1b0
[   87.698571]  driver_register+0x8f/0xe0
[   87.698574]  ? 0xffffffffc0252000
[   87.698577]  do_one_initcall+0x5b/0x2f0
[   87.698580]  ? rcu_read_lock_sched_held+0x3f/0x70
[   87.698583]  ? trace_kmalloc+0xa6/0xd0
[   87.698587]  ? kmem_cache_alloc_trace+0x22a/0x360
[   87.698590]  do_init_module+0x7a/0x5c0
[   87.698595]  __do_sys_finit_module+0xa5/0xe0
[   87.698600]  do_syscall_64+0x6b/0x80
[   87.698604]  ? do_syscall_64+0x11/0x80
[   87.698607]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   87.698611] RIP: 0033:0x701d894cd18d
[   87.698613] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
[   87.698615] RSP: 002b:00007fff19800878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   87.698617] RAX: ffffffffffffffda RBX: 0000603fadd124b0 RCX: 0000701d894cd18d
[   87.698619] RDX: 0000000000000000 RSI: 0000603fac9b8270 RDI: 0000000000000003
[   87.698620] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000701d89598380
[   87.698621] R10: 0000000000000003 R11: 0000000000000246 R12: 0000603fac9b8270
[   87.698623] R13: 0000000000000000 R14: 0000603fadd12480 R15: 0000000000000000
[   87.698626] Modules linked in: intel_lpss_acpi(E+)
[   87.698629] CR2: 0000000000000000
[   87.698631] ---[ end trace c7ab8e7eeffb100e ]---
[   87.698633] RIP: 0010:strlen+0x0/0x20
[   87.698636] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[   87.698638] RSP: 0018:ffffa463c359f990 EFLAGS: 00010246
[   87.698640] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   87.698641] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000000
[   87.698643] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[   87.698644] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   87.698645] R13: 0000000000000000 R14: 0000000000000000 R15: dead000000000100
[   87.698647] FS:  0000701d893a7740(0000) GS:ffff96026d600000(0000) knlGS:0000000000000000
[   87.698649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.698650] CR2: 0000000000000000 CR3: 000000015555a006 CR4: 00000000003706e0
[   87.698652] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   87.698653] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   87.698655] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[   87.698656] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2249, name: insmod
[   87.698658] INFO: lockdep is turned off.
[   87.698659] irq event stamp: 12200
[   87.698660] hardirqs last  enabled at (12199): [<ffffffff8a027c8e>] console_unlock+0x4de/0x5f0
[   87.698664] hardirqs last disabled at (12200): [<ffffffff8b18d904>] exc_page_fault+0x34/0x8a0
[   87.698667] softirqs last  enabled at (11666): [<ffffffff8b400349>] __do_softirq+0x349/0x4b1
[   87.698671] softirqs last disabled at (11659): [<ffffffff89faf73f>] irq_exit_rcu+0xff/0x140
[   87.698675] CPU: 4 PID: 2249 Comm: insmod Tainted: G      D     E   T 5.13.0-rc7 #1
[   87.698677] Hardware name: Dell Inc. Latitude 7390/09386V, BIOS 1.9.2 04/03/2019
[   87.698678] Call Trace:
[   87.698680]  dump_stack+0x7f/0xad
[   87.698684]  ___might_sleep.cold+0xf5/0x109
[   87.698688]  exit_signals+0x1c/0x330
[   87.698691]  do_exit+0xcd/0xb50
[   87.698695]  rewind_stack_do_exit+0x17/0x17
[   87.698698] RIP: 0033:0x701d894cd18d
[   87.698700] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
[   87.698702] RSP: 002b:00007fff19800878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   87.698704] RAX: ffffffffffffffda RBX: 0000603fadd124b0 RCX: 0000701d894cd18d
[   87.698705] RDX: 0000000000000000 RSI: 0000603fac9b8270 RDI: 0000000000000003
[   87.698707] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000701d89598380
[   87.698708] R10: 0000000000000003 R11: 0000000000000246 R12: 0000603fac9b8270
[   87.698709] R13: 0000000000000000 R14: 0000603fadd12480 R15: 0000000000000000

Hope this helps,
	Dominik
