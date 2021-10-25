Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7325438F94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJYGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhJYGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:40:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101BC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:37:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v77so14210727oie.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPpEb1n5zsr4bfcN2qUMVNqzU/tSK0OigA3PBd9KLm8=;
        b=GJxz+ZoGxmSVqIJqzm/VCqaaXqd3MzI8xjT7vrHCTkE8bDHhkxRoR5m0SgcgdulTAe
         YUYKwKsUI69s19grHN6YX0H/SfdUmew4gFXoACHsnuoBGzyp+lXP87FWQqzmMlFNIBnf
         walR7Jlj03G65Lzm43AMmcjYBSmVU30On+88VcRLq3Gqj4WP2hbE8j4bbZCWMkL5TtO+
         ipbYUqZsq5ncdR1oupQ818eVTdb2uCi/+/hHUejKbgUs27cK/euCJtyuY0GsbVQ9j3eS
         gnqub0Cf/3hIjsSmh0BcnjzTqwEN+PcwZifc8vXUAz0WaE1e5XaOcuB/c9SsxmKAFc/V
         KL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPpEb1n5zsr4bfcN2qUMVNqzU/tSK0OigA3PBd9KLm8=;
        b=Am3iT9VL5eXyRALhLYwnUwbd7ZUh+rqB4lOaf84JD8FHsv8A/12f0DzriXN5Demdl2
         +Xsv2EpbODvbgPPYrXGbLuijKR8xcBK+ouj5bzIiFPKxarJjXTGN0M4vgMq3JEpcc7xg
         FQ/qVYodxw/7P9eb/J+b05AbtB9ycuSrJQ80roWu13jaHd3RFzEv6Tpnf39yxcdM5CPb
         /6YZ27LOsihFJP81Ul0VjAOYD7fAvrdp3ypUEsS7MlvQnsQvaSl+Y9vBoPHCFqDZk1aJ
         TTlgNGr/dufoDYTV8fv0o/0hAP30Q/tSH3/WG8uFEdFV87XfZ79jWJyr8J2bcyEd8Dsg
         fyHQ==
X-Gm-Message-State: AOAM531cOJZrXHYD48aGWt3tCVTfLgnud52Lh0q1aoFX8Zis3D1Xx70E
        vgO8Jss1U9aC+2TlU1NWhgWclQOsYyfKS6tH5ZstFg==
X-Google-Smtp-Source: ABdhPJwnqmxUqlHFwoeDbGrAVb2Iwe5aVKW3sq4NyJn9WG599mNgBsrZtqjVaRHJDMT5R3HqZ4psua8FKKexgB27QpQ=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr20768923oiv.160.1635143876338;
 Sun, 24 Oct 2021 23:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064451505cf0a3aa2@google.com> <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
 <YXW9lmQVx1PLX9aj@casper.infradead.org>
In-Reply-To: <YXW9lmQVx1PLX9aj@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Oct 2021 08:37:45 +0200
Message-ID: <CACT4Y+YZ-JR0iOX8MP9rnoYCwfz=9a+aM4L2LoUtJVko3=CkRQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in memfd_secret
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        jordy@jordyzomer.github.io, jordy@pwning.systems,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 at 22:12, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Oct 24, 2021 at 09:54:22AM -1000, Linus Torvalds wrote:
> > On Sat, Oct 23, 2021 at 9:35 AM syzbot
> > <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=115a0328b00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=75639e6a0331cd61d3e2
> > > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a035c2b00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae869f300000
> > >
> > > The issue was bisected to:
> > >
> > > commit 110860541f443f950c1274f217a1a3e298670a33
> >
> > I think that commit is actually just buggy.
> >
> > "secretmem_users" is not actually a reference count. There's no "magic
> > happens when it goes down to zero".
> >
> > It's purely a count of the number of existing users, and incrementing
> > it from zero is not a probolem at all - it is in fact expected.
> >
> > Sure, zero means "we can hibernate", so zero and overflow are somewhat
> > special, but not special enough to cause these kinds of issues.
> >
> > I have reverted this commit in my tree, because honestly, the whole
> > "try to overflow exactly, and hibernate" threat model just isn't worth
> > this all.
> >
> > If people really care, I can suggest
> >
> >  - use "atomic_long_t" instead. Let's face it, 32-bit isn't
> > interesting any more, and 64-bit doesn't overflow.
> >
> >  - make up some new "atomic_inc_nooverflow()" thing or whatever.
> >
> > but for now this is just reverted.
>
> There was a separate thread on an earlier version of this report.

gcc and clang somehow produce different frames (I guess a tail call).
Need to fix parsing.

#syz dup: WARNING: refcount bug in sys_memfd_secret


> https://lore.kernel.org/linux-mm/YXU7%2FiRjf9v77gon@casper.infradead.org/
> I agree with you and suggested that if anybody really cares (I mean,
> you need a multi-TB machine to produce this problem) that we simply do
> what we did with the page refcount:
>
> +++ b/mm/secretmem.c
> @@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>
>         if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
>                 return -EINVAL;
> +       if (atomic_read(&secretmem_users) < 0)
> +               return -ENFILE;
>
>         fd = get_unused_fd_flags(flags & O_CLOEXEC);
>         if (fd < 0)
>
> Mike didn't particularly like that answer though.
