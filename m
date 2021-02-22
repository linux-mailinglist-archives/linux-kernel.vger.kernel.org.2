Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91073212EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBVJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:17:27 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35544 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBVJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:15:57 -0500
Received: by mail-il1-f199.google.com with SMTP id i7so7220475ilu.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OEjUdAntmh0cV69BmZZEmoUlVVj/CIh6n7qrYCRIkK8=;
        b=qT1nMEKZMSUCNZDoj+zi6YZ8V7ySSPuNZdr59ze/wFe60HXMTLDC4j5iFtuEdIMz9y
         OC9ZfuTmlMXA49o3vHq+pO9vaHANgSKSB9/lFG/naQPHppgTuR2NenTXjQn9+IpEbj0j
         QLr2X4WsvlPpBwMBTrKJnLROTkXafFWRxPIbXKOo82BCa0uLNsTprHOpME90uT37bIIO
         c025JIm+HhOiTuGkQfJHOWFGOGVtyv9XrNk2/EByD2duWnrcTt6LESwRjLo55rqL6Lj3
         fycsiX9rgyNNekY1e2A6XHp4vj4zwum4YhmzDA+Z8XlMagpqAqoizKVs5SCrzbxf/Ydc
         4cTA==
X-Gm-Message-State: AOAM533JjjLZBwVzdUaUQCYZ2WEFBkgGx9meiOqpNB9ftky/PJ57zFnO
        mdtzGH+zyEUcecXzVbZjX3RTQfg0Pw8aMQcYDTm0kgb296oj
X-Google-Smtp-Source: ABdhPJxZJaKpP8tyaybDaDJn5xSuedJMPndywknS7IfdSwqObQsk56zdpme9j16Z8mZeWv9AwiK4Xea4DW/KTvNXxPYEmbktDv2r
MIME-Version: 1.0
X-Received: by 2002:a92:ab10:: with SMTP id v16mr14643708ilh.100.1613985314424;
 Mon, 22 Feb 2021 01:15:14 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:15:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056cda705bbe93d11@google.com>
Subject: KMSAN: kernel-infoleak in compat_drm_wait_vblank
From:   syzbot <syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        glider@google.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=111e6312d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8e3b38ca92283e
dashboard link: https://syzkaller.appspot.com/bug?extid=620cf21140fc7e772a5d
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+620cf21140fc7e772a5d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
CPU: 1 PID: 26999 Comm: syz-executor.2 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x484/0x520 mm/kmsan/kmsan.c:437
 kmsan_copy_to_user+0x9c/0xb0 mm/kmsan/kmsan_hooks.c:249
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1ac/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:209 [inline]
 compat_drm_wait_vblank+0x36f/0x450 drivers/gpu/drm/drm_ioc32.c:866
 drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
 __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
 __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
 __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
 do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
 __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f47549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f55415fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018643a
RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 compat_drm_wait_vblank+0x43c/0x450 drivers/gpu/drm/drm_ioc32.c:865
 drm_compat_ioctl+0x3f6/0x590 drivers/gpu/drm/drm_ioc32.c:995
 __do_compat_sys_ioctl fs/ioctl.c:842 [inline]
 __se_compat_sys_ioctl+0x53d/0x1100 fs/ioctl.c:793
 __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:793
 do_syscall_32_irqs_on arch/x86/entry/common.c:79 [inline]
 __do_fast_syscall_32+0x102/0x160 arch/x86/entry/common.c:141
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable ----req@compat_drm_wait_vblank created at:
 compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849
 compat_drm_wait_vblank+0x7b/0x450 drivers/gpu/drm/drm_ioc32.c:849

Bytes 12-15 of 16 are uninitialized
Memory access of size 16 starts at ffff88814ffe3c98
Data copied to user address 0000000020000100
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
