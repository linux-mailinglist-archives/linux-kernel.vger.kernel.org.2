Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496C418DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhI0Czq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhI0Czp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:55:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58935C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 19:54:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j14so10770349plx.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qcraft-ai.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=FhHLiSp0N8Y7r7RjQO2xWk4EbjynVzAJss09GhCE63o=;
        b=aj0q8v1Om+Zj5+ltt8snO4Ce29Cm7X7jwIDjHIdJD3ofMf06Awyz2hLCg6MHu6tlMH
         S8INX+6tLmwtL+/zosIHmzSCt41PJMUxAQ8Ps3+g1ZHxWtKiDFUeeGXs5JaUjo5Yn+nL
         fHlkIXZyqWLF8/kCdzsE64GiN4y5MJnJvJfZH0T2W1ZrCXTXs4Ao2dxA4ev/6whrH9fY
         nPBtbBFqAPdJXayNlfBYcIXhQycA44ny5ommO3SwQoM5sJdYfmvTfestS8OfsbtNNq5m
         FjvGfvBhi+afCphkWtMyINypkwelPJ2yDYyeECRA8FIgdBuV8HxOw/txkLlsdIrYwwY9
         hjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FhHLiSp0N8Y7r7RjQO2xWk4EbjynVzAJss09GhCE63o=;
        b=634Tp09UK4aCVW5FjcMwph9pbfnOYIns//T1Hd4OPF25IB5dGy5Nh8BL9Pl5dIpqsv
         WGiPaa3SCQXbcmt+gLWcdy3wlHhLMYx4snfPLoqJzJ3MIPaj78lJXRYfznFBXHJT4met
         2F6kKpCQugU06TnjHD5/CKdt7g9bJfQNPFe8TdX9w/bnxEmsLNa/EVEcSrq/7dhpPida
         veearCdig3F7tg+rj7aR/I2Y4qnwzmKxsMu9NvuywiV06adz1YwkgRxOI0xNw05nWvpc
         ajp+658WJHbCHdz800InNn6EyczAwuUW31Rnf2D0kBSY2Cw0m/SI4E6Qts5nZvAIuAwC
         rtZg==
X-Gm-Message-State: AOAM530/h50PK6Zadh4v2V0JqelenNBHieKvw+X7MWDaMSxi3T1NQ8TF
        Qj30tvGDsN6yY28SOLrW8L/8GA==
X-Google-Smtp-Source: ABdhPJwdaVLHpxITiy5QPpf7cquisFoFj4x93Y0M9W+mhm48+9qp8fW+oUp9geP9Og1S6ylXpc8fow==
X-Received: by 2002:a17:90a:578e:: with SMTP id g14mr17163365pji.184.1632711247700;
        Sun, 26 Sep 2021 19:54:07 -0700 (PDT)
Received: from [172.18.4.161] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id s2sm18674232pjs.56.2021.09.26.19.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 19:54:07 -0700 (PDT)
Subject: Re: [syzbot] INFO: rcu detected stall in io_ring_exit_work
To:     syzbot <syzbot+49a58b47c63ba584ff51@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jirislaby@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, axboe@kernel.dk
References: <000000000000d2f3ef05ccc6a52e@google.com>
From:   zhangqiang <zhangqiang@qcraft.ai>
Message-ID: <2b6450ae-1861-bdbc-6f65-ca9aedd7aa37@qcraft.ai>
Date:   Mon, 27 Sep 2021 10:54:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <000000000000d2f3ef05ccc6a52e@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/25 上午8:07, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5a5d008887b4 Add linux-next specific files for 20210924
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1094cbf7300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae26deb010ccc26f
> dashboard link: https://syzkaller.appspot.com/bug?extid=49a58b47c63ba584ff51
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176ffc40b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fdcda0b00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+49a58b47c63ba584ff51@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu: 	0-...!: (10499 ticks this GP) idle=76d/1/0x4000000000000000 softirq=9206/9206 fqs=0
> 	(t=10501 jiffies g=12161 q=535)
> rcu: rcu_preempt kthread starved for 10502 jiffies! g12161 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28696 pid:   14 ppid:     2 flags:0x00004000
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:4955 [inline]
>   __schedule+0x940/0x26f0 kernel/sched/core.c:6236
>   schedule+0xd3/0x270 kernel/sched/core.c:6315
>   schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
>   rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1955
>   rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2128
>   kthread+0x405/0x4f0 kernel/kthread.c:327
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>   </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 6548 Comm: syz-executor027 Not tainted 5.15.0-rc2-next-20210924-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:30 [inline]
> RIP: 0010:__orc_find+0x6a/0xf0 arch/x86/kernel/unwind_orc.c:52
> Code: 89 de 49 39 ec 72 4d 4c 89 e0 48 29 e8 48 89 c2 48 c1 e8 3f 48 c1 fa 02 48 01 d0 48 d1 f8 48 8d 5c 85 00 48 89 d8 48 c1 e8 03 <42> 0f b6 14 38 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 48
> RSP: 0018:ffffc900020bf510 EFLAGS: 00000a06
> RAX: 1ffffffff1bc00c0 RBX: ffffffff8de00600 RCX: ffffffff89400067
> RDX: 0000000000000007 RSI: ffffffff8e7ffc8a RDI: ffffffff8de005f4
> RBP: ffffffff8de005f4 R08: 0000000000000000 R09: ffffffff8e7ffc8a
> R10: fffff52000417ed1 R11: 0000000000086089 R12: ffffffff8de00610
> R13: ffffffff8de005f4 R14: ffffffff8de005f4 R15: dffffc0000000000
> FS:  0000555556c6f300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbfeb842140 CR3: 000000017b0ce000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   orc_find arch/x86/kernel/unwind_orc.c:173 [inline]
>   unwind_next_frame+0x32a/0x1ce0 arch/x86/kernel/unwind_orc.c:443
>   arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
>   stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
>   kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
>   kasan_set_track mm/kasan/common.c:46 [inline]
>   set_alloc_info mm/kasan/common.c:434 [inline]
>   ____kasan_kmalloc mm/kasan/common.c:513 [inline]
>   ____kasan_kmalloc mm/kasan/common.c:472 [inline]
>   __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
>   kmalloc include/linux/slab.h:592 [inline]
>   io_add_buffers fs/io_uring.c:4423 [inline]
>   io_provide_buffers fs/io_uring.c:4457 [inline]
>   io_issue_sqe+0x1d9e/0x7430 fs/io_uring.c:6759
>   __io_queue_sqe+0x90/0xb50 fs/io_uring.c:6991
>   io_queue_sqe fs/io_uring.c:7042 [inline]
>   io_submit_sqe fs/io_uring.c:7224 [inline]
>   io_submit_sqes+0x21be/0x99d0 fs/io_uring.c:7329
>   __do_sys_io_uring_enter+0xf55/0x1f00 fs/io_uring.c:9995
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae

