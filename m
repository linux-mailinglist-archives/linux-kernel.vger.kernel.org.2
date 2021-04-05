Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495BC353B07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhDEDJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhDEDJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65AC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BeBVpYmMi0EGHzD7xMjcprnZ4td+YmP9T+kOblzjlBk=; b=lYeZqHgzPQ0UlzMTrQq6rKOfpf
        69YjhitIY1uvuGITASgqJZeQvddDixBd0MorCw2kceAEKyD8BPRolyl89fvLxoIazNkLFhkAlndk0
        GAELP/qGD2IMGc21t92TFzR2MfPNj1dAXniDgPTijipbbPPAXRDuSPyVX7uE/NyFbvg26Cy3WkWMN
        eMEiot6IZVqMm7mR1Ddgof1FdCw7RbLqKMQpRMRdHAUac6Aliwh3eWoY4Qe3JbFKKpsX4VA51YR68
        0cwWsBofbhH3ahnR+tChwJTjUa99PaVqqI7zQRDdwSy08/KcXfGzFdKkqMGvVR1lMX3DFcaxXDUD5
        IIm0MQUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTFbj-00ArN4-Ta; Mon, 05 Apr 2021 03:09:02 +0000
Date:   Mon, 5 Apr 2021 04:08:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <20210405030855.GG2531743@casper.infradead.org>
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
 <20210404214030.GB2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404214030.GB2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 02:40:30PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> > On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> > 
> > Cc + ...
> 
> And a couple more...
> 
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.12.0-rc5-syzkaller #0 Not tainted
> > > -----------------------------
> > > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> > >
> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 0
> > > 3 locks held by syz-executor.4/8418:
> > >  #0: 
> > > ffff8880751d2b28
> > >  (
> > > &p->pi_lock
> > > ){-.-.}-{2:2}
> > > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> > >  #1: 
> > > ffff8880b9d35258
> > >  (
> > > &rq->lock
> > > ){-.-.}-{2:2}
> > > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> > >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> 
> This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
> in that rcu_sleep_check() sees an RCU lock held, but the later call to
> lockdep_print_held_locks() does not.  Did something change recently that
> could let the ->lockdep_depth counter get out of sync with the actual
> number of locks held?

Dmitri had a different theory here:

https://groups.google.com/g/syzkaller-bugs/c/FmYvfZCZzqA/m/nc2CXUgsAgAJ
