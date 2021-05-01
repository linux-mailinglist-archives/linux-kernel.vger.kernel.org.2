Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3763705D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhEAGJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 02:09:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50919 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhEAGJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 02:09:05 -0400
Received: by mail-il1-f198.google.com with SMTP id t4-20020a92c0c40000b02901990d153bb9so402776ilf.17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 23:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p3unqPICiul6oD0wliBI7Q/yeSILbxkUkABFTplBX48=;
        b=eowXzokE57ENrXJX1NKg9cO7nbQHjk1cI46wuEEIPqgUABHUNkxyLoDKaZ1ZF/G4qK
         B4vFi7WJx4YWqOwucQU513jSnhvonm8pa2yeyFFZP7wWkDfrZHYKbN1RfdvbAnNVTgnk
         /5ZFLxi35eHG7m/FaT4xMA/cRZSJInGJRNdPVL0nZBNaCPmtfTToTIAzECQcPPeGfobf
         7Ps1KUOGV7XrD0XuPikz8GnCZasvDL67jB0e+xWS+bmBt+0R3DwkcVPWHIm/qn72y49l
         CFWPD4fYsULUEXj34U7iimvvh1RpFbdtSD6cFT7w4vjg0XGtlebFQKgiHXUhUfzaSrgO
         vDEQ==
X-Gm-Message-State: AOAM531YYZFNl4RsrLHNGBX7c5BC7/1NgZWOlxyPc+9wTm+yJ/d+Tojl
        TRq42Irvx4ICC8YHN4wW0vwnPRIeoKfGHpzBvFioAmm2mkth
X-Google-Smtp-Source: ABdhPJyCZhuYJ78/lXJfVH78juFqlysThomOFKacnfVzdtT7O6VoiPjA9DTCx4BeK+QbhjMpOcyYkJ0fzzF3edCkIJp0A3NS2Wrt
MIME-Version: 1.0
X-Received: by 2002:a6b:3118:: with SMTP id j24mr6465003ioa.205.1619849296146;
 Fri, 30 Apr 2021 23:08:16 -0700 (PDT)
Date:   Fri, 30 Apr 2021 23:08:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2fb0605c13e8d29@google.com>
Subject: [syzbot] KMSAN: uninit-value in do_mbind
From:   syzbot <syzbot+0bdecd1b2c19a1faa92d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4ebaab5f kmsan: drop unneeded references to kmsan_context_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11b6bfe5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=647ca0f5bbe7703a
dashboard link: https://syzkaller.appspot.com/bug?extid=0bdecd1b2c19a1faa92d
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11012825d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1425f45dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bdecd1b2c19a1faa92d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __mpol_equal mm/mempolicy.c:2340 [inline]
BUG: KMSAN: uninit-value in mpol_equal include/linux/mempolicy.h:108 [inline]
BUG: KMSAN: uninit-value in mbind_range mm/mempolicy.c:825 [inline]
BUG: KMSAN: uninit-value in do_mbind+0x2d1b/0x38c0 mm/mempolicy.c:1350
CPU: 0 PID: 8220 Comm: syz-executor545 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __mpol_equal mm/mempolicy.c:2340 [inline]
 mpol_equal include/linux/mempolicy.h:108 [inline]
 mbind_range mm/mempolicy.c:825 [inline]
 do_mbind+0x2d1b/0x38c0 mm/mempolicy.c:1350
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4456f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c4152c308 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 00000000004456f9
RDX: 0000000000002001 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00000000004ca400 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ca40c
R13: 00007ffe6c9a98ff R14: 00007f4c4152c400 R15: 0000000000022000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8e/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2931 [inline]
 kmem_cache_alloc+0x895/0x1030 mm/slub.c:2936
 mpol_new mm/mempolicy.c:302 [inline]
 do_mbind+0x8d5/0x38c0 mm/mempolicy.c:1306
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
