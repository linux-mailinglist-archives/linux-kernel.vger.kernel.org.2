Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915673BC850
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGFJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhGFJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:11:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 02:09:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s18so6414395ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x41Yq1mRaRCaSbb6nX6qnut930aY0jVFr07ZUi2uqCg=;
        b=r6lzHYjOwE2KjPN1STxtE/ergUPhUI0WWp+p/Nga/w3gKiuPQDNDMKdbb7viGQZggx
         YEuHKfvenA0O1MWTjtF1ufEJMyGDQymOAgMc7XtRzQt/jFBccjax/gz7FjEIa5WzkrGo
         Hq51kY66Zx1jYRoKkVurqNnHE9lxyn6+bkFAL3T6wGmNcW0IlU1WuFFQCAsvDcVADYDq
         BqUv8s0sHI6OtpDU9VA9W9otb2kVAHQ3VcdW9IMVtnZSrs1osmibaMT8X+8JMETAJdI7
         Pvlrnz2+d9BQpiNxRnhUcrcvrZIRN/QiH8uqewRmjVMY55cTWrCaiRyFqKK8zwownZ2t
         xlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x41Yq1mRaRCaSbb6nX6qnut930aY0jVFr07ZUi2uqCg=;
        b=n2CeSVOuyHkp23nJ7dJBJg9pWRdejw+Inhix2CQyei5dykmyzATyay6VPIZoMkkq5g
         /q8vLqR7aPIChNmc2SeOt9tFX6rIizdtS5bR8LvFyIV/4zdQ7rq0XOudor0F71yofQnx
         jAtmoGC2BP4CldNrI54eQF+htJqUaSRteSGfYs9govj3HnyMufNgmMw4PfbkDeNDoPtG
         cfhpMIybUVfyclRrUUKnx4lwutV0oCn0NrpZFxJGZJjEWUkQAWp3Nv9apwIWIjf81ZP8
         za/ByrP7VOC5JqCxRBDvPbIAx4HahaEpcDEeP9HyCYZmWNr9rfK0gxNi9tNHzRTUN3uy
         /wkA==
X-Gm-Message-State: AOAM530/X9pQrqCDxTP633tajuqkwqJ5zWRysFMCQ/LF/w8KWUEKlBiM
        0ZPz64uMYPJ8Fnhch/zvJRL5jo0bQmGAG3R4+T+Lsg==
X-Google-Smtp-Source: ABdhPJxwi92RErzqosMZnb4u11sTRG4WlUWEEpuM5LsKky9V0FAqc+EVhVi0+41I6vLwmx84CfJMajygC++CfqTk1Ho=
X-Received: by 2002:a05:651c:1422:: with SMTP id u34mr706649lje.221.1625562545823;
 Tue, 06 Jul 2021 02:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210706085652.GF2022171@shao2-debian>
In-Reply-To: <20210706085652.GF2022171@shao2-debian>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Jul 2021 11:08:54 +0200
Message-ID: <CAKfTPtBnEmMFwCWD3sGP=vrbG8tkLncKbjStYLN+od3z0K=RrA@mail.gmail.com>
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

Hi Rong

