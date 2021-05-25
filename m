Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC438FE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhEYJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhEYJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:59:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:57:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a7so11355875qvf.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2G+a3KhL7giyiU3cumO+1VZ8nFP4g8cAZnQTQMYg9A=;
        b=g/UvupdTrBvqYCHiaZXraaSiS6etffB7H0bQr+nddkQrcVd03kT571oV6zxrSr9aRP
         pFGvnGDoI+s1fwKxiVN/EGg3YOf5q7Jmy9TUBeVjnN9zmUzFm222gCpbNJikTdBlyCo/
         MPdLZm1lpNvk84U/j98p/nllz6Hafq9L9H6EMw7tz287R+KjYcGn+kheG5qrmnS53W5E
         tTVFY4AjWYI9IOD5OSOsJlyV8K/PF/+snRbbwrC31EBBlznauc7JNqw71mAD1SWyFANE
         5tvddy9PSeirXYdXWhtf29N+Ds82BbFIXHVlZCMreMUVico/dIH9/Isyd2R0ma23EPdo
         1TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2G+a3KhL7giyiU3cumO+1VZ8nFP4g8cAZnQTQMYg9A=;
        b=lcCuAE1SESG9kUbAXZsb1pLMsYAsVVt8ISrh3U9M2bTkuALwPn4Wt/kxKGcgWhyoxQ
         FzAPO4pBaUIPK4d/48JQNDoKePuEzghE5c2IPp5Z7aPIMCA5jUL/nhKLRRzaIhBuD9de
         MkXsWDPxiiOemYyDu9mbTcvnpMb3taqd0qWMh4hhwPvJCgtpM0/QhhbLNyqbnqEPRVvz
         osnMTv9gEKe3VH5TxK1bR5y0Rv+XSlximGewwSy3UOAsSIgxI3UfSiA286EZTO/cpiPb
         GPlVZXQYFybswy4XGd4+qNz7LgBl26aitWOr6Mn5zWsC3dRMlIVk6wEdpcaDyWXip+tX
         paRg==
X-Gm-Message-State: AOAM531akYXXylqpiqAW0lnLlSVlJzPrGNDkzcDNnKaJBoArmg6kRj1T
        rACwJ72Nm3qjUlBZ7+CLIKNOuOxWZSTdo/p6lJbw/w==
X-Google-Smtp-Source: ABdhPJw+vqBGyqqrW8Lra9rgTU+EXu2LvaEum1FbKbEhFTzI8hct78ns+3rU3P0YgRBldeBNln8Oc1RKnimOgMPU2lA=
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr36223939qvb.13.1621936657494;
 Tue, 25 May 2021 02:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z8NDQPN0WFnfQL_26B4OdAUEjVziYKErcyGhcxv=zskg@mail.gmail.com>
 <00000000000097310705c3247e9e@google.com>
In-Reply-To: <00000000000097310705c3247e9e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 May 2021 11:57:26 +0200
Message-ID: <CACT4Y+ZUiS19Hcoi+TgjDSsWtTvUtpgEsLeN8Arcj-z6t4Oe+Q@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_epoll_wait (5)
To:     syzbot <syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        jroedel@suse.de, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 11:53 AM syzbot
<syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com> wrote:
>
> > On Sun, May 23, 2021 at 3:30 PM syzbot
> > <syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    a1f92694 Add linux-next specific files for 20210518
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=153eaa07d00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4e0bd67836a023cc6d01
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10130d1ed00000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com
> >
> > Looks like a dup of:
> > https://syzkaller.appspot.com/bug?id=0d02d5e232cfc4403fd12fca1f0a9bfd2a82683f
> > #syz dup: INFO: rcu detected stall in mac80211_hwsim_beacon
>
> Can't dup bug to a bug in different reporting (upstream->internal).Please dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.

Let's try:

https://syzkaller.appspot.com/bug?id=12583843806e7885cd666583a4a166c5f6b0c4d9
#syz dup: BUG: soft lockup in mac80211_hwsim_beacon


