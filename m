Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7713E56B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhHJJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:22:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhHJJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:22:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF1B321FBD;
        Tue, 10 Aug 2021 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628587302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJs0pRvd/ZvOIZNTjSIQFHz8l1ZafxIyvbgNuLmitqc=;
        b=M7qGSedOH03Qbzkhl+vZF0PDc/ljk56etpya9GM2rLaXLlBdUQ3V/st8P3NTC74+sw4H98
        JI2YECFTm2HVivPyOTkCxQKmxG75E7qj8k8lKq11gcaRPN/M5qgIUQJL04jTXaWik1hI7W
        So2ZDsbEftLqnkDSWOXdo7DIz+uLYRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628587302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJs0pRvd/ZvOIZNTjSIQFHz8l1ZafxIyvbgNuLmitqc=;
        b=HXAVNMAhnkggcuqGL7bsd/YsRCwMP+2GCRzKjbiWVlzHmkOfD0yqKz+lJsxsey+MTh+NrH
        G04uVq0GUUJiVDAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6D36DA3C32;
        Tue, 10 Aug 2021 09:21:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80A081E3BFC; Tue, 10 Aug 2021 11:21:42 +0200 (CEST)
Date:   Tue, 10 Aug 2021 11:21:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        dvyukov@google.com, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] possible deadlock in dquot_commit
Message-ID: <20210810092142.GB18722@quack2.suse.cz>
References: <000000000000a05b3b05baf9a856@google.com>
 <20210810041100.3271-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810041100.3271-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-08-21 12:11:00, Hillf Danton wrote:
> On Mon, 09 Aug 2021 05:54:27 -0700
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    66745863ecde Merge tag 'char-misc-5.14-rc5' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13edca6e300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aeba6e300000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a609e6300000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 4096
> > EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: writeback.
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.14.0-rc4-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor211/9242 is trying to acquire lock:
> > ffff88803a37ece8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x57/0x360 fs/quota/dquot.c:474
> > 
> > but task is already holding lock:
> > ffff88803a303e48 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x9e5/0x1cb0 fs/ext4/inode.c:631
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #2 (&ei->i_data_sem/2){++++}-{3:3}:
> >        lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
> >        down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
> >        ext4_map_blocks+0x266/0x1cb0 fs/ext4/inode.c:561
> >        ext4_getblk+0x187/0x6c0 fs/ext4/inode.c:848
> >        ext4_bread+0x2a/0x170 fs/ext4/inode.c:900
> >        ext4_quota_write+0x2c7/0x5b0 fs/ext4/super.c:6602
> >        write_blk fs/quota/quota_tree.c:64 [inline]
> >        get_free_dqblk+0x33a/0x660 fs/quota/quota_tree.c:93
> >        do_insert_tree+0x24c/0x1d30 fs/quota/quota_tree.c:300
> >        do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
> >        do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
> >        do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
> >        dq_insert_tree fs/quota/quota_tree.c:357 [inline]
> >        qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:376
> >        v2_write_dquot+0x110/0x1a0 fs/quota/quota_v2.c:358
> >        dquot_acquire+0x2d7/0x5b0 fs/quota/dquot.c:441
> 
> Mark1, see below.
> 
> >        ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6261
> >        dqget+0x999/0xdc0 fs/quota/dquot.c:899
> >        __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
> >        ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
> >        lookup_open fs/namei.c:3228 [inline]
> >        open_last_lookups fs/namei.c:3298 [inline]
> >        path_openat+0x13b7/0x36b0 fs/namei.c:3504
> >        do_filp_open+0x253/0x4d0 fs/namei.c:3534
> >        do_sys_openat2+0x124/0x460 fs/open.c:1204
> >        do_sys_open fs/open.c:1220 [inline]
> >        __do_sys_creat fs/open.c:1294 [inline]
> >        __se_sys_creat fs/open.c:1288 [inline]
> >        __x64_sys_creat+0x11f/0x160 fs/open.c:1288
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
> >        lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
> >        down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
> >        v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
> >        dquot_acquire+0x144/0x5b0 fs/quota/dquot.c:432
> 
> What boggles mind is both this line and the above line at Mark1 are under
> 
> 430	mutex_lock(&dquot->dq_lock);
> 
> Is it likely?

