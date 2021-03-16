Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51233DD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhCPT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbhCPT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:26:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327EC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:26:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m22so64166770lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJ8ESo0xqLlhuMcPL8POiu1QM1DGh9i+Siia5DD90iA=;
        b=PjQAR7jNs9aEbwhkT9krh4CX5Eq0E0nqKvuTh1ox18H2jnLEyvjLF0ogBNQZx70+qE
         w88lKXrGNC0u2RLFwPYEFIJJP7fzVM1wcZzREZLxuIVXkxTvV3Utf4GXsqCDaqxts1Nt
         pQkwtLqPxVJxeYhj4PkZwJA43mxfvW69caxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJ8ESo0xqLlhuMcPL8POiu1QM1DGh9i+Siia5DD90iA=;
        b=VFqwkP13X/Jxsc1zkrZDrDFnP04UfxZhBKIryBc/AtDJ7J0w4AiTvH47a20blUNH5Z
         4Zw7exTZtPmL84tthAWNg6JOZ8GOBToFiqZCZZcd3Y3WNW8JhJ2XJN2vw5x4IHb0tQr/
         V0tpFcoBeP6uyP4c2OZXfATq8ENmg059PCH/u63OZ1VGLSx/uvaaxnmnadnRb0H30nGJ
         /A5+xT1ElK8Pm95YhlAUAfWbwmMjTl4MW9w1kxR/MU8tEyiS1s13i3fBM5XA4xilrMYh
         EwJLuehFC7eRHNlgyuE3aYjByzP9yXthWBUAE/Ysb2paYnbGOG/3/6OAGaeL0ZuvcRE+
         iyZg==
X-Gm-Message-State: AOAM533FTUkKvSTj+h666wsY588GfofQoZIuv353fydT5HDmGL6QUk0g
        6SDp/WlMScepVozBgqVM0vcsjvAzLF/Lag==
X-Google-Smtp-Source: ABdhPJwnRatUB1TnrtkxMVMGxCKCkr576TrvNwvVVd8fJpXhJoilGgklGzZhzn3UxCUnzkEEsdwttA==
X-Received: by 2002:a19:e85:: with SMTP id 127mr184681lfo.77.1615922784050;
        Tue, 16 Mar 2021 12:26:24 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n23sm3149858lfq.121.2021.03.16.12.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:26:23 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a1so221244ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:26:22 -0700 (PDT)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr118915ljj.465.1615922781857;
 Tue, 16 Mar 2021 12:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615372955.git.gladkov.alexey@gmail.com>
 <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
 <202103151426.ED27141@keescook> <CAHk-=wjYOCgM+mKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com>
 <202103161146.E118DE5@keescook>
In-Reply-To: <202103161146.E118DE5@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Mar 2021 12:26:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7k2nCB8Q5kMYsYi1ajb99yZ-EYn_MYFMQ2bw3nWuT5Q@mail.gmail.com>
Message-ID: <CAHk-=wj7k2nCB8Q5kMYsYi1ajb99yZ-EYn_MYFMQ2bw3nWuT5Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] Use atomic_t for ucounts reference counting
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> Right -- I saw that when digging through the thread. I'm honestly
> curious, though, why did the 0-day bot find a boot crash? (I can't
> imagine ucounts wrapped in 0.4 seconds.) So it looked like an
> increment-from-zero case, which seems like it would be a bug?

Agreed. It's almost certainly a bug. Possibly a use-after-free, but
more likely just a "this count had never gotten initialized to
anything but zero, but is used by the init process (and kernel
threads) and will be incremented but never be free'd, so we never
noticed"

> Heh, right -- I'm not arguing that refcount_t MUST be used, I just didn't
> see the code path that made them unsuitable: hitting INT_MAX - 128 seems
> very hard to do. Anyway, I'll go study it more to try to understand what
> I'm missing.

So as you may have seen later in the thread, I don't like the "INT_MAX
- 128" as a limit.

