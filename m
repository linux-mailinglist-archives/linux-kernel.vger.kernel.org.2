Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C73F33F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhHTSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhHTSlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6383261051;
        Fri, 20 Aug 2021 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629484828;
        bh=bwrWjaSZAcax8gZH7Y+OnBX/ZMOuWevN09YGZjagTvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=agezTs9TRTEi8SGkqKaOGbjN4zjCrSSohboqbaEy1AbP03SLii5sEEK3FzndCtUhD
         D/L9HxPQma4eKXu/D3rM51+BB/MT/+grxIfoViKdljlEyGZjJ0KG0RNpf2uFwRvq1K
         AVNgC0GveMyIH5eq3IQsGwl4IF2mTdtLkbLCS0qxQd30FrBoI1ZlXE9hBxQubHI9yI
         mX5aPYuGg64CHoLwuEBXJp1QhQzavODfJtcSRyEEMRPf3ei9e/sbFXtt12K+rcHVXj
         zECSEL6n6tf0oUL9hmi9xQSrFzvJCzBssFB9RsjWjmdd4hrlqnqKe6flyJ1Q9ICw0q
         AOTgYLFon87gw==
Date:   Fri, 20 Aug 2021 20:40:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: HiSilicon: clk-hi3670: mark critical clocks as
 such
Message-ID: <20210820204023.39752576@coco.lan>
In-Reply-To: <20210820175233.GA26106@thinkpad>
References: <92f1641972bf899847e54ee041a95bb7c1bbff71.1629473738.git.mchehab+huawei@kernel.org>
        <20210820175233.GA26106@thinkpad>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 20 Aug 2021 23:22:33 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> On Fri, Aug 20, 2021 at 05:35:43PM +0200, Mauro Carvalho Chehab wrote:
> > The fixed-rate and fixed_factor clocks are critical to the
> > system: disabling them causes HiKey970 to not finish booting.
> >   
> 
> You mean all fixed rate and fixed factor clocks are critical to the system?
> I don't think so.

