Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8563349BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhCJVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhCJVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:14:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9217C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:14:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m22so35941313lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWjSyj9+MgpkAuhvTxP4EPO0ZRIe4bF8NB224VR5k5Y=;
        b=PIqDJ2U0GSCx4NtqwWKrFE9QHN7qXy5qh2Js/ocQazC6t5gl+kXnW0bxIJE/LFuD2k
         T6xs2xk/6PHqSWp9K4hjRH0M1ASKEW1Ap/K9lX9Q8UAOfl66sg1BvnzXj2ilccmkluus
         iX3LkCYCwJNr7hiSwfQg9Kx4Hg3FIHAwDl0VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWjSyj9+MgpkAuhvTxP4EPO0ZRIe4bF8NB224VR5k5Y=;
        b=C1QWMmVZvigJkc9gOiQvef6dAW0aenIaG8F76sK95dMPkjcwZScCGJwMKuw9A7DRQl
         I5O25CTtA7TXbR36QociAIAJvvIrYL3aNlwCvbeJH1YahxuYGLk72+vdfxswyxqIXk9V
         M0dZC7m3AsDq3mXnPIqivQX/MJIMqYN3tA24CB8X/mTv/uifiKEsia3k4I44APKMb9Sq
         8MINWcir5eKBMonvilYQJC0t0l2gi9mi6ERyA+A+RX0WQgNegG4LeDy6wE86KsIyq2Qf
         mXN3d8uwCyYi7/DHj5b/u8V69126r+fZAtxX1RQ2ztYlTbTwJw7aj69Y1NTWgnETmdYz
         o4rA==
X-Gm-Message-State: AOAM532F3JaaBaTJwjBfGFnWPpDWb2rPqzYgu+crwCNPBUm6TqGdXEVU
        LOofugU5bOkoOPVTpqck7zSdpU+GHPa1sQ==
X-Google-Smtp-Source: ABdhPJx8tQ4aSXEBOfbtkAkKOIPcf6cqNVlWiV0yAwUqkHb3Alz+RhBYxrzRvsHSxAfy8uglJjXipQ==
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr222993lfg.355.1615410882705;
        Wed, 10 Mar 2021 13:14:42 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l30sm138278lfp.221.2021.03.10.13.14.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 13:14:41 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id h4so27535276ljl.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:14:41 -0800 (PST)
X-Received: by 2002:a2e:5c84:: with SMTP id q126mr2800569ljb.61.1615410880841;
 Wed, 10 Mar 2021 13:14:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615372955.git.gladkov.alexey@gmail.com> <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
In-Reply-To: <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Mar 2021 13:14:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whg4aVxA7LFAUFCzOn78_7TL1CPo+esPKgN5JTHy8H-Rg@mail.gmail.com>
Message-ID: <CAHk-=whg4aVxA7LFAUFCzOn78_7TL1CPo+esPKgN5JTHy8H-Rg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] Use atomic_t for ucounts reference counting
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 4:01 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
>
> +/* 127: arbitrary random number, small enough to assemble well */
> +#define refcount_zero_or_close_to_overflow(ucounts) \
> +       ((unsigned int) atomic_read(&ucounts->count) + 127u <= 127u)
> +
> +struct ucounts *get_ucounts(struct ucounts *ucounts)
> +{
> +       if (ucounts) {
> +               if (refcount_zero_or_close_to_overflow(ucounts)) {
> +                       WARN_ONCE(1, "ucounts: counter has reached its maximum value");
> +                       return NULL;
> +               }
> +               atomic_inc(&ucounts->count);
> +       }
> +       return ucounts;

Side note: you probably should just make the limit be the "oh, the
count overflows into the sign bit".

The reason the page cache did that tighter thing is that it actually
has _two_ limits:

 - the "try_get_page()" thing uses the sign bit as a "uhhuh, I've now
used up half of the available reference counting bits, and I will
refuse to use any more".

   This is basically your "get_ucounts()" function. It's a "I want a
refcount, but I'm willing to deal with failures".

 - the page cache has a _different_ set of "I need to unconditionally
get a refcount, and I can *not* deal with failures".

   This is basically the traditional "get_page()", which is only used
in fairly controlled places, and should never be something that can
overflow.

    And *that* special code then uses that
"zero_or_close_to_overflow()" case as a "doing a get_page() in this
situation is very very wrong". This is purely a debugging feature used
for a VM_BUG_ON() (that has never triggered, as far as I know).

For your ucounts situation, you don't have that second case at all, so
you have no reason to ever allow the count to even get remotely close
to overflowing.

A reference count being within 128 counts of overflow (when we're
talking a 32-bit count) is basically never a good idea. It means that
you are way too close to the limit, and there's a risk that lots of
concurrent people all first see an ok value, and then *all* decide to
do the increment, and then you're toast.

In contrast, if you use the sign bit as a "ok, let's stop
incrementing", the fact that your "overflow" test and the increment
aren't atomic really isn't a big deal.

(And yes, you could use a cmpxchg to *make* the overflow test atomic,
but it's often much much more expensive, so..)

                    Linus
