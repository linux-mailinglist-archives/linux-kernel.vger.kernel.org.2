Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D24319D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBLLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhBLLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:02:44 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB54C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:02:04 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t63so8257888qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLlDZLo6J0qVw7DIWlolEd00K/8Vmkz9/g4Vjh3lwzY=;
        b=RaghVpWAE6XgDa+HDXMzh89M6RnNWqFmstpzz3f7zAGD1CDN/Yy4xkPQ12o7vO4D8S
         R5RXn/PCEzoisuymlyZfLHHa4fe1lqUdyqQO8n0HYmIv72zwL5ONagkYGMfgLG57oJQQ
         9rom9fOOnfZGMkNsYbEwo+6K/NxSUNgbR1HDyr8+AOiIOu17aWdJNcG/hCY+61u0ssFd
         EVsMsF/Qe44OqGSjGE9TyEAC5mCS0NIyDlDH85VEtrsIrX7Di3ep+jDRI7SfjA1TD0+p
         envoqSZMLJAlTHbqHi5dVimxVGWU/GNHJNpyaMdLA0qdlyb8t8V4AoFIRAf7+vWM/VlC
         e8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLlDZLo6J0qVw7DIWlolEd00K/8Vmkz9/g4Vjh3lwzY=;
        b=sHLQYvlB4llNC1zMky+kszzCgqW4zrkh1MPb1/OvSSwz6ycTblv84qjJ7fo/paMrNw
         +xP4X038wr1s/9XMG+dKLgppY+aVskgTJ2998xCGJJFsEL7UxsIQbleqwPyTOeEF926s
         Qk1RF+ZAUtftOse/3E0WXBs4j0vmbjYxj46eVSoIGit+ztjqsnRcB2GC7yQs3ySmzPMC
         Xpt6eHvDe68eFr9tPod6pgu2WvzqwlUkAmbHT4KyNvkX6lWL/lwHdmAbs+l5+pq4H5yD
         awuA546QxW8AssOfupHevHKOctL2s9qZLoFdr8DEFdhqB/4JLbhdYfZXm1RnanT0mFUi
         5mzg==
X-Gm-Message-State: AOAM531Ka7qwlYe4va0qW+wy3iEzHMdyYDFN/G37DqCrwZbeOfnRMTgi
        0bVs9bGKqIQB6B5+AzRos+vT9t7T3PMYS93Zze0bPJbo7UzZLw==
X-Google-Smtp-Source: ABdhPJxyrEwIbEcpuZ923S4FGmILlzhZM0w/VyOJBgDAeA8VIKwTKXaVj6sxfoC0Kvh2P29tiNUpLkNjn64kZzMiUeQ=
X-Received: by 2002:a37:ef07:: with SMTP id j7mr2000170qkk.265.1613127723188;
 Fri, 12 Feb 2021 03:02:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a05b3b05baf9a856@google.com> <20210211113718.GM19070@quack2.suse.cz>
 <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com> <YCWlzl1q+eP22KVc@mit.edu>
