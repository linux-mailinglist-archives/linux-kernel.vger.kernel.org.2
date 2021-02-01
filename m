Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9C30AEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhBASKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhBASKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:10:44 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:10:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k193so17168858qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFYcz2wx3YcoNA7SoQ9+Z7cQV1+YG8iv6K+CoY5Z0tA=;
        b=p1a/Zon4q10aFOJ0j1zT9J9N3mmhk1TXF/8mZUhTtc7KPNT1flv6jASOH81zRd7ztV
         Abhdw4yW7eV+jw20qjq8m8fbf4394i61qQpmHgJBE5qYwxfhs/Hq/wQFnptJ6RRbOH/C
         TNw1RFwtvN2ox6+fKFHtuNuK+WuJe2yD3wxFwrTUXrDy85eqsb5OLDtJDEZKoaMoBGNv
         xf0FTrOnSR5Co00puFtdcCzbGkD7sFwVB7CV7B/zVfYHtDLh+zgAcMKvtjSNFdQAtYdZ
         pnz5UUZF93+fum3OOYQFAj5VzXkxcbKjeyRCAyKfliDjvsKkLjuiiIWoKMS6CTkrG7Zc
         OPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFYcz2wx3YcoNA7SoQ9+Z7cQV1+YG8iv6K+CoY5Z0tA=;
        b=IRQ/D+D1SaRcnRpIU/QYYzINwGd/vJQl+XFeVHhsLD/AwRZ/nk5PyOvfRF/wnlPBt6
         7LOkf/QLBgMf6OdqvLMVYTI5EOw5GDxSGA1iPzSAaR+ab968Kb87fNl496CQim9zwHjV
         ZUJ/VRhOHvEwKAeUSf8Jt+2Mv0ug9IIqAudHYCDNLbOKq+frNem4JQ9ncwObt5sg4mXX
         14XzekJz+vA2Tl35wFGIVCldMOdKYBRa2s1rR9avfpOz+Ms+SGRqzUOSPXWsItE+bX//
         jnld78XLTHAOiCnstgPZlXxPzJlY/oriHV5Jx26KrbSZc+9hX3kfUd4n7QFKIidkrXXP
         n4mg==
X-Gm-Message-State: AOAM533CmVEaIOk6ZJQ31uTRHod9FrfhrBwpVNybxb6RQdJEiyR7Mp73
        fptU19mUMo5RqSpeuoZY4cWR9PrhKYDDtfi+kwpkug==
X-Google-Smtp-Source: ABdhPJxxOUy3OV/E12GCdn/Fj4Wwp9IFhZ1vR4HVV3eYmdEgZzOM1ZPvKbDNnKm9qhGhDUClvYtVKjzP3MJr7QNnIkY=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr16821693qko.424.1612203003088;
 Mon, 01 Feb 2021 10:10:03 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YJp0t0HA3+wDsAVxgTK4J+Pvht-J4-ENkOtS=C=Fhtzg@mail.gmail.com>
 <YBfPAvBa8bbSU2nZ@hirez.programming.kicks-ass.net> <YBfkuyIfB1+VRxXP@hirez.programming.kicks-ass.net>
 <5936f4a4-f150-e56e-f07d-1efee06eba16@redhat.com>
In-Reply-To: <5936f4a4-f150-e56e-f07d-1efee06eba16@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Feb 2021 19:09:51 +0100
Message-ID: <CACT4Y+ZEPG0keEM5BzeqxnqOETyjPsa+7_cvGk=VDH+ErhyF-Q@mail.gmail.com>
Subject: Re: corrupted pvqspinlock in htab_map_update_elem
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 6:54 PM Waiman Long <longman@redhat.com> wrote:
>
> On 2/1/21 6:23 AM, Peter Zijlstra wrote:
> > On Mon, Feb 01, 2021 at 10:50:58AM +0100, Peter Zijlstra wrote:
> >
> >>>   queued_spin_unlock arch/x86/include/asm/qspinlock.h:56 [inline]
> >>>   lockdep_unlock+0x10e/0x290 kernel/locking/lockdep.c:124
> >>>   debug_locks_off_graph_unlock kernel/locking/lockdep.c:165 [inline]
> >>>   print_usage_bug kernel/locking/lockdep.c:3710 [inline]
> >> Ha, I think you hit a bug in lockdep.
> > Something like so I suppose.
> >
> > ---
> > Subject: locking/lockdep: Avoid unmatched unlock
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Mon Feb 1 11:55:38 CET 2021
> >
> > Commit f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI"
> > inversions") overlooked that print_usage_bug() releases the graph_lock
> > and called it without the graph lock held.
> >
> > Fixes: f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   kernel/locking/lockdep.c |    3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3773,7 +3773,7 @@ static void
> >   print_usage_bug(struct task_struct *curr, struct held_lock *this,
> >               enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
> >   {
> > -     if (!debug_locks_off_graph_unlock() || debug_locks_silent)
> > +     if (!debug_locks_off() || debug_locks_silent)
> >               return;
> >
> >       pr_warn("\n");
> > @@ -3814,6 +3814,7 @@ valid_state(struct task_struct *curr, st
> >           enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
> >   {
> >       if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
> > +             graph_unlock()
> >               print_usage_bug(curr, this, bad_bit, new_bit);
> >               return 0;
> >       }
>
> I have also suspected doing unlock without a corresponding lock. This
> patch looks good to me.
>
> Acked-by: Waiman Long <longman@redhat.com>

Just so that it's not lost: there is still a bug related to bpf map lock, right?
