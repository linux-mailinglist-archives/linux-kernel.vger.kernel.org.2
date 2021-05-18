Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C65387CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350473AbhERPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350468AbhERPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:55:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40749C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:54:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z24so9896570ioi.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOPjeGVfoUdxyxMmaIKR534ol/sgRMD+2CApIb85FWI=;
        b=uZ9ZrgULd90pJ20c60zlutZDxiYgz2KMRpQrFP+tc4KCMQMpd0PtyYsFoi0zZqY7ZL
         rjpnuQdps9gVTl7c9Aqb55/rB3bt8TC+Ce0s1xjFd3IdFQ0awjoCjhCCbYc5j1/BSCzJ
         BESztBItvfU8v+O0wIQo4l4cEm+Nvhx0nBLfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOPjeGVfoUdxyxMmaIKR534ol/sgRMD+2CApIb85FWI=;
        b=G2E6WRF8ywUm5MohetgQSsMYjfqDN7guwwNUsQ2pw4ymHwLpNqVyCOb44Wk4mZ0TqA
         SU7x/losh57f9fuJW6a/eR8J0En9GI6n7wlRwUgtGaGv9ziTA8j42pzHzC9ycABvRizn
         X0ZnLlwKzCl3pvOdfUnTwqnFCkzWZZMfLzzBKQUfBpKbo3GyH0QV1gtGAEBKVqTwwB7+
         kMtaQP4F/0knfw8VTgmj+juzgWEtdDb6zt6nwjR2bcXPBCaeDbEDXUKl8UE5a9afR23b
         swQxfkGMEeSQ8E/h6ilyJfd4L+6E0L+D2hRc1tKpC65Ij+y1FJoCAbRtwNQGpxOSjnSo
         L/pg==
X-Gm-Message-State: AOAM530NflA9P/AZwOJo4N0NKM0kzL88d/Mw0IpS+p6wfQH1iaPw9PbW
        PdkbimB9e2WC0Yw7Ums4itvUAw283dG6mxTGnxa6zQ==
X-Google-Smtp-Source: ABdhPJzURMQ4kvYFWw7AgaAHsJSaRhXQyg1AetYl3k5dAaTEx26ENB19AxNZJIqbobJv00LtqNXnUeimts0DC3FkZbo=
X-Received: by 2002:a6b:7306:: with SMTP id e6mr4814895ioh.75.1621353248649;
 Tue, 18 May 2021 08:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
 <YKHvUkxpytzSewEC@boqun-archlinux> <YKMd99hE78xdUkQk@google.com> <YKMlWIPMLFU0vzF6@boqun-archlinux>
In-Reply-To: <YKMlWIPMLFU0vzF6@boqun-archlinux>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 May 2021 11:53:57 -0400
Message-ID: <CAEXW_YTiL_hsqw9f0fiXWYen8i8R=Uj+eYM8tBaV-K6Hw1CRSQ@mail.gmail.com>
Subject: Re: Silencing false lockdep warning related to seq lock
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > [...]
> > > > After apply Laurent's SPF patchset [1] , we're facing a large number
> > > > of (seemingly false positive) lockdep reports which are related to
> > > > circular dependencies with seq locks.
> > > >
> > > >  lock(A); write_seqcount(B)
> > > >   vs.
> > > > write_seqcount(B); lock(A)
> > > >
> > >
> > > Two questions here:
> > >
> > > *   Could you provide the lockdep splats you saw? I wonder whether
> > >     it's similar to the one mentioned in patch #9[1].
> >
> > Sure I have appended them to this email. Here is the tree with Laurent's
> > patches applied, in case you want to take a look:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4
> >
> > Yes, the splat is similar to the one mentioned in that patch #9, however the
> > first splat I appended below shows an issue with lockdep false positive -
> > there is clearly problem with lockdep where it thinks following sequence is
> > bad, when in fact it is not:
> >
> >     init process (skipped some functions):
> >     exec->
> >      flush_old_exec->
> >       exit_mmap ->
> >         free_pgtables->
> >           vm_write_begin(vma) // Y: acquires seq lock in write mode
> >              unlink_anon_vmas // Z: acquires anon_vma->rwsem
> >
> >     exec->
> >     load_elf_binary->
> >       -> setup_arg_pages
> >         -> expand_downwards (in the if (grow <=) block)
> >            mm->page_table_lock // X
> >            vm_write_begin(vma) // Y: acquires seq lock
> >
> >     exec->
> >      do_execve_file->
> >        ->get_user_pages
> >          -> handle_pte_fault
> >           -> anon_vma_prepare
> >               -> acquire anon_vma->rwsem  // Z
> >               -> acquire mm->page_table_lock // X
> >
> >     If vm_write_begin ever had to wait, then it could lockup like this if following happened concurrently:
> >     Acquire->TryToAcquire
> >     Y->Z
> >     X->Y
> >     Z->X
> >
> >     But Y can never result in a wait since it is a sequence lock. So this is
> >     a lockdep false positive.
> >
> > >
> > > *   What keeps write_seqcount(vm_seqcount) serialized? If it's only
> > >     one lock that serializes the writers, we probably can make it
> > >     as the nest_lock argument for seqcount_acquire(), and that will
> > >     help prevent the false positives.
> >
> > I think the write seqcount is serialized by the mmap_sem in all the code
> > paths I audited in Laurent's patchset.
> >
> > I am not sure how making it nest_lock argument will help though? The issue is
> > that lockdep's understanding of seqcount needs to relate seqcount readers to
>
> The thing lockdep will not report deadlock for the following sequences:
>
>         T1:
>         lock(A);
>         lock_nest(B, A);
>         lock(C);
>
>         T2:
>         lock(A);
>         lock(C);
>         lock_nest(B, A);
>
> because with the nest_lock, lockdep would know A serializes B, so the
> following case cannot happen:
>
>         CPU 0                   CPU 1
>         ============            ============
>         lock_nest(B,A);
>                                 lock(C);
>         lock(C);
>                                 lock_nest(B, A);
>
> becaue either CPU 0 or CPU 1 will already hold A, so they are
> serialized. So nest_lock can solve part of the problem if all the
> writers of vm_seqcount are serialized somehow.
>
> Yes, seqcount writers cannot block each other, however, they are
> supposed to be seralized with each other, right? So if we have the
> reason to believe the above two CPUs case can happen, though it's not
> a deadlock, but it's a data race, right?
>
> I think the proper fix here is to annotate vm_seqcount with the correct
> locks serializing the writers.
>

I agree with you now and that's the best way forward. I will work on
something like this (unless you already did), thanks Boqun!

-Joel
