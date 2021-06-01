Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F49397364
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFAMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:39:00 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36718 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhFAMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:38:58 -0400
Received: by mail-io1-f70.google.com with SMTP id i15-20020a6bee0f0000b029043af67da217so9100975ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n3zaRnm1Am3dRbzx8TdvX9j3uIpt6Z3WWYTcqVt70ug=;
        b=RIo/FZo5cfaHP9jpoOO0IES6/xpSaKNA0DuV1VURaX5IeJUhp0k+iHFZHpFnsgWC5p
         ifMogfONPZ2V5d6HLqEdXQnKWMmN/cfaXYLEpn6y3aBfGi1I4s21gRdJCSxmTTpmsRke
         B/GVTjg6H/6bsYW0enBIKbef9t7kDdJkYyAlgW+ipqLwAgOynDn9d8PohGWGBpj8BwgF
         9p1Jn77GQz7NzHwq8TdVNpLQKiLXiaZ92sMEZluafy/adImaUvl5I/j1aLzY+8uiotXU
         WfKp0jlh1j6juNpLxo6eBelLK+26mJisyaLFwl7BlkZ17k2D/eO2r6LIgEnc12lQd+Qi
         QdTg==
X-Gm-Message-State: AOAM5311+JmEGcMXNeybmSpdCflKLFY4ijT8Qe+yKeSX+yANYtAJD47F
        Lk1/d5NAzQ8glEfHwPmRKCspEyXWRD9rxmfIF4hTu3qxJHC0
X-Google-Smtp-Source: ABdhPJy4smZYE1QseMF5h/2pqMS/3MC+mL0q1ctSMCdw4/sQUaQuVLIu0Euz6o/SkCtGTJDfzzoIH90Ok4WEGdqRzwwSfWGGPcnP
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:: with SMTP id u12mr21169863ilv.221.1622551036066;
 Tue, 01 Jun 2021 05:37:16 -0700 (PDT)
Date:   Tue, 01 Jun 2021 05:37:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002281b205c3b39a2c@google.com>
Subject: [syzbot] WARNING in schedule_bh (2)
From:   syzbot <syzbot+e89a1109c376e2c3c389@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97e5bf60 Merge branch 'for-5.13-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1412ceefd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
dashboard link: https://syzkaller.appspot.com/bug?extid=e89a1109c376e2c3c389
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e89a1109c376e2c3c389@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 0 at drivers/block/floppy.c:999 schedule_bh+0x5f/0x70 drivers/block/floppy.c:999
Modules linked in:
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh+0x5f/0x70 drivers/block/floppy.c:999
Code: 17 28 11 fd 48 89 2d 70 2d 41 0c 5b 48 c7 c2 20 b7 a5 8c 48 8b 35 41 32 41 0c bf 08 00 00 00 5d e9 56 86 e7 fc e8 f1 27 11 fd <0f> 0b eb d1 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 e8 db 27 11 fd
RSP: 0018:ffffc900005a8dd0 EFLAGS: 00010046
RAX: 0000000080010001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888011a53880 RSI: ffffffff8463b48f RDI: 0000000000000003
RBP: ffffffff8463b0c0 R08: 0000000000000000 R09: ffffffff8ca5b727
R10: ffffffff8463b45f R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff8463b0c0 R14: 0000000000000000 R15: ffff88801106d000
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c018d93000 CR3: 000000005c09d000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 floppy_interrupt+0x228/0x340 drivers/block/floppy.c:1765
 floppy_hardint+0x256/0x320 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:156
 handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
 handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
 handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9e/0x200 arch/x86/kernel/irq.c:250
 common_interrupt+0x9f/0xd0 arch/x86/kernel/irq.c:240
 </IRQ>
 asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:638
RIP: 0010:default_idle+0xe/0x10 arch/x86/kernel/process.c:701
Code: ff ff ff 48 89 df e8 c1 c3 a0 f8 e9 52 ff ff ff 4c 89 e7 e8 b4 c3 a0 f8 eb 93 66 90 e9 07 00 00 00 0f 00 2d c4 e2 4c 00 fb f4 <c3> cc 41 55 41 54 55 48 89 fd 53 e8 52 bd 5b f8 e8 2d 60 fd ff 48
RSP: 0018:ffffc9000044fdf8 EFLAGS: 00000202
RAX: 00000000003f60f7 RBX: ffff888011a53880 RCX: ffffffff89167441
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: ffff88802cd365cb
R10: ffffed10059a6cb9 R11: 0000000000000000 R12: ffffed100234a710
R13: 0000000000000003 R14: ffffffff8dc969d0 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x401/0x590 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_secondary+0x274/0x350 arch/x86/kernel/smpboot.c:272
 secondary_startup_64_no_verify+0xb0/0xbb


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
