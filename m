Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE13F39CC93
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 23:50:29 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44937 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFDu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 23:50:27 -0400
Received: by mail-lf1-f44.google.com with SMTP id r198so17024334lff.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYTZ0aVkCupy147WxRNKwW/8x7k8EKzPl0T5uXCBADE=;
        b=Zo6bRdKVAXx4rABaNQFHDKIcnmCE0mQIEHI2xzzZsiSixlnzFQRE7LEfhxGkjl6YKa
         tqQ2emAPcylF8ergb0DoTwbkVnUyd3IZD1Fc/0M87b1M2fNep6H/kY+77J3vUZh3Ge3U
         tTIZehMKt1Lln/1Lh7r9w8XgIHb5V+QKF+nkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYTZ0aVkCupy147WxRNKwW/8x7k8EKzPl0T5uXCBADE=;
        b=Ypw9svuwuWGO1Owtg5ZWDCPvAKAsEbrdTicY30nALD1pqjt0JAmgRxa04R3e/9BgM2
         E1f3sGWr6UV4I47eIF6gghukuixpCcU/UX19LQEsmq57kL9bdu2Z3Hk5qe9+NI9pgy6C
         9BYu8zLm8te0Q59u0VcFC1yhybLwxiJmkDOwE9pY83pvRov0xedlK3LZlTxdFNSwlT1x
         dFCt4F4ngQm/yuinCx2i1ax1BZPtSzgqJKHAbr/GI5H+ohjbUEo7mrB8wBNcoNao5BCy
         kW51iHMkn6FMV+D3Ycz+bqjBfWSK7X0joAW0klQfixXq0mUP04CWuOeFjipxr1k7bNad
         koBQ==
X-Gm-Message-State: AOAM532bmnVBc1ymNzXXK0s0LtjK2CUieKwRkjyytLeraWqJlv997N5t
        ibkrd16Kc3jC9eHa+Iu1Jn4Lio+ybMCo9Q5PXE4=
X-Google-Smtp-Source: ABdhPJxxEjYaw1UvNeaxv6GZL3MqBK0y7LZakD7qw7VnEqwL/9Ah8P/FYmD3Hd6MqbNZTlqU4Gj4Uw==
X-Received: by 2002:a05:6512:3fa2:: with SMTP id x34mr7518555lfa.437.1622951243147;
        Sat, 05 Jun 2021 20:47:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s11sm1245475ljc.66.2021.06.05.20.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 20:47:23 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r5so20414382lfr.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 20:47:22 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr7389694lfs.377.1622950876683;
 Sat, 05 Jun 2021 20:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu> <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
In-Reply-To: <20210606012903.GA1723421@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jun 2021 20:41:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
Message-ID: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 6:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Interesting.  And changing one of the branches from barrier() to __asm__
> __volatile__("nop": : :"memory") also causes a branch to be emitted.  So
> even though the compiler doesn't "look inside" assembly code, it does
> compare two pieces at least textually and apparently assumes if they are
> identical then they do the same thing.

That's actually a feature in some cases, ie the ability to do CSE on
asm statements (ie the "always has the same output" optimization that
the docs talk about).

So gcc has always looked at the asm string for that reason, afaik.

I think it's something of a bug when it comes to "asm volatile", but
the documentation isn't exactly super-specific.

There is a statement of "Under certain circumstances, GCC may
duplicate (or remove duplicates of) your assembly code when
optimizing" and a suggestion of using "%=" to generate a unique
instance of an asm.

Which might actually be a good idea for "barrier()", just in case.
However, the problem with that is that I don't think we are guaranteed
to have a universal comment character for asm statements.

IOW, it might be a good idea to do something like

   #define barrier() \
        __asm__ __volatile__("# barrier %=": : :"memory")

but I'm  not 100% convinced that '#' is always a comment in asm code,
so the above might not actually build everywhere.

However, *testing* the above (in my config, where '#' does work as a
comment character) shows that gcc doesn't actually consider them to be
distinct EVEN THEN, and will still merge two barrier statements.

That's distressing.

So the gcc docs are actively wrong, and %= does nothing - it will
still compare as the exact same inline asm, because the string
equality testing is apparently done before any expansion.

Something like this *does* seem to work:

   #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
   #define __barrier(id) ____barrier(id)
   #define barrier() __barrier(__COUNTER__)

which is "interesting" or "disgusting" depending on how you happen to feel.

And again - the above works only as long as "#" is a valid comment
character in the assembler. And I have this very dim memory of us
having comments in inline asm, and it breaking certain configurations
(for when the assembler that the compiler uses is a special
human-unfriendly one that only accepts compiler output).

You could make even more disgusting hacks, and have it generate something like

    .pushsection .discard.barrier
    .long #id
    .popsection

instead of a comment. We already expect that to work and have generic
inline asm cases that generate code like that.

              Linus
