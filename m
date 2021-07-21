Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CE3D1976
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhGUVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhGUVR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:17:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA3261208;
        Wed, 21 Jul 2021 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626904683;
        bh=5UoMnJEEg6XKCF4a7sAm/qI5IKnQTfcQXGojmhPwuPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyYaLCQxmf67pnI82wTDdVC/RJm7h9TMwtR1W9rlVSigBlft1iukY3Lns+IPvBWqU
         80fisKhOIMHMLbxhy0IVEw2SwqdygVshNVTdb4LUtZuhNZrKpV4w9J6xunSbceTT+V
         xWLuYLJRYzsoDwlAfh8RKrCYAoeixt9PUn1q5BzY=
Date:   Wed, 21 Jul 2021 14:58:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: Re: [syzbot] WARNING in __set_page_dirty
Message-Id: <20210721145801.8ca097bc1d9ad3d0018517bd@linux-foundation.org>
In-Reply-To: <000000000000b25bb805c798a1a5@google.com>
References: <000000000000b25bb805c798a1a5@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc gfs2 maintainers)

On Tue, 20 Jul 2021 19:07:25 -0700 syzbot <syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d936eb238744 Revert "Makefile: Enable -Wimplicit-fallthrou..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1512834a300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d5b462a6f07447991b3
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 inode_to_wb include/linux/backing-dev.h:283 [inline]
> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 account_page_dirtied mm/page-writeback.c:2435 [inline]
> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 __set_page_dirty+0xace/0x1070 mm/page-writeback.c:2483
> Modules linked in:
> CPU: 0 PID: 8696 Comm: syz-executor.0 Not tainted 5.14.0-rc1-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:inode_to_wb include/linux/backing-dev.h:283 [inline]
> RIP: 0010:account_page_dirtied mm/page-writeback.c:2435 [inline]
> RIP: 0010:__set_page_dirty+0xace/0x1070 mm/page-writeback.c:2483
> Code: a8 01 00 00 be ff ff ff ff 48 8d 78 70 e8 0a bf 8c 07 31 ff 89 c3 89 c6 e8 3f af d8 ff 85 db 0f 85 ac f7 ff ff e8 f2 a7 d8 ff <0f> 0b e9 a0 f7 ff ff e8 e6 a7 d8 ff 4c 8d 75 08 48 b8 00 00 00 00
> RSP: 0000:ffffc90000e578a0 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888013d71c40 RSI: ffffffff819cdfce RDI: 0000000000000003
> RBP: ffffea0001de0240 R08: 0000000000000000 R09: ffff888019819e07
> R10: ffffffff819cdfc1 R11: 0000000000000000 R12: 0000000000000293
> R13: ffff888078a38c90 R14: ffff888019819e00 R15: ffff888019819c58
> FS:  0000000000000000(0000) GS:ffff88802ca00000(0063) knlGS:0000000009b20380
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00007fd805161390 CR3: 000000004c16a000 CR4: 0000000000150ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  mark_buffer_dirty+0x49a/0x5e0 fs/buffer.c:1108
>  gfs2_unpin+0x123/0xd10 fs/gfs2/lops.c:111
>  buf_lo_after_commit+0x140/0x210 fs/gfs2/lops.c:750
>  lops_after_commit fs/gfs2/lops.h:49 [inline]
>  gfs2_log_flush+0x162b/0x2940 fs/gfs2/log.c:1108
>  do_sync+0x5ab/0xcd0 fs/gfs2/quota.c:967
>  gfs2_quota_sync+0x2e2/0x660 fs/gfs2/quota.c:1310
>  gfs2_sync_fs+0x40/0xb0 fs/gfs2/super.c:711
>  __sync_filesystem fs/sync.c:39 [inline]

Seems that gfs2_unpin() is running mark_buffer_dirty() against a bh
which is attached to a non-upto-date page.

>  sync_filesystem fs/sync.c:64 [inline]
>  sync_filesystem+0x105/0x260 fs/sync.c:48
>  generic_shutdown_super+0x70/0x370 fs/super.c:448
>  kill_block_super+0x97/0xf0 fs/super.c:1395
>  gfs2_kill_sb+0x104/0x160 fs/gfs2/ops_fstype.c:1682
>  deactivate_locked_super+0x94/0x160 fs/super.c:335
>  deactivate_super+0xad/0xd0 fs/super.c:366
>  cleanup_mnt+0x3a2/0x540 fs/namespace.c:1136
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>  exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf7f86549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000ffeb89bc EFLAGS: 00000296 ORIG_RAX: 0000000000000034
> RAX: 0000000000000000 RBX: 00000000ffeb8a60 RCX: 0000000000000002
> RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
> RBP: 00000000ffeb8a60 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 

