Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3008643A99C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhJZBNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhJZBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:13:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E328C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:11:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u21so17476204lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtWXwfuaH6YO89IeWMAaSmOX7k04XWxVVJQflOLKKPU=;
        b=DjFGmggF2BzXZ3m0L7IJhIQ6i1iK4kxkRXO1HpAV7yknmCHxWUZBIB7IOldZXa1w5Q
         1GHozxd5zQsANLVpe5xqWWzm4PK35l3/hXuDbzTDZHtJQLkYzgBAsNRhBt4Ts920bt8T
         vkDTc5JaWSDAKi3dB/TDj6IDLUWMB0bE7alKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtWXwfuaH6YO89IeWMAaSmOX7k04XWxVVJQflOLKKPU=;
        b=30BdCf/pAqlGKi5MP5H/dE+7XfISuovnCblCfMl3x/0ahLBJ2NrCp0cZxzhfrqhf7v
         ISggWhQ+KggKUEe7K7Hh+0iiUVRWhDEJpd2ZLxld50S7WIO055SI7ZaEjfVj2wCJ3z1F
         cHfVK3T5ouKvBV5j2NRk4h3qZsJpQJVn3ZcHrLW8ProQGtu2SbU22vLMUyCYc+KNeJU0
         zRnH4lZIvA2hNI8OfnfSOymvETiw1M6Ssqou8C6zPVUZNaXKtNNtmxD/mQPnh9ctL7lk
         jvzCNS3+EvPTZBgpSEGx9R6FIfzlIibBdQej1SFPMrGnXX/QqeCFgvkpfO8OV/FjFHrc
         rMPg==
X-Gm-Message-State: AOAM532FsMKC1jPOltf7mzlyGFv4cNbKV5MyOpcAoj5JEBe4DJ8IFu7R
        +aA/mrs1KNS210yn8/CBdbPytgFVn7CJBg==
X-Google-Smtp-Source: ABdhPJxv8cOydOIvq79KHi/KQyRictls7pWQZnwRTVngzNlfNXRxRg0Iy8+M/L27DFcAHgJqbfXwRA==
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr20788652lfb.26.1635210675609;
        Mon, 25 Oct 2021 18:11:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a12sm436855lff.236.2021.10.25.18.11.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 18:11:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w23so11716573lje.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:11:14 -0700 (PDT)
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr22545470ljf.95.1635210674455;
 Mon, 25 Oct 2021 18:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211025181634.3889666-1-willy@infradead.org> <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org> <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
 <202110251438.1762406A5@keescook> <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
 <202110251706.BBEE1428@keescook>
In-Reply-To: <202110251706.BBEE1428@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 18:10:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVhUMXR80UmT-6vYNs-BmraOqXOVdH5XVmxbhrtjAbtg@mail.gmail.com>
Message-ID: <CAHk-=wgVhUMXR80UmT-6vYNs-BmraOqXOVdH5XVmxbhrtjAbtg@mail.gmail.com>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 5:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> Right, sure, but it's not a rare pattern.

Well, for an actual reference count it certainly isn't a rare pattern,
and zero _is_ special, because at zero, you are now in use-after-free
territory.

But that's kind of the issue here: that really isn't what
'secretmem_users' was ever about.

Zero isn't some "now we're use-after-free" situation. Quite the
reverse. Zero ends up being the safe thing.

So with that kind of "just count number of existing users", where zero
isn't special, then refcount_t doesn't make sense.

And refcount_t is for non-core stuff that has a lot of random kernel
users that you can't easily verify.

In contrast, 'secretmem_users' had exactly two sites that modified it,
and one that tested it.

> But these places need to check for insane
> conditions too ("we got a -1 back -- this means there's a bug but what
> do we do?"). Same for atomic_inc(): "oh, we're at our limit, do
> something", but what above discovering ourselves above the limit?

So honestly, "above the limit" is often perfectly fine too.

It can be fine for two very different reasons:

 (a) racy checks are often much simpler and faster, and perfectly safe
when the limit is "far away from overflow".

 (b) limits can change

And (a) isn't just about "avoid special atomics". It's about doing the
limit check optimistically outside locking etc.

And (b) wasn't an issue here (where the only real use was ltierally
"are there any users at all"), but in most _proper_ use cases you will
want to have some resource limit that might be set by MIS. And might
be changed dynamically.

So it's entirely possible that somebody sets the limit to something
smaller than the current user (prep for shutdown, whatever), without
it being an error at all.

The limit is for future work, not for past work. Easily happens with
things like rlimits etc.

> There's nothing about using the atomic_t primitives that enforces these
> kinds of checks. (And there likely shouldn't be for atomic_t -- it's a
> plain type.) But we likely need something that fills in this API gap
> between atomic_t and refcount_t.

I dispute the "need". This isn't as common as you claim. Most resource
counting _is_ for "free when no longer used".

And on the other end, you have the users that don't want refcount_t
because they can't live with the limitations of that interface, like
the page counts etc, that do it properly.

So I think in 99% of all situations, the proper fix is to embed an
"atomic_t" in the type it protects, and then have the helper functions
that actually do it properly. Like we do for "get_page()" and friends.
The "new type" isn't about the reference counting, it's about the data
itself, and the atomic_t is just a part of it.

Could we do something new type that warns on the "decrement past zero"
and "overflow on increment"? Sure. But since they by _definition_
aren't about data lifetimes, they probably don't need saturation - you
want the _warning_, but they aren't protecting data, since they aren't
refcounts.

Or could we have something even fancier, that is an actual defined
range, and "overflow" is not "overflow in 32 bits", but "becomes
bigger than X")? That gets more complex because now you'd have to
encode the range in the type somehow.

You could do it with actual static types (generate typedef names and
code), or you could do it with types that have a more dynamic pointer
to ranges (kind of like the sysfs interfaces do) or have the ranges
embedded in the data structure itself.

But honestly, the complexity downside seems to just dwarf the upside.

                  Linus
