Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38A3BEAA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhGGP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:26:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 08:23:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n14so4703636lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c9GeYd0BFSYLjzlo1KFhrAQnO7dlGAJVxqkvuU8lV9U=;
        b=yAUQ/JOMiRrokiYg1RaI+Vg0L4SAJl386niVfjiAtBCm8hqDhDTnFyon9LyjbBFeTq
         rwflxu4hlIJw7/Qjg4p7NIzy64c3kQXQQZnMBDaWaCD/1TPVWqvYCWVZttF3lZ6YbUIF
         pKZ3w2w3EqKOAQSRkvntFv7Am2ueqv5ALq544EwIwVMPkn6r9gSPnHSBLg/s3K0vkpWv
         ik6fUzZGmNTfO1VQEerXFOLy1TBqNej687YPjBz++Ntk0E3Q1SWlyr/gMlyMIzFyCb+M
         EL6ivYlt3uFcGtkqOJ/maLJvwah56sDc/iBbuGU+V0AjwtjvYPtCIgfKWSK/1zQ3yA70
         6O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c9GeYd0BFSYLjzlo1KFhrAQnO7dlGAJVxqkvuU8lV9U=;
        b=HnKAw5FhBPoj2YOcZwIWyo17pUmEHmDU2klf7WlaenFgkAhH6l142KhuPNdl8tu4RZ
         tcmPfLODRRZTBiDPj55dRfJLZkAi7WKtObVeI/GeD3qwXH89+19j9Y8eWhHz9EZQpXoZ
         7coHIEt32PbaUpVY+d/z3fuThrQNdAqVpSKIB6RO+tWB6Ektqiz/0udTxMenCciJ15Bn
         E9wwfr4oQrvWDFSzmhC08Z5cuJ75fwYCZPO4/jYnaamISiqZKk/1ccfv5zptkx/8sdCr
         vRYB0og8IeEjoGB4JXW95WP2yZLIlTQyS7IVSQl9GSMVGdVzYdcPoFxkPCLL39E/xBCr
         QMiA==
X-Gm-Message-State: AOAM532mMpId/OoV2JxspTHJoVK/A6bH9J9Y8P2hDDGS0mOAer454Qcu
        xjjG2d0EjqFQS+rgve5S1piB6qACEMcS0yY2OmDNtg==
X-Google-Smtp-Source: ABdhPJy/x/dkSqDZdHC5gy/oLn2qqquHAn8gv+Xe5/W6hp/1WndIq8kO9YxYT3nSqHXoBW/hL0Rkqdf1HnfiU2Fs9/Q=
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr15770578lfu.154.1625671437557;
 Wed, 07 Jul 2021 08:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210706085652.GF2022171@shao2-debian> <CAKfTPtBnEmMFwCWD3sGP=vrbG8tkLncKbjStYLN+od3z0K=RrA@mail.gmail.com>
 <20210707090722.GH2022171@shao2-debian>
