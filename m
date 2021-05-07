Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2725376249
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhEGIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhEGIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:44:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 01:43:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so7675030qkj.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb9P6QJRf3R/kuxzibC+gE7Dz3EXR5+UUtiBkO36FWM=;
        b=YyISCRmDSw2peIdvLIhzJ4UNct+wL6XFwPl439r1JVNUbaeFcD8KMRo95VChXKwmR1
         JOh/79V9gF5+SYbKm6XIuEUS/yOjCEKZ47RWhkyT1cIitihw/7teMnSamHdduR4rcAHJ
         4F0hTMvptHNZsyX34CW++LJjxM8Z3O6+j/EXgKoAEd/1K7Q5YAZd2EYIFxC0CXvyqeF8
         9wRaeZenzYKf8Q/oe2SmQFXo3j92gnc84aif3X09tpL1oN9mrAX6JQClMHNWLxFYcdBU
         BlMGXCWoqtLFpp/KKyQSX5Oiwan0Nr4c9bOIc231kA3SooF4fL4mFMvAwofKCJQBSWuv
         4iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb9P6QJRf3R/kuxzibC+gE7Dz3EXR5+UUtiBkO36FWM=;
        b=IxVKSA4cApi+xvW7rLfX7si2M3bf6Mt1zpCeydI/o2hhgYOGC6scFM9m7m6mhFrW9n
         ge5uSRRp7VcsPIoL8KXlANef+PkyCg+PRH1aBsFSuFFvGCfUi0136VVQYlzTuvvln7eF
         tsNRgiOgRupYZwO/odtRoXOAfNQibbwCYezlCEhX1ZrVeNIlyNqGxKun3qA+1griMByX
         i8mqqtakHWI5lDQmG76odPm9whL5CCivnOEd2nXO0Z7i+7M3kbr8rk07kZdeUk7Y0dhZ
         0hJkjfU8qP7uNLuFhOWK9ScljZ3FWkp5oOxKCwXDSe5iXRuv2zPXumwUZsqagV4P+09P
         iOtA==
X-Gm-Message-State: AOAM532+1cKEzOk7PkXZ71lRJmg6bB+MGPMVMOo0P79GT5p4cc55SA+v
        uESDGmNdNXIsd6ejlX+L/nuX/PRJklforWVLmNZ6Vg==
X-Google-Smtp-Source: ABdhPJy1GJxgmzCA6+I/Jg95NLd2DLUJ+F0nzi2U4b3T4yCti3u+hwhV7yOkv5AHHSvTySk/bIHGu8ryV/+4X4gE6Qs=
X-Received: by 2002:ae9:e850:: with SMTP id a77mr3740690qkg.424.1620376979918;
 Fri, 07 May 2021 01:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006540d705c1b013b5@google.com> <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
In-Reply-To: <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 7 May 2021 10:42:48 +0200
Message-ID: <CACT4Y+aaGyfiEgbKca-6gourQjtwVMHuwUcb30QJPOF1LhLcxQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_signal
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 10:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 06, 2021 at 02:34:27PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com
> >
> > =============================
> > WARNING: suspicious RCU usage
> > 5.12.0-syzkaller #0 Not tainted
> > -----------------------------
> > kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
> >
> > other info that might help us debug this:
> >
> >
> > rcu_scheduler_active = 2, debug_locks = 0
> > no locks held by syz-executor.4/10430.
>
> Looks like this is a concurrent fail?, if !debug_locks (as per the above)
> then RCU_LOCKDEP_WARN() should not trigger.

FTR the log is here:
https://syzkaller.appspot.com/text?tag=CrashLog&x=123a56a5d00000

It contains 2 intermixed reports:

[  289.896033][T10430] =============================
[  289.896039][T10430] WARNING: suspicious RCU usage
[  289.896046][T10430] 5.12.0-syzkaller #0 Not tainted
[  289.898388][T13493] ======================================================
[  289.898401][T13493] WARNING: possible circular locking dependency detected
[  289.898410][T13493] 5.12.0-syzkaller #0 Not tainted
[  289.898424][T13493] ------------------------------------------------------
[  289.898432][T13493] syz-executor.0/13493 is trying to acquire lock:
[  289.898448][T13493] ffff888019065ca0 (&bdev->bd_mutex){+.+.}-{3:3},
at: del_gendisk+0x250/0x9e0
