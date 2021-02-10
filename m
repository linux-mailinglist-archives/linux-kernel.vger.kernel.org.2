Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6320A316544
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhBJLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:32:23 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35316 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhBJL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:26:04 -0500
Received: by mail-io1-f71.google.com with SMTP id a1so1949359ios.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gdicyBPrdggd4hZh7fQUO+xUBLlm1bZ8gIsc/nDBlq4=;
        b=D/v7fCnTuO/aYd0cTCe4hQbAPjvX7aAYy0EpEYF2FHmQylpaDuJiNHAtHuPiz6Rslv
         zWX4sQ+ciZuvGCNqAgkv+Jx3adRMHsYsLdknztRt333VMJxgjm8TXkZo5ArLRoj+4SFB
         88+aCq3Blr9jCGhjHzJCwSW+0JXFjgn0izUrZJv0W+SRem6kwa+Xt6Mh7dMiHuP+kbDe
         3dJb4WZ4mHKqhKaPb3izoeKHqXga8kgmH6JWXDKl5F4QJRG99lD1vAL8yXuuzAioU6OR
         TWnpsjExrzqvMR3vrSUOx5sqwPMb0GUj15lIjldlTlHGwXAH1yIQOeSULfeRra0aUiYV
         fy5A==
X-Gm-Message-State: AOAM5317K1jZMGdQ53/suYeFoazgGhBn25F0dDG82lMenQSSs0iOVMCz
        B1iz1tKxY1N7Gf3xaqX6oiaxPUnqHKc9fIQdtLXCK878CJ+f
X-Google-Smtp-Source: ABdhPJyr0I8eeEuWQjgsWELrOY6hdOEFmd66WEVK4oPNiC9av0nerdyop9U1rpO7mY6ScJnbL277eOfmzaAtrG2QCTc70+HzlDgJ
MIME-Version: 1.0
X-Received: by 2002:a5d:939a:: with SMTP id c26mr535449iol.63.1612956322256;
 Wed, 10 Feb 2021 03:25:22 -0800 (PST)
Date:   Wed, 10 Feb 2021 03:25:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a05b3b05baf9a856@google.com>
Subject: possible deadlock in dquot_commit
From:   syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e0d27fc Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101cf2f8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com

loop1: detected capacity change from 4096 to 0
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
5.11.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/16170 is trying to acquire lock:
ffff8880795f5b28 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x4d/0x420 fs/quota/dquot.c:476