Hi Jens Axboe

Does it also trigger RCU stall ?

Thanks
Qiang


> RIP: 0033:0x7fbfeb7d0fb9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe945eef88 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> RAX: ffffffffffffffda RBX: 00000000000d7de4 RCX: 00007fbfeb7d0fb9
> RDX: 0000000000000000 RSI: 00000000000069c1 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe945eefac
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.736 msecs
> NMI backtrace for cpu 0
> CPU: 0 PID: 2575 Comm: kworker/u4:6 Not tainted 5.15.0-rc2-next-20210924-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events_unbound io_ring_exit_work
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
>   nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>   rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
>   print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
>   check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
>   rcu_pending kernel/rcu/tree.c:3878 [inline]
>   rcu_sched_clock_irq.cold+0x9d/0x746 kernel/rcu/tree.c:2597
>   update_process_times+0x16d/0x200 kernel/time/timer.c:1785
>   tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
>   tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428
>   __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>   __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
>   hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
>   __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
>   sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:unwind_next_frame+0xb7/0x1ce0 arch/x86/kernel/unwind_orc.c:621
> Code: fc ff df 48 c7 04 13 00 00 00 00 48 8b 8c 24 98 00 00 00 65 48 2b 0c 25 28 00 00 00 0f 85 4c 15 00 00 48 81 c4 a0 00 00 00 5b <5d> 41 5c 41 5d 41 5e 41 5f c3 4d 8d 66 48 48 b8 00 00 00 00 00 fc
> RSP: 0018:ffffc9000b507710 EFLAGS: 00000282
> RAX: 0000000000000001 RBX: ffffffff81648250 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: ffffc9000b507f28 RDI: 0000000000000001
> RBP: ffffc9000b507f58 R08: ffffffff8dea4be6 R09: 0000000000000001
> R10: fffff520016a0ef3 R11: 0000000000086089 R12: ffffc9000b500000
> R13: ffffc9000b507775 R14: ffffc9000b507740 R15: ffffc9000b507774
>   arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
>   stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
>   kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
>   kasan_set_track+0x21/0x30 mm/kasan/common.c:46
>   kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
>   ____kasan_slab_free mm/kasan/common.c:366 [inline]
>   ____kasan_slab_free mm/kasan/common.c:328 [inline]
>   __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
>   kasan_slab_free include/linux/kasan.h:230 [inline]
>   slab_free_hook mm/slub.c:1700 [inline]
>   slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1726
>   slab_free mm/slub.c:3492 [inline]
>   kfree+0xf6/0x560 mm/slub.c:4538
>   __io_remove_buffers fs/io_uring.c:4345 [inline]
>   __io_remove_buffers fs/io_uring.c:4330 [inline]
>   io_destroy_buffers fs/io_uring.c:9222 [inline]
>   io_ring_ctx_free fs/io_uring.c:9279 [inline]
>   io_ring_exit_work+0xbaa/0x1980 fs/io_uring.c:9460
>   process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
>   worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
>   kthread+0x405/0x4f0 kernel/kthread.c:327
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>   </TASK>
> ----------------
> Code disassembly (best guess):
>     0:	89 de                	mov    %ebx,%esi
>     2:	49 39 ec             	cmp    %rbp,%r12
>     5:	72 4d                	jb     0x54
>     7:	4c 89 e0             	mov    %r12,%rax
>     a:	48 29 e8             	sub    %rbp,%rax
>     d:	48 89 c2             	mov    %rax,%rdx
>    10:	48 c1 e8 3f          	shr    $0x3f,%rax
>    14:	48 c1 fa 02          	sar    $0x2,%rdx
>    18:	48 01 d0             	add    %rdx,%rax
>    1b:	48 d1 f8             	sar    %rax
>    1e:	48 8d 5c 85 00       	lea    0x0(%rbp,%rax,4),%rbx
>    23:	48 89 d8             	mov    %rbx,%rax
>    26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx <-- trapping instruction
>    2f:	48 89 d8             	mov    %rbx,%rax
>    32:	83 e0 07             	and    $0x7,%eax
>    35:	83 c0 03             	add    $0x3,%eax
>    38:	38 d0                	cmp    %dl,%al
>    3a:	7c 04                	jl     0x40
>    3c:	84 d2                	test   %dl,%dl
>    3e:	75 48                	jne    0x88
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
