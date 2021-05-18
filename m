Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22E387530
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbhERJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241318AbhERJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FFE1FB;
        Tue, 18 May 2021 02:33:06 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C56C3F719;
        Tue, 18 May 2021 02:33:03 -0700 (PDT)
Date:   Tue, 18 May 2021 10:32:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
Message-ID: <20210518093211.GA82842@C02TD0UTHF1T.local>
References: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
 <878s4cv20v.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s4cv20v.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:12:32AM +0100, Marc Zyngier wrote:
> + Michael
> 
> On Mon, 17 May 2021 22:52:59 +0100,
> John Stultz <john.stultz@linaro.org> wrote:
> > 
> > With v5.13-rc2, I've been seeing an odd boot regression with the
> > DragonBoard 845c:
> > 
> > Unfortunately, trying to bisect it down (v5.13-rc1 works ok) is giving
> > me inconsistent results so far. It feels a bit like maybe some config
> > option gets enabled moving forward, and then sticks around when we go
> > back.  I'll take another swing at bisecting it later today, but I have
> > to move on to some other work right now, so I figured I'd share (with
> > folks who better know the recent __apply_alternatives changes) in case
> > folks have a better idea:
> > 
> > [    0.254384] CPU features: detected: RAS Extension Support
> > [    0.259928] CPU: All CPU(s) started at EL1
> > [    0.264127] alternatives: patching kernel code
> > [    0.268635] ------------[ cut here ]------------
> > [    0.273303] kernel BUG at arch/arm64/kernel/alternative.c:157!
> > [    0.279192] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [    0.284736] Modules linked in:
> > [    0.287833] CPU: 0 PID: 14 Comm: migration/0 Not tainted
> > 5.13.0-rc2-mainline #4501
> > [    0.295472] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [    0.301182] Stopper: multi_cpu_stop+0x0/0x1a0 <-
> > stop_machine_cpuslocked+0x128/0x160
> > [    0.309020] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
> > [    0.315086] pc : __apply_alternatives+0x1f0/0x270
> > [    0.319847] lr : __apply_alternatives+0xf4/0x270
> > [    0.324515] sp : ffffffc01020bca0
> > [    0.327874] x29: ffffffc01020bca0 x28: 00000000000000a0 x27: ffffffd7f5c11124
> > [    0.335086] x26: ffffffd7f5c11128 x25: 00000000001b0020 x24: ffffffd7f700ab90
> > [    0.342297] x23: 0000000000000000 x22: ffffffc01020bd20 x21: ffffffd7f7bea374
> > [    0.349508] x20: ffffffc01020bd30 x19: ffffffd7f72194fc x18: ffffffffffffffff
> > [    0.356718] x17: ffffffd7f7bdce40 x16: 000000005c8e1b43 x15: ffffffd7f76d9d10
> > [    0.363929] x14: ffffffc09020b967 x13: ffffffc01020b975 x12: ffffffd7f76d9e30
> > [    0.371140] x11: 0000000005f5e0ff x10: ffffffc01020b8c0 x9 : 00000000ffffffd0
> > [    0.378350] x8 : 6b20676e69686374 x7 : ffffffd7f79b9238 x6 : c0000000ffff7fff
> > [    0.385560] x5 : 0000000000000000 x4 : ffffffd7f5c22898 x3 : 0000000000000010
> > [    0.392771] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 000000000000003f
> > [    0.399982] Call trace:
> > [    0.402461]  __apply_alternatives+0x1f0/0x270
> > [    0.406873]  __apply_alternatives_multi_stop+0xc0/0xe0
> > [    0.412062]  multi_cpu_stop+0xb8/0x1a0
> > [    0.415851]  cpu_stopper_thread+0xac/0x120
> > [    0.419997]  smpboot_thread_fn+0x200/0x238
> > [    0.424146]  kthread+0x14c/0x158
> > [    0.427423]  ret_from_fork+0x10/0x1c
> > [    0.431045] Code: 39402e61 39402a62 6b01005f 54fff500 (d4210000)
> > [    0.437199] ---[ end trace 523e13d9d60a992d ]---
> > [    0.441868] note: migration/0[14] exited with preempt_count 2
> > [    0.447739] migration/0 (14) used greatest stack depth: 12448 bytes left
> 
> [/me digs in my IRC logs]
> 
> This looks a lot like an issue that was reported my Michael Walle a
> few days ago on IRC, leading to a crash that looked like this:
> 
> [    0.325238] alternatives: patching kernel code
> [    0.329735] ------------[ cut here ]------------
> [    0.334394] kernel BUG at arch/arm64/kernel/alternative.c:157!
> [    0.340300] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.345836] Modules linked in:
> [    0.348916] CPU: 0 PID: 14 Comm: migration/0 Not tainted 5.13.0-rc1-next-20210511+ #536
> [    0.356998] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
> [    0.365339] Stopper: multi_cpu_stop+0x0/0x1a8 <- stop_cpus.constprop.9+0x78/0xc8
> [    0.372820] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
> [    0.378882] pc : __apply_alternatives.isra.1+0x1c4/0x270
> [    0.384246] lr : __apply_alternatives.isra.1+0x110/0x270
> [    0.389606] sp : ffff800012db3ca0
> [    0.392946] x29: ffff800012db3ca0 x28: 0000000000000000 x27: ffff800010011924
> [    0.400155] x26: ffff800010011928 x25: 00000000001b0020 x24: ffff8000115ad350
> [    0.407364] x23: ffff800012db3d28 x22: 0000000000000000 x21: ffff800011fb24cd
> [    0.414571] x20: ffff800012db3d30 x19: ffff800011840b38 x18: 0000000000000010
> [    0.421779] x17: 0000000044a56c23 x16: 0000000000000002 x15: ffffffffffffffff
> [    0.428986] x14: ffff800011d50a48 x13: ffff800092db3987 x12: ffff800011de6a70
> [    0.436193] x11: 0000000000000003 x10: ffff800011dcea30 x9 : ffff8000105d8928
> [    0.443401] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> [    0.450608] x5 : 0000000000000000 x4 : ffff800010024398 x3 : 0000000000000010
> [    0.457815] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 000000000000003f
> [    0.465022] Call trace:
> [    0.467483]  __apply_alternatives.isra.1+0x1c4/0x270
> [    0.472493]  __apply_alternatives_multi_stop+0xcc/0xe0
> [    0.477679]  multi_cpu_stop+0xac/0x1a8
> [    0.481460]  cpu_stopper_thread+0xa4/0x138
> [    0.485592]  smpboot_thread_fn+0x12c/0x268
> [    0.489725]  kthread+0x164/0x168
> [    0.492980]  ret_from_fork+0x10/0x30
> [    0.496588] Code: 39402e61 39402a62 6b01005f 54fff6a0 (d4210000) 
> [    0.502742] ---[ end trace 24ef7d65759ab825 ]---
> [    0.507398] note: migration/0[14] exited with preempt_count 2
> [    0.513290] ------------[ cut here ]------------
> 
> Michael subsequently reported that:
> 
> <quote>
>  mhh nevermind, I can't reproduce it anymore. Maybe I should have
>  recompiled with a clean build dir at first
> </quote>
> 
> My gut feeling is that we can end-up with some build leftovers when
> going between -rc1 and -rc2, hence the screw-up when the capabilities
> get reordered. Dependency issues?