I tested one by one a couple of times. It took me ~2 weeks or so to produce
this patch. I applied first a patch adding CLK_IGNORE_UNUSED to
all clocks. Then, I broke the big change into hundreds of individual
patches with:

	TOP=$(git log -1 --pretty=%h)

	mkdir -p patches/
	rm patches/*

	COUNT=$(git grep CLK_IGNORE_UNUSED drivers/clk/hisilicon/clk-hi3670.c|wc -l)
	for i in $(seq 1 $COUNT); do
		sed '0,/ | CLK_IGNORE_UNUSED/s///' -i drivers/clk/hisilicon/clk-hi3670.c; git commit -a -m "change $i" --no-edit
	done

	git format-patch ${TOP}.. -o patches/
	(cd patches/; ls *.patch >series)

	git reset --hard $TOP
	git commit -a -m TEST --no-edit --allow-empty

Then, I ran this script in order to test each change individually[1]:

	#!/bin/bash
	trap ctrl_c INT
	
	function ctrl_c() {
	        echo "** Aborting script"
		exit 1
	}
	
	LANG=C
		
	LAST=$(cat patches/series|sort -n|tail -1)

	while :; do
		TOP=$(quilt top)
		echo $TOP

		git commit --amend -a --allow-empty --no-edit
		./test970.sh
		./test_host || break
		ssh hikey970 ./check_kernel
		if [ "$?" != "0" ]; then
			TOP=`quilt top`
			quilt pop
			toquilt $TOP
		fi
		if [ "$TOP" == "patches/$LAST" ]; then
			echo "Finishing."
			exit 0
		fi
		quilt push
	done

Every time the script fails, I had to power off it by hand, power it
on and then boot it with a working Kernel, moving the offending patch
to the end of quilt, with:

	TOP=`quilt top`; quilt pop; toquilt $TOP

[1] This script uses a couple of ancillary scripts:

     a) test970.sh:
	pushes the change from my git tree into the HiKey970,
	builds a new kernel and boots it;
     b) test_host:
	check if the board's network came up after booting;
     c) ./check_kernel:
	checks if the boot succeeded and the board is at a sane state;
     d) toquilt:
	moves a patch to the end of the quilt tree.

Once I finished. I re-checked the patches, in order to double check
that the unapplied patches are all causing issues.

At the end, I renamed the flags with:

	$ sed s,CLK_IGNORE_UNUSED,CLK_IS_CRITICAL, -i drivers/clk/hisilicon/clk-hi3670.c
      
So, yeah, I'm pretty sure that fixed rate and fixed factor clocks
are all critical to the system.

> You should identify the gateable clocks that are causing the issues and see if
> they can be marked as critical.

They were already checked by the above procedure.

> 
> Also, at what point of time you are seeing the boot issue?

That depends on the clock. See, this device is taking ~11 seconds to finish
booting and starting a prompt at the console here.

Most of critical clocks cause a panic() with SError up to ~2 seconds after 
start booting:

	[    2.173211] SError Interrupt on CPU3, code 0xbf000002 -- SError
	[    2.173216] CPU: 3 PID: 102 Comm: kworker/3:1H Not tainted 5.14.0-rc1+ #723
	[    2.173218] Hardware name: HiKey970 (DT)
	[    2.173220] Workqueue: kblockd blk_mq_run_work_fn
	[    2.173226] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO BTYPE=--)
	[    2.173228] pc : el1_interrupt+0x20/0x80
	[    2.173229] lr : el1h_64_irq_handler+0x18/0x24
	[    2.173231] sp : ffff80001283b920
	[    2.173233] x29: ffff80001283b920 x28: ffff000100b6c740 x27: ffff0001011e4040
	[    2.173239] x26: 0000000000000001 x25: ffff0001011e4dc0 x24: 000000000000001b
	[    2.173244] x23: 0000000080000005 x22: ffff800010ed5078 x21: ffff80001283baa0
	[    2.173249] x20: ffff8000104e42e0 x19: ffff80001283b950 x18: ffff8000121db8c0
	[    2.173255] x17: 0000000000001800 x16: 0000000000000000 x15: 0000000000000000
	[    2.173260] x14: 00000000000002a7 x13: ffff000101d56298 x12: 0000000000000001
	[    2.173266] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
	[    2.173271] x8 : 0000000000000000 x7 : 0001000000a30100 x6 : 00000000016ec5e1
	[    2.173276] x5 : 00ffffffffffffff x4 : 0000000000000000 x3 : ffff0001011e2030
	[    2.173281] x2 : 0000000000000000 x1 : 00000000000000c0 x0 : ffff80001283b950
	[    2.173288] Kernel panic - not syncing: Asynchronous SError Interrupt
	[    2.173290] CPU: 3 PID: 102 Comm: kworker/3:1H Not tainted 5.14.0-rc1+ #723
	[    2.173292] Hardware name: HiKey970 (DT)
	[    2.173294] Workqueue: kblockd blk_mq_run_work_fn
	[    2.173297] Call trace:
	[    2.173298]  dump_backtrace+0x0/0x1e0
	[    2.173300]  show_stack+0x18/0x24
	[    2.173302]  dump_stack_lvl+0x68/0x84
	[    2.173304]  dump_stack+0x18/0x34
	[    2.173305]  panic+0x16c/0x334
	[    2.173307]  nmi_panic+0x8c/0x90
	[    2.173309]  arm64_serror_panic+0x78/0x84
	[    2.173310]  do_serror+0x58/0x5c
	[    2.173312]  el1h_64_error_handler+0x30/0x50
	[    2.173314]  el1h_64_error+0x78/0x7c
	[    2.173316]  el1_interrupt+0x20/0x80
	[    2.173318]  el1h_64_irq_handler+0x18/0x24
	[    2.173319]  el1h_64_irq+0x78/0x7c
	[    2.173321]  _raw_spin_unlock_irqrestore+0x18/0x50
	[    2.173323]  ufshcd_queuecommand+0x34c/0x480
	[    2.173324]  scsi_queue_rq+0x420/0x96c
	[    2.173327]  blk_mq_dispatch_rq_list+0x118/0x800
	[    2.173328]  __blk_mq_do_dispatch_sched+0x238/0x2b4
	[    2.173330]  __blk_mq_sched_dispatch_requests+0x110/0x170
	[    2.173332]  blk_mq_sched_dispatch_requests+0x3c/0x80
	[    2.173334]  __blk_mq_run_hw_queue+0x54/0x90
	[    2.173336]  blk_mq_run_work_fn+0x24/0x30
	[    2.173338]  process_one_work+0x1cc/0x350
	[    2.173340]  worker_thread+0x138/0x46c
	[    2.173341]  kthread+0x150/0x160
	[    2.173343]  ret_from_fork+0x10/0x18
	[    2.173365] SMP: stopping secondary CPUs
	[    2.173367] Kernel Offset: disabled
	[    2.173369] CPU features: 0x00003051,00000846
	[    2.173371] Memory Limit: none

a couple of clocks that cause the device to stop producing any dmesg 
after ~2 seconds:

	...
	[    1.886460] printk: bootconsole [pl11] disabled
	[    1.886460] printk: bootconsole [pl11] disabled
	[    1.924965] i2c 0-004e: Fixing up cyclic dependency with hikey_usbhub
	[    1.925433]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12
	[    1.935446] dwmmc_k3 fc183000.dwmmc2: fifo-depth property not found, using value of FIFOTH register as default
	[    1.935977] ALSA device list:
	[    1.935977]   No soundcards found.
	[    1.935977] sd 0:0:0:3: [sdc] Attached SCSI disk
	[    1.935977] uart-pl011 fff32000.serial: no DMA platform data
	<no more dmesg>

There are some clocks that cause SError panic() after ~4 seconds or so,
when some driver would be probed, like this one:

	[    4.012925] Kernel panic - not syncing: Asynchronous SError Interrupt
	[    4.012926] CPU: 5 PID: 142 Comm: kworker/u16:3 Not tainted 5.14.0-rc1+ #718
	[    4.012927] Hardware name: HiKey970 (DT)
	[    4.012928] Workqueue: events_unbound deferred_probe_work_func
	[    4.012930] Call trace:
	[    4.012930]  dump_backtrace+0x0/0x1e0
	[    4.012931]  show_stack+0x18/0x24
	[    4.012932]  dump_stack_lvl+0x68/0x84
	[    4.012932]  dump_stack+0x18/0x34
	[    4.012933]  panic+0x16c/0x334
	[    4.012934]  nmi_panic+0x8c/0x90
	[    4.012934]  arm64_serror_panic+0x78/0x84
	[    4.012935]  do_serror+0x58/0x5c
	[    4.012936]  el1h_64_error_handler+0x30/0x50
	[    4.012937]  el1h_64_error+0x78/0x7c
	[    4.012938]  pin_request+0x8c/0x2b0
	[    4.012939]  pinmux_request_gpio+0x50/0x9c
	[    4.012939]  pinctrl_gpio_request+0x64/0x1bc
	[    4.012940]  gpiochip_generic_request+0x30/0x4c
	[    4.012941]  gpiod_request_commit+0xf8/0x1d0
	[    4.012942]  gpiod_request.part.0+0xd0/0x10c
	[    4.012942]  gpiod_request+0x44/0xd0
	[    4.012943]  gpio_request+0x30/0x50
	[    4.012944]  devm_gpio_request+0x54/0xb0
	[    4.012945]  kirin_pcie_probe+0x738/0x88c [pcie_kirin]
	[    4.012945]  platform_probe+0x68/0xe0
	[    4.012946]  really_probe+0x1b0/0x42c
	[    4.012947]  __driver_probe_device+0x114/0x190
	[    4.012948]  driver_probe_device+0x40/0x100
	[    4.012949]  __device_attach_driver+0x98/0x130
	[    4.012950]  bus_for_each_drv+0x78/0xd0
	[    4.012951]  __device_attach+0xdc/0x1c0
	[    4.012951]  device_initial_probe+0x14/0x20
	[    4.012952]  bus_probe_device+0x98/0xa0
	[    4.012953]  deferred_probe_work_func+0x9c/0xf0
	[    4.012954]  process_one_work+0x1cc/0x350
	[    4.012954]  worker_thread+0x138/0x46c
	[    4.012955]  kthread+0x150/0x160
	[    4.012956]  ret_from_fork+0x10/0x18
	[    4.012978] SMP: stopping secondary CPUs
	[    4.012979] Kernel Offset: disabled
	[    4.012979] CPU features: 0x00003051,00000846
	[    4.012980] Memory Limit: none


There are some clocks that make the device to not panic(). Instead, it seems
to disable the access to the disk, causing UFS to fail:

	[    2.701778] ufshcd-hisi ff3c0000.ufs: uic cmd 0x1 with arg3 0x0 completion timeout
	[    2.709352] ufshcd-hisi ff3c0000.ufs: dme-get: attr-id 0x1571 failed 0 retries
	[    2.817775] ufshcd-hisi ff3c0000.ufs: __ufshcd_issue_tm_cmd: task management cmd 0x80 timed-out
	[    3.830445] ------------[ cut here ]------------
	[    3.835068] ufshcd-hisi ff3c0000.ufs: __ufshcd_issue_tm_cmd: unable to clear tm cmd (slot 2) after timeout
	[    3.844736] WARNING: CPU: 6 PID: 140 at drivers/scsi/ufs/ufshcd.c:6575 __ufshcd_issue_tm_cmd+0x2dc/0x2fc
	[    3.854225] Modules linked in:
	[    3.857277] CPU: 6 PID: 140 Comm: kworker/u16:2 Not tainted 5.14.0-rc1+ #725
	[    3.864321] Hardware name: HiKey970 (DT)
	[    3.868238] Workqueue: ufs_eh_wq_0 ufshcd_err_handler
	[    3.873288] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
	[    3.879289] pc : __ufshcd_issue_tm_cmd+0x2dc/0x2fc
	[    3.884075] lr : __ufshcd_issue_tm_cmd+0x2dc/0x2fc
	[    3.888858] sp : ffff800012a3bb90
	[    3.892164] x29: ffff800012a3bb90 x28: 00000000000000a0 x27: ffff0001011e2920
	[    3.899297] x26: ffff0001011e2000 x25: 0000000000000000 x24: ffff0001014e0280
	[    3.906429] x23: 0000000000000004 x22: 0000000000000000 x21: 0000000000000002
	[    3.913560] x20: ffff80001115cf98 x19: ffff0001011e2860 x18: 0000000000000000
	[    3.920691] x17: 7261656c63206f74 x16: 20656c62616e7520 x15: 0720072007200720
	[    3.927822] x14: 0720072007200720 x13: ffff0001b87e0000 x12: 0000000000000444
	[    3.934953] x11: 000000000000016c x10: ffff0001bf2386c0 x9 : 00000000ffff0000
	[    3.942083] x8 : ffff0001b87e0000 x7 : ffff0001bf2386c0 x6 : 0000000000000000
	[    3.949215] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
	[    3.956345] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000101071c80
	[    3.963477] Call trace:
	[    3.965916]  __ufshcd_issue_tm_cmd+0x2dc/0x2fc
	[    3.970353]  ufshcd_issue_tm_cmd+0x74/0xf0
	[    3.974442]  ufshcd_try_to_abort_task+0x84/0x21c
	[    3.979053]  ufshcd_err_handler+0x4a0/0xad0
	[    3.983229]  process_one_work+0x1cc/0x350
	[    3.987236]  worker_thread+0x138/0x46c
	[    3.990978]  kthread+0x150/0x160
	[    3.994200]  ret_from_fork+0x10/0x18
	[    3.997772] ---[ end trace 7cf4829a5cdb528e ]---
	[    4.002392] ufshcd-hisi ff3c0000.ufs: ufshcd_try_to_abort_task: no response from device. tag = 18, err -110
	[    4.045167] ufshcd-hisi ff3c0000.ufs: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
	[    4.074477] ufshcd-hisi ff3c0000.ufs: ufshcd_print_pwr_info:[RX, TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
	[    5.614829] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[    7.150830] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[    8.686827] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[    8.697091] ufshcd-hisi ff3c0000.ufs: ufshcd_read_desc_param: Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0, ret -11
	[    8.709437] ufshcd-hisi ff3c0000.ufs: ufshcd_set_active_icc_lvl: Failed reading power descriptor.len = 98 ret = -11
	[    8.756444] ufshcd-hisi ff3c0000.ufs: ufshcd_intr: Unhandled interrupt 0x00000000 (0x00000010, 0x00000010)
	...
	[   98.230000] ufshcd-hisi ff3c0000.ufs: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
	[   98.259323] ufshcd-hisi ff3c0000.ufs: ufshcd_print_pwr_info:[RX, TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
	[   99.790788] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[  101.326787] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[  102.862787] ufshcd-hisi ff3c0000.ufs: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
	[  102.873051] ufshcd-hisi ff3c0000.ufs: ufshcd_read_desc_param: Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0, ret -11
	[  102.885396] ufshcd-hisi ff3c0000.ufs: ufshcd_set_active_icc_lvl: Failed reading power descriptor.len = 98 ret = -11
	[  102.932393] ufshcd-hisi ff3c0000.ufs: ufshcd_intr: Unhandled interrupt 0x00000000 (0x00000010, 0x00000010)
	...

Thanks,
Mauro
