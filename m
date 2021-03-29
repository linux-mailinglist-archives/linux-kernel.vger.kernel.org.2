Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637BE34D4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhC2QXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:23:34 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54847 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhC2QXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:23:24 -0400
Received: by mail-io1-f69.google.com with SMTP id s6so11211486iom.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=d1Y41bekLPlXWYNgg5+HGDMcXEAwwxN+aPYbycrvlNY=;
        b=Dz8C8eCCtPOOrv5sH2qInqme9Puu5iGwQfEpc6GgsbCAlU6RGLe0ymmlTJIG6waIrM
         fWu4o9/BELAxn3Wr3DzffHfxn7zfpKv50RPt/DbAL8pjvTkn/F9bagfC+fHmth9Ie0H3
         0MuJ1ZIRVm8w9ygcrKycmQO/TkOi+HifrmMjcEXTD4JOzS+lpXBdXrz23ZShb+l5GDnT
         Rer9BvWSo0CiwrTdt6xSqmG+0lNZd6pyszMeSyIdGO9T0rPWJswSD6DTnFeXwOmNDRKb
         beLW0m66f81mHhYZmm88U8SoEXJqTI9pZzmnH11OueuqisOieq0pmooYCYebtCQAsKi4
         hFtA==
X-Gm-Message-State: AOAM532vk3N4urCl/qNqvL8dqFBJDLK4gR7Zk9cJMT53mkZWaLpiHaOG
        fx1gPTD7L4kwvVHNpgLw6jzswHyPzgUKwRgvMNRvOd12r62T
X-Google-Smtp-Source: ABdhPJy+He+jZ2TETS4rf/lgYdmEckBHqEaWmLtXvZBulFxgvxLezFlo6vPTtnQkJ57YAZzm5WYO3Ry3dt+8F1b1HZIQLD5SiIDf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ed2:: with SMTP id i18mr22362665ilk.173.1617035004044;
 Mon, 29 Mar 2021 09:23:24 -0700 (PDT)
Date:   Mon, 29 Mar 2021 09:23:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000016ca805beaf4d26@google.com>
Subject: [syzbot] WARNING in emulate_vsyscall
From:   syzbot <syzbot+2698183e871d8a137f9d@syzkaller.appspotmail.com>
To:     bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, krisman@collabora.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wad@chromium.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0f4498ce Merge tag 'for-5.12/dm-fixes-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1658754ed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
dashboard link: https://syzkaller.appspot.com/bug?extid=2698183e871d8a137f9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122aab01d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11004d06d00000

The issue was bisected to:

commit 5042d40a264c8a508d58ed71e4c07b05175b3635
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Feb 10 02:33:42 2021 +0000

    x86/fault: Bypass no_context() for implicit kernel faults from usermode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1004e126d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1204e126d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1404e126d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2698183e871d8a137f9d@syzkaller.appspotmail.com
Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")

syz-executor412[8390] vsyscall fault (exploit attempt?) ip:ffffffffff600000 cs:33 sp:7ffe5492ae00 ax:ffffffffffffffda si:600000001 di:aa060
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8390 at arch/x86/entry/vsyscall/vsyscall_64.c:276 emulate_vsyscall+0x317/0xbf0 arch/x86/entry/vsyscall/vsyscall_64.c:276
Modules linked in:
CPU: 1 PID: 8390 Comm: syz-executor412 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:emulate_vsyscall+0x317/0xbf0 arch/x86/entry/vsyscall/vsyscall_64.c:276
Code: 80 01 00 00 e8 0a 88 73 00 48 c1 eb 0a 31 ff 41 bc 01 00 00 00 f7 d3 83 e3 01 89 de e8 a2 8f 73 00 85 db 74 0f e8 e9 87 73 00 <0f> 0b e9 44 01 00 00 45 31 e4 e8 da 87 73 00 44 89 e0 48 83 c4 38
RSP: 0000:ffffc9000151fe48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888017243880 RSI: ffffffff81006987 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8100697e R11: 0000000000000000 R12: 0000000000000001
R13: ffffc9000151ffd8 R14: ffffc9000151fff0 R15: 0000000000000000
FS:  00000000006c63c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae07369000 CR3: 0000000018320000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_user_addr_fault+0x9a5/0x1210 arch/x86/mm/fault.c:1314
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:_end+0x6f3da000/0x0
Code: Unable to access opcode bytes at RIP 0xffffffffff5fffd6.
RSP: 002b:00007ffe5492ae00 EFLAGS: 00010246
RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00000000000266c5
RDX: 0000000000001000 RSI: 0000000600000001 RDI: 00000000000aa060
RBP: 00000000000812c1 R08: 0000000000483000 R09: 0000000000483000
R10: 0000000000083000 R11: 0000000400000001 R12: 00000000000812c1
R13: 0000000000401000 R14: 0000000000401000 R15: 0000000000001000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
