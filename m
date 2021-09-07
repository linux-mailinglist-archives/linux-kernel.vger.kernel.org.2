Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74820402991
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbhIGNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbhIGNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:20:25 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B0C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 06:19:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f15so19762644ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S70zXzfMkV5dCR71ol96XxuHd/xWASEtpkzPbCrtjH0=;
        b=yds38u5DFsXMS0V6lvd/AA9JlLQ/sQApKUee/hIY/BZqvsTBYE3SR0T7icvPnq56Xo
         DltudfiGiX5bkUGw4o1V61IYXjeg5faqgVuajvgd/WipqxBh7inOhjUG/NU2aDoQ2+w/
         +zz5Nqr2I+/CScXGmXjeZh7H/IWLtSlqDLEsLn4tO6WOw4jLIvLHADlmHMU0ce0DSrV5
         aQ703muWWq2O2q+S6Tj4RiSiqJ6CboiIArjHxhOzZbj3d9FSQot5QiEgPn+8KrDbpY/Y
         dRLMpwxEOJraIjb9fKN/d7/uKJU3e+s2S6suZ8b0RNovYT5jGKr1m3j+bRW8q0ubgB14
         KtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S70zXzfMkV5dCR71ol96XxuHd/xWASEtpkzPbCrtjH0=;
        b=iETpjbiX6wP2ZFB1nTilxFvrRO+2WG5b/6K3BAD9jQQxO711qWLhXIElH7EXpKbn2V
         SRHfboLlex/w50vX08ryoDOy30B3RwuEgRobusi941JDQ6mHExcack8BMjDp00LdIONo
         fv2vKu7zPnHMreeiQ/wgbXVIW6nBlHRNE+PgmRZvUKFvecLh32G9Ob2JUfk/YgNdj7mB
         kUEjNDVyrhxAsHTG7tKPtZhZB84qA8y2JLwiqk4wpJbZbtCzOyPzlPeLgy2wS5rFKpxH
         uAblliaFHwa7psJVypV/DkFSbct55eNM3EiHwSvrBaVcIq0UMxZMrunu2QG/TFYP5HxJ
         OSiQ==
X-Gm-Message-State: AOAM533K0HGf8bbcy5P/Qv3emH+hVJuTFvMM7kK7v787cjfL91/61CJ9
        sJxi1JbFYF/OdD+O6YKodot8Fvs9/sU/z/mh7OClXQ==
X-Google-Smtp-Source: ABdhPJy0dlE+ivFcJHKfy/xIXvtipO4JmWMBgHnjVe3UgW68RAfD7e+5P2t35S9ntY716jdc+IUVyoWcJ/xOLOtcSkI=
X-Received: by 2002:a25:5645:: with SMTP id k66mr22552761ybb.259.1631020751540;
 Tue, 07 Sep 2021 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210907132336.GB17617@xsang-OptiPlex-9020>
