Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8B3B54B3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhF0Sz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhF0Sz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 14:55:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:53:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d25so21564559lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+E1ulirZppXJbjGpA3Hm56N/AqCsySDfUBGRIjaj1E=;
        b=hoNv+TJrxoUEJnXqZcUwcImNMsyg4dEPHwS68x6I5/d+BZ1FkEs2uJN/p8wX0qONS5
         5cpfnlo4RPZC4J0HB1U/JWYmka8cb7PT8K71L/dr0j6dAd6aWovQp5ejNLp8nDr4JpYH
         mP7K7l0pPcLfmh4UAwFuKJucCFg88DEl48qDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+E1ulirZppXJbjGpA3Hm56N/AqCsySDfUBGRIjaj1E=;
        b=CZtM7nKEUn4n+l29ykwAjFBvBs9a8PnwvIzCOgIwRZXJfPedzS2RO29NmLN3mXXyq/
         FOjmC3tUxq52q7BMWe7SsIGQ//Rc03/wMiCNXmX9LLgXbmdFPhYtHbA1zb1dPdX44GjT
         7Y1uO89hmpTB6kF6rs09xbsEBuPHQbpUmlT29h/Us9liUVAUUKZpQ4EJnQlxDeXq5oeJ
         3joZsdiSMEU1TWkONp8KeuPRVSpuPb48Dfj8QboSCFAbIKiNKLo2eu3vVewaBfb8erp2
         iXJJRvtcCyItSYEpsX00rS25IsYSJDrKHtwc0ypcoAZMjmHafxghcu5uR8XOEbYkN+DY
         h+pw==
X-Gm-Message-State: AOAM531JmwccToNRsyvVsXSjqFNo5/tNDcd0hXmwij6O4r6KKGD4zVBY
        UAEY+pp4e7+gXAsx02kcIrRgUfWhPAuasbJq
X-Google-Smtp-Source: ABdhPJx0IkFrVhFLIJBu7lOHahiNKkEfciV70qYuC7+vl8aAHcoxr8YtWd3RLbt1CggjVKzHXV3GCw==
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr16652072ljk.243.1624819981090;
        Sun, 27 Jun 2021 11:53:01 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v2sm1104147lfo.194.2021.06.27.11.53.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 11:53:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i13so27575187lfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:53:00 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr15657017lfs.377.1624819979954;
 Sun, 27 Jun 2021 11:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <YNQwgTR3n3mSO9+3@gmail.com> <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
In-Reply-To: <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jun 2021 11:52:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
Message-ID: <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
Subject: Re: [GIT PULL] sigqueue cache fix
To:     Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Christian and Oleg to participants ]

On Thu, Jun 24, 2021 at 9:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think the sigqueue cache is still potentially quite buggy, and I
> think the bug is hidden by the READ/WRITE_ONCE games that are
> misleading and not actually valid.

Guys, I haven't heard any reaction to this. Any comments?

Because the more I look at it, the stranger it looks.

In particular: the code in sigqueue_cache_or_free() is a simple

        if (!READ_ONCE(current->sigqueue_cache))
                WRITE_ONCE(current->sigqueue_cache, q);

and it is documented to be safe because "current" is obviously single-threaded.

Except that documented "obviously" is not so obvious at all. Yes,
"current" is single-threaded, but only in task context. You can still
have interrupts etc that see that same "current" that happen
concurrently.

So it's not at all obviously safe. It *may* be safe, but it worries me.

It worries me _particularly_ with exactly this commit 399f8dd9a866
("signal: Prevent sigqueue caching after task got released").

Why? Because the alleged path is release_task() -> __exit_signal() ->
exit_task_sigqueue_cache(). And by the time "release_task()" runs,
that task it releases shouldn't be running. So how can release_task()
race with this logic in sigqueue_cache_or_free()?

IOW how can that change in commit 399f8dd9a866 _possibly_ fix
anything? That would seem to be a serious problem if it's actually the
case..

So I think

 (a) sigqueue_cache_or_free() is fine only if no signal is ever
released from interrupt/bh context.

 (b) commit 399f8dd9a866 looks dodgy to me - could we really ever do
"release_task(current)" without it being a huge bug?

Anyway, trying to really distill the logic of the sigqueue_cache, I've
come up with

 - sigqueue_cache_or_free() only does something if saw NULL (and will
turn it non-NULL)

 - __sigqueue_alloc() only does something if it saw a non-NULL value
(and will turn it NULL)

so they can't race with each other, because their initial values are disjoint.

So then we have

 (a) sigqueue_cache_or_free() allegedly cannot race with itself
because of "current".

 (b) __sigqueue_alloc() allegedly cannot race with itself because of
sighand->siglock

Now (b) I will actually believe, because __sigqueue_alloc() has only
two callers, and the first one actually has

        assert_spin_locked(&t->sighand->siglock);

and the second one passes SIGQUEUE_PREALLOC as sigqueue_flags, and
that will force it to not touch sigqueue_cache at all.

So I think __sigqueue_alloc() is ok.

Which makes me really suspect that (a) is the problem here.

Looking at what calls __sigqueue_free() -> sigqueue_cache_or_free(), we have:

 - flush_sigqueue

 - flush_itimer_signals() -> __flush_itimer_signals()

 - dequeue_signal() -> __dequeue_signal -> collect_signal()

 - get_signal() -> dequeue_synchronous_signal() (and dequeue_signal())

 - send_signal() -> __send_signal() -> prepare_signal() -> flush_sigqueue_mask()

 - kill_pid_usb_asyncio() -> __send_signal() -> ..

 - do_notify_parent() -> __send_signal() -> ..

 - send_sigqueue() -> prepare_signal() -> flush_sigqueue_mask()

 - kernel_sigaction() -> flush_sigqueue_mask()

 - sigqueue_free()

so there's a lot of things that can get into sigqueue_cache_or_free(),
and it's worth noting that that path does *NOT* serialize on the
sighand->siglock, but expressly purely on "current" being
single-threaded (and 'current' has nothing to do with sighand->siglock
anyway, the sighand lock is for the target of the signal, not the
source of it).

At at least that send_signal() path is very much called from
interrupts (ie timers etc).

Hmm?

Ok, I may have confused myself looking at all this, but it does all
make me think this is dodgy.

                  Linus
