Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89345FFFB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355537AbhK0Pzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 10:55:46 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:37585 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355401AbhK0Pxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:53:42 -0500
Received: by mail-il1-f200.google.com with SMTP id d2-20020a056e02214200b0029e6bb73635so17473579ilv.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 07:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pHlBgl604i9Nf/MvR8dtaojCRt5dHuTDftUoHrCETeY=;
        b=oHcN4AfrkWfzuE72Mj73zkqgwFjfuxh9hWJybEqiW8Y8iehDrZSBnyTIlxIKmEdtkx
         j6fMfgu/jCocxh2SbW2X9l9B7emKHXx/01MLNbmDDqKRvRtVnA5KoYEcbXpdFAfaqU0k
         OlONicBAGCtthoQX6KHAkcNDjcJhulWYOwevr7Iiod5BndXkigf4pnrJfsEamp7bW5Q8
         n9AItamYWrlZYk5xBb8NHXJo4GRKXYFAiYPZpd/umtXyGchWm4qlRz0vtmVD68HyRKEQ
         0Jj8e4l3tYqnhJI/6EmJObq28IrEr4ANNzRTe9MwjN97Sx26WFXk/oP5mPP8EXbMVOh4
         lQIg==
X-Gm-Message-State: AOAM530k7vb49hJPmpvsVAGpqlqEPDraIscmCVcdeFUmKae7jvUMuLFw
        SPO7bW0dNEqWonBzJdNtGH4Zi54inD53lyewastvuHhhV220
X-Google-Smtp-Source: ABdhPJz9lcF+ht8nai3oIgyXaEgswYf5HhrqgliJ4AgwDwKfqdKACuQ3tikAwT1wasPHXFrYPYkHZVPg3o+9Eqye1qonsI7xd5hu
MIME-Version: 1.0
X-Received: by 2002:a02:9f87:: with SMTP id a7mr52966819jam.136.1638028227432;
 Sat, 27 Nov 2021 07:50:27 -0800 (PST)
Date:   Sat, 27 Nov 2021 07:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0d53f05d1c72a4c@google.com>
Subject: [syzbot] KMSAN: uninit-value in from_kuid
From:   syzbot <syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        cxfcosmos@gmail.com, ebiederm@xmission.com, glider@google.com,
        legion@kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    425295055ce6 kmsan: core: address comments to kmsan-checks.h
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1640209ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
dashboard link: https://syzkaller.appspot.com/bug?extid=dfac92a50024b54acaa4
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:335 [inline]
BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:365 [inline]
BUG: KMSAN: uninit-value in from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
 map_id_up_base kernel/user_namespace.c:335 [inline]
 map_id_up kernel/user_namespace.c:365 [inline]
 from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
 p9pdu_vwritef+0x15ab/0x5120 net/9p/protocol.c:398
 p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
 p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
 p9_client_prepare_req+0xa4b/0xff0 net/9p/client.c:709
 p9_client_rpc+0x278/0x1410 net/9p/client.c:740
 p9_client_setattr+0x115/0x2c0 net/9p/client.c:1899
 v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:590
 notify_change+0x1fe3/0x2170 fs/attr.c:410
 vfs_utimes+0x8aa/0xc70 fs/utimes.c:65
 do_utimes_path fs/utimes.c:98 [inline]
 do_utimes fs/utimes.c:144 [inline]
 __do_sys_utime32 fs/utimes.c:247 [inline]
 __se_sys_utime32+0x386/0x520 fs/utimes.c:235
 __ia32_sys_utime32+0x91/0xc0 fs/utimes.c:235
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 v9fs_vfs_setattr_dotl+0x58a/0xd70 fs/9p/vfs_inode_dotl.c:567
 notify_change+0x1fe3/0x2170 fs/attr.c:410
 vfs_utimes+0x8aa/0xc70 fs/utimes.c:65
 do_utimes_path fs/utimes.c:98 [inline]
 do_utimes fs/utimes.c:144 [inline]
 __do_sys_utime32 fs/utimes.c:247 [inline]
 __se_sys_utime32+0x386/0x520 fs/utimes.c:235
 __ia32_sys_utime32+0x91/0xc0 fs/utimes.c:235
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable newattrs created at:
 vfs_utimes+0x69/0xc70 fs/utimes.c:22
 do_utimes_path fs/utimes.c:98 [inline]
 do_utimes fs/utimes.c:144 [inline]
 __do_sys_utime32 fs/utimes.c:247 [inline]
 __se_sys_utime32+0x386/0x520 fs/utimes.c:235
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
