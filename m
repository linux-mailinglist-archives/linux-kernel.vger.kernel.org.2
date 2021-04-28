Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8895A36D9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhD1OlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:41:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55009 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhD1OlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:41:16 -0400
Received: by mail-il1-f197.google.com with SMTP id a1-20020a92c5410000b02901689a5cd3bdso32714196ilj.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C7EFdiioOxUOH8X0G9cSoSSLkQZ4y5Cg8hsh16Kn3Sw=;
        b=fnczQrCIj5xf+DDrNBpzbHUNngew8GwiOLZTYfVhS5F12M1R4W1oP0uTVOdoSYEwtx
         SxAxBlX09D7+bRjHSdINoJdlTv+79q6FxXqW3NgGIYnjGc/PM1lHDCK3hkblyXgEjpzT
         3xO69CV259I3CDmUA+7/2xkraJE/PLZJ5e8dqDIkjNZXop4nQQxrtsF4Gng2wYqknNch
         uhaRGB24J0keQW2XCEXn2vzzerYKxMJa5u0mXqGbyMM1SN/YOcScAE+8lyfDM4sE8wYK
         IkGshf9eazg4FDbzdDUNXsN3UcdazR4ZpiyPcD2IMpZ0oYAjgqBsdRQxiUPm88lYjrX2
         3NuA==
X-Gm-Message-State: AOAM5321msVSB6ImxxDM/u64oKGi2JeF6OyKCE+QxL7E3PbgVI2YtoGp
        7qTIVIJ9nSv5SK935561KRzYQoS5dqrgMyhsuL3kQJR3IONs
X-Google-Smtp-Source: ABdhPJw1FAgjPAaUssRqBESUIBT77fK/gvCT8KEsoDv7OUOa5Y36b+oHSQbdg3n9OqfMnkI3Dn7qcpeYxwJWb6zs22gY1+xO0vkK
MIME-Version: 1.0
X-Received: by 2002:a5e:8a0c:: with SMTP id d12mr23381629iok.152.1619620831370;
 Wed, 28 Apr 2021 07:40:31 -0700 (PDT)
Date:   Wed, 28 Apr 2021 07:40:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053287805c1095c9d@google.com>
Subject: [syzbot] WARNING in percpu_ref_switch_to_atomic_rcu (2)
From:   syzbot <syzbot+842c825a3ade3fb904bf@syzkaller.appspotmail.com>
To:     bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57fa2369 Merge tag 'cfi-v5.13-rc1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173e8725d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c37352b2923ef305
dashboard link: https://syzkaller.appspot.com/bug?extid=842c825a3ade3fb904bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f0c7dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+842c825a3ade3fb904bf@syzkaller.appspotmail.com

------------[ cut here ]------------
percpu ref (free_ioctx_reqs) <= 0 (0) after switching to atomic
WARNING: CPU: 0 PID: 9966 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x3e4/0x4a0 lib/percpu-refcount.c:196
Modules linked in:
CPU: 0 PID: 9966 Comm: kworker/u4:4 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x3e4/0x4a0 lib/percpu-refcount.c:196
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ba 00 00 00 48 8b 44 24 08 4c 89 e2 48 c7 c7 80 05 c2 89 48 8b 70 e8 e8 cb 7c fb 04 <0f> 0b e9 3b ff ff ff 48 c7 c7 a4 27 c6 8d e8 39 a9 ee fd e9 19 fd
RSP: 0018:ffffc90000007e28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88803c80b880 RSI: ffffffff815c3fc5 RDI: fffff52000000fb7
RBP: ffff888027181980 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815bcd5e R11: 0000000000000000 R12: 0000000000000000
R13: 0000607f46081cc0 R14: 0000000000000007 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000300 CR3: 0000000012084000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2559 [inline]
 rcu_core+0x74a/0x12f0 kernel/rcu/tree.c:2794
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
Code: f0 4d 89 03 e9 f2 fc ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 40 00 <65> 8b 05 29 07 8e 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc9000b2f78d0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff88803c80b880 RSI: ffffffff816465bf RDI: 0000000000000003
RBP: 0000000000044664 R08: 0000000000000000 R09: ffffffff901948b7
R10: ffffffff816465b5 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8bf92b90 R15: 0000000000002192
 __seqprop_raw_spinlock_sequence include/linux/seqlock.h:276 [inline]
 timekeeping_get_delta kernel/time/timekeeping.c:252 [inline]
 timekeeping_get_ns kernel/time/timekeeping.c:386 [inline]
 ktime_get_with_offset+0x1f5/0x500 kernel/time/timekeeping.c:872
 ktime_get_boottime include/linux/timekeeping.h:94 [inline]
 ktime_get_boottime_ns include/linux/timekeeping.h:163 [inline]
 copy_process+0x350f/0x71a0 kernel/fork.c:2226
 kernel_clone+0xe7/0xab0 kernel/fork.c:2500
 kernel_thread+0xb5/0xf0 kernel/fork.c:2552
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:158
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