I'm not quite sure what you are asking about but yes, dquot_acquire() grabs
dquot->dq_lock, then e.g. v2_write_dquot() acquires dqio_sem, then
ext4_map_blocks() acquires i_data_sem/2 (special lock subclass for quota
files). What is unexpected is the #0 trace where i_data_sem/2 is acquired
by ext4_map_blocks() called from ext4_write_begin(). That shows that
normal write(2) call was able to operate on quota file which is certainly
wrong. My patch closed one path how this could happen and I'm puzzled how
else this could happen. I'll try to reproduce the issue (I've already tried
but so far failed) as see if I can find out more.

									Honza

> >        dqget+0x999/0xdc0 fs/quota/dquot.c:899
> >        __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
> >        ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
> >        lookup_open fs/namei.c:3228 [inline]
> >        open_last_lookups fs/namei.c:3298 [inline]
> >        path_openat+0x13b7/0x36b0 fs/namei.c:3504
> >        do_filp_open+0x253/0x4d0 fs/namei.c:3534
> >        do_sys_openat2+0x124/0x460 fs/open.c:1204
> >        do_sys_open fs/open.c:1220 [inline]
> >        __do_sys_creat fs/open.c:1294 [inline]
> >        __se_sys_creat fs/open.c:1288 [inline]
> >        __x64_sys_creat+0x11f/0x160 fs/open.c:1288
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #0 (&dquot->dq_lock){+.+.}-{3:3}:
> >        check_prev_add kernel/locking/lockdep.c:3051 [inline]
> >        check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
> >        validate_chain kernel/locking/lockdep.c:3789 [inline]
> >        __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
> >        lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
> >        __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
> >        __mutex_lock kernel/locking/mutex.c:1104 [inline]
> >        mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
> >        dquot_commit+0x57/0x360 fs/quota/dquot.c:474
> >        ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6245
> >        mark_dquot_dirty fs/quota/dquot.c:345 [inline]
> >        mark_all_dquot_dirty fs/quota/dquot.c:383 [inline]
> >        __dquot_alloc_space+0xa18/0x1020 fs/quota/dquot.c:1707
> >        dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
> >        dquot_alloc_space include/linux/quotaops.h:310 [inline]
> >        dquot_alloc_block include/linux/quotaops.h:334 [inline]
> >        ext4_mb_new_blocks+0xe85/0x2470 fs/ext4/mballoc.c:5477
> >        ext4_ext_map_blocks+0x2be3/0x7210 fs/ext4/extents.c:4245
> >        ext4_map_blocks+0xab3/0x1cb0 fs/ext4/inode.c:638
> >        _ext4_get_block+0x24b/0x710 fs/ext4/inode.c:794
> >        ext4_block_write_begin+0x63a/0x1250 fs/ext4/inode.c:1077
> >        ext4_write_begin+0x5cc/0x1350 fs/ext4/ext4_jbd2.h:498
> >        ext4_da_write_begin+0x384/0x10c0 fs/ext4/inode.c:2960
> >        generic_perform_write+0x262/0x580 mm/filemap.c:3656
> >        ext4_buffered_write_iter+0x41c/0x590 fs/ext4/file.c:269
> >        ext4_file_write_iter+0x8f7/0x1b90 fs/ext4/file.c:519
> >        call_write_iter include/linux/fs.h:2114 [inline]
> >        new_sync_write fs/read_write.c:518 [inline]
> >        vfs_write+0xa39/0xc90 fs/read_write.c:605
> >        ksys_write+0x171/0x2a0 fs/read_write.c:658
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >   &dquot->dq_lock --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&ei->i_data_sem/2);
> >                                lock(&s->s_dquot.dqio_sem);
> >                                lock(&ei->i_data_sem/2);
> >   lock(&dquot->dq_lock);
> > 
> >  *** DEADLOCK ***
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