> > Somehow rcu detected the stall on the other CPU, which made it look
> > like a stall in sys_epoll_wait.
> >
> >
> >> 3 locks held by systemd-udevd/10927:
> >>  #0: ffff88802c570088 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
> >>  #0: ffff88802c570088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
> >>  #1: ffff88802d4cb578 (kn->active#96){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
> >>  #1: ffff88802d4cb578 (kn->active#96){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
> >>  #2: ffff888037a2a220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:749 [inline]
> >>  #2: ffff888037a2a220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:897
> >> =============================================
> >> rcu: INFO: rcu_preempt self-detected stall on CPU
> >> rcu:    1-...!: (6 ticks this GP) idle=c0a/1/0x4000000000000000 softirq=13589/13590 fqs=1
> >>         (t=11336 jiffies g=15153 q=7841)
> >> rcu: rcu_preempt kthread starved for 11334 jiffies! g15153 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> >> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> >> rcu: RCU grace-period kthread stack dump:
> >> task:rcu_preempt     state:R  running task     stack:28864 pid:   14 ppid:     2 flags:0x00004000
> >> Call Trace:
> >>  context_switch kernel/sched/core.c:4688 [inline]
> >>  __schedule+0xb38/0x58c0 kernel/sched/core.c:5945
> >>  schedule+0xcf/0x270 kernel/sched/core.c:6024
> >>  schedule_timeout+0x14a/0x250 kernel/time/timer.c:1878
> >>  rcu_gp_fqs_loop kernel/rcu/tree.c:1996 [inline]
> >>  rcu_gp_kthread+0xd21/0x1960 kernel/rcu/tree.c:2169
> >>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >> rcu: Stack dump where RCU GP kthread last ran:
> >> Sending NMI from CPU 1 to CPUs 0:
> >> NMI backtrace for cpu 0
> >> CPU: 0 PID: 4855 Comm: systemd-journal Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> RIP: 0010:in_irq_stack arch/x86/kernel/dumpstack_64.c:159 [inline]
> >> RIP: 0010:get_stack_info_noinstr+0xdb/0x120 arch/x86/kernel/dumpstack_64.c:176
> >> Code: 8b 05 b1 af e4 76 48 8d 90 08 80 ff ff 48 8d 48 08 49 39 d4 72 25 49 39 cc 73 20 c7 45 00 02 00 00 00 48 89 55 08 48 89 4d 10 <48> 8b 00 48 89 45 18 b8 01 00 00 00 e9 3a ff ff ff 5b 48 89 ee 4c
> >> RSP: 0018:ffffc900000077c0 EFLAGS: 00000283
> >> RAX: ffffc90000007ff8 RBX: fffffe0000008000 RCX: ffffc90000008000
> >> RDX: ffffc90000000000 RSI: 0000000000000100 RDI: 0000000000000000
> >> RBP: ffffc90000007860 R08: 0000000000000001 R09: ffffc90000007860
> >> R10: fffff52000000f17 R11: 000000000000003f R12: ffffc90000007810
> >> R13: ffffc90000007860 R14: ffffc90000007898 R15: ffffc90000007860
> >> FS:  00007f8d260ca8c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000000541198 CR3: 0000000017124000 CR4: 00000000001506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <IRQ>
> >>  get_stack_info+0x2d/0x90 arch/x86/kernel/dumpstack_64.c:193
> >>  __unwind_start+0x4ae/0x800 arch/x86/kernel/unwind_orc.c:668
> >>  unwind_start arch/x86/include/asm/unwind.h:60 [inline]
> >>  arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
> >>  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
> >>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
> >>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
> >>  ____kasan_slab_free mm/kasan/common.c:363 [inline]
> >>  ____kasan_slab_free mm/kasan/common.c:328 [inline]
> >>  __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:371
> >>  kasan_slab_free include/linux/kasan.h:212 [inline]
> >>  slab_free_hook mm/slub.c:1623 [inline]
> >>  slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1648
> >>  slab_free mm/slub.c:3208 [inline]
> >>  kmem_cache_free+0x8e/0x5a0 mm/slub.c:3224
> >>  kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:684
> >>  __kfree_skb net/core/skbuff.c:741 [inline]
> >>  consume_skb net/core/skbuff.c:896 [inline]
> >>  consume_skb+0xcf/0x160 net/core/skbuff.c:890
> >>  mac80211_hwsim_tx_frame+0x157/0x1e0 drivers/net/wireless/mac80211_hwsim.c:1776
> >>  mac80211_hwsim_beacon_tx+0x49e/0x920 drivers/net/wireless/mac80211_hwsim.c:1829
> >>  __iterate_interfaces+0x1e5/0x520 net/mac80211/util.c:793
> >>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
> >>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1852
> >>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> >>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
> >>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
> >>  __do_softirq+0x29b/0x9fb kernel/softirq.c:559
> >>  invoke_softirq kernel/softirq.c:433 [inline]
> >>  __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
> >>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
> >>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
> >>  </IRQ>
> >>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
> >> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
> >> RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
> >> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
> >> Code: 01 f0 4d 89 03 e9 63 fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 <65> 8b 05 e9 1b 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
> >> RSP: 0018:ffffc9000132fb58 EFLAGS: 00000202
> >> RAX: 0000000000110819 RBX: 1ffff92000265f6c RCX: 1ffffffff208fdc2
> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> RBP: 0000000000000bb8 R08: 0000000000000001 R09: ffffffff90440a07
> >> R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000004b
> >> R13: ffff8880143d8000 R14: 0000000000000000 R15: 0000000000000001
> >>  devkmsg_poll+0x173/0x260 kernel/printk/printk.c:847
> >>  vfs_poll include/linux/poll.h:90 [inline]
> >>  ep_item_poll+0xf4/0x190 fs/eventpoll.c:846
> >>  ep_send_events fs/eventpoll.c:1683 [inline]
> >>  ep_poll fs/eventpoll.c:1798 [inline]
> >>  do_epoll_wait+0x727/0x1940 fs/eventpoll.c:2226
> >>  __do_sys_epoll_wait fs/eventpoll.c:2238 [inline]
> >>  __se_sys_epoll_wait fs/eventpoll.c:2233 [inline]
> >>  __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2233
> >>  do_syscall_64+0x31/0xb0 arch/x86/entry/common.c:47
> >>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> RIP: 0033:0x7f8d253932e3
> >> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
> >> RSP: 002b:00007ffef4b74df8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
> >> RAX: ffffffffffffffda RBX: 0000560d633031e0 RCX: 00007f8d253932e3
> >> RDX: 0000000000000013 RSI: 00007ffef4b74e00 RDI: 0000000000000008
> >> RBP: 00007ffef4b74ff0 R08: 431bde82d7b634db R09: 00007ffef4b99080
> >> R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffef4b74e00
> >> R13: 0000000000000001 R14: ffffffffffffffff R15: 0005c2ae65972648
> >> NMI backtrace for cpu 1
> >> CPU: 1 PID: 8449 Comm: kworker/u4:8 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> Workqueue: bat_events batadv_nc_worker
> >> Call Trace:
> >>  <IRQ>
> >>  __dump_stack lib/dump_stack.c:88 [inline]
> >>  dump_stack_lvl+0x13e/0x1d6 lib/dump_stack.c:129
> >>  nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
> >>  nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
> >>  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
> >>  rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:342
> >>  print_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
> >>  check_cpu_stall kernel/rcu/tree_stall.h:700 [inline]
> >>  rcu_pending kernel/rcu/tree.c:3922 [inline]
> >>  rcu_sched_clock_irq.cold+0x3f1/0x74b kernel/rcu/tree.c:2641
> >>  update_process_times+0x16d/0x200 kernel/time/timer.c:1782
> >>  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
> >>  tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1420
> >>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
> >>  __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1601
> >>  hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
> >>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
> >>  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
> >>  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1100
> >>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
> >> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
> >> RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
> >> Code: 74 24 10 e8 aa 03 3b f8 48 89 ef e8 42 7c 3b f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 13 99 2e f8 65 8b 05 ec 98 e1 76 85 c0 74 0a 5b 5d c3 e8 e0 90
> >> RSP: 0018:ffffc90000dc0c80 EFLAGS: 00000206
> >> RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff2093eea
> >> RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
> >> RBP: ffff8880176a2218 R08: 0000000000000001 R09: ffffffff90440a5f
> >> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000246
> >> R13: ffff8880176a2218 R14: 0000000000000021 R15: ffff8880176a2108
> >>  spin_unlock_irqrestore include/linux/spinlock.h:414 [inline]
> >>  input_repeat_key+0x118/0x380 drivers/input/input.c:201
> >>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
> >>  expire_timers kernel/time/timer.c:1462 [inline]
> >>  __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
> >>  __run_timers kernel/time/timer.c:1712 [inline]
> >>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
> >>  __do_softirq+0x29b/0x9fb kernel/softirq.c:559
> >>  invoke_softirq kernel/softirq.c:433 [inline]
> >>  __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
> >>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
> >>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
> >>  </IRQ>
> >>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
> >> RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
> >> RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
> >> RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:106 [inline]
> >> RIP: 0010:lock_release+0x14a/0x720 kernel/locking/lockdep.c:5528
> >> Code: 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 69 05 00 00 45 8b 8e 24 0a 00 00 45 85 c9 0f 85 9e 02 00 00 9c <8f> 04 24 fa 48 c7 c7 60 b8 8b 89 e8 46 14 c2 07 48 89 da 83 e3 07
> >> RSP: 0018:ffffc900017afbc0 EFLAGS: 00000246
> >> RAX: 0000000000000007 RBX: ffffffff8de9f76c RCX: 0000000000000001
> >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888016978a24
> >> RBP: 1ffff920002f5f7b R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c17afe0
> >> R13: 0000000000000000 R14: ffff888016978000 R15: 000000000000026b
> >>  rcu_lock_release include/linux/rcupdate.h:272 [inline]
> >>  rcu_read_unlock include/linux/rcupdate.h:720 [inline]
> >>  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
> >>  batadv_nc_worker+0x771/0xe50 net/batman-adv/network-coding.c:715
> >>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
> >>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
> >>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
