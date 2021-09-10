Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329754064E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhIJBHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:07:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34471 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhIJAfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:35:42 -0400
Received: by mail-io1-f69.google.com with SMTP id a9-20020a5ec309000000b005baa3f77016so132818iok.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 17:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7Dh5mijrqSL6MQmilhCXyQSFiAQjt8KP7FPQ6faPMOw=;
        b=65yVgXw/lGnv4FghFf9O0mU0uF0KbgdCYVpjfty6QI+PFdtI1v/CkHfmhoHOegB7Uu
         JNjbcm7LN+lHzlKLh7N9PuWynXxeCX22xD8WBQFvvciqMf1htptMIRzodSM8T2WHlI/y
         HzRSCajIv+LrfGMnLBU23nYvYNH2q7ip9uGtBLmF6yhA5380NOcDTVjrEBVJ57S0SY8z
         eSG1pbvsXLMRl6V9K0l/de0Asz50RcOiXdzHnyfe5AeQe80+xLWGnRP2ns0BKmIxcE1C
         fpW6TIHPGe5/4OYTDxQFaFnNHt/Ivf6XoBFZCFRH71dARDpdbGSPfVqM61CLxA41tHSG
         GrwQ==
X-Gm-Message-State: AOAM532HeUR0QEIgEm1BT7V53jC9it0TdRJx7Aw7bwS8y15ivSBGsk+p
        5oyhtaxIl8OKCKww1y/5C9aAMyaF86WcHiRbxb53HJocqLP0
X-Google-Smtp-Source: ABdhPJyC+7jV5UnTRapFZb0pUKckB4WZJfmZGQg1CjxY9Nf8jpBYqNWsespvjZZ4H2puy3aKsoqxFOheRqFrEiTeTb3jtBYLkKAH
MIME-Version: 1.0
X-Received: by 2002:a92:bf01:: with SMTP id z1mr1018591ilh.155.1631234072620;
 Thu, 09 Sep 2021 17:34:32 -0700 (PDT)
Date:   Thu, 09 Sep 2021 17:34:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b5b105cb994728@google.com>
Subject: [syzbot] kernel panic: panic_on_warn set (3)
From:   syzbot <syzbot+8d41ad9c88279d71f7c9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16144a63300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
dashboard link: https://syzkaller.appspot.com/bug?extid=8d41ad9c88279d71f7c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136aedb5300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d41ad9c88279d71f7c9@syzkaller.appspotmail.com

 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 panic+0x2b0/0x6dd kernel/panic.c:232
 kfence_report_error.cold+0x304/0xa56 mm/kfence/report.c:264
 kfence_handle_page_fault+0x203/0x630 mm/kfence/core.c:880
 page_fault_oops+0x1c5/0x6b0 arch/x86/mm/fault.c:686
 kernelmode_fixup_or_oops+0x219/0x280 arch/x86/mm/fault.c:755
 __bad_area_nosemaphore+0x36d/0x400 arch/x86/mm/fault.c:801
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1200
 handle_page_fault arch/x86/mm/fault.c:1473 [inline]
 exc_page_fault+0x155/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
Code: d3 ed e9 ef d4 6e f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 45 e2 6e f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 35 ec 6e f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 0000003361736376 RBX: ffff88806f1e3068 RCX: ffff88823bd14020
RDX: ffffed100de3c614 RSI: 0000000000000005 RDI: 0000000000000007
RBP: 0000000000000005 R08: 0000000000000000 R09: ffff88806f1e3098
R10: ffffed100de3c613 R11: 0000000000000000 R12: ffff88823bd14020
R13: ffff88823bd14020 R14: ffff88806f1e3098 R15: dffffc0000000000
 d_lookup+0xd8/0x170 fs/dcache.c:2370
 lookup_dcache+0x1e/0x130 fs/namei.c:1520
 __lookup_hash+0x29/0x180 fs/namei.c:1543
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Kernel Offset: disabled
----------------
Code disassembly (best guess):
   0:	d3 ed                	shr    %cl,%ebp
   2:	e9 ef d4 6e f8       	jmpq   0xf86ed4f6
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 45 e2 6e f8       	jmpq   0xf86ee267
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
* 2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 35 ec 6e f8       	jmpq   0xf86eec74
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
