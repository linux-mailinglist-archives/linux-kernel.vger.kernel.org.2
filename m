Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F373E45F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhHIMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:54:51 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48006 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbhHIMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:54:48 -0400
Received: by mail-il1-f199.google.com with SMTP id c7-20020a928e070000b0290222cccb8651so5651961ild.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3tqrax3REEfbkDNjYeOFK7hswBov4/TqvhBk5DHKi6o=;
        b=sW0svJfatXyE9oSb/MQ2GbOKORRk7yLro0uqPMP9diq9UW91xV7/G8yXgCiDqUtsPE
         0tcaju98YzMC7/TGdUoIKy7l2Sl5CNJ9YmEh917woH42uWzZhZMJydjVnzcAOnscddWl
         5/T89Ivm3ZW6acqxMdtWpietuvhmj8fOrHnt2Y4ZPci7ChPyodf/GqfXHwM+P65HCw6j
         gSHB0aAOW+vp/md8StnlRU+TwvPl3WtIQHFSOmP/6Mbr9lRpj7zmWw4EZxLSVQrn7KKB
         ScK5P0IbRD9DOw25kjAKfAgrFO2xcVYJ98N6jWqUBhsQQ1qrpkwkEmxrMDGIjSkALiQZ
         13Ug==
X-Gm-Message-State: AOAM532MvfL4BObkZRqd6Y5IieiQPcRBfvjHVYfuULBXzZs/skWSNFvB
        0mBT8rH/T6xUaj+fr7bvEsbbDdxR2aHhWJP5/NsyvdL0KuCw
X-Google-Smtp-Source: ABdhPJyrk3J2JQqu6I4L0Ie9VKIeU/Ak2hAqnA2T0+N+ZWvwexF0QoKjk2WS0i3kB/9ydATYrHi9gbP88e6N+uzxSkm7B21BdbMF
MIME-Version: 1.0
X-Received: by 2002:a02:b0d1:: with SMTP id w17mr21742670jah.1.1628513667533;
 Mon, 09 Aug 2021 05:54:27 -0700 (PDT)
Date:   Mon, 09 Aug 2021 05:54:27 -0700
In-Reply-To: <000000000000a05b3b05baf9a856@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa4cd605c91fe2b3@google.com>
Subject: Re: [syzbot] possible deadlock in dquot_commit
From:   syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    66745863ecde Merge tag 'char-misc-5.14-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13edca6e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aeba6e300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a609e6300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor211/9242 is trying to acquire lock:
ffff88803a37ece8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x57/0x360 fs/quota/dquot.c:474