I've just reproduced this, and I'm dissecting what I have. It looks like
something goes wrong when moving from v5,13-rc1 to v5.13-rc2.

Reproduction steps below. Note `usekorg` is my script to run a specific
build of the kernel.org crosstool binaries.

$ git clean -fdx
$ git checkout v5.13-rc1
$ usekorg 10.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- defconfig
$ usekorg 10.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- Image -j50
$ git checkout v5.13-rc2
$ usekorg 10.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- Image -j50

... then when I run the resulting Image in a KVM guest on ThunderX2, I
get a splat at boot:

[    0.437023] ------------[ cut here ]------------
[    0.438314] kernel BUG at arch/arm64/kernel/alternative.c:157!
[    0.439970] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.441428] Modules linked in:
[    0.442293] CPU: 0 PID: 12 Comm: migration/0 Not tainted 5.13.0-rc2 #2
[    0.444123] Hardware name: linux,dummy-virt (DT)
[    0.445351] Stopper: multi_cpu_stop+0x0/0x17c <- stop_machine_cpuslocked+0x11c/0x16c
[    0.447542] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
[    0.449155] pc : __apply_alternatives+0x210/0x250
[    0.450473] lr : __apply_alternatives+0xf8/0x250
[    0.451800] sp : ffff8000100abcb0
[    0.452718] x29: ffff8000100abcb0 x28: ffffa8930f011128 x27: ffffa8931070f4c8
[    0.454836] x26: ffffa8930f01112c x25: 00000000001b0020 x24: ffffa89310470650
[    0.456854] x23: 0000000000000000 x22: ffffa89310f5ea84 x21: ffff8000100abd30
[    0.458957] x20: ffff8000100abd40 x19: ffffa8931070f4cc x18: 0000000000000030
[    0.460944] x17: ffff16ea7efee940 x16: 0000000000000068 x15: ffff16e94016a050
[    0.463142] x14: ffffffffffffffff x13: ffffa89310ca29d8 x12: 0000000000000135
[    0.465157] x11: 0000000000000067 x10: ffffa89310cfa9d8 x9 : 00000000fffff000
[    0.467292] x8 : ffffa89310ca29d8 x7 : ffffa89310cfa9d8 x6 : 0000000000000000
[    0.469273] x5 : 0000000000000000 x4 : 000000000000003f x3 : ffffffffffffffc0
[    0.471471] x2 : 0000000000000023 x1 : 0000000000000004 x0 : 0000000000000000
[    0.473532] Call trace:
[    0.474216]  __apply_alternatives+0x210/0x250
[    0.475426]  __apply_alternatives_multi_stop+0xc0/0xd4
[    0.476994]  multi_cpu_stop+0xa8/0x17c
[    0.478052]  cpu_stopper_thread+0x9c/0x130
[    0.479235]  smpboot_thread_fn+0x254/0x280
[    0.480434]  kthread+0x158/0x160
[    0.481395]  ret_from_fork+0x10/0x30
[    0.482449] Code: 8b040264 d63f0080 f94006a1 17ffffc9 (d4210000) 
[    0.484144] ---[ end trace f570e0f98f46a6c3 ]---

Thanks,
Mark.
