Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939E0370264
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhD3UtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:49:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47951 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3UtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:49:01 -0400
Received: by mail-il1-f198.google.com with SMTP id b7-20020a920b070000b029016965167fa7so38190446ilf.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IxAm+3dAHzK4phyxV1ggsOjobYz5RB8dA3+m953Q/78=;
        b=Ew7GsDnajlcdHnfprTPpDL45sD5o7obW2pn8GUp2Zzt294jx/UkjkuZaLtl282yY7g
         Xm93rvpTqX2Q1mf7+KJtRmzTP4xs+NQTGpFBjBr5oPWxSXpc6OBTWCfz34DVvfrgqzav
         B7vaCWDFGlTzzWp9jH8//O1OSiGxkiAIwi0dNlfMyXkwD3lk7fLgFPre4Nx+PjWeS6AR
         +j2opP5PFXP90iNq1k+Z0/zo5uFSnvPkIId9kuX1dfjRJY4691W1rY3UWZ4IuWZPSfOr
         8nOsFYi1q+fS9zbubrvGoE+zUbSz/g9isKaoj76pVfCw3TioXnwa/iEZI3YhrkQlzlqL
         Z74Q==
X-Gm-Message-State: AOAM532xbKtGamIzOcRN/1AZM2k8H6QcUe5eTO1wAS6OS/CjVd4fypKd
        19l/yeplJTqo8GLSCgfjMDzmf+rrmNLNZmjORrM8n8F9FIzM
X-Google-Smtp-Source: ABdhPJwWQ1a2WhIjNb/rfXCFN1dwNcHUmU2mMTU38g0te2Wg4XpbsEA6t7M5TJ9rksuxv23hkxdbXUixoIqmKPXPlM28jwALNC5a
MIME-Version: 1.0
X-Received: by 2002:a6b:6013:: with SMTP id r19mr5362028iog.208.1619815693058;
 Fri, 30 Apr 2021 13:48:13 -0700 (PDT)
Date:   Fri, 30 Apr 2021 13:48:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc85d105c136baf5@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in
 do_page_fault (2)
From:   syzbot <syzbot+66bcf89bc98a2524351b@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ae11635 riscv: keep interrupts disabled for BREAKPOINT ex..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=132778c1d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8af20e245283c9a
dashboard link: https://syzkaller.appspot.com/bug?extid=66bcf89bc98a2524351b
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66bcf89bc98a2524351b@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1352
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 6832, name: syz-executor.1
Unable to handle kernel paging request at virtual address ffffffe024768000
Oops [#1]
Modules linked in:
CPU: 1 PID: 6832 Comm: syz-executor.1 Not tainted 5.12.0-rc6-syzkaller-00183-g7ae11635ec90 #0
Hardware name: riscv-virtio,qemu (DT)
epc : ___might_sleep+0x21c/0x2c0 kernel/sched/core.c:8317
 ra : ___might_sleep+0x21c/0x2c0 kernel/sched/core.c:8317
epc : ffffffe00008456c ra : ffffffe00008456c sp : ffffffe07fdffd90
 gp : ffffffe004588ad0 tp : ffffffe008680000 t0 : ffffffe004ffdbb7
 t1 : ffffffc40ffbff52 t2 : 0000000000000000 s0 : ffffffe07fdffdd0
 s1 : ffffffe024768000 a0 : ffffffe024768000 a1 : 0000000000000007
 a2 : 1ffffffc048ed000 a3 : ffffffe00008456c a4 : 0000000000000000
 a5 : ffffffe024768000 a6 : 0000000000f00000 a7 : ffffffe07fdffa97
 s2 : 0000000000000000 s3 : 0000000000000100 s4 : ffffffe008680000
 s5 : ffffffe0000274ec s6 : 0000000000000000 s7 : ffffffe07fdfffe0
 s8 : 0000000000000214 s9 : ffffffe0071e4ed8 s10: 0000000000001000
 s11: ffffffe003000c68 t3 : dd4b702f2cefd800 t4 : ffffffc40ffbff51
 t5 : ffffffc40ffbff53 t6 : ffffffe07fdffa98
status: 0000000000000100 badaddr: ffffffe024768000 cause: 000000000000000d
Call Trace:
[<ffffffe00008456c>] ___might_sleep+0x21c/0x2c0 kernel/sched/core.c:8317
[<ffffffe00008466a>] __might_sleep+0x5a/0x8a kernel/sched/core.c:8282
[<ffffffe002a996ec>] down_read+0x2e/0x1a4 kernel/locking/rwsem.c:1352
[<ffffffe00000fef8>] mmap_read_lock include/linux/mmap_lock.h:117 [inline]
[<ffffffe00000fef8>] do_page_fault+0x1e6/0x95e arch/riscv/mm/fault.c:263
[<ffffffe000005586>] ret_from_exception+0x0/0x14


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
