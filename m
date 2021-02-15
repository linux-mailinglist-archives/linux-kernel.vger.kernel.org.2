Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1831B9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBOMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhBOMv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:51:27 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31797C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:50:46 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m144so6178595qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxLelD5sy/Kikw1flxrP1PC9JE4RpCQoIxEScGAOhpc=;
        b=jcrHpZygZAjVrFZczEW9tTbln5Ae4GBtJ5SwQi6F35T+prwtBJMLx2TP4zKY5mQTBx
         lLntp4zhoZfXVhUENkJ4ZTzd60rTmwDkul9sl+TLIvjap0Rh+EZ8mPWCIqfkUjj9xxvG
         nJ/BWKhC6tfWTyGMeX4K/TBkivY9Rtxu5vKL2TkcFfLcTJyUVMPDPesBF4k5MkSc7BRx
         ZGmlgGhqdE617n5kp7+QqYiAz9Peqs9yzFKcK/C4W77JGIGQ/P6e/yD8+yrTJVl56v+A
         y8OuAYLwb9sy6bi8iaVysu9qYxU4PrDchKiKaS9F/4kPOqm9hRdYOYWqCn2qsL0aRznU
         fZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxLelD5sy/Kikw1flxrP1PC9JE4RpCQoIxEScGAOhpc=;
        b=s9rbm5KWJpvU7zo/yTpV0+FnIz+zoqHYIL7YpvHF+KJm8DQxSbIodQ7T/FNXj8/WlM
         zRZd/ZqQgthr5rTTPqv8vDTMOGxvtnqugFCYUiDX6s08kRhKu55mX2UA6CEuCRQkXLCf
         NrO78TrFK6nitRLYIkoV3KLD7+ufojnFvp5kyqJgEbjlFBftx0SwVewo/uIjymLTMReS
         gbLay96nCyccsPlPvgFa/t/SYhcnFS4xLoDPRHyE0Y9R/H1kokZOmtTPtdwL7KJHOz5y
         FUr47yOQP5Tf23V+8y6HR2xPz4rBYfwWOMhffb+pjZaV7HZ0tU56mM85CsECLdkD/EtB
         qB2g==
X-Gm-Message-State: AOAM530FkCNFBaJHDfUkSCx6NPrV7PLKrRVQMDQoAnQ3y39YVfAQJrZx
        wL3jlsmcpNw4V7T9woTFG6jti2RHSnGlCwCw6A3dvg==
X-Google-Smtp-Source: ABdhPJzHqw3T9IcDdiphGKjGp0C+BYkuC3MO0JVtCQZyH+NuHRU99wuLPtB4P70cbcGErkgt9XmrGK8P2/AmV95LASE=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr7589958qka.265.1613393445059;
 Mon, 15 Feb 2021 04:50:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a05b3b05baf9a856@google.com> <20210211113718.GM19070@quack2.suse.cz>
 <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
 <YCWlzl1q+eP22KVc@mit.edu> <CACT4Y+YJtk_Lb9AGB4K3pdc-1VpBV0ZzH=1oHVDA003YpAhAog@mail.gmail.com>
 <YCaoaNpF5n3nyja9@mit.edu>
In-Reply-To: <YCaoaNpF5n3nyja9@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Feb 2021 13:50:33 +0100
Message-ID: <CACT4Y+b0tcLeWoA9QGBPvmf=04K3QTnoKMVALdkPgtNNb4J5ow@mail.gmail.com>
Subject: Re: possible deadlock in dquot_commit
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 5:10 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
>  >From: Theodore Ts'o <tytso@mit.edu>
>
> On Fri, Feb 12, 2021 at 12:01:51PM +0100, Dmitry Vyukov wrote:
> > > >
> > > > There is a reproducer for 4.19 available on the dashboard. Maybe it will help.
> > > > I don't why it did not pop up on upstream yet, there lots of potential
> > > > reasons for this.
> > >
> > > The 4.19 version of the syzbot report has a very different stack
> > > trace.  Instead of it being related to an apparent write to the quota
> > > file, it is apparently caused by a call to rmdir:
> > >
> >
> > The 4.19 reproducer may reproducer something else, you know better. I
> > just want to answer points re syzkaller reproducers. FTR the 4.19
> > reproducer/reproducer is here:
> > https://syzkaller.appspot.com/bug?id=b6cacc9fa48fea07154b8797236727de981c1e02
>
> Yes, I know.  That was my point.  I don't think it's useful for
> debugging the upstream dquot_commit syzbot report (for which we don't
> have a reproducer yet).
>
> > > there is never any attempt to run rmdir() on the corrupted file system that is mounted.
> >
> > Recursive rmdir happens as part of test cleanup implicitly, you can
> > see rmdir call in remove_dir function in the C reproducer:
> > https://syzkaller.appspot.com/text?tag=ReproC&x=12caea37900000
>
> That rmdir() removes the mountpoint, which is *not* the fuzzed file
> system which has the quota feature enabled.

remove_dir function is recursive, so rmdir should be called for all
subdirectories starting from the deepest ones. At least that was the
intention. Do you see it's not working this way? That would be
something to fix.

> > > procid never gets incremented, so all of the threads only operate on /dev/loop0
> >
> > This is intentional. procid is supposed to "isolate" parallel test
> > processes (if any). This reproducer does not use parallel test
> > processes, thus procid has constant value.
>
> Um... yes it does:

There is waitpid before remove_dir. So these are sequential test
processes, not parallel.

> int main(void)
> {
>   syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   use_temporary_dir();
>   loop();
>   return 0;
> }
>
> and what is loop?
>
> static void loop(void)
> {
>   int iter = 0;
>   for (;; iter++) {
>         ...
>     reset_loop();
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       if (chdir(cwdbuf))
>         exit(1);
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     ...
>     remove_dir(cwdbuf);
>   }
> }
>
> > > Am I correct in understanding that when syzbot is running, it uses the syzbot repro, and not the C repro?
> >
> > It tries both. If first tries to interpret "syzkaller program" as it
> > was done when the bug was triggered during fuzzing. But then it tries
> > to convert it to a corresponding stand-alone C program and confirms
> > that it still triggers the bug. If it provides a C reproducer, it
> > means that it did trigger the bug using this exact C program on a
> > freshly booted kernel (and the provided kernel oops is the
> > corresponding oops obtained on this exact program).
> > If it fails to reproduce the bug with a C reproducer, then it provides
> > only the "syzkaller program" to not mislead developers.
>
> Well, looking at the C reproducer, it doesn't reproduce on upstream,
> and the stack trace makes no sense to me.  The rmdir() executes at the
> end of the test, as part of the cleanup, and looking at the syzkaller
> console, the stack trace involving rmdir happens *early* while test
> threads are still trying to mount the file system.

My assumption that the 4.19 reproducer for a somewhat similarly
looking bug may also reproduce this upstream bug is false then.
