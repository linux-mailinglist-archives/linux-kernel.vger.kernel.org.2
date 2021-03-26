Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAB34A2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCZHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:55:52 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37390 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCZHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:55:19 -0400
Received: by mail-io1-f69.google.com with SMTP id a18so5620567ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2eBBmYU/ALPuMTlQsOGaHV63IlPxJR7X8iVzJ/P2w7Y=;
        b=URAIPGnvIkhpx8MVdV8jOOK8dEpja+aRGUf3FJcXncF0LFlX7AA6gqH9GyFwD8atnE
         L5YXaMaRoUduM9+ClZQGCa/nmEcBm3Xr0bRNuWOmR7IuKZGGpJuw6v9FpXvWru4hYKZA
         v3lhrYJ8UkqYBMmASWi/JeYBiOm5edNGk4NG2sYTB852S6JWau2+IaeDXhP97ekR2zC5
         ZjQ+v9VGVm92PpzpZzinHzNDaso6mw35Rw29XjueG3T4CZRsUp9gC0mM1SrZTehzERAW
         hziCi/lq3wo8W87LAZT0+3IKzqmQOu+NK24dpmA1FQRlqDmJtFUANBLApyHzv2E37bLh
         UUlA==
X-Gm-Message-State: AOAM531e3nFMpPVrYGjmjc+hvBD+9zhour11+Pe1ml6BRwELiw5RCIo9
        NV61X7eklRUQ91rhWbf3l1VQjZ5Nvr6VPgBp4jBd39NYcL96
X-Google-Smtp-Source: ABdhPJxGz+loRgOOjyTPw4XqiczYdsVcs/SUyaLeuGwpOm86KUlyAnTRkF58JgiqGIlWh8/Z/5fjo9lsBOgsWnSCZtu2SnWAUPNJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:: with SMTP id g2mr9893569ile.231.1616745318693;
 Fri, 26 Mar 2021 00:55:18 -0700 (PDT)
Date:   Fri, 26 Mar 2021 00:55:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c40405be6bdad4@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fb84bed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170 fs/open.c:1289
Read of size 8 at addr 0000000000000077 by task syz-executor.4/16965

CPU: 0 PID: 16965 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:403 [inline]
 kasan_report.cold+0x5f/0xd8 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 filp_close+0x22/0x170 fs/open.c:1289
 close_files fs/file.c:403 [inline]
 put_files_struct fs/file.c:418 [inline]
 put_files_struct+0x1d0/0x350 fs/file.c:415
 exit_files+0x7e/0xa0 fs/file.c:435
 do_exit+0xbc2/0x2a60 kernel/exit.c:820
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x42c/0x2100 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466459
Code: Unable to access opcode bytes at RIP 0x46642f.
RSP: 002b:00007feb5e334218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000056bf68 RCX: 0000000000466459
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf68
RBP: 000000000056bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf6c
R13: 0000000000a9fb1f R14: 00007feb5e334300 R15: 0000000000022000
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