In-Reply-To: <20210907132336.GB17617@xsang-OptiPlex-9020>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Sep 2021 15:19:00 +0200
Message-ID: <CAKfTPtBBW37uSoqWTXo7fUYT9vp4Z9FMERPdoZ9aBuhhkFk9Sg@mail.gmail.com>
Subject: Re: [sched/fair] e9b9734b74: UBSAN:shift-out-of-bounds_in_kernel/sched/fair.c
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 15:06, kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: e9b9734b74656abb585a7f6fabf1d30ce00e51ea ("sched/fair: Reduce cases for active balance")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
real culprit is probably 5a7f55590467 ("sched/fair: Relax constraint
on task's load during load balance")
and
commit 39a2a6eb5c9b ("sched/fair: Fix shift-out-of-bounds in
load_balance()") should have already fixed it

>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
>
> [   32.516177][    C1] ================================================================================
> [   32.518142][    C1] UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7741:14
> [   32.519764][    C1] shift exponent 111 is too large for 64-bit type 'long unsigned int'
> [   32.521337][    C1] CPU: 1 PID: 337 Comm: (sd-executor) Not tainted 5.11.0-rc2-00009-ge9b9734b7465 #1
> [   32.522980][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   32.528699][    C1] Call Trace:
> [   32.529366][    C1]  <IRQ>
> [   32.529950][    C1]  dump_stack+0xac/0xe3
> [   32.530839][    C1]  ubsan_epilogue+0xa/0x4e
> [   32.531685][    C1]  __ubsan_handle_shift_out_of_bounds+0x162/0x17d
> [   32.532878][    C1]  ? can_migrate_task+0x4f2/0x890
> [   32.533859][    C1]  load_balance.cold+0x17/0x25
> [   32.534738][    C1]  ? lock_acquire+0xaf/0x400
> [   32.535586][    C1]  rebalance_domains+0x351/0x550
> [   32.536587][    C1]  __do_softirq+0xd3/0x558
> [   32.537417][    C1]  asm_call_irq_on_stack+0xf/0x20
> [   32.538396][    C1]  </IRQ>
> [   32.539033][    C1]  do_softirq_own_stack+0x9d/0xb0
> [   32.539962][    C1]  irq_exit_rcu+0xe0/0xf0
> [   32.540798][    C1]  sysvec_apic_timer_interrupt+0x71/0xf0
> [   32.541805][    C1]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [   32.542893][    C1] RIP: 0010:__slab_alloc+0x14/0x60
> [   32.543848][    C1] Code: ff ff ff e9 47 fa ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 83 ec 20 9c 5b fa f6 c7 02 75 0d e8 4e f7 ff ff 53 9d <48> 83 c4 20 5b c3 4c 89 44 24 18 48 89 4c 24 10 89 54 24 0c 89 74
> [   32.547146][    C1] RSP: 0018:ffffc90001cbfbc8 EFLAGS: 00000282
> [   32.548300][    C1] RAX: ffff8881456e27d8 RBX: 0000000000000282 RCX: 0000000000000006
> [   32.549836][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff813c4939
> [   32.551308][    C1] RBP: ffff8881008b11c0 R08: 0000000000000001 R09: 0000000000000001
> [   32.553506][    C1] R10: 0000000000000001 R11: 0000000000080000 R12: 0000000000000001
> [   32.555016][    C1] R13: 0000000000000000 R14: 0000000000002800 R15: ffffffff8139ae1c
> [   32.560568][    C1]  ? anon_vma_clone+0x6c/0x2b0
> [   32.561556][    C1]  ? __slab_alloc+0x59/0x60
> [   32.562394][    C1]  ? anon_vma_clone+0x6c/0x2b0
> [   32.563296][    C1]  kmem_cache_alloc+0x33a/0x3c0
> [   32.564252][    C1]  anon_vma_clone+0x6c/0x2b0
> [   32.565132][    C1]  anon_vma_fork+0x38/0x150
> [   32.565964][    C1]  dup_mmap+0x449/0x620
> [   32.566798][    C1]  dup_mm+0x63/0x120
> [   32.567639][    C1]  copy_process+0x1b7e/0x2050
> [   32.568586][    C1]  ? kvm_sched_clock_read+0x14/0x30
> [   32.569524][    C1]  ? sched_clock+0x5/0x10
> [   32.570386][    C1]  ? sched_clock_cpu+0x11e/0x150
> [   32.571321][    C1]  kernel_clone+0xb8/0xa20
> [   32.572206][    C1]  ? kvm_sched_clock_read+0x14/0x30
> [   32.573140][    C1]  ? sched_clock+0x5/0x10
> [   32.573943][    C1]  ? sched_clock_cpu+0x11e/0x150
> [   32.574845][    C1]  ? __might_fault+0x47/0xa0
> [   32.575711][    C1]  __do_sys_clone+0x66/0x80
> [   32.580655][    C1]  do_syscall_64+0x52/0x60
> [   32.581569][    C1]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   32.582621][    C1] RIP: 0033:0x7fa44a0ae7be
> [   32.583445][    C1] Code: db 0f 85 25 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 b6 00 00 00 41 89 c4 85 c0 0f 85 c3 00 00
> [   32.586835][    C1] RSP: 002b:00007ffce49cc6f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [   32.588340][    C1] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa44a0ae7be
> [   32.589777][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [   32.591207][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fa448f21940
> [   32.592654][    C1] R10: 00007fa448f21c10 R11: 0000000000000246 R12: 0000000000000020
> [   32.594231][    C1] R13: 00007fa449f1741c R14: 00007ffce49cc8b8 R15: 0000000000000001
> [   32.595648][    C1] ================================================================================
>
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.11.0-rc2-00009-ge9b9734b7465 .config
>         make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>
