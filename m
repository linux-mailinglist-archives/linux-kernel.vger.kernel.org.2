Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC327376965
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhEGRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234557AbhEGRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15BBE610CD;
        Fri,  7 May 2021 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620407942;
        bh=nAVXmO+rfcdFTOBebvWaB9OwgZ+PUmBDHpyvxqpRi0U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T5RiJdeyfyAK+qnUOe6j0ly1QqVyqChj3t/CJ+vKtsMSWRCHKZqudXasY9nNwSTo1
         Zl2zrlZ9/Urc2V+SMgUUHDZY9ew88zBUzCp5Itc+KSY6FbvA56IodJkhd0YVxSfiqH
         5pGvbvYFioLbEjeDD3CzA06o2jG7vSiZHnrz4QgRYByCJ+2Sm6CvCJhzdWz2IX1BMd
         2zrpjznOJNhNVZcgXG/wDSRzMQ6bxjNB+J6Fw7eqWp8fAU+UL6+0L1rmDH6asLcPTz
         Tmk2UXsv/5rJQoD5kHHJis2ktcsxSB+NRD3DBrC0eFaIfVBvg+3k67hat/sPA1xl2M
         8SMN9CIl4QXxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9821B5C0293; Fri,  7 May 2021 10:19:01 -0700 (PDT)
Date:   Fri, 7 May 2021 10:19:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_signal
Message-ID: <20210507171901.GV975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <0000000000006540d705c1b013b5@google.com>
 <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
 <CACT4Y+aaGyfiEgbKca-6gourQjtwVMHuwUcb30QJPOF1LhLcxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aaGyfiEgbKca-6gourQjtwVMHuwUcb30QJPOF1LhLcxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:42:48AM +0200, Dmitry Vyukov wrote:
> On Fri, May 7, 2021 at 10:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, May 06, 2021 at 02:34:27PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.12.0-syzkaller #0 Not tainted
> > > -----------------------------
> > > kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
> > >
> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 0
> > > no locks held by syz-executor.4/10430.
> >
> > Looks like this is a concurrent fail?, if !debug_locks (as per the above)
> > then RCU_LOCKDEP_WARN() should not trigger.
> 
> FTR the log is here:
> https://syzkaller.appspot.com/text?tag=CrashLog&x=123a56a5d00000
> 
> It contains 2 intermixed reports:
> 
> [  289.896033][T10430] =============================
> [  289.896039][T10430] WARNING: suspicious RCU usage
> [  289.896046][T10430] 5.12.0-syzkaller #0 Not tainted
> [  289.898388][T13493] ======================================================
> [  289.898401][T13493] WARNING: possible circular locking dependency detected
> [  289.898410][T13493] 5.12.0-syzkaller #0 Not tainted
> [  289.898424][T13493] ------------------------------------------------------
> [  289.898432][T13493] syz-executor.0/13493 is trying to acquire lock:
> [  289.898448][T13493] ffff888019065ca0 (&bdev->bd_mutex){+.+.}-{3:3},
> at: del_gendisk+0x250/0x9e0

This "suspicious RCU usage" false positive looks to be addressed by this
commit in -rcu, slated for the v5.14 merge window:

81a5e05455d4 ("rcu: Reject RCU_LOCKDEP_WARN() false positives")

So I suggest ignoring the "suspicious RCU usage" report in favor of the
"possible circular locking dependency detected" report.

							Thanx, Paul
