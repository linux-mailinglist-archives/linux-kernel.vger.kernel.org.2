Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6978B31955E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBKVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:47:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45178 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229478AbhBKVrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:47:48 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11BLksBX030966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 16:46:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C89B15C3601; Thu, 11 Feb 2021 16:46:54 -0500 (EST)
Date:   Thu, 11 Feb 2021 16:46:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in dquot_commit
Message-ID: <YCWlzl1q+eP22KVc@mit.edu>
References: <000000000000a05b3b05baf9a856@google.com>
 <20210211113718.GM19070@quack2.suse.cz>
 <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:47:18PM +0100, Dmitry Vyukov wrote:
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

The 4.19 version of the syzbot report has a very different stack
trace.  Instead of it being related to an apparent write to the quota
file, it is apparently caused by a call to rmdir:

 dump_stack+0x22c/0x33e lib/dump_stack.c:118
 print_circular_bug.constprop.0.cold+0x2d7/0x41e kernel/locking/lockdep.c:1221
   ...
 __mutex_lock+0xd7/0x13f0 kernel/locking/mutex.c:1072
 dquot_commit+0x4d/0x400 fs/quota/dquot.c:469
 ext4_write_dquot+0x1f2/0x2a0 fs/ext4/super.c:5644
   ...
 ext4_evict_inode+0x933/0x1830 fs/ext4/inode.c:298
 evict+0x2ed/0x780 fs/inode.c:559
 iput_final fs/inode.c:1555 [inline]
   ...
 vfs_rmdir fs/namei.c:3865 [inline]
 do_rmdir+0x3af/0x420 fs/namei.c:3943
 __do_sys_unlinkat fs/namei.c:4105 [inline]
 __se_sys_unlinkat fs/namei.c:4099 [inline]
 __x64_sys_unlinkat+0xdf/0x120 fs/namei.c:4099
 do_syscall_64+0xf9/0x670 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Which leads me to another apparent contradiction.  Looking at the C
reproducer source code, and running the C reproducer under "strace
-ff", there is never any attempt to run rmdir() on the corrupted file
system that is mounted.  Neither as observed by my running the C
reproducer, or by looking at the C reproducer source code.

Looking at the code, I did see a number of things which seemed to be
bugs; procid never gets incremented, so all of the threads only
operate on /dev/loop0, and each call to the execute() function tries
to setup two file systems on /dev/loop0.  So the each thread to run
creates a temp file, binds it to /dev/loop0, and then creates another
temp file, tries to bind it to /dev/loop0 (which will fail), tries to
mount /dev/loop0 (again) on the samee mount point (which will
succeed).

I'm not sure if this is just some insanity that was consed up by the
fuzzer... or I'm wondering if this was an unfaithful translation of
the syzbot repro to C.  Am I correct in understanding that when syzbot
is running, it uses the syzbot repro, and not the C repro?

   	       	    	       	      - Ted