In-Reply-To: <YCWlzl1q+eP22KVc@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Feb 2021 12:01:51 +0100
Message-ID: <CACT4Y+YJtk_Lb9AGB4K3pdc-1VpBV0ZzH=1oHVDA003YpAhAog@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 10:46 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Feb 11, 2021 at 12:47:18PM +0100, Dmitry Vyukov wrote:
> > > This actually looks problematic: We acquired &ei->i_data_sem/2 (i.e.,
> > > I_DATA_SEM_QUOTA subclass) in ext4_map_blocks() called from
> > > ext4_block_write_begin(). This suggests that the write has been happening
> > > directly to the quota file (or that lockdep annotation of the inode went
> > > wrong somewhere). Now we normally protect quota files with IMMUTABLE flag
> > > so writing it should not be possible. We also don't allow clearing this
> > > flag on used quota file. Finally I'd checked lockdep annotation and
> > > everything looks correct. So at this point the best theory I have is that a
> > > filesystem has been suitably corrupted and quota file supposed to be
> > > inaccessible from userspace got exposed but I'd expect other problems to
> > > hit first in that case. Anyway without a reproducer I have no more ideas...
> >
> > There is a reproducer for 4.19 available on the dashboard. Maybe it will help.
> > I don't why it did not pop up on upstream yet, there lots of potential
> > reasons for this.
>
> The 4.19 version of the syzbot report has a very different stack
> trace.  Instead of it being related to an apparent write to the quota
> file, it is apparently caused by a call to rmdir:
>
>  dump_stack+0x22c/0x33e lib/dump_stack.c:118
>  print_circular_bug.constprop.0.cold+0x2d7/0x41e kernel/locking/lockdep.c:1221
>    ...
>  __mutex_lock+0xd7/0x13f0 kernel/locking/mutex.c:1072
>  dquot_commit+0x4d/0x400 fs/quota/dquot.c:469
>  ext4_write_dquot+0x1f2/0x2a0 fs/ext4/super.c:5644
>    ...
>  ext4_evict_inode+0x933/0x1830 fs/ext4/inode.c:298
>  evict+0x2ed/0x780 fs/inode.c:559
>  iput_final fs/inode.c:1555 [inline]
>    ...
>  vfs_rmdir fs/namei.c:3865 [inline]
>  do_rmdir+0x3af/0x420 fs/namei.c:3943
>  __do_sys_unlinkat fs/namei.c:4105 [inline]
>  __se_sys_unlinkat fs/namei.c:4099 [inline]
>  __x64_sys_unlinkat+0xdf/0x120 fs/namei.c:4099
>  do_syscall_64+0xf9/0x670 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Which leads me to another apparent contradiction.  Looking at the C
> reproducer source code, and running the C reproducer under "strace
> -ff", there is never any attempt to run rmdir() on the corrupted file
> system that is mounted.  Neither as observed by my running the C
> reproducer, or by looking at the C reproducer source code.
>
> Looking at the code, I did see a number of things which seemed to be
> bugs; procid never gets incremented, so all of the threads only
> operate on /dev/loop0, and each call to the execute() function tries
> to setup two file systems on /dev/loop0.  So the each thread to run
> creates a temp file, binds it to /dev/loop0, and then creates another
> temp file, tries to bind it to /dev/loop0 (which will fail), tries to
> mount /dev/loop0 (again) on the samee mount point (which will
> succeed).
>
> I'm not sure if this is just some insanity that was consed up by the
> fuzzer... or I'm wondering if this was an unfaithful translation of
> the syzbot repro to C.  Am I correct in understanding that when syzbot
> is running, it uses the syzbot repro, and not the C repro?

Hi Ted,

The 4.19 reproducer may reproducer something else, you know better. I
just want to answer points re syzkaller reproducers. FTR the 4.19
reproducer/reproducer is here:
https://syzkaller.appspot.com/bug?id=b6cacc9fa48fea07154b8797236727de981c1e02

> there is never any attempt to run rmdir() on the corrupted file system that is mounted.

Recursive rmdir happens as part of test cleanup implicitly, you can
see rmdir call in remove_dir function in the C reproducer:
https://syzkaller.appspot.com/text?tag=ReproC&x=12caea37900000

> procid never gets incremented, so all of the threads only operate on /dev/loop0

This is intentional. procid is supposed to "isolate" parallel test
processes (if any). This reproducer does not use parallel test
processes, thus procid has constant value.

> Am I correct in understanding that when syzbot is running, it uses the syzbot repro, and not the C repro?

It tries both. If first tries to interpret "syzkaller program" as it
was done when the bug was triggered during fuzzing. But then it tries
to convert it to a corresponding stand-alone C program and confirms
that it still triggers the bug. If it provides a C reproducer, it
means that it did trigger the bug using this exact C program on a
freshly booted kernel (and the provided kernel oops is the
corresponding oops obtained on this exact program).
If it fails to reproduce the bug with a C reproducer, then it provides
only the "syzkaller program" to not mislead developers.