I think the page count thing does the right thing: it has separate
"debug checks" and "limit checks", and the way it's done it never
really needs to worry about doing the (often) expensive cmpxchg loop,
because the limit check is _so_ far off the final case that we don't
care, and the debug checks aren't about races, they are about "uhhuh,
yoiu used this wrong".

So what the page code does is:

 - try_get_page() has a limit check _and_ a debug check:

    (a) the limit check is "you've used up half the refcounts, I'm not
giving you any more".
    (b) the debug check is "you can't get a page that has a zero count
or has underflowed".

   it's not obvious that it has both of those checks, because they are
merged into one single WARN_ON_ONCE(), but that's purely for "we
actually want that warning for the limit check, because that looks
like somebody trying an attack" and it just got combined.

   So technically, the code really should do

        page = compound_head(page);
        /* Debug check for mis-use of the count */
        if (WARN_ON_ONCE(page_ref_zero_or_close_to_overflow(page)))
                return false;
        /*
         * Limit check - we're not incrementing the
         * count (much) past the halfway point
         */
        if (page_ref_count(page) <= 0)
                return false;

        /* The actual atomic reference - the above were done "carelessly" */
        page_ref_inc(page);
        return true;

   because the "oh, we're not allowing you this ref" is not
_technically_ wrong, it's just traditionally wrong, if you see what I
mean.

and notice how none of the above really cares about the
"page_ref_inc()" itself being atomic wrt the checks.  It's ok if we
race, and the page ref goes a bit above the half-way point. You can't
race _so_ much that you actually overflow, because our limit check is
_so_ far away from the overflow area that it's not an issue.

And similarly, the debug check with
page_ref_zero_or_close_to_overflow() is one of those things that are
trying to see underflows or bad use-cases, and trying to do that
atomically with the actual ref update doesn't really help. The
underfulow or mis-use will have happened before we increment the page
count.

So the above is very close to what the ucounts code I think really
wants to do: the "zero_or_close_to_overflow" is an error case: it
means something just underflowed, or you were trying to increment a
ref to something you didn't have a reference to in the first place.

And the "<= 0" check is just the cheap test for "I'm giving you at
most half the counter space, because I don't want to have to even
remotely worry about overflow".

Note that the above very intentionally does allow the "we can go over
the limit" case for another reason: we still have that regular
*unconditional* get_page(), that has a "I absolutely need a temporary
ref to this page, but I know it's not some long-term thing that a user
can force". That's not only our traditional model, but it's something
that some kernel code simply does need, so it's a good feature in
itself. That might be less of an issue for ucounts, but for pages, we
somethines do have "I need to take a ref to this page just for my own
use while I then drop the page lock and do something else".

The "put_page()" case then has its own debug check (in
"put_page_testzero()") which says "hey, you can't put a page that has
no refcount.

Thct could could easily use that "zero_or_close_to_overflow(()" rule
too, but if you actually do underflow for real, you'll see the zero
(again - races aren't really important because even if you have some
attack vector that depends on the race, such attack vectors will also
have to depend on doing the thing over and over and over again until
it successfully hits the race, so you'll see the zero case in
practice, and trying to be "atomic" for debug testing is thus
pointless.

So I do think out page counting this is actually pretty good.

And it's possible that "refcount_t" could use that exact same model,
and actually then offer that option that ucounts wants, of a "try to
get a refcount, but if we have too many refcounts, then never mind, I
can just return an error to user space instead".

Hmm? On x86 (and honestly, these days on arm too with the new
atomics), it's generally quite a bit cheaper to do an atomic
increment/decrement than it is to do a cmpxchg loop. That seems to
become even more true as microarchitectures optimize those atomics -
apparently AMD actually does regular locked ops by doing them
optimistically out-of-order, and verifying that the serialization
requirements hold after-the-fact. So plain simple locked ops that
historically used to be quite expensive are getting less so (because
they've obviously gotten much more important over the years).

                Linus
