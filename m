Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF59D38FE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhEYJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:54:44 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56183 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhEYJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:54:43 -0400
Received: by mail-il1-f197.google.com with SMTP id a15-20020a927f0f0000b02901ac2bdd733dso34515284ild.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=M6LuaOQoA3w46G0O6SwByXNhy70Wfv5aJGZHV4LZyhg=;
        b=IlaZYX4YZFRJEEU8dmEwNdsN+Z0NNYee5SJ5V43CsqwLdT23wWSJYihHvElmqnzweo
         xG9dVvyrV92aXTJPHmNEXiSOft5zvvlT4EQTDt2osQmIcs/mf/IcrZBbGTv3fKm44rPl
         Vb7jT2vASaEj99lrCPMve7vf/ydg3pYO0anzLgu88VgRW83YsSUfJ7XmiTMeBeqYA2gj
         gfrUmEupRihZxoPImcJtVZmc2CafY8+r5yMf0sFS+ChS2q4ZJ56QC7Nq/rq56nUZuHT7
         PZV1vEIuER+Fskyy5Bx9bAlG+EAQLREfQk2dHM93SIGhm+dEhojmAVoTznDb0tycDQnZ
         oCaA==
X-Gm-Message-State: AOAM533G637P8ekdl27GAM9XlH9HTL5oGymayt8MTnPjCWoegB5+CRb7
        b+SkfkNCPLNrjkH6X0DcvQ7aYW84kG/yz598IwGK7fdhSZKW
X-Google-Smtp-Source: ABdhPJycP822IAfKH5Uz+8mHLt8ROuoTrHdBUTxAUEefP3L/88YWqwMeYKA1l2HdfPaM48LUuirKYETLVDby/b51nGGKhZfd8fK4
MIME-Version: 1.0
X-Received: by 2002:a6b:7d4b:: with SMTP id d11mr20154500ioq.161.1621936393628;
 Tue, 25 May 2021 02:53:13 -0700 (PDT)
Date:   Tue, 25 May 2021 02:53:13 -0700
In-Reply-To: <CACT4Y+Z8NDQPN0WFnfQL_26B4OdAUEjVziYKErcyGhcxv=zskg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097310705c3247e9e@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_epoll_wait (5)
From:   syzbot <syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     bp@alien8.de, dvyukov@google.com, hpa@zytor.com, jroedel@suse.de,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, May 23, 2021 at 3:30 PM syzbot
> <syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    a1f92694 Add linux-next specific files for 20210518
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=153eaa07d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4e0bd67836a023cc6d01
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10130d1ed00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+4e0bd67836a023cc6d01@syzkaller.appspotmail.com
>
> Looks like a dup of:
> https://syzkaller.appspot.com/bug?id=0d02d5e232cfc4403fd12fca1f0a9bfd2a82683f
> #syz dup: INFO: rcu detected stall in mac80211_hwsim_beacon

Can't dup bug to a bug in different reporting (upstream->internal).Please dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.