but task is already holding lock:
ffff88803a303e48 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x9e5/0x1cb0 fs/ext4/inode.c:631

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem/2){++++}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
       ext4_map_blocks+0x266/0x1cb0 fs/ext4/inode.c:561
       ext4_getblk+0x187/0x6c0 fs/ext4/inode.c:848
       ext4_bread+0x2a/0x170 fs/ext4/inode.c:900
       ext4_quota_write+0x2c7/0x5b0 fs/ext4/super.c:6602
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0x33a/0x660 fs/quota/quota_tree.c:93
       do_insert_tree+0x24c/0x1d30 fs/quota/quota_tree.c:300
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:376
       v2_write_dquot+0x110/0x1a0 fs/quota/quota_v2.c:358
       dquot_acquire+0x2d7/0x5b0 fs/quota/dquot.c:441
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6261
       dqget+0x999/0xdc0 fs/quota/dquot.c:899
       __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
       ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
       lookup_open fs/namei.c:3228 [inline]
       open_last_lookups fs/namei.c:3298 [inline]
       path_openat+0x13b7/0x36b0 fs/namei.c:3504
       do_filp_open+0x253/0x4d0 fs/namei.c:3534
       do_sys_openat2+0x124/0x460 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_creat fs/open.c:1294 [inline]
       __se_sys_creat fs/open.c:1288 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1288
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
       v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
       dquot_acquire+0x144/0x5b0 fs/quota/dquot.c:432
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6261
       dqget+0x999/0xdc0 fs/quota/dquot.c:899
       __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
       ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
       lookup_open fs/namei.c:3228 [inline]
       open_last_lookups fs/namei.c:3298 [inline]
       path_openat+0x13b7/0x36b0 fs/namei.c:3504
       do_filp_open+0x253/0x4d0 fs/namei.c:3534
       do_sys_openat2+0x124/0x460 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_creat fs/open.c:1294 [inline]
       __se_sys_creat fs/open.c:1288 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1288
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       dquot_commit+0x57/0x360 fs/quota/dquot.c:474
       ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6245
       mark_dquot_dirty fs/quota/dquot.c:345 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:383 [inline]
       __dquot_alloc_space+0xa18/0x1020 fs/quota/dquot.c:1707
       dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
       dquot_alloc_space include/linux/quotaops.h:310 [inline]
       dquot_alloc_block include/linux/quotaops.h:334 [inline]
       ext4_mb_new_blocks+0xe85/0x2470 fs/ext4/mballoc.c:5477
       ext4_ext_map_blocks+0x2be3/0x7210 fs/ext4/extents.c:4245
       ext4_map_blocks+0xab3/0x1cb0 fs/ext4/inode.c:638
       _ext4_get_block+0x24b/0x710 fs/ext4/inode.c:794
       ext4_block_write_begin+0x63a/0x1250 fs/ext4/inode.c:1077
       ext4_write_begin+0x5cc/0x1350 fs/ext4/ext4_jbd2.h:498
       ext4_da_write_begin+0x384/0x10c0 fs/ext4/inode.c:2960
       generic_perform_write+0x262/0x580 mm/filemap.c:3656
       ext4_buffered_write_iter+0x41c/0x590 fs/ext4/file.c:269
       ext4_file_write_iter+0x8f7/0x1b90 fs/ext4/file.c:519
       call_write_iter include/linux/fs.h:2114 [inline]
       new_sync_write fs/read_write.c:518 [inline]
       vfs_write+0xa39/0xc90 fs/read_write.c:605
       ksys_write+0x171/0x2a0 fs/read_write.c:658
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

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

4 locks held by syz-executor211/9242:
 #0: ffff88802ff60460 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x21b/0xc90 fs/read_write.c:601
 #1: ffff88803a304058 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
 #1: ffff88803a304058 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: ext4_buffered_write_iter+0xaf/0x590 fs/ext4/file.c:263
 #2: ffff88803a303e48 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x9e5/0x1cb0 fs/ext4/inode.c:631
 #3: ffffffff8c840518 (dquot_srcu){....}-{0:0}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:266

stack backtrace:
CPU: 1 PID: 9242 Comm: syz-executor211 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2009
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
 __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 dquot_commit+0x57/0x360 fs/quota/dquot.c:474
 ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6245
 mark_dquot_dirty fs/quota/dquot.c:345 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:383 [inline]
 __dquot_alloc_space+0xa18/0x1020 fs/quota/dquot.c:1707
 dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
 dquot_alloc_space include/linux/quotaops.h:310 [inline]
 dquot_alloc_block include/linux/quotaops.h:334 [inline]
 ext4_mb_new_blocks+0xe85/0x2470 fs/ext4/mballoc.c:5477
 ext4_ext_map_blocks+0x2be3/0x7210 fs/ext4/extents.c:4245
 ext4_map_blocks+0xab3/0x1cb0 fs/ext4/inode.c:638
 _ext4_get_block+0x24b/0x710 fs/ext4/inode.c:794
 ext4_block_write_begin+0x63a/0x1250 fs/ext4/inode.c:1077
 ext4_write_begin+0x5cc/0x1350 fs/ext4/ext4_jbd2.h:498
 ext4_da_write_begin+0x384/0x10c0 fs/ext4/inode.c:2960
 generic_perform_write+0x262/0x580 mm/filemap.c:3656
 ext4_buffered_write_iter+0x41c/0x590 fs/ext4/file.c:269
 ext4_file_write_iter+0x8f7/0x1b90 fs/ext4/file.c:519
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445219
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8864cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004885e9 RCX: 0000000000445219
RDX: 000000000d4ba0ff RSI: 00000000200009c0 RDI: 0000000000000003
RBP: 0000000020010500 R08: 00007ffd8864cd40 R09: 00007ffd8864cd40
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020010000
R13: 0030656c69662f2e R14: 00007ffd8864cd50 R15: 000000000000004d

