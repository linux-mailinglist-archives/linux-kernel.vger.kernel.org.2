Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A135E617
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbhDMSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbhDMSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:12:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA232C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:12:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t11so4874032qtr.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9vFrP90BtHdVUAnBqEihgqSC2EUUvSWUWH+wphvxjE=;
        b=eKzDBe5vneRFdAO4WozQqRZFFGKT+xx5Sx3UuolrsNRH5iamCFt3Fut698Iw3l9ehx
         plFOVnXWoyQ7AxKytvss3WdyWyn4p2thSai2LnopQVcqQL3r+klvUVoZCaC/Cw2iigSS
         pfEl/6U0+vWLUhYHGCbqRk8cDxXI6MpgjMTfopmiO+1vkUBWcjfnx73WkuPsLKkbnoES
         6mkdKdjKLTBLiy4BDbUPMEEu7cbELbPNb5R8mjZCJMJ4bkj/YHbZnil9A6qIZSSurKRI
         +M+xHJWbBuM5DS5++jdczfKsFTGyT8i43lzTLI/bYxKy0KIAqXN9T1Stf71YuvVfQWNd
         OFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9vFrP90BtHdVUAnBqEihgqSC2EUUvSWUWH+wphvxjE=;
        b=X2saBOK1ah2CDhRZAsOHnMRJWCy0J45kWlEGNV/pAlmdol+Nh4yIyUqB0/b1TR/0c0
         APPHIOP6nlHR6kajrsUpIv6M6AzyJFv6mPw91Tzcy5oyGYrjFrqeIp4rYnChM8ywAkdn
         PLBnxkgIevQmqKT3WWtWyGSNX3o2/B+5h8Fmv+jHvihKcjV9jtpPLoyWe3qfw44vLg+M
         7XNXQih7CsoOUaDU+liZZweqsCHDnY9ArsPvmCATAtJi7iYvWTMrZAevyGugzNbC2XSG
         C4Jjer6PxmRYzfFfCbVXSqkfmJ9id5nZkMhEYHI99o0zCLsFiw/Y7DJprDJ7GxBi56P1
         8H3Q==
X-Gm-Message-State: AOAM5310u4z7aiqlTrfCByvqmOH62G/sb1NJhBfPYMuIacPUAIr/XVzU
        O33QAAG7p51Px8+40/Sh95m5txS8nNWTQeQC7Qq4bg==
X-Google-Smtp-Source: ABdhPJwZ5wHRe5YxKTRhCgZ8ffY38dTe9Zm33Yt4BxnuurFMW+m/Hm6k26wH0+fcXPqys7ctWW/8UOUhDKiV5kfL3OY=
X-Received: by 2002:ac8:768c:: with SMTP id g12mr16223273qtr.67.1618337556792;
 Tue, 13 Apr 2021 11:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000086695705bec87c9f@google.com> <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
 <YGQlHvte0BeKx0uV@hirez.programming.kicks-ass.net> <CACT4Y+b1NsdnC1hqk54Y8zEs7r3y7+EnAqbG1eBmuhji_bfFqw@mail.gmail.com>
 <YGwQlnpKBbUrGaZm@hirez.programming.kicks-ass.net>
In-Reply-To: <YGwQlnpKBbUrGaZm@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 20:12:25 +0200
Message-ID: <CACT4Y+YU5OQFtXeZ-R20OpAz8Y_zFjKh75s7YBHuroEyNZidHQ@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 31, 2021 at 11:57:23AM +0200, Dmitry Vyukov wrote:
> > On Wed, Mar 31, 2021 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 08:11:38AM +0200, Dmitry Vyukov wrote:
> > > > On Wed, Mar 31, 2021 at 12:26 AM syzbot
> > > > <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com
> > > >
> > > > I think this is a LOCKDEP issue. +LOCKDEP maintainers.
> > > >
> > > > Another bug happened on another thread ("WARNING: possible circular
> > > > locking dependency detected"). Lockdep disabled lock tracking
> > > > ("debug_locks = 0" in the report), which probably made it miss
> > > > rcu_unlock somewhere, but it did not turn off reporting yet and
> > > > produced the false positive first.
> > > >
> > > > I think if LOCKDEP disables lock tracking, it must also disable
> > > > reporting of issues that require lock tracking. That would avoid false
> > > > positives.
> > >
> > > Still early and brain hasn't really booted yet, but features that
> > > require lock tracking are supposed to check debug_locks.
> > >
> > > And afaict debug_lockdep_rcu_enabled(), which is called by
> > > RCU_LOCKDEP_WARN(), which is called by rcu_sleep_check() does just that.
> >
> > Right... yet it somehow happens.
> > Looking at a dozen of reports, all with 2 concurrent lockdep splats
> > and "debug_locks = 0" in the report, I am pretty sure there is some
> > kind of race in lockdep.
>
> Aah, concurrent splats. Yes, that was per design. The theory was that
> concurrent splats are rare and this is much simpler code.

#syz dup: WARNING: suspicious RCU usage in getname_flags