On Tue, 6 Jul 2021 at 10:56, kernel test robot <rong.a.chen@intel.com> wrot=
e:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 1c35b07e6d3986474e5635be566e7bc79d97c64d ("sched/fair: Ensure _su=
m and _avg values stay consistent")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I don't think this commit is the real culprit as it mainly replaces a
sub by a mul whereas the dmesg mentioned spinlock deadlock . Have you
bisect the problem down to this commit or you faced the problem while
testing latest master branch ?

>
>
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20210703
> with following parameters:
>
>         disk: 1HDD
>         fs: ext4
>         test: dio-01
>         ucode: 0xe2
>
> test-description: The LTP testsuite contains a collection of tools for te=
sting the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 2=
8G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> [  160.446205]
> [  160.451594] <<<test_output>>>
> [  160.451595]
> [  178.116525] ------------[ cut here ]------------
> [  203.592757] NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
> [  203.592758] Modules linked in: dm_mod btrfs blake2b_generic xor zstd_c=
ompress raid6_pq libcrc32c ipmi_devintf ipmi_msghandler sd_mod t10_pi sg in=
tel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp corete=
mp i915 kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel =
ghash_clmulni_intel mei_wdt intel_gtt drm_kms_helper ahci rapl syscopyarea =
libahci sysfillrect intel_cstate sysimgblt mei_me fb_sys_fops wmi_bmof drm =
intel_uncore libata mei joydev intel_pch_thermal wmi video intel_pmc_core a=
cpi_pad ip_tables
> [  203.592770] CPU: 3 PID: 3103 Comm: diotest6 Tainted: G          I     =
  5.13.0-rc6-00076-g1c35b07e6d39 #1
> [  203.592770] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 =
01/26/2016
> [  203.592771] RIP: 0010:native_queued_spin_lock_slowpath (kbuild/src/con=
sumer/kernel/locking/qspinlock.c:382 kbuild/src/consumer/kernel/locking/qsp=
inlock.c:315)
> [ 203.592771] Code: 6c f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b=
 07 30 e4 09 d0 a9 00 01 ff ff 75 46 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8=
b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 b8 00 02 00 00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   6c                      insb   (%dx),%es:(%rdi)
>    1:   f0 0f ba 2f 08          lock btsl $0x8,(%rdi)
>    6:   0f 92 c0                setb   %al
>    9:   0f b6 c0                movzbl %al,%eax
>    c:   c1 e0 08                shl    $0x8,%eax
>    f:   89 c2                   mov    %eax,%edx
>   11:   8b 07                   mov    (%rdi),%eax
>   13:   30 e4                   xor    %ah,%ah
>   15:   09 d0                   or     %edx,%eax
>   17:   a9 00 01 ff ff          test   $0xffff0100,%eax
>   1c:   75 46                   jne    0x64
>   1e:   85 c0                   test   %eax,%eax
>   20:   74 0e                   je     0x30
>   22:   8b 07                   mov    (%rdi),%eax
>   24:   84 c0                   test   %al,%al
>   26:   74 08                   je     0x30
>   28:   f3 90                   pause
>   2a:*  8b 07                   mov    (%rdi),%eax              <-- trapp=
ing instruction
>   2c:   84 c0                   test   %al,%al
>   2e:   75 f8                   jne    0x28
>   30:   b8 01 00 00 00          mov    $0x1,%eax
>   35:   66 89 07                mov    %ax,(%rdi)
>   38:   c3                      retq
>   39:   8b 37                   mov    (%rdi),%esi
>   3b:   b8 00 02 00 00          mov    $0x200,%eax
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   8b 07                   mov    (%rdi),%eax
>    2:   84 c0                   test   %al,%al
>    4:   75 f8                   jne    0xfffffffffffffffe
>    6:   b8 01 00 00 00          mov    $0x1,%eax
>    b:   66 89 07                mov    %ax,(%rdi)
>    e:   c3                      retq
>    f:   8b 37                   mov    (%rdi),%esi
>   11:   b8 00 02 00 00          mov    $0x200,%eax
> [  203.592772] RSP: 0018:ffffc90001f032d8 EFLAGS: 00000002
> [  203.592773] RAX: 0000000000000101 RBX: ffff88810d4a0000 RCX: ffff88875=
9cc0000
> [  203.592773] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88875=
9ceba80
> [  203.592774] RBP: ffffc90001f032e8 R08: ffff888759ceb420 R09: ffff88875=
9ceb420
> [  203.592774] R10: ffff88810cc01500 R11: 0000000000000000 R12: ffff88875=
9ceba80
> [  203.592774] R13: 0000000000000000 R14: 0000000000000087 R15: ffff88810=
d4a0c8c
> [  203.592775] FS:  00007fc252ae2740(0000) GS:ffff888759cc0000(0000) knlG=
S:0000000000000000
> [  203.592775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  203.592776] CR2: 00007fa0a4d577f8 CR3: 000000074d22a005 CR4: 000000000=
03706e0
> [  203.592776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  203.592776] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  203.592777] Call Trace:
> [  203.592777] _raw_spin_lock (kbuild/src/consumer/arch/x86/include/asm/p=
aravirt.h:585 kbuild/src/consumer/arch/x86/include/asm/qspinlock.h:51 kbuil=
d/src/consumer/include/asm-generic/qspinlock.h:85 kbuild/src/consumer/inclu=
de/linux/spinlock.h:183 kbuild/src/consumer/include/linux/spinlock_api_smp.=
h:143 kbuild/src/consumer/kernel/locking/spinlock.c:151)
> [  203.592777] raw_spin_rq_lock_nested (kbuild/src/consumer/arch/x86/incl=
ude/asm/preempt.h:85 kbuild/src/consumer/kernel/sched/core.c:462)
> [  203.592778] try_to_wake_up (kbuild/src/consumer/kernel/sched/sched.h:1=
536 kbuild/src/consumer/kernel/sched/sched.h:1611 kbuild/src/consumer/kerne=
l/sched/core.c:3555 kbuild/src/consumer/kernel/sched/core.c:3835)
> [  203.592778] __queue_work (kbuild/src/consumer/arch/x86/include/asm/par=
avirt.h:590 kbuild/src/consumer/arch/x86/include/asm/qspinlock.h:56 kbuild/=
src/consumer/include/linux/spinlock.h:212 kbuild/src/consumer/include/linux=
/spinlock_api_smp.h:151 kbuild/src/consumer/kernel/workqueue.c:1501)
> [  203.592778] queue_work_on (kbuild/src/consumer/kernel/workqueue.c:1526=
)
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached i=
n this email
>         bin/lkp split-job --compatible job.yaml  # generate the yaml file=
 for lkp run
>         bin/lkp run                    generated-yaml-file
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Ce=
nter
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corpora=
tion
>
> Thanks,
> Rong Chen
>
