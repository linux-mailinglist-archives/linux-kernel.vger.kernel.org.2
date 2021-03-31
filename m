Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC234FD90
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhCaJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhCaJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:57:35 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DEEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:57:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x14so18709522qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaFf3c0pAD325NQqmF7krvZFMYaMN0y0Ix6o5G4Cv9w=;
        b=NVzW4nr4UJtS0fhefAsBX6Yp1QT6Bwdbgkp+jKXiKEcQXL8x9E0uZhNGFfagQLSUj1
         rfxjySr02xEMTfE0HWtGMN2LyK4dMdkOV/06fcfvVK1r3RLYuS9mwELR2VgMnxfa/OTG
         l8ZH5I/jp1ln+HModag5BRqkZrViqqQCzrnWBrai0ZF30YR1wOJVosyrniTVFmhxBXaj
         pUdO7vpYU+0szK3kzVAcLur0qUnttKrjyPlQ3KHpGegjZqLZk6SMZqsZQEmIfW+C8cND
         2XVDzsO5ag5sCdf2YDYg600NdvKeVVwoNenTj+L+cDV/nkvY0RfT9d9mwupCKL8Za+zJ
         GV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaFf3c0pAD325NQqmF7krvZFMYaMN0y0Ix6o5G4Cv9w=;
        b=XlLAdWek8McGxblJf1FyXAXFXjGGtmP0ZmvJR5t7xCWQN8cv/5VDPuEYqyERJkGHaR
         GPi7WCaRVp6a1HwF9PjPkIa2cJ29fwh0KBzFW4hNLrT1/A4dbAqurPlxzXknSk7cNNIf
         7zSFhfHRZ4xTFzrOfqXY2xsJUVCEgxx7CSjAzQ8Z4upQutkj2Jfipya/ccljembYFq2Y
         oZPb3usV25Z7ZLCf0mAiyxm2WY1GxR09cnc5HrpirVhXxrsnUzdDeCViHAAZc9jToIuz
         ic4lc4/Gx2NdT5MhWTXfVlFBGEMrZcqKsIJ9GwhSbjAv/dG7GASwtIPqVkVnHLdEbXWc
         slUg==
X-Gm-Message-State: AOAM532m0sgxKfX86hj0kpmMCDwj4EIgooKVingdhps9EDdXQG9ZypCS
        qKUy9TO0bkfEHg/Tj5oWPNL53TfBheDW2Q+nVvUy+g==
X-Google-Smtp-Source: ABdhPJysgMIvk8aS4FbQzmtrwCOHF1+OIoRvzKO+ydkxl78f0PXyYG7b0w2m3OoE3nDBYlYqMfVZGjJvqfIbla5KAKo=
X-Received: by 2002:ae9:e513:: with SMTP id w19mr2377518qkf.231.1617184654294;
 Wed, 31 Mar 2021 02:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000086695705bec87c9f@google.com> <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
 <YGQlHvte0BeKx0uV@hirez.programming.kicks-ass.net>
In-Reply-To: <YGQlHvte0BeKx0uV@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Mar 2021 11:57:23 +0200
Message-ID: <CACT4Y+b1NsdnC1hqk54Y8zEs7r3y7+EnAqbG1eBmuhji_bfFqw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in copy_page_range
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 31, 2021 at 08:11:38AM +0200, Dmitry Vyukov wrote:
> > On Wed, Mar 31, 2021 at 12:26 AM syzbot
> > <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com
> >
> > I think this is a LOCKDEP issue. +LOCKDEP maintainers.
> >
> > Another bug happened on another thread ("WARNING: possible circular
> > locking dependency detected"). Lockdep disabled lock tracking
> > ("debug_locks = 0" in the report), which probably made it miss
> > rcu_unlock somewhere, but it did not turn off reporting yet and
> > produced the false positive first.
> >
> > I think if LOCKDEP disables lock tracking, it must also disable
> > reporting of issues that require lock tracking. That would avoid false
> > positives.
>
> Still early and brain hasn't really booted yet, but features that
> require lock tracking are supposed to check debug_locks.
>
> And afaict debug_lockdep_rcu_enabled(), which is called by
> RCU_LOCKDEP_WARN(), which is called by rcu_sleep_check() does just that.

Right... yet it somehow happens.
Looking at a dozen of reports, all with 2 concurrent lockdep splats
and "debug_locks = 0" in the report, I am pretty sure there is some
kind of race in lockdep.
I see there are at least 2 places where lockdep can falsely assume rcu
lock is held:
https://elixir.bootlin.com/linux/v5.12-rc5/source/kernel/locking/lockdep.c#L5543
https://elixir.bootlin.com/linux/v5.12-rc5/source/kernel/rcu/update.c#L105
both to "avoid false positives", but for "Illegal context switch in
RCU-bh read-side critical section" it can actually lead to false
positives, right?

Is there something else that turns off tracking before setting
debug_locks=0? Perhaps we get into that window where tracking is
disabled, but debug_locks is not reset yet?

lockdep_enabled() returns false if lockdep_recursion var is set:
https://elixir.bootlin.com/linux/v5.12-rc5/source/kernel/locking/lockdep.c#L87

but lockdep_lock() sets it _before_ taking the lock:
https://elixir.bootlin.com/linux/v5.12-rc5/source/kernel/locking/lockdep.c#L111

Is it possible that lockdep_recursion is set, then the task is
rescheduled and another task sees wrong value for lockdep_recursion?
Shouldn't lockdep_recursion be set _after_ arch_spin_unlock(&__lock)?
Though, I assume lockdep_lock() is called frequently and not only on
reports, so if my reasoning would be true, it would produce false
positives all the time, not necessary on concurrent reports... this
does not agree with the observed failure mode...
