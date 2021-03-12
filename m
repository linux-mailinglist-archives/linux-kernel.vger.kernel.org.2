Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9143392CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhCLQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCLQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:10:57 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EABC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:10:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f12so4102424qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTlJebjzAhOrbXbvHuHkRZ64VAk6M9r7vPronU5acgY=;
        b=cl5I73Fi6uwMkYkJBIhoN2eMDQzhKURe92etMIf9PW4MA5IHYc95LeMOOu+6Hw8ceb
         4n8LwDog1mGkjRE+HQHXm8dPPSHYKWSxaAUb3hWjf0kRzQaiTpEdeBdt72bODsafUlQU
         PTQpdu6Ho0LeQncDnOLDnIcxK1gFBPqfP/WkhFZdyy9Dlz93XFMj97T+r7+telB/mjs9
         SaYlz54GG/YBGsycaEvg4/jjLAQYE1x/i7UhCtiKRv68qSDzi8Wx49NlPHJEDTHRzFU+
         yeDKIEcbvBbxDr6ZB0hrriJXnx/CVDYZ4gzpAIFi5HJbtAo8kbbRt9d4qv5SqSlyLnpN
         QoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTlJebjzAhOrbXbvHuHkRZ64VAk6M9r7vPronU5acgY=;
        b=N9n8aMhLXKgyLUK67+WHAQJgHqiPoAG9m84IYMT8wHhuu22hQGN7JGmkvePqlCXdRh
         5F6QHByzzFh3w08g8R9U2mB1GaGB6Gz0HQPviP7zQyx9laGpmYO9JTkkmCsKGzpUJ2c7
         V3+tDvubtufpgw4KluifRSEBuJfbPsl9ros+dwtMpAmfmYMwSj6ZZIbKl/SHdgE1H2C6
         cgpdVJ9O2gLP5Nb15RIWqewBeUUxQ6r9uBfsy0xQU7mZQcDf8e5z6jJ+Ej2PRU9hAGK5
         Xum8x69E+uHQML5ggRWPFqqFyJosaEm200sbgDrswOAQR514/a2e4lkL21PtCg9R2Ho2
         4V8g==
X-Gm-Message-State: AOAM531rdX3AAy/H6M29G0i6Aq5p2vPjx57E+TtHrA7gjyKkWzzHi9lJ
        1KpOnzCOvsjS3s+mt/f3Kpzdl6KrrtjWn2heHIKoYw==
X-Google-Smtp-Source: ABdhPJyjbertmxSluCrsWFZMeBJNtneOh+y1yDsAG7sSSJj1URjDIg0wpaGpd9OanyEY4oSNwtwsP3jjCMTQ48C/aLw=
X-Received: by 2002:ac8:5847:: with SMTP id h7mr12086113qth.43.1615565455494;
 Fri, 12 Mar 2021 08:10:55 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009cd8d505bd545452@google.com> <CACT4Y+a68cidsRa1zd8h=rNVkwyYKdihBtO2YBPyyxwc2Twpng@mail.gmail.com>
 <YEt5MfyAB7YCFFhl@phenom.ffwll.local>
In-Reply-To: <YEt5MfyAB7YCFFhl@phenom.ffwll.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 17:10:43 +0100
Message-ID: <CACT4Y+ZRxiFB2GvGSg-ucka23aHYLzxfg09tgpnm1fQGAmTChg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: WARNING in vkms_vblank_simulate
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+333bd014262fd5d0a418@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, melissa.srw@gmail.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 3:22 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Mar 12, 2021 at 11:46:27AM +0100, Dmitry Vyukov wrote:
> > On Fri, Mar 12, 2021 at 11:26 AM syzbot
> > <syzbot+333bd014262fd5d0a418@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    f78d76e7 Merge tag 'drm-fixes-2021-03-12-1' of git://anong..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11c16ba2d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=dc02c6afcb046874
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=333bd014262fd5d0a418
> > > userspace arch: arm
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+333bd014262fd5d0a418@syzkaller.appspotmail.com
> >
> > This WARNING seems to be happening just randomly.
> > It was already reported as:
> >
> > #syz dup: WARNING in vkms_vblank_simulate (2)
> > https://syzkaller.appspot.com/bug?id=9b10491371879700d6a21c15684c2232ff015084
> >
> > It now has whooping 48589 crashes and also crashes slow qemu tcg instances.
>
> Yeah your box is too slow. We're trying to simulate hw here, which means
> if we can process less than 1 hrtimer per vblank (standard every 16ms)
> then we scream, because things go very wrong with the simulated hw. And
> the hrtimer is really not that big, all the expensive processing is pushed
> to worker, where we have code to handle if it falls back too much.
>
> So either patch this out or make the code robust against a kernel that
> somehow can't process a single hrtimer every 16ms.
> -Daniel

Majority of these happen on the latest Intel CPUs. If that's not fast,
then I don't know what' fast :)
WARNING must not be used for timing-triggerable conditions. pr_warn is
more appropriate here. I assume the call stack and the rest of the
info that WARNING prints is completely useless, it's only the binary
condition, right.


> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/vkms/vkms_crtc.c:21 vkms_vblank_simulate+0x26c/0x2f4 drivers/gpu/drm/vkms/vkms_crtc.c:41
> > > Modules linked in:
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc2-syzkaller-00338-gf78d76e72a46 #0
> > > Hardware name: linux,dummy-virt (DT)
> > > pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> > > pc : vkms_vblank_simulate+0x26c/0x2f4 drivers/gpu/drm/vkms/vkms_crtc.c:21
> > > lr : hrtimer_forward_now include/linux/hrtimer.h:510 [inline]
> > > lr : vkms_vblank_simulate+0x90/0x2f4 drivers/gpu/drm/vkms/vkms_crtc.c:19
> > > sp : ffff00006a693cd0
> > > x29: ffff00006a693cd0 x28: ffff00000c9d1e58
> > > x27: dfff800000000000 x26: ffff00006a67f540
> > > x25: 1fffe0000d4cfeb1 x24: 1fffe0000d4cfeaa
> > > x23: ffff00000c9d0d30 x22: 0000000000fe4c00
> > > x21: ffff00006a67f540 x20: ffff00000c9d0e58
> > > x19: ffff00000c9d1e58 x18: ffff00006a6a1b48
> > > x17: 1fffe00001952345 x16: 0000000000000000
> > > x15: ffff8000197bf810 x14: 1fffe0000d4d2750
> > > x13: 0000000000000001 x12: 0000000000000033
> > > x11: 1ffff00002fb4936 x10: 0000000000000007
> > > x9 : 1ffff00002fb4943 x8 : ffff800017d14c00
> > > x7 : 00000000f1f1f1f1 x6 : dfff800000000000
> > > x5 : 7fffffffffffffff x4 : 00000008e44f6b90
> > > x3 : 00000008e54db790 x2 : 00000008e44f6b90
> > > x1 : 00000008e54db790 x0 : 0000000000000002
> > > Call trace:
> > >  vkms_vblank_simulate+0x26c/0x2f4 drivers/gpu/drm/vkms/vkms_crtc.c:41
> > >  __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
> > >  __hrtimer_run_queues+0x590/0xe40 kernel/time/hrtimer.c:1583
> > >  hrtimer_interrupt+0x2d4/0x810 kernel/time/hrtimer.c:1645
> > >  timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
> > >  arch_timer_handler_phys+0x4c/0x70 drivers/clocksource/arm_arch_timer.c:665
> > >  handle_percpu_devid_irq+0x19c/0x330 kernel/irq/chip.c:930
> > >  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
> > >  generic_handle_irq kernel/irq/irqdesc.c:652 [inline]
> > >  __handle_domain_irq+0x11c/0x1f0 kernel/irq/irqdesc.c:689
> > >  handle_domain_irq include/linux/irqdesc.h:176 [inline]
> > >  gic_handle_irq+0x5c/0x1b0 drivers/irqchip/irq-gic.c:370
> > >  el1_irq+0xb4/0x180 arch/arm64/kernel/entry.S:669
> > >  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:124 [inline]
> > >  queue_work_on+0x74/0x110 kernel/workqueue.c:1528
> > >  queue_work include/linux/workqueue.h:507 [inline]
> > >  cursor_timer_handler+0x64/0x100 drivers/video/fbdev/core/fbcon.c:397
> > >  call_timer_fn+0x1d4/0x9c4 kernel/time/timer.c:1431
> > >  expire_timers kernel/time/timer.c:1476 [inline]
> > >  __run_timers.part.0+0x530/0xa00 kernel/time/timer.c:1745
> > >  __run_timers kernel/time/timer.c:1726 [inline]
> > >  run_timer_softirq+0xa4/0x1a0 kernel/time/timer.c:1758
> > >  _stext+0x2b4/0x1084
> > >  do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> > >  invoke_softirq kernel/softirq.c:228 [inline]
> > >  __irq_exit_rcu+0x46c/0x510 kernel/softirq.c:422
> > >  irq_exit+0x14/0x84 kernel/softirq.c:446
> > >  __handle_domain_irq+0x120/0x1f0 kernel/irq/irqdesc.c:692
> > >  handle_domain_irq include/linux/irqdesc.h:176 [inline]
> > >  gic_handle_irq+0x5c/0x1b0 drivers/irqchip/irq-gic.c:370
> > >  el1_irq+0xb4/0x180 arch/arm64/kernel/entry.S:669
> > >  arch_local_irq_enable+0xc/0x14 arch/arm64/include/asm/irqflags.h:37
> > >  default_idle_call+0x64/0xf4 kernel/sched/idle.c:112
> > >  cpuidle_idle_call kernel/sched/idle.c:194 [inline]
> > >  do_idle+0x38c/0x4ec kernel/sched/idle.c:300
> > >  cpu_startup_entry+0x28/0x80 kernel/sched/idle.c:397
> > >  rest_init+0x1d0/0x2cc init/main.c:721
> > >  arch_call_rest_init+0x10/0x1c
> > >  start_kernel+0x3b0/0x3e8 init/main.c:1064
> > >  0x0
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009cd8d505bd545452%40google.com.
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