In-Reply-To: <20210707090722.GH2022171@shao2-debian>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 17:23:45 +0200
Message-ID: <CAKfTPtCT_mVNT7-FnZSN=p0S2NWqDeoxRvn7vHO9R6XSwEC4iA@mail.gmail.com>
Subject: Re: [sched/fair] 1c35b07e6d: RIP:native_queued_spin_lock_slowpath
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Odin Ugedal <odin@uged.al>, Peter Zijlstra <peterz@infradead.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>, ltp@lists.linux.it,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 11:07, kernel test robot <rong.a.chen@intel.com> wrot=
e:
>
> On Tue, Jul 06, 2021 at 11:08:54AM +0200, Vincent Guittot wrote:
> > Hi Rong
> >
> > On Tue, 6 Jul 2021 at 10:56, kernel test robot <rong.a.chen@intel.com> =
wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: 1c35b07e6d3986474e5635be566e7bc79d97c64d ("sched/fair: Ensure=
 _sum and _avg values stay consistent")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
> >
> > I don't think this commit is the real culprit as it mainly replaces a
> > sub by a mul whereas the dmesg mentioned spinlock deadlock . Have you
> > bisect the problem down to this commit or you faced the problem while
> > testing latest master branch ?
>
> Hi Vincent,
>
> It's bisected by 0day-CI, I tried to run more times and found the issue i=
s not
> first introduced by this commit, but boot always failed with this commit.

Thanks for the detailed test results. By replacing sub by mul, it
mainly increases the time spent under the lock and it seems to be
enough to catch the deadlock all the time now.

Will try to reproduce it


>
> adf3c31e18b765ea 1c35b07e6d3986474e5635be566
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           7:15         -47%            :12    last_state.booting

Do you know since when you have a 31% (7:15)  rate of failure ?

Thanks


>           2:15          67%          12:12    dmesg.Kernel_panic-not_sync=
ing:Hard_LOCKUP
>            :15           7%           1:12    dmesg.RIP:cpuidle_enter_sta=
te
>           2:15          67%          12:12    dmesg.RIP:native_queued_spi=
n_lock_slowpath
>            :15           7%           1:12    dmesg.RIP:sd_init_command[s=
d_mod]
>           1:15          -7%            :12    dmesg.RIP:update_blocked_av=
erages
>           1:15          -7%            :12    dmesg.WARNING:at_kernel/sch=
ed/fair.c:#update_blocked_averages
>           3:15          60%          12:12    dmesg.boot_failures
>
> Best Regards,
> Rong Chen
>
> >
> > >
> > >
> > > in testcase: ltp
> > > version: ltp-x86_64-14c1f76-1_20210703
> > > with following parameters:
> > >
> > >         disk: 1HDD
> > >         fs: ext4
> > >         test: dio-01
> > >         ucode: 0xe2
> > >
> > > test-description: The LTP testsuite contains a collection of tools fo=
r testing the Linux kernel and related features.
> > > test-url: http://linux-test-project.github.io/
> > >
> > >
> > > on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz wi=
th 28G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
> > >
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >
> > >
> > > [  160.446205]
> > > [  160.451594] <<<test_output>>>
> > > [  160.451595]
> > > [  178.116525] ------------[ cut here ]------------
> > > [  203.592757] NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
> > > [  203.592758] Modules linked in: dm_mod btrfs blake2b_generic xor zs=
td_compress raid6_pq libcrc32c ipmi_devintf ipmi_msghandler sd_mod t10_pi s=
g intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp co=
retemp i915 kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_in=
tel ghash_clmulni_intel mei_wdt intel_gtt drm_kms_helper ahci rapl syscopya=
rea libahci sysfillrect intel_cstate sysimgblt mei_me fb_sys_fops wmi_bmof =
drm intel_uncore libata mei joydev intel_pch_thermal wmi video intel_pmc_co=
re acpi_pad ip_tables
> > > [  203.592770] CPU: 3 PID: 3103 Comm: diotest6 Tainted: G          I =
      5.13.0-rc6-00076-g1c35b07e6d39 #1
> > > [  203.592770] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.=
2.8 01/26/2016
> > > [  203.592771] RIP: 0010:native_queued_spin_lock_slowpath (kbuild/src=
/consumer/kernel/locking/qspinlock.c:382 kbuild/src/consumer/kernel/locking=
/qspinlock.c:315)
> > > [ 203.592771] Code: 6c f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c=
2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 46 85 c0 74 0e 8b 07 84 c0 74 08 f3 9=
0 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 b8 00 02 00 00
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >    0:   6c                      insb   (%dx),%es:(%rdi)
> > >    1:   f0 0f ba 2f 08          lock btsl $0x8,(%rdi)
> > >    6:   0f 92 c0                setb   %al
> > >    9:   0f b6 c0                movzbl %al,%eax
> > >    c:   c1 e0 08                shl    $0x8,%eax
> > >    f:   89 c2                   mov    %eax,%edx
> > >   11:   8b 07                   mov    (%rdi),%eax
> > >   13:   30 e4                   xor    %ah,%ah
> > >   15:   09 d0                   or     %edx,%eax
> > >   17:   a9 00 01 ff ff          test   $0xffff0100,%eax
> > >   1c:   75 46                   jne    0x64
> > >   1e:   85 c0                   test   %eax,%eax
> > >   20:   74 0e                   je     0x30
> > >   22:   8b 07                   mov    (%rdi),%eax
> > >   24:   84 c0                   test   %al,%al
> > >   26:   74 08                   je     0x30
> > >   28:   f3 90                   pause
> > >   2a:*  8b 07                   mov    (%rdi),%eax              <-- t=
rapping instruction
> > >   2c:   84 c0                   test   %al,%al
> > >   2e:   75 f8                   jne    0x28
> > >   30:   b8 01 00 00 00          mov    $0x1,%eax
> > >   35:   66 89 07                mov    %ax,(%rdi)
> > >   38:   c3                      retq
> > >   39:   8b 37                   mov    (%rdi),%esi
> > >   3b:   b8 00 02 00 00          mov    $0x200,%eax
> > >
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >    0:   8b 07                   mov    (%rdi),%eax
> > >    2:   84 c0                   test   %al,%al
> > >    4:   75 f8                   jne    0xfffffffffffffffe
> > >    6:   b8 01 00 00 00          mov    $0x1,%eax
> > >    b:   66 89 07                mov    %ax,(%rdi)
> > >    e:   c3                      retq
> > >    f:   8b 37                   mov    (%rdi),%esi
> > >   11:   b8 00 02 00 00          mov    $0x200,%eax
> > > [  203.592772] RSP: 0018:ffffc90001f032d8 EFLAGS: 00000002
> > > [  203.592773] RAX: 0000000000000101 RBX: ffff88810d4a0000 RCX: ffff8=
88759cc0000
> > > [  203.592773] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8=
88759ceba80
> > > [  203.592774] RBP: ffffc90001f032e8 R08: ffff888759ceb420 R09: ffff8=
88759ceb420
> > > [  203.592774] R10: ffff88810cc01500 R11: 0000000000000000 R12: ffff8=
88759ceba80
> > > [  203.592774] R13: 0000000000000000 R14: 0000000000000087 R15: ffff8=
8810d4a0c8c
> > > [  203.592775] FS:  00007fc252ae2740(0000) GS:ffff888759cc0000(0000) =
knlGS:0000000000000000
> > > [  203.592775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  203.592776] CR2: 00007fa0a4d577f8 CR3: 000000074d22a005 CR4: 00000=
000003706e0
> > > [  203.592776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > > [  203.592776] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > > [  203.592777] Call Trace:
> > > [  203.592777] _raw_spin_lock (kbuild/src/consumer/arch/x86/include/a=
sm/paravirt.h:585 kbuild/src/consumer/arch/x86/include/asm/qspinlock.h:51 k=
build/src/consumer/include/asm-generic/qspinlock.h:85 kbuild/src/consumer/i=
nclude/linux/spinlock.h:183 kbuild/src/consumer/include/linux/spinlock_api_=
smp.h:143 kbuild/src/consumer/kernel/locking/spinlock.c:151)
> > > [  203.592777] raw_spin_rq_lock_nested (kbuild/src/consumer/arch/x86/=
include/asm/preempt.h:85 kbuild/src/consumer/kernel/sched/core.c:462)
> > > [  203.592778] try_to_wake_up (kbuild/src/consumer/kernel/sched/sched=
.h:1536 kbuild/src/consumer/kernel/sched/sched.h:1611 kbuild/src/consumer/k=
ernel/sched/core.c:3555 kbuild/src/consumer/kernel/sched/core.c:3835)
> > > [  203.592778] __queue_work (kbuild/src/consumer/arch/x86/include/asm=
/paravirt.h:590 kbuild/src/consumer/arch/x86/include/asm/qspinlock.h:56 kbu=
ild/src/consumer/include/linux/spinlock.h:212 kbuild/src/consumer/include/l=
inux/spinlock_api_smp.h:151 kbuild/src/consumer/kernel/workqueue.c:1501)
> > > [  203.592778] queue_work_on (kbuild/src/consumer/kernel/workqueue.c:=
1526)
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install                job.yaml  # job file is attach=
ed in this email
> > >         bin/lkp split-job --compatible job.yaml  # generate the yaml =
file for lkp run
> > >         bin/lkp run                    generated-yaml-file
> > >
> > >
> > >
> > > ---
> > > 0DAY/LKP+ Test Infrastructure                   Open Source Technolog=
y Center
> > > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Cor=
poration
> > >
> > > Thanks,
> > > Rong Chen
> > >
