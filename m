Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB9456C39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhKSJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:21:25 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46941 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhKSJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:21:24 -0500
Received: by mail-io1-f72.google.com with SMTP id z21-20020a5e8615000000b005e22e531c8aso5270588ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oZJ1ZvgM2MTH4JzpVQcxnkDfXFABgNeZ+HUKmgEFpX0=;
        b=XdGC6ke618+FF0frCZr9470TS8QS/UO7SG5FIecwvrPMonXKvaZUMVw4R8IldLJian
         SG3beWA6fQQq08/Mx1a042hWN6tsx0+hO3Z76JM2syiAkFsXzdHSbZZ6Y7kn6KEls/H4
         vL0W/SK04Xv50VmfT5GRA5a1h8s52Xlttk7o8NaZ/XOqX8J512Ky4bmBbaEArbYPHzXD
         NAkCaTxy8swr6CuLOP/pG5QG1lH6t1hAX/XWVWp5sNkLWtL7F76R+vYSb3Q0vkXDKSrM
         TY9EdxBw7M4ZizpcLJ8/hLCt70z95yoncNY/beTxV8a522G0QnTU08jAQ3pjUZRppWFs
         a2eg==
X-Gm-Message-State: AOAM5333cTWvqrho4x/p+ddX7PRMCNWMc57GUKELMYrqlP4Y5339y/oy
        PTdDuz6T5e3dszpW5y+lgS4eg3mD/GyCqd5zSC04BtUhNgoI
X-Google-Smtp-Source: ABdhPJyMWG24aZxGW9kelXBa+W83Kj1OprEnNkNwd6lsB0bXfMQgYVeSGZIltrr5Hkj3WwPVgw49idJzrL8lnUZMEAULHmjSxJ46
MIME-Version: 1.0
X-Received: by 2002:a92:c88e:: with SMTP id w14mr3620284ilo.24.1637313503024;
 Fri, 19 Nov 2021 01:18:23 -0800 (PST)
Date:   Fri, 19 Nov 2021 01:18:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbdd0405d120c155@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
From:   syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fa55b7dcdc43 Linux 5.16-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe2569b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d3b8fd1977c1e73
dashboard link: https://syzkaller.appspot.com/bug?extid=14b0e8f3fd1612e35350
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com

524155 pages RAM
0 pages HighMem/MovableOnly
163742 pages reserved
0 pages cma reserved
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x12f4/0x1430 drivers/video/fbdev/core/sysimgblt.c:275
Write of size 4 at addr ffffc90004631000 by task syz-executor.0/7913

CPU: 0 PID: 7913 Comm: syz-executor.0 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
 sys_imageblit+0x12f4/0x1430 drivers/video/fbdev/core/sysimgblt.c:275
 drm_fb_helper_sys_imageblit drivers/gpu/drm/drm_fb_helper.c:794 [inline]
 drm_fbdev_fb_imageblit+0x15c/0x350 drivers/gpu/drm/drm_fb_helper.c:2282
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:124 [inline]
 bit_putcs+0x6e1/0xd20 drivers/video/fbdev/core/bitblit.c:173
 fbcon_putcs+0x353/0x440 drivers/video/fbdev/core/fbcon.c:1277
 do_update_region+0x399/0x630 drivers/tty/vt/vt.c:676
 redraw_screen+0x61f/0x740 drivers/tty/vt/vt.c:1035
 fbcon_modechanged+0x58c/0x6c0 drivers/video/fbdev/core/fbcon.c:2182
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:2227
 do_fb_ioctl+0x62e/0x690 drivers/video/fbdev/core/fbmem.c:1114
 fb_compat_ioctl+0x17e/0x610 drivers/video/fbdev/core/fbmem.c:1313
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf6e67549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f44615fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000004601
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


Memory state around the buggy address:
 ffffc90004630f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004630f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004631000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90004631080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004631100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
