Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B193B68C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhF1TFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhF1TFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:05:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:03:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so26650863lfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uR/ZxXYOfetOCIPFRvKNULFj2/1YAj7wkBUuAw2Y1ls=;
        b=RACA7+LLO50Cky/qJJNkQqRagEmWSnMIqo1OLMpw0plnLeIC9kJ68PHAMATFyfmYhV
         P7c7jTDmTegZ0lzfLxA0pq400U8jSROY9IHCUFMn2wvIAvlcuJdkmJpy9cviHj2M3WKn
         NMTgV8nXT0gT0ca/CBswfP0oxbRlf6qT0p5no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR/ZxXYOfetOCIPFRvKNULFj2/1YAj7wkBUuAw2Y1ls=;
        b=qWN5CBEGylsDIS6UkPEC4FL/OzWtWuqIz96S5NPFy5aW+97KInqcMUEOuj3VVVvmrj
         BUCFlwm8s/PB/+AmA80TbTPdpkAPpVtqcUByzbXFTgZoOGzl0BeqwJoWozh8JfnmOeQo
         /XXrqs/Bj1Hr+JvkYVJXMnR9jQIRgXdYKfEJNsyWibKe/Tb2WNmJF2XNssEkNWt9xzMu
         woRuWrj9SkdEkSeBgNjXc6LxvQHpyINb/PXYHL3yPhkmIy/1bAwhPPOGaF4BGZMJK4ma
         H4ApwZVXMQ8Kdhl84QLczVyDx6uWPsHxkW9JqJvTzv6LhRrs9zlp9xdxU4wbLoLWf4YS
         t8Hw==
X-Gm-Message-State: AOAM531+8tT6OwfTKq7gARRRwv8H8ix2WuY3l8IZKj8iRm5HNrKMp8AM
        Ztm0VwsHq1NhbGT112pO8zeq5sLduX8RO1he
X-Google-Smtp-Source: ABdhPJwHYzl/QvvsAAj8TXnSR6YtLnzLceMotdmJi27A1P3SAL0Zit+80mpv2ak33dDCvpIBXC/1WQ==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr20440271lfn.244.1624906994467;
        Mon, 28 Jun 2021 12:03:14 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a7sm1513098lfg.220.2021.06.28.12.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:03:13 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w19so5910781lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:03:13 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr19320422lfc.201.1624906993250;
 Mon, 28 Jun 2021 12:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <YNQwgTR3n3mSO9+3@gmail.com> <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
 <YNlapAKObfeVPoQO@gmail.com> <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com>
 <YNoZIVgboj6YKo3V@gmail.com>
In-Reply-To: <YNoZIVgboj6YKo3V@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 12:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrd6-ZHyQGznpM+O0CtTHjzZ5P2Ozddh68WmDH9c+hBg@mail.gmail.com>
Message-ID: <CAHk-=wjrd6-ZHyQGznpM+O0CtTHjzZ5P2Ozddh68WmDH9c+hBg@mail.gmail.com>
Subject: Re: [GIT PULL] sigqueue cache fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:47 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> But even if release_posix_timer() is changed to call sigqueue_free() with
> IRQs disabled, or sigqueue_free() disables interrupts itself, I think we
> need to be mindful of the Consumer <-> Producer SMP races, which only
> appear to be safe due to an accidental barrier by free_uid().

Oh, I agree. The SMP memory ordering issues are subtle and while I
suspect they aren't something that can be triggered in reality, it's
an example of how broken some WRITE_ONCE -> READ_ONCE serialization
is.

I don't mind READ_ONCE/WRITE_ONCE in general, but I absolutely detest
them when they are used to hide KCSAN things, and when they are used
randomly for pointers.

I think they are much better suited for one-time flag things, and
pretty much every time you see a READ_ONCE/WRITE_ONCE you should
likely see a barrier somewhere.

And no, we don't want them to be some subtle barriers that are just
"in the context of this code, we can depend on the barrier in that
other function".

In general, if you have a WRITE_ONCE -> READ_ONCE chain an dnot some
obvious required barrier for other reasons right *there*, it should
almost certainly not be one of those ONCE things at all. It should be
a proper smp_store_release() -> smp_load_acquire(). Those have real -
and on sane hardware cheap - memory orderings.

And as the whole - and only - point of the sigqueue cache was a very
subtle performance and latency issue, I don't think we want to use
locks or atomics. It's why my revert commit suggests re-purposing the
"percpu_cmpxchg()" functionality: that would likely be a good model at
least for x86 and arm.

But while we have "percpu_cmpxchg()", I don't think we currently don't
really have that kind of operation where it

 (a) works on a non-percpu variable (but we can force casts, I guess)

 (b) has "acquire" semantics

We do have the *atomic* cmpxchg with acquire semantics, but atomics
are rather more expensive than we'd probably really want.

                 Linus
