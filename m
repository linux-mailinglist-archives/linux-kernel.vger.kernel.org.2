Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46931907E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBKQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:58:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhBKPr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:47:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1186FACBF;
        Thu, 11 Feb 2021 15:47:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AAF211E14C6; Thu, 11 Feb 2021 16:47:14 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:47:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in dquot_commit
Message-ID: <20210211154714.GR19070@quack2.suse.cz>
References: <000000000000a05b3b05baf9a856@google.com>
 <20210211113718.GM19070@quack2.suse.cz>
 <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-02-21 12:47:18, Dmitry Vyukov wrote:
> On Thu, Feb 11, 2021 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 10-02-21 03:25:22, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1e0d27fc Merge branch 'akpm' (patches from Andrew)
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=101cf2f8d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
> > >
> > > loop1: detected capacity change from 4096 to 0
> > > EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: writeback.
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 5.11.0-rc6-syzkaller #0 Not tainted
> > > ------------------------------------------------------
> > > syz-executor.1/16170 is trying to acquire lock:
> > > ffff8880795f5b28 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x4d/0x420 fs/quota/dquot.c:476
> > >
> > > but task is already holding lock:
> > > ffff88807960b438 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630
> > >
> > > which lock already depends on the new lock.
> >
> > <snip>
> >
> > All snipped stacktraces look perfectly fine and the lock dependencies are as
> > expected.
> >
> > > 5 locks held by syz-executor.1/16170:
> > >  #0: ffff88802ad18b70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:947
> > >  #1: ffff88802fbec460 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x12d/0x250 fs/read_write.c:658
> > >  #2: ffff88807960b648 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:773 [inline]
> > >  #2: ffff88807960b648 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: ext4_buffered_write_iter+0xb6/0x4d0 fs/ext4/file.c:264
> > >  #3: ffff88807960b438 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630
> > >  #4: ffffffff8bf1be58 (dquot_srcu){....}-{0:0}, at: i_dquot fs/quota/dquot.c:926 [inline]
> > >  #4: ffffffff8bf1be58 (dquot_srcu){....}-{0:0}, at: __dquot_alloc_space+0x1b4/0xb60 fs/quota/dquot.c:1671
> >
> > This actually looks problematic: We acquired &ei->i_data_sem/2 (i.e.,
> > I_DATA_SEM_QUOTA subclass) in ext4_map_blocks() called from
> > ext4_block_write_begin(). This suggests that the write has been happening
> > directly to the quota file (or that lockdep annotation of the inode went
> > wrong somewhere). Now we normally protect quota files with IMMUTABLE flag
> > so writing it should not be possible. We also don't allow clearing this
> > flag on used quota file. Finally I'd checked lockdep annotation and
> > everything looks correct. So at this point the best theory I have is that a
> > filesystem has been suitably corrupted and quota file supposed to be
> > inaccessible from userspace got exposed but I'd expect other problems to
> > hit first in that case. Anyway without a reproducer I have no more ideas...
> 
> There is a reproducer for 4.19 available on the dashboard. Maybe it will help.
> I don't why it did not pop up on upstream yet, there lots of potential
> reasons for this.

OK, so I've checked the fs images generated by the syzkaller reproducer and
they indeed have QUOTA feature enabled. Also inodes used by quota files are
not marked as allocated so there is some potential for surprises. But all
the possible paths I could think of seem to be covered and return
EFSCORRUPTED. Also note that the reproducer didn't trigger the
lockdep splat for me so the problem still isn't clear to me.

								Honza

> > >
> > > stack backtrace:
> > > CPU: 0 PID: 16170 Comm: syz-executor.1 Not tainted 5.11.0-rc6-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:79 [inline]
> > >  dump_stack+0x107/0x163 lib/dump_stack.c:120
> > >  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
> > >  check_prev_add kernel/locking/lockdep.c:2868 [inline]
> > >  check_prevs_add kernel/locking/lockdep.c:2993 [inline]
> > >  validate_chain kernel/locking/lockdep.c:3608 [inline]
> > >  __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
> > >  lock_acquire kernel/locking/lockdep.c:5442 [inline]
> > >  lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
> > >  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
> > >  __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
> > >  dquot_commit+0x4d/0x420 fs/quota/dquot.c:476
> > >  ext4_write_dquot+0x24e/0x310 fs/ext4/super.c:6200
> > >  ext4_mark_dquot_dirty fs/ext4/super.c:6248 [inline]
> > >  ext4_mark_dquot_dirty+0x111/0x1b0 fs/ext4/super.c:6242
> > >  mark_dquot_dirty fs/quota/dquot.c:347 [inline]
> > >  mark_all_dquot_dirty fs/quota/dquot.c:385 [inline]
> > >  __dquot_alloc_space+0x5d4/0xb60 fs/quota/dquot.c:1709
> > >  dquot_alloc_space_nodirty include/linux/quotaops.h:297 [inline]
> > >  dquot_alloc_space include/linux/quotaops.h:310 [inline]
> > >  dquot_alloc_block include/linux/quotaops.h:334 [inline]
> > >  ext4_mb_new_blocks+0x5a9/0x51a0 fs/ext4/mballoc.c:4937
> > >  ext4_ext_map_blocks+0x20da/0x5fb0 fs/ext4/extents.c:4238
> > >  ext4_map_blocks+0x653/0x17d0 fs/ext4/inode.c:637
> > >  _ext4_get_block+0x241/0x590 fs/ext4/inode.c:793
> > >  ext4_block_write_begin+0x4f8/0x1190 fs/ext4/inode.c:1077
> > >  ext4_write_begin+0x4b5/0x14b0 fs/ext4/inode.c:1202
> > >  ext4_da_write_begin+0x672/0x1150 fs/ext4/inode.c:2961
> > >  generic_perform_write+0x20a/0x4f0 mm/filemap.c:3412
> > >  ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:270
> > >  ext4_file_write_iter+0x423/0x14d0 fs/ext4/file.c:664
> > >  call_write_iter include/linux/fs.h:1901 [inline]
> > >  new_sync_write+0x426/0x650 fs/read_write.c:518
> > >  vfs_write+0x791/0xa30 fs/read_write.c:605
> > >  ksys_write+0x12d/0x250 fs/read_write.c:658
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > RIP: 0033:0x465b09
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f8097ffc188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > > RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465b09
> > > RDX: 000000000d4ba0ff RSI: 00000000200009c0 RDI: 0000000000000003
> > > RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
> > > R13: 00007ffefc77f01f R14: 00007f8097ffc300 R15: 0000000000022000
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20210211113718.GM19070%40quack2.suse.cz.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
