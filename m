Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187C376FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEHFFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 01:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhEHFFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 01:05:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 22:04:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g13so8224476qts.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14phvkyaG3Z9zvqOpQWg9ARBVRW3kycoUCHqs9pgPes=;
        b=pyG9+mRgHuL7NklNHc8HF675/1f2nodTpa2OBy/61Hg+NcspINXxyG8jB8d1hc/hFc
         SZHzRnQS73zjW10aqFwTAJobaZrLSlJNyOiZH8VuBy6aM5ltkKNK2/aLgVjMYSA6RaaW
         1ZXCtBErhKnGLfAW84F2u2cK1rj0bgMplq2maTlU+CQNl15i1kqeqKgEshyJd0Ydtvps
         /h/LzvXFozH0gIXtiW4Lbhl5D3aORfBXD8XTLMSl9wo6ZtR5m6Im1V7djqes0Zxa33wn
         80HDu4/KlL2BSVP9nf+5vtdPMKmVBDEDL47zRAWu7mqbZrPMfSjHAfMFlKdtRLzLJSO1
         hAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14phvkyaG3Z9zvqOpQWg9ARBVRW3kycoUCHqs9pgPes=;
        b=cec7tEH/EVHqW4HkK4cmG8Wkn5ba4+lWoQvIxkhP8zCnhRZer13Y6je1vN2eZswTBm
         mC36Q1DCPk8ZYhSnn+4ShI4KAY/AhKCteBCpQFyNdS2JM7MAx0Fn9gB7RyNGjku3QBta
         Q59GpcSHqHMQfkrNgIO98IT4vXqXxLwfx6oimnf2Ka6BCBJCOmbmMtDjNJ+/XLPAwbhz
         /oY4fVNtJFUWnTNWjyTCV09VjWJfual7WXXIWNmkbm9DVlsJGuKqe0TSJhrxNxKJPRQ/
         +uUvwyMsqKqo9g+wVAkEoelmSRbnQfcko3HB/PfMqsEaFTGMvlP10UeYTY4RRI5/a5x0
         Vr3w==
X-Gm-Message-State: AOAM533fJeHsApI881RKodqsPE3pPjLGl7zCRMyYYdfDfOXejoJju+kA
        q467dOBhtw56Hvfiz4B4kGjtDcBfmZD0LNEvP7rcMw==
X-Google-Smtp-Source: ABdhPJzeYX90jxHezeIF03ACIDBTPGylgPFNhiU8m8LZM1Gut+MViVR2oA1sk+9phb4rLJeKfhQQ89hLbb/gBjPpThc=
X-Received: by 2002:ac8:518a:: with SMTP id c10mr12574502qtn.66.1620450242631;
 Fri, 07 May 2021 22:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006540d705c1b013b5@google.com> <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
 <CACT4Y+aaGyfiEgbKca-6gourQjtwVMHuwUcb30QJPOF1LhLcxQ@mail.gmail.com> <20210507171901.GV975577@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210507171901.GV975577@paulmck-ThinkPad-P17-Gen-1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 8 May 2021 07:03:51 +0200
Message-ID: <CACT4Y+Ydu6Dcmx1tXe-1aOw-hAcHgjwncrSmWuEr_8tfq02Dtg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_signal
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 7:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, May 07, 2021 at 10:42:48AM +0200, Dmitry Vyukov wrote:
> > On Fri, May 7, 2021 at 10:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, May 06, 2021 at 02:34:27PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
> > > > userspace arch: i386
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com
> > > >
> > > > =============================
> > > > WARNING: suspicious RCU usage
> > > > 5.12.0-syzkaller #0 Not tainted
> > > > -----------------------------
> > > > kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
> > > >
> > > > other info that might help us debug this:
> > > >
> > > >
> > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > no locks held by syz-executor.4/10430.
> > >
> > > Looks like this is a concurrent fail?, if !debug_locks (as per the above)
> > > then RCU_LOCKDEP_WARN() should not trigger.
> >
> > FTR the log is here:
> > https://syzkaller.appspot.com/text?tag=CrashLog&x=123a56a5d00000
> >
> > It contains 2 intermixed reports:
> >
> > [  289.896033][T10430] =============================
> > [  289.896039][T10430] WARNING: suspicious RCU usage
> > [  289.896046][T10430] 5.12.0-syzkaller #0 Not tainted
> > [  289.898388][T13493] ======================================================
> > [  289.898401][T13493] WARNING: possible circular locking dependency detected
> > [  289.898410][T13493] 5.12.0-syzkaller #0 Not tainted
> > [  289.898424][T13493] ------------------------------------------------------
> > [  289.898432][T13493] syz-executor.0/13493 is trying to acquire lock:
> > [  289.898448][T13493] ffff888019065ca0 (&bdev->bd_mutex){+.+.}-{3:3},
> > at: del_gendisk+0x250/0x9e0
>
> This "suspicious RCU usage" false positive looks to be addressed by this
> commit in -rcu, slated for the v5.14 merge window:
>
> 81a5e05455d4 ("rcu: Reject RCU_LOCKDEP_WARN() false positives")
>
> So I suggest ignoring the "suspicious RCU usage" report in favor of the
> "possible circular locking dependency detected" report.

Oh, I see, it's not merged yet.
In my memory we discussed it so long ago that I assumed it is fixed already.
Let's mark it as fixed then:

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives

Thanks for double checking.
