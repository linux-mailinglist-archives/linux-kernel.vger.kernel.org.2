Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F143BF23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhJ0BnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbhJ0BnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:43:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54EAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:40:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v1-20020a17090a088100b001a21156830bso3816291pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qMgVnXJJi+80V4XgZWewbY8tftz5ivpIkClqb8Lv9Cc=;
        b=JWl3lTPbYHxUNBIDTFAcYOJBPyfEKAHhGOElj8XH/hkxHfmwtZRrGWUPcQd6cQiaLU
         RHf+PJ1+sCaOi6Kjut24As3O1JjcSLqqZ9si29Q3Aq31OIB57n41Sv37GwUihTIopOJe
         bgKvUkj910LQ9RerNG/vuoN7dC0yQHq3WHEK09ttHX1wPlITNSvH1tpIR0O1tMDdrT1T
         TBUj7NDJgY2Zz5rpnU7kbL8svkT+55LHergNn+m+6ymNeRYp/B6kVF0DL8we4u76TtlX
         gHaJxBmIzBrAid2LF8t9A44ot3EQ6dPlfMEQsit+J4HYtwgHy+PmaWW/9AthM/oy4UII
         CirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qMgVnXJJi+80V4XgZWewbY8tftz5ivpIkClqb8Lv9Cc=;
        b=y5wlZCmXR29FnNc/joWU64TyfXhxaIKVgX1NovK2nCP3Fa7LoJpN2LNDCUNv1M1s/O
         TWE5BfSikKCbwLiTXFBBcNpQ/IW7blxTHGGqrGfR4w/YuVW5kBhFw5g2bCr7DbrpuFXR
         qZKtATkIxL5+p5OWJhLTGYDcBnrjy/QGZVIPWZLllX5AWFsL55vI9CsVCDdxakcYqZcB
         FVdJGo4/Cz897AHc3mWoyH+GMXanC9g4IqMuLzQ2N8DkA32vu+ONvarStwSgWXKP5Pi/
         6LtdJK2pCKq77SxguPHs3Wee8UyNTsGTrSzDpG/Ah1pB9r1MCea24W2/aT+MkKlr+MT/
         Ik8w==
X-Gm-Message-State: AOAM531XoRQRxNoJTm05u9nvPQR7c0kFX6AjFZHEplnwUXKF73Fz0dir
        fYKSflLERPUGrlvyORS4usGLBa6hedPIbtMT8A==
X-Google-Smtp-Source: ABdhPJzt4KGh7rfhQF+lo2ut+wHtngRU0pOcNjmOXod+SKS2Sc+bBNq7C0ItnCcPanBetsgK6kUA11XYgBVhPZr+TeM=
X-Received: by 2002:a17:903:2348:b0:140:37e8:5944 with SMTP id
 c8-20020a170903234800b0014037e85944mr21462072plh.15.1635298849341; Tue, 26
 Oct 2021 18:40:49 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:40:36 +0800
Message-ID: <CACkBjsan33jgTuLteEw9FPs5Og=JLdqYT3CB4g_71_m7dZo3oA@mail.gmail.com>
Subject: possible deadlock in force_sig_info_to_task
To:     christian@brauner.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, ebiederm@xmission.com,
        elver@google.com, peterz@infradead.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1tpVyBpfPqZKvBwGtvHk4Bpi3G9ycYJRT/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

============================================
WARNING: possible recursive locking detected
5.15.0-rc6 #4 Not tainted
--------------------------------------------
syz-executor/11999 is trying to acquire lock:
ffff88810eba65d8 (&sighand->siglock){....}-{2:2}, at:
force_sig_info_to_task+0x74/0x450 kernel/signal.c:1333

