Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8237747B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhEHXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 19:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhEHXAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 19:00:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57138613EE;
        Sat,  8 May 2021 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620514793;
        bh=6cLcIISfVMA39dZyMddgsuL+j0rAWjSSyewRfGwaabw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l417ed8xvJmvP1uLYwmq8IaKFdf6HCf/06vwtp8MhPpy5S5mrZfM/wU0HUyy6KM/w
         Iugw313A4/ifeTEKgbSlUJhZEpYEVZr7ERhPCJN3+UmIODxQSFGYT6aMmRnipSDP6b
         o3XdXJOX2BlqgBuMgc3oh5dL3j80Z1UWwJwappT9NLlrGuF8HkX1oNfT9qleS9Geg5
         m5Ervx8uoWRB4/Yys2nqQy91jhlNq/VVzTaOYnf8DRkwjlWuf//dWfg+htcSBYFJxX
         rl2to4bLA2Z2sVOG5WD5+ioXNEpcw3pjCvOP2JCGeiN4ving3ZcHWCczHdrMuNWCJP
         GMZWqRUGNlOuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 141415C013E; Sat,  8 May 2021 15:59:53 -0700 (PDT)
Date:   Sat, 8 May 2021 15:59:53 -0700
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
Message-ID: <20210508225953.GB975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <0000000000006540d705c1b013b5@google.com>
 <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
 <CACT4Y+aaGyfiEgbKca-6gourQjtwVMHuwUcb30QJPOF1LhLcxQ@mail.gmail.com>
 <20210507171901.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Ydu6Dcmx1tXe-1aOw-hAcHgjwncrSmWuEr_8tfq02Dtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ydu6Dcmx1tXe-1aOw-hAcHgjwncrSmWuEr_8tfq02Dtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 07:03:51AM +0200, Dmitry Vyukov wrote:
> On Fri, May 7, 2021 at 7:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, May 07, 2021 at 10:42:48AM +0200, Dmitry Vyukov wrote:
> > > On Fri, May 7, 2021 at 10:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, May 06, 2021 at 02:34:27PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
> > > > > userspace arch: i386
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com
> > > > >
> > > > > =============================
> > > > > WARNING: suspicious RCU usage
> > > > > 5.12.0-syzkaller #0 Not tainted
> > > > > -----------------------------
> > > > > kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
> > > > >
> > > > > other info that might help us debug this:
> > > > >
> > > > >
> > > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > > no locks held by syz-executor.4/10430.
> > > >
> > > > Looks like this is a concurrent fail?, if !debug_locks (as per the above)
> > > > then RCU_LOCKDEP_WARN() should not trigger.
> > >
> > > FTR the log is here:
> > > https://syzkaller.appspot.com/text?tag=CrashLog&x=123a56a5d00000
> > >
> > > It contains 2 intermixed reports:
> > >
> > > [  289.896033][T10430] =============================
> > > [  289.896039][T10430] WARNING: suspicious RCU usage
> > > [  289.896046][T10430] 5.12.0-syzkaller #0 Not tainted
> > > [  289.898388][T13493] ======================================================
> > > [  289.898401][T13493] WARNING: possible circular locking dependency detected
> > > [  289.898410][T13493] 5.12.0-syzkaller #0 Not tainted
> > > [  289.898424][T13493] ------------------------------------------------------
> > > [  289.898432][T13493] syz-executor.0/13493 is trying to acquire lock:
> > > [  289.898448][T13493] ffff888019065ca0 (&bdev->bd_mutex){+.+.}-{3:3},
> > > at: del_gendisk+0x250/0x9e0
> >
> > This "suspicious RCU usage" false positive looks to be addressed by this
> > commit in -rcu, slated for the v5.14 merge window:
> >
> > 81a5e05455d4 ("rcu: Reject RCU_LOCKDEP_WARN() false positives")
> >
> > So I suggest ignoring the "suspicious RCU usage" report in favor of the
> > "possible circular locking dependency detected" report.
> 
> Oh, I see, it's not merged yet.
> In my memory we discussed it so long ago that I assumed it is fixed already.

It was a bit too late to make my pull request.  I won't lose it.  ;-)

							Thanx, Paul

> Let's mark it as fixed then:
> 
> #syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives
> 
> Thanks for double checking.