but task is already holding lock:
ffff88807960b438 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem/2){++++}-{3:3}:
       down_read+0x95/0x440 kernel/locking/rwsem.c:1353
       ext4_map_blocks+0x381/0x17d0 fs/ext4/inode.c:560
       ext4_getblk+0x13c/0x670 fs/ext4/inode.c:847
       ext4_bread+0x29/0x210 fs/ext4/inode.c:899
       ext4_quota_write+0x26b/0x670 fs/ext4/super.c:6557
       write_blk+0x12e/0x220 fs/quota/quota_tree.c:73
       get_free_dqblk+0xff/0x2d0 fs/quota/quota_tree.c:102
       do_insert_tree+0x79c/0x1180 fs/quota/quota_tree.c:309
       do_insert_tree+0xf77/0x1180 fs/quota/quota_tree.c:340
       do_insert_tree+0xf77/0x1180 fs/quota/quota_tree.c:340
       do_insert_tree+0xf77/0x1180 fs/quota/quota_tree.c:340
       dq_insert_tree fs/quota/quota_tree.c:366 [inline]
       qtree_write_dquot+0x3b7/0x580 fs/quota/quota_tree.c:385
       v2_write_dquot+0x11c/0x250 fs/quota/quota_v2.c:353
       dquot_acquire+0x2c5/0x590 fs/quota/dquot.c:443
       ext4_acquire_dquot+0x254/0x3b0 fs/ext4/super.c:6216
       dqget+0x678/0x1080 fs/quota/dquot.c:901
       __dquot_initialize+0x560/0xbe0 fs/quota/dquot.c:1479
       ext4_create+0x8b/0x4c0 fs/ext4/namei.c:2606
       lookup_open.isra.0+0xf85/0x1350 fs/namei.c:3106
       open_last_lookups fs/namei.c:3180 [inline]
       path_openat+0x96d/0x2730 fs/namei.c:3368
       do_filp_open+0x17e/0x3c0 fs/namei.c:3398
       do_sys_openat2+0x16d/0x420 fs/open.c:1172
       do_sys_open fs/open.c:1188 [inline]
       __do_sys_creat fs/open.c:1262 [inline]
       __se_sys_creat fs/open.c:1256 [inline]
       __x64_sys_creat+0xc9/0x120 fs/open.c:1256
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       down_read+0x95/0x440 kernel/locking/rwsem.c:1353
       v2_read_dquot+0x49/0x120 fs/quota/quota_v2.c:327
       dquot_acquire+0x12e/0x590 fs/quota/dquot.c:434
       ext4_acquire_dquot+0x254/0x3b0 fs/ext4/super.c:6216
       dqget+0x678/0x1080 fs/quota/dquot.c:901
       __dquot_initialize+0x560/0xbe0 fs/quota/dquot.c:1479
       ext4_create+0x8b/0x4c0 fs/ext4/namei.c:2606
       lookup_open.isra.0+0xf85/0x1350 fs/namei.c:3106
       open_last_lookups fs/namei.c:3180 [inline]
       path_openat+0x96d/0x2730 fs/namei.c:3368
       do_filp_open+0x17e/0x3c0 fs/namei.c:3398
       do_sys_openat2+0x16d/0x420 fs/open.c:1172
       do_sys_open fs/open.c:1188 [inline]
       __do_sys_creat fs/open.c:1262 [inline]
       __se_sys_creat fs/open.c:1256 [inline]
       __x64_sys_creat+0xc9/0x120 fs/open.c:1256
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2868 [inline]
       check_prevs_add kernel/locking/lockdep.c:2993 [inline]
       validate_chain kernel/locking/lockdep.c:3608 [inline]
       __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
       lock_acquire kernel/locking/lockdep.c:5442 [inline]
       lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
       dquot_commit+0x4d/0x420 fs/quota/dquot.c:476
       ext4_write_dquot+0x24e/0x310 fs/ext4/super.c:6200
       ext4_mark_dquot_dirty fs/ext4/super.c:6248 [inline]
       ext4_mark_dquot_dirty+0x111/0x1b0 fs/ext4/super.c:6242
       mark_dquot_dirty fs/quota/dquot.c:347 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:385 [inline]
       __dquot_alloc_space+0x5d4/0xb60 fs/quota/dquot.c:1709
       dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
       dquot_alloc_space include/linux/quotaops.h:310 [inline]
       dquot_alloc_block include/linux/quotaops.h:334 [inline]
       ext4_mb_new_blocks+0x5a9/0x51a0 fs/ext4/mballoc.c:4937
       ext4_ext_map_blocks+0x20da/0x5fb0 fs/ext4/extents.c:4238
       ext4_map_blocks+0x653/0x17d0 fs/ext4/inode.c:637
       _ext4_get_block+0x241/0x590 fs/ext4/inode.c:793
       ext4_block_write_begin+0x4f8/0x1190 fs/ext4/inode.c:1077
       ext4_write_begin+0x4b5/0x14b0 fs/ext4/inode.c:1202
       ext4_da_write_begin+0x672/0x1150 fs/ext4/inode.c:2961
       generic_perform_write+0x20a/0x4f0 mm/filemap.c:3412
       ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:270
       ext4_file_write_iter+0x423/0x14d0 fs/ext4/file.c:664
       call_write_iter include/linux/fs.h:1901 [inline]
       new_sync_write+0x426/0x650 fs/read_write.c:518
       vfs_write+0x791/0xa30 fs/read_write.c:605
       ksys_write+0x12d/0x250 fs/read_write.c:658
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &dquot->dq_lock --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/2);
                               lock(&s->s_dquot.dqio_sem);
                               lock(&ei->i_data_sem/2);
  lock(&dquot->dq_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.1/16170:
 #0: ffff88802ad18b70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:947
 #1: ffff88802fbec460 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x12d/0x250 fs/read_write.c:658
 #2: ffff88807960b648 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:773 [inline]
 #2: ffff88807960b648 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: ext4_buffered_write_iter+0xb6/0x4d0 fs/ext4/file.c:264
 #3: ffff88807960b438 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630
 #4: ffffffff8bf1be58 (dquot_srcu){....}-{0:0}, at: i_dquot fs/quota/dquot.c:926 [inline]
 #4: ffffffff8bf1be58 (dquot_srcu){....}-{0:0}, at: __dquot_alloc_space+0x1b4/0xb60 fs/quota/dquot.c:1671

stack backtrace:
CPU: 0 PID: 16170 Comm: syz-executor.1 Not tainted 5.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
 check_prev_add kernel/locking/lockdep.c:2868 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
 dquot_commit+0x4d/0x420 fs/quota/dquot.c:476
 ext4_write_dquot+0x24e/0x310 fs/ext4/super.c:6200
 ext4_mark_dquot_dirty fs/ext4/super.c:6248 [inline]
 ext4_mark_dquot_dirty+0x111/0x1b0 fs/ext4/super.c:6242
 mark_dquot_dirty fs/quota/dquot.c:347 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:385 [inline]
 __dquot_alloc_space+0x5d4/0xb60 fs/quota/dquot.c:1709
 dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
 dquot_alloc_space include/linux/quotaops.h:310 [inline]
 dquot_alloc_block include/linux/quotaops.h:334 [inline]
 ext4_mb_new_blocks+0x5a9/0x51a0 fs/ext4/mballoc.c:4937
 ext4_ext_map_blocks+0x20da/0x5fb0 fs/ext4/extents.c:4238
 ext4_map_blocks+0x653/0x17d0 fs/ext4/inode.c:637
 _ext4_get_block+0x241/0x590 fs/ext4/inode.c:793
 ext4_block_write_begin+0x4f8/0x1190 fs/ext4/inode.c:1077
 ext4_write_begin+0x4b5/0x14b0 fs/ext4/inode.c:1202
 ext4_da_write_begin+0x672/0x1150 fs/ext4/inode.c:2961
 generic_perform_write+0x20a/0x4f0 mm/filemap.c:3412
 ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:270
 ext4_file_write_iter+0x423/0x14d0 fs/ext4/file.c:664
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8097ffc188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 000000000d4ba0ff RSI: 00000000200009c0 RDI: 0000000000000003
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffefc77f01f R14: 00007f8097ffc300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
