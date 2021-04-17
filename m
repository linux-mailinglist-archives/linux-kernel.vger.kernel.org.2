Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A241A36310D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhDQQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhDQQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:03:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43743C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:03:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o5so1331769ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LJl9wVLNRxb9RnQqWj2jQ5/RndjtgEudpd/mK1fJLc=;
        b=ebcIEAd1/kxeQC+Ev+j1PqxGwnV2jLHRyPg+i/OYU1V67NcBkIhOgJx/ip5A43EfGM
         Z5/qcTcs7+YTJX4D+BGP62yjU0ahRoMHXMWm9Ss6XGydPccMXWwLAkFGeEXC3SGMYsWh
         aC1T9pGMsm7i/yJKGmm+GcOafPBrA0ObWh3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LJl9wVLNRxb9RnQqWj2jQ5/RndjtgEudpd/mK1fJLc=;
        b=rOrsJPJmpI+FiOTEplmNU30iAhalqIWoG8UuFnQto5+YMWhtP5e+q+Dw1UyydUpPBR
         /zKyOAN8ZwzPRU81+pMQmmnN4432hqkMSLjJh9f/MsvfsYKlB5frMzgbKnTLB2R2HUQk
         wwAmOSnVPtsU/ANdvxu/W1+4flXFlYZUggFs2g7aGQ7y4RDKHjHQBdjfL3C1PG96fG4v
         JE9dLpyktsvvEqXueNOMjiEWeTiz57NrI1ATuA2eDVn88StmpV7n3mA3wuMvjJ6eZb7F
         qF3h4dTgHqcGQ/jhHooQ6fh1mxOLAoBZjV8Ssvh4lxre0YpRT5RJk+FecZ2aMWyA/O+h
         1ksA==
X-Gm-Message-State: AOAM53169VNLrx7Y9Gm9+bueLvqT4ja8RzRrbfOwU69J7wsazqaf1npT
        r5tRKsDQ91i0h7wqSKGxPw68CWX6xh8Mh9x8
X-Google-Smtp-Source: ABdhPJyHaqSqc2bLSWlhnQSi6Ye/88y0431jrpo1QnU9fWB/PkqjSBwkTV4Z2nbxXS3XKg3+GJlyLQ==
X-Received: by 2002:a2e:b4f2:: with SMTP id s18mr5969996ljm.138.1618675399391;
        Sat, 17 Apr 2021 09:03:19 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l6sm1324806lfp.13.2021.04.17.09.03.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 09:03:18 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id n138so49503369lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:03:18 -0700 (PDT)
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr6412741lfr.421.1618675398566;
 Sat, 17 Apr 2021 09:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
In-Reply-To: <20210416192413.1514419-1-eric.dumazet@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 09:03:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
Message-ID: <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:24 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> We have to loop only to copy u64 values.
> After this first loop, we copy at most one u32, one u16 and one byte.

As Al mentioned, at least in trivial cases the compiler understands
that the subsequent loops can only be executed once, because earlier
loops made sure that 'len' is always smaller than 2*size.

But apparently the problem is the slightly more complex cases where
the compiler just messes up and loses sight of that. Oh well.

So the patch looks fine to me.

HOWEVER.

Looking at the put_cmsg() case in net-next, I'm very *VERY* unhappy
about how you use those "unsafe" user access functions.

Why? Because the point of the "unsafe" is to be a big red flag and
make sure you are very VERY careful with it.

And that code isn't.

In particular, what if the "int len" argument is negative? Maybe it
cannot happen, but when it comes to things like those unsafe user
accessors, I really really want to see that all the arguments are
*checked*.

And you don't.

You do

        if (!user_write_access_begin(cm, cmlen))

ahead of time, and that will do basic range checking, but "cmlen" is

        sizeof(struct cmsghdr) + (len))

so it's entirely possible that "cmlen" has a valid value, but "len"
(and thus "cmlen - sizeof(*cm)", which is the length argument to the
unsafe user copy) might be negative and that is never checked.

End result: I want people to be a LOT more careful when they use those
unsafe user space accessors. You need to make it REALLY REALLY obvious
that everything you do is safe. And it's not at all obvious in the
context of put_cmsg() - the safety currently relies on every single
caller getting it right.

So either fix "len" to be some restricted type (ie "unsigned short"),
or make really really sure that "len" is valid (ie never negative, and
the cmlen addition didn't overflow.

Really. The "unsafe" user accesses are named that way very explicitly,
and for a very very good reason: the safety needs to be guaranteed and
obvious within the context of those accesses. Not within some "oh,
nobody will ever call this with a negative argument" garbage bullshit.

                  Linus
