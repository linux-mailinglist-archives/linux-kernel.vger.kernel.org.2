Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3814C307B21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhA1QiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:38:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:32878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232616AbhA1Qha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:37:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611851801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WybSJxoHdYVCgie3d8jjobcsCEqTYehyaUtKcLMGQYU=;
        b=tjlLPuZ7K6NqI5z4hap845+6arO6Hc+HKwT3dhjlBDUI9z+//7UkI9hZfL252ARrlc56wr
        UNNTcpDFOMf2ROzPwstMGcsrb4jT+phJvMAK77jaqZkEx0u1K/PTOJYkvQ3G2tzl45RuO5
        cQfazOl9fLb1DdieeSSQUQGRjFewvmA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80238AF0E;
        Thu, 28 Jan 2021 16:36:41 +0000 (UTC)
Date:   Thu, 28 Jan 2021 17:36:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YBLoGNQNMkFivh34@alley>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
 <YAr7d6A4CkMpgx+g@alley>
 <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
 <87bldaaxcc.fsf@jogness.linutronix.de>
 <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain>
 <87czxpmhe1.fsf@jogness.linutronix.de>
 <YBLPhkHQ8cXFiY1X@alley>
 <877dnxm5ju.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dnxm5ju.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-28 16:48:29, John Ogness wrote:
> On 2021-01-28, Petr Mladek <pmladek@suse.com> wrote:
> > If you are able to reproduce this, it might be interesting to see
> > backtraces from all CPUs when RCU stall gets detected. Or even
> > printing all processes, even the sleeping ones.
> 
> OK, I now have lkp running on my intel core i5 machine and it reliably
> reproduces this. First let me say a word about lkp. The instructions in
> the report email are a bit misleading. There are lots of steps that it
> doesn't mention.
> 
> First I needed to install lkp and its dependencies. I did all of this as
> root because lkp seems to get confused when sudo is involved.
> 
> # git clone https://github.com/intel/lkp-tests.git
> # cd lkp-tests
> # make install
> # lkp install
> 
> Then I built the kernel and modules using a helper script to setup the
> environment for me:
> 
> ----- BEGIN /tmp/mk.sh -----
> #!/bin/sh
> 
> export INSTALL_MOD_PATH=`pwd`
> export HOSTCC=gcc-9
> export CC=gcc-9
> export ARCH=x86_64
> 
> exec make "$@"
> ----- END /tmp/mk.sh -----
> 
> # cd linux
> # git checkout -b lkp b031a684bfd01d633c79d281bd0cf11c2f834ada
> # cp /tmp/config-5.10.0-rc5-gb031a684bfd0 .config
> # /tmp/mk.sh -j `nproc` olddefconfig prepare modules_prepare bzImage modules modules_install
> 
> Then I created the modules.cgz:
> 
> # find lib/modules | cpio -H newc -o | gzip -9c > modules.cgz
> 
> I put kernel and modules in /tmp/:
> 
> # cp arch/x86/boot/bzImage modules.cgz /tmp/
> 
> And ran lkp inside script(1) so I have a logfile:
> 
> # script
> # lkp qemu -k /tmp/bzImage -m /tmp/modules.cgz /tmp/job-script
> 
> And reliably I see the first stall at about 925 seconds:
> 
> [  926.386441][   T22] INFO: rcu_tasks detected stalls on tasks:
> [  926.387310][   T22] 0000000041eb5240: .. nvcsw: 0/0 holdout: 1 idle_cpu: -1/1
> [  926.388196][   T22] task:dmesg           state:R  running task     stack:    0 pid: 1752 ppid:   511 flags:0x2002000
> 0
> [  926.389509][   T22] Call Trace:
> [  926.389962][   T22]  __schedule+0xa12/0xab5
> [  926.390534][   T22]  ? firmware_map_remove+0xd1/0xd1
> [  926.391190][   T22]  ? ksys_read+0x116/0x150
> [  926.391773][   T22]  schedule+0x16c/0x1df
> [  926.392317][   T22]  exit_to_user_mode_loop+0x28/0x84
> [  926.392977][   T22]  exit_to_user_mode_prepare+0x1d/0x4a
> [  926.393671][   T22]  syscall_exit_to_user_mode+0x41/0x4f
> [  926.394357][   T22]  entry_INT80_compat+0x71/0x76
> [  926.394982][   T22] RIP: 0023:0xf7f0fa02
> [  926.395528][   T22] RSP: 002b:00000000ff850364 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [  926.396590][   T22] RAX: ffffffffffffffe0 RBX: 0000000000000004 RCX: 00000000565c8234
> [  926.397607][   T22] RDX: 0000000000001fff RSI: 00000000000001e0 RDI: 00000000565c8234
> [  926.398617][   T22] RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
> [  926.399629][   T22] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  926.400643][   T22] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> But actually it is not the rcu stall that interests me so much. I am
> more interested in some bizarre console output I am seeing. Here is a
> snippet:
> 
> [  903.008486][  T356] [  778.732883] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.008496][  T356]
> [  903.014733][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.030232][  T356] [  778.735197] [  655.203106] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.030242][  T356]
> [  903.040809][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.044327][  T356] [  778.746898] [  655.214214] [  531.584847] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.044337][  T356]
> [  903.048732][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.066039][  T356] [  778.751162] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.066050][  T356]
> [  903.070123][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.077137][  T356] [  778.768744] [  655.227204] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.077147][  T356]
> [  903.092792][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.095313][  T356] [  778.773836] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.095323][  T356]
> [  903.106788][  T356] [  778.781780] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.106798][  T356]
> [  903.121986][  T356] [  778.791183] [  655.230287] [  531.589973] [  407.116952] [  283.068815] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.121997][  T356]
> [  903.134120][  T356] [  778.797950] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.134130][  T356]
> [  903.148741][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.151626][  T356] [  778.805164] [  655.241173] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.151637][  T356]
> [  903.160126][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.166936][  T356] [  778.818740] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.166946][  T356]
> [  903.175785][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.185955][  T528] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [  903.189448][  T356] [  778.825864] [  655.250559] [  531.607066] [  407.120936] tasks-torture:torture_onoff task: online 0 failed: errno -5
> 
> These multi-timestamp lines are odd. And they are almost exactly 124
> seconds apart.

Yup, this looks suspicious.

Here are my few ideas. Feel free to ignore them and do your own
debugging. I do not want to distract you.

The test produces the same messages over and over again. It is
possible that something has overflown after some amount of messages.
And the regular intervals are just a coincidence.

Are all messages broken this way?
Or does it start later?
Are this exact messages printed correctly at some points?

Is this console output? Or dmesg?

Are you able to reproduce it with the current Linus's master.
I wonder if it is something that we have already fixed.

Best Regards,
Petr