>
> Somehow rcu detected the stall on the other CPU, which made it look
> like a stall in sys_epoll_wait.
>
>
>> 3 locks held by systemd-udevd/10927:
>>  #0: ffff88802c570088 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
>>  #0: ffff88802c570088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
>>  #1: ffff88802d4cb578 (kn->active#96){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
>>  #1: ffff88802d4cb578 (kn->active#96){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
>>  #2: ffff888037a2a220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:749 [inline]
>>  #2: ffff888037a2a220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:897
>> =============================================
>> rcu: INFO: rcu_preempt self-detected stall on CPU
>> rcu:    1-...!: (6 ticks this GP) idle=c0a/1/0x4000000000000000 softirq=13589/13590 fqs=1
>>         (t=11336 jiffies g=15153 q=7841)
>> rcu: rcu_preempt kthread starved for 11334 jiffies! g15153 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>> rcu: RCU grace-period kthread stack dump:
>> task:rcu_preempt     state:R  running task     stack:28864 pid:   14 ppid:     2 flags:0x00004000
>> Call Trace:
>>  context_switch kernel/sched/core.c:4688 [inline]
>>  __schedule+0xb38/0x58c0 kernel/sched/core.c:5945
>>  schedule+0xcf/0x270 kernel/sched/core.c:6024
>>  schedule_timeout+0x14a/0x250 kernel/time/timer.c:1878
>>  rcu_gp_fqs_loop kernel/rcu/tree.c:1996 [inline]
>>  rcu_gp_kthread+0xd21/0x1960 kernel/rcu/tree.c:2169
>>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>> rcu: Stack dump where RCU GP kthread last ran:
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 4855 Comm: systemd-journal Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:in_irq_stack arch/x86/kernel/dumpstack_64.c:159 [inline]
>> RIP: 0010:get_stack_info_noinstr+0xdb/0x120 arch/x86/kernel/dumpstack_64.c:176
>> Code: 8b 05 b1 af e4 76 48 8d 90 08 80 ff ff 48 8d 48 08 49 39 d4 72 25 49 39 cc 73 20 c7 45 00 02 00 00 00 48 89 55 08 48 89 4d 10 <48> 8b 00 48 89 45 18 b8 01 00 00 00 e9 3a ff ff ff 5b 48 89 ee 4c
>> RSP: 0018:ffffc900000077c0 EFLAGS: 00000283
>> RAX: ffffc90000007ff8 RBX: fffffe0000008000 RCX: ffffc90000008000
>> RDX: ffffc90000000000 RSI: 0000000000000100 RDI: 0000000000000000
>> RBP: ffffc90000007860 R08: 0000000000000001 R09: ffffc90000007860
>> R10: fffff52000000f17 R11: 000000000000003f R12: ffffc90000007810
>> R13: ffffc90000007860 R14: ffffc90000007898 R15: ffffc90000007860
>> FS:  00007f8d260ca8c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000541198 CR3: 0000000017124000 CR4: 00000000001506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <IRQ>
>>  get_stack_info+0x2d/0x90 arch/x86/kernel/dumpstack_64.c:193
>>  __unwind_start+0x4ae/0x800 arch/x86/kernel/unwind_orc.c:668
>>  unwind_start arch/x86/include/asm/unwind.h:60 [inline]
>>  arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
>>  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
>>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
>>  ____kasan_slab_free mm/kasan/common.c:363 [inline]
>>  ____kasan_slab_free mm/kasan/common.c:328 [inline]
>>  __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:371
>>  kasan_slab_free include/linux/kasan.h:212 [inline]
>>  slab_free_hook mm/slub.c:1623 [inline]
>>  slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1648
>>  slab_free mm/slub.c:3208 [inline]
>>  kmem_cache_free+0x8e/0x5a0 mm/slub.c:3224
>>  kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:684
>>  __kfree_skb net/core/skbuff.c:741 [inline]
>>  consume_skb net/core/skbuff.c:896 [inline]
>>  consume_skb+0xcf/0x160 net/core/skbuff.c:890
>>  mac80211_hwsim_tx_frame+0x157/0x1e0 drivers/net/wireless/mac80211_hwsim.c:1776
>>  mac80211_hwsim_beacon_tx+0x49e/0x920 drivers/net/wireless/mac80211_hwsim.c:1829
>>  __iterate_interfaces+0x1e5/0x520 net/mac80211/util.c:793
>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1852
>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
>>  __do_softirq+0x29b/0x9fb kernel/softirq.c:559
>>  invoke_softirq kernel/softirq.c:433 [inline]
>>  __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
>>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
>>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>>  </IRQ>
>>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
>> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
>> RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
>> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
>> Code: 01 f0 4d 89 03 e9 63 fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 <65> 8b 05 e9 1b 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
>> RSP: 0018:ffffc9000132fb58 EFLAGS: 00000202
>> RAX: 0000000000110819 RBX: 1ffff92000265f6c RCX: 1ffffffff208fdc2
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000bb8 R08: 0000000000000001 R09: ffffffff90440a07
>> R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000004b
>> R13: ffff8880143d8000 R14: 0000000000000000 R15: 0000000000000001
>>  devkmsg_poll+0x173/0x260 kernel/printk/printk.c:847
>>  vfs_poll include/linux/poll.h:90 [inline]
>>  ep_item_poll+0xf4/0x190 fs/eventpoll.c:846
>>  ep_send_events fs/eventpoll.c:1683 [inline]
>>  ep_poll fs/eventpoll.c:1798 [inline]
>>  do_epoll_wait+0x727/0x1940 fs/eventpoll.c:2226
>>  __do_sys_epoll_wait fs/eventpoll.c:2238 [inline]
>>  __se_sys_epoll_wait fs/eventpoll.c:2233 [inline]
>>  __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2233
>>  do_syscall_64+0x31/0xb0 arch/x86/entry/common.c:47
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x7f8d253932e3
>> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
>> RSP: 002b:00007ffef4b74df8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
>> RAX: ffffffffffffffda RBX: 0000560d633031e0 RCX: 00007f8d253932e3
>> RDX: 0000000000000013 RSI: 00007ffef4b74e00 RDI: 0000000000000008
>> RBP: 00007ffef4b74ff0 R08: 431bde82d7b634db R09: 00007ffef4b99080
>> R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffef4b74e00
>> R13: 0000000000000001 R14: ffffffffffffffff R15: 0005c2ae65972648
>> NMI backtrace for cpu 1
>> CPU: 1 PID: 8449 Comm: kworker/u4:8 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: bat_events batadv_nc_worker
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x13e/0x1d6 lib/dump_stack.c:129
>>  nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
>>  nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
>>  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>>  rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:342
>>  print_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
>>  check_cpu_stall kernel/rcu/tree_stall.h:700 [inline]
>>  rcu_pending kernel/rcu/tree.c:3922 [inline]
>>  rcu_sched_clock_irq.cold+0x3f1/0x74b kernel/rcu/tree.c:2641
>>  update_process_times+0x16d/0x200 kernel/time/timer.c:1782
>>  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
>>  tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1420
>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>>  __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1601
>>  hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
>>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
>>  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
>>  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1100
>>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
>> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
>> RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
>> Code: 74 24 10 e8 aa 03 3b f8 48 89 ef e8 42 7c 3b f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 13 99 2e f8 65 8b 05 ec 98 e1 76 85 c0 74 0a 5b 5d c3 e8 e0 90
>> RSP: 0018:ffffc90000dc0c80 EFLAGS: 00000206
>> RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff2093eea
>> RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
>> RBP: ffff8880176a2218 R08: 0000000000000001 R09: ffffffff90440a5f
>> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000246
>> R13: ffff8880176a2218 R14: 0000000000000021 R15: ffff8880176a2108
>>  spin_unlock_irqrestore include/linux/spinlock.h:414 [inline]
>>  input_repeat_key+0x118/0x380 drivers/input/input.c:201
>>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
>>  expire_timers kernel/time/timer.c:1462 [inline]
>>  __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
>>  __run_timers kernel/time/timer.c:1712 [inline]
>>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
>>  __do_softirq+0x29b/0x9fb kernel/softirq.c:559
>>  invoke_softirq kernel/softirq.c:433 [inline]
>>  __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
>>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
>>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>>  </IRQ>
>>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
>> RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
>> RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
>> RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:106 [inline]
>> RIP: 0010:lock_release+0x14a/0x720 kernel/locking/lockdep.c:5528
>> Code: 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 69 05 00 00 45 8b 8e 24 0a 00 00 45 85 c9 0f 85 9e 02 00 00 9c <8f> 04 24 fa 48 c7 c7 60 b8 8b 89 e8 46 14 c2 07 48 89 da 83 e3 07
>> RSP: 0018:ffffc900017afbc0 EFLAGS: 00000246
>> RAX: 0000000000000007 RBX: ffffffff8de9f76c RCX: 0000000000000001
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888016978a24
>> RBP: 1ffff920002f5f7b R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c17afe0
>> R13: 0000000000000000 R14: ffff888016978000 R15: 000000000000026b
>>  rcu_lock_release include/linux/rcupdate.h:272 [inline]
>>  rcu_read_unlock include/linux/rcupdate.h:720 [inline]
>>  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
>>  batadv_nc_worker+0x771/0xe50 net/batman-adv/network-coding.c:715
>>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
>>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
>>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007e3bc605c2ff4bf3%40google.com.
