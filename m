Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455D5363205
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 21:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhDQTo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbhDQTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 15:44:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99396C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 12:44:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x8so28876759ybx.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsZFBFFoAaaTWLJGWma6NC1Q9EELC2PXJ77u91vj0fE=;
        b=niNu9plk007R4+Pb6UpFMQ3tXO4HDoSZ6YUPnXBb8BZ0Pt29fqkc821WWcs/WXQqD5
         pG9qq55FcG3weAR+W2dwViSGwPL5TNcBkFZfb7AT5MhHFZvvjzg4IqqSUGKlg4Bvuo7x
         qjTkcJ7WPovQgdaKCG17KvoOGwkG/buQ6TE3LOhGdpkMQEztfJDssixJ+IdjH9rQk62i
         EoK9FEnCObyWxCz22lV0wRJvSs1lcGFCm2ks4s09A7zdZ6NB524TdXnGYPShMrLlLs5U
         hPPu6TnbdBXy09oaWpKkFgKOWE5RpKRzk61M9a4q1Qlmb/kIC+NQsDN8E9AFjtwXN/l+
         G/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsZFBFFoAaaTWLJGWma6NC1Q9EELC2PXJ77u91vj0fE=;
        b=pH/ZmDBtnBgK9L0WvhdYZBl85xSl/U3EyfiLMNvazHmkFXCDw7+Z6ktjYlE/J710SO
         bmWuWK4a6hvGFqI162ahxJpRDhVj6GYsN7+gZdTaOTnFm+zPprh9zrnuQTtvX/ki+/dU
         W74Svd1L3oxWzjrrU/WqXyGRPTrFoeehnC+MOLfEvnTyEJskDFvYIiWmNHtt6y0LtkKS
         6sYSXpe0/0dIPLXCUyS03upmfiD6ixRmhxqO0VmveL+oeJzyqG2zOjvfsI2PH0P9LCKK
         F0vhFRcdVkvCWPmGT0AR8PTuFfzBW4keK5tGzkVFSZQW4sXPEOlpogB6O4Narx3FY9UU
         lJJA==
X-Gm-Message-State: AOAM532GPIKnaczwOVS04SZtJ+iYOkbgNPyk9D6otFrXu1cfLFKQzUYG
        jqvBTvGIh+6cL2SHqlpiGU+owLfLq5Ul0hw3MFZeBN4H2H0unQ==
X-Google-Smtp-Source: ABdhPJzHpCFIuXFZlrRPLj9Kt9ZmIyg2+DtIyzkGwZralxv3XTl7Ve1OiENuOoli65OaQ2/dD8WvPOAoHydID93tAp0=
X-Received: by 2002:a25:4883:: with SMTP id v125mr4617161yba.253.1618688660505;
 Sat, 17 Apr 2021 12:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com> <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
In-Reply-To: <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 17 Apr 2021 21:44:09 +0200
Message-ID: <CANn89iK0Win0m5ggB-EjFvVwmpkyg_nG9FW9uzREmrpoeTF_aw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 6:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 16, 2021 at 12:24 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> >
> > We have to loop only to copy u64 values.
> > After this first loop, we copy at most one u32, one u16 and one byte.
>
> As Al mentioned, at least in trivial cases the compiler understands
> that the subsequent loops can only be executed once, because earlier
> loops made sure that 'len' is always smaller than 2*size.
>
> But apparently the problem is the slightly more complex cases where
> the compiler just messes up and loses sight of that. Oh well.
>
> So the patch looks fine to me.
>
> HOWEVER.
>
> Looking at the put_cmsg() case in net-next, I'm very *VERY* unhappy
> about how you use those "unsafe" user access functions.
>
> Why? Because the point of the "unsafe" is to be a big red flag and
> make sure you are very VERY careful with it.
>
> And that code isn't.
>
> In particular, what if the "int len" argument is negative? Maybe it
> cannot happen, but when it comes to things like those unsafe user
> accessors, I really really want to see that all the arguments are
> *checked*.
>
> And you don't.
>
> You do
>
>         if (!user_write_access_begin(cm, cmlen))
>
> ahead of time, and that will do basic range checking, but "cmlen" is
>
>         sizeof(struct cmsghdr) + (len))
>
> so it's entirely possible that "cmlen" has a valid value, but "len"
> (and thus "cmlen - sizeof(*cm)", which is the length argument to the
> unsafe user copy) might be negative and that is never checked.
>
> End result: I want people to be a LOT more careful when they use those
> unsafe user space accessors. You need to make it REALLY REALLY obvious
> that everything you do is safe. And it's not at all obvious in the
> context of put_cmsg() - the safety currently relies on every single
> caller getting it right.

I thought put_cmsg() callers were from the kernel, with no possibility
for user to abuse this interface trying to push GB of data.

Which would be terrible even if we  ' fix'  possible overflows.

Maybe I was wrong.


>
> So either fix "len" to be some restricted type (ie "unsigned short"),
> or make really really sure that "len" is valid (ie never negative, and
> the cmlen addition didn't overflow.
>
> Really. The "unsafe" user accesses are named that way very explicitly,
> and for a very very good reason: the safety needs to be guaranteed and
> obvious within the context of those accesses. Not within some "oh,
> nobody will ever call this with a negative argument" garbage bullshit.
>
>                   Linus
