Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B658E3A3E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFKId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:33:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:51884 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhFKIdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:33:55 -0400
IronPort-SDR: tG0+R3rq6qru/Rn2oxKCJ6Bu4JBKe+9USf0+Tr9xrUGmhKfY2T25BpkKdm504t9JPJzunjHRiC
 KBaThTO8cawg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266638180"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266638180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 01:31:56 -0700
IronPort-SDR: 1pUlL1XQoWapVdpMkrlnsUrvT/HyRzx2rEarZuGaZF3PI4BJO8dRHDnaSkZo1y20XjrFD+V/qi
 QecRcCkUMgtQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="449039619"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 01:31:53 -0700
Date:   Fri, 11 Jun 2021 16:48:17 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
Message-ID: <20210611084817.GB26476@xsang-OptiPlex-9020>
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
 <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Rasmus,

On Tue, Jun 08, 2021 at 09:42:58AM +0200, Rasmus Villemoes wrote:
> On 07/06/2021 16.44, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: e7cb072eb988e46295512617c39d004f9e1c26f8 ("init/initramfs.c: do unpacking asynchronously")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: locktorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 
> > test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> > test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > please be noted that we use 'vmalloc=512M' for both parent and this commit.
> > since it's ok on parent but oom on this commit, we want to send this report
> > to show the potential problem of the commit on some cases.
> > 
> > we also tested by changing to use 'vmalloc=128M', it will succeed.
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [    4.443950] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [    4.716374] ACPI: _SB_.LNKC: Enabled at IRQ 11
> > [    5.081518] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> > [    5.082999] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > [    5.085275] VFIO - User Level meta-driver version: 0.3
> > [    8.029204] kworker/u4:0 invoked oom-killer: gfp_mask=0x100cc0(GFP_USER), order=0, oom_score_adj=0
> > [    8.031021] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.12.0-11533-ge7cb072eb988 #1
> > [    8.031988] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [    8.031988] Workqueue: events_unbound async_run_entry_fn
> > [    8.031988] Call Trace:
> > [    8.031988] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
> > [    8.031988] dump_header (kbuild/src/consumer/mm/oom_kill.c:463) 
> > [    8.031988] ? lock_release (kbuild/src/consumer/kernel/locking/lockdep.c:5190 kbuild/src/consumer/kernel/locking/lockdep.c:5532) 
> > [    8.031988] ? out_of_memory (kbuild/src/consumer/include/linux/rcupdate.h:710 kbuild/src/consumer/mm/oom_kill.c:379 kbuild/src/consumer/mm/oom_kill.c:1102 kbuild/src/consumer/mm/oom_kill.c:1048) 
> > [    8.031988] out_of_memory.cold (kbuild/src/consumer/mm/oom_kill.c:1106 kbuild/src/consumer/mm/oom_kill.c:1048) 
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.12.0-11533-ge7cb072eb988 .config
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> > 	cd <mod-install-dir>
> > 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> So I got this far...
> 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
> Is there some way to reproduce which doesn't require adding an lkp user?

no need to run the test by 'lkp' account. lkp-tests will create a .lkp folder
under home path. do you mean this? normally we run 'qemu' by 'root'.

> Also, I don't have 16G to give to a virtual machine. I tried running the
> bzImage with that modules.cgz under qemu with some naive parameters just
> to get some output [1], but other than failing because there's no rootfs
> to mount (as expected), I only managed to make it fail when providing
> too little memory (the .cgz is around 70M, decompressed about 200M -
> giving '-m 1G' to qemu works fine). You mention the vmalloc= argument,
> but I can't make the decompression fail when passing either vmalloc=128M
> or vmalloc=512M or no vmalloc= at all.

sorry about this. we also tried to follow exactly above steps to test on
some local machine (8G memory), but cannot reproduce. we are analyzing
what's the diference in our automaion run in test cluster, which reproduced
the issue consistently. will update you when we have findings.

> 
> As an extra data point, what happens if you add initramfs_async=0 to the
> command line?

yes, we tested this before sending out the report. the issue gone
if initramfs_async=0 is added.

> 
> [1] qemu-system-x86_64 -kernel arch/i386/boot/bzImage -initrd
> ../../tmp/header-install/modules.cgz -append "console=ttyAMA0
> console=ttyS0 vmalloc=512M" -serial stdio -smp 2 -m 1G
> 
> Rasmus