but task is already holding lock:
ffff88810eba65d8 (&sighand->siglock){....}-{2:2}, at:
force_sig_info_to_task+0x74/0x450 kernel/signal.c:1333

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sighand->siglock);
  lock(&sighand->siglock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor/11999:
 #0: ffff88810eba65d8 (&sighand->siglock){....}-{2:2}, at:
force_sig_info_to_task+0x74/0x450 kernel/signal.c:1333
 #1: ffffffff8b97ea20 (rcu_read_lock){....}-{1:2}, at:
perf_sample_regs_user kernel/events/core.c:6567 [inline]
 #1: ffffffff8b97ea20 (rcu_read_lock){....}-{1:2}, at:
perf_event_output_forward+0x0/0x280 kernel/events/core.c:7363

stack backtrace:
CPU: 2 PID: 11999 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
 check_deadlock kernel/locking/lockdep.c:2987 [inline]
 validate_chain kernel/locking/lockdep.c:3776 [inline]
 __lock_acquire.cold+0x168/0x3c3 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5590
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 force_sig_info_to_task+0x74/0x450 kernel/signal.c:1333
 force_sig_fault_to_task+0xac/0xf0 kernel/signal.c:1700
 kernelmode_fixup_or_oops+0x204/0x2b0 arch/x86/mm/fault.c:743
 __bad_area_nosemaphore+0x381/0x410 arch/x86/mm/fault.c:806
 do_user_addr_fault+0x6bd/0x11c0 arch/x86/mm/fault.c:1282
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0010:__get_user_nocheck_8+0x10/0x13 arch/x86/lib/getuser.S:162
Code: 0f b7 10 31 c0 0f 01 ca c3 90 0f 01 cb 0f ae e8 8b 10 31 c0 0f
01 ca c3 66 90 0f 01 cb 0f ae e8 48 8b 10 31 c0 0f 01 ca c3 90 <0f> 01
ca 31 d2 48 c7 c0 f2 ff ff ff c3 cc cc cc 53 89 fb e8 28 b4
RSP: 0000:ffffc90001acf198 EFLAGS: 00050016
RAX: 000000000000000a RBX: ffffc90001acf268 RCX: 0000000000040000
RDX: ffffc90002ea1000 RSI: ffff88810f401c80 RDI: 0000000000000002
RBP: ffffc90001acf274 R08: ffffffff810136a7 R09: 000000000000000a
R10: 0000000000000006 R11: ffffed1021e80390 R12: 000000000000000a
R13: dffffc0000000000 R14: 00007fffffffeff0 R15: ffffc90001acf270
 perf_callchain_user+0x81f/0xbc0 arch/x86/events/core.c:2897
 get_perf_callchain+0x39d/0x4a0 kernel/events/callchain.c:221
 perf_callchain+0x165/0x1c0 kernel/events/core.c:7291
 perf_prepare_sample+0xa0f/0x1e50 kernel/events/core.c:7318
 __perf_event_output kernel/events/core.c:7487 [inline]
 perf_event_output_forward+0xda/0x280 kernel/events/core.c:7507
 __perf_event_overflow+0x13c/0x3d0 kernel/events/core.c:9177
 perf_swevent_overflow+0xac/0x150 kernel/events/core.c:9253
 perf_swevent_event+0x1e9/0x2e0 kernel/events/core.c:9286
 perf_tp_event+0x21c/0x740 kernel/events/core.c:9709
 perf_trace_run_bpf_submit+0x118/0x170 kernel/events/core.c:9683
 perf_trace_lock+0x2ef/0x4d0 include/trace/events/lock.h:39
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x4a7/0x670 kernel/locking/lockdep.c:5636
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_unlock_irqrestore+0x16/0x70 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:418 [inline]
 force_sig_info_to_task+0x1fd/0x450 kernel/signal.c:1351
 force_sig_fault_to_task+0xac/0xf0 kernel/signal.c:1700
 kernelmode_fixup_or_oops+0x204/0x2b0 arch/x86/mm/fault.c:743
 __bad_area_nosemaphore+0x381/0x410 arch/x86/mm/fault.c:806
 do_user_addr_fault+0x8e0/0x11c0 arch/x86/mm/fault.c:1360
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0010:__put_user_nocheck_8+0x11/0x21
Code: 0f 01 ca c3 66 0f 1f 44 00 00 48 bb f9 ef ff ff ff 7f 00 00 48
39 d9 73 14 0f 01 cb 48 89 01 31 c9 0f 01 ca c3 0f 1f 44 00 00 <0f> 01
ca b9 f2 ff ff ff c3 cc cc cc cc cc cc cc 41 57 41 56 41 55
RSP: 0000:ffffc90001acfdb0 EFLAGS: 00050293
RAX: 000000006172a1b5 RBX: 00007fffffffeff9 RCX: 0000000000000004
RDX: ffffc90002ea1000 RSI: ffff88810f401c80 RDI: 0000000000000002
RBP: 1ffff92000359fb7 R08: ffffffff8164ef15 R09: ffffed100c7e6542
R10: ffff888063f32a0b R11: ffffed100c7e6541 R12: 0000000000000004
R13: 0000000000000003 R14: ffffc90001acfff0 R15: 0000000000000000
 __do_sys_gettimeofday kernel/time/time.c:147 [inline]
 __se_sys_gettimeofday kernel/time/time.c:140 [inline]
 __x64_sys_gettimeofday+0xe2/0x200 kernel/time/time.c:140
 emulate_vsyscall+0x9f4/0xc00 arch/x86/entry/vsyscall/vsyscall_64.c:246
 do_user_addr_fault+0x8f8/0x11c0 arch/x86/mm/fault.c:1321
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:_end+0x6edda000/0x0
Code: Unable to access opcode bytes at RIP 0xffffffffff5fffd6.
RSP: 002b:00007eff995c6bb8 EFLAGS: 00010246
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000000000002
RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 000000000000000a R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000008 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007eff995c6dc0
----------------
Code disassembly (best guess):
   0: 0f b7 10              movzwl (%rax),%edx
   3: 31 c0                xor    %eax,%eax
   5: 0f 01 ca              clac
   8: c3                    retq
   9: 90                    nop
   a: 0f 01 cb              stac
   d: 0f ae e8              lfence
  10: 8b 10                mov    (%rax),%edx
  12: 31 c0                xor    %eax,%eax
  14: 0f 01 ca              clac
  17: c3                    retq
  18: 66 90                xchg   %ax,%ax
  1a: 0f 01 cb              stac
  1d: 0f ae e8              lfence
  20: 48 8b 10              mov    (%rax),%rdx
  23: 31 c0                xor    %eax,%eax
  25: 0f 01 ca              clac
  28: c3                    retq
  29: 90                    nop
* 2a: 0f 01 ca              clac <-- trapping instruction
  2d: 31 d2                xor    %edx,%edx
  2f: 48 c7 c0 f2 ff ff ff mov    $0xfffffffffffffff2,%rax
  36: c3                    retq
  37: cc                    int3
  38: cc                    int3
  39: cc                    int3
  3a: 53                    push   %rbx
  3b: 89 fb                mov    %edi,%ebx
  3d: e8                    .byte 0xe8
  3e: 28                    .byte 0x28
  3f: b4                    .byte 0xb4
