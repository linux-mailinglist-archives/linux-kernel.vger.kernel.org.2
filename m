Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6DA39D073
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFFSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFFSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:36:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC655C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 11:34:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w33so22305468lfu.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCWr8JhNzCloXh66R5AnUaro6vaXxFcYsMy/7mthDQQ=;
        b=HItZ9v7fXL1gEgMoDc3i806KpoLYfXqzrqdg4mQsNbVbvYJzdSQETr3wZGeWn2EXa6
         k7oQxmIHn4DtblbRxGIyxJ0LIZ7Aertif+w4INhRIlYU3pUTd6WCzoHzZxB0svZdpP4b
         NmeMrc3Kbor0jG7ssfgpCV0XKQEBJz1sfkOVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCWr8JhNzCloXh66R5AnUaro6vaXxFcYsMy/7mthDQQ=;
        b=csygXvAuDzFDL6HF1xX1GsBQmLowvF/ADLn/RuZti3e6Gt0DU9IXcIKNjps65JpnyU
         oQqhMtoVTQYqskJ3kA2nBtrue2wTIwI+xPdjZqBuywDk7wgb/hyd2pozZLdZPHo4+giF
         Pzc3us8y8Sz2KUGejwZtEAVIcB1LAjPck/fc5xpePpnUE1zbFzAqUZdrg7sOetnF9H/S
         pSox2fZn3bOEChwMKfhxEtI9SLLrhayfftBZEeckBSWkxym/y6PkFwkRT8UZzrzDiBlU
         wmKLSux7oaP/0sGmkbuPnk46GN9J21gj4o9eYOU58lHkEflZLhA+R1xCdr5eSlir39AQ
         BhBg==
X-Gm-Message-State: AOAM531A1kVmB+hYVgthEs1n5E5+hxYDkAKYwmznmpSUlYzdc1mdEaDd
        kVxjBP6cwwEnBAXyxsIQLwa+D0Vo9ediAbPu4p0=
X-Google-Smtp-Source: ABdhPJyXUsYgv71LJbt0xW8CSLusG+VjpHrrjwtuODjY7XagbFIcKMesQaWa+FXYZLGuejHwWMPn0g==
X-Received: by 2002:a05:6512:344e:: with SMTP id j14mr9675239lfr.468.1623004446214;
        Sun, 06 Jun 2021 11:34:06 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id bn18sm1536959ljb.48.2021.06.06.11.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:34:06 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a4so18870525ljq.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:34:05 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr11983678ljh.507.1623003962243;
 Sun, 06 Jun 2021 11:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606125955.GT18427@gate.crashing.org>
In-Reply-To: <20210606125955.GT18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:25:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPUaj7tv-JYzKQ34ukP3LEuGf82g+Nyp96pTnxN=xOtA@mail.gmail.com>
Message-ID: <CAHk-=wgPUaj7tv-JYzKQ34ukP3LEuGf82g+Nyp96pTnxN=xOtA@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Sun, Jun 6, 2021 at 6:03 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> >
> > I think it's something of a bug when it comes to "asm volatile", but
> > the documentation isn't exactly super-specific.
>
> Why would that be?  "asm volatile" does not prevent optimisation.

Sure it does.

That's the whole and only *POINT* of the "volatile".

It's the same as a vol;atile memory access. That very much prevents
certain optimizations. You can't just join two volatile reads or
writes, because they have side effects.

And the exact same thing is true of inline asm. Even when they are
*identical*, inline asms have side effects that gcc simply doesn't
understand.

And yes, those side effects can - and do - include "you can't just merge these".

> It says this code has some unspecified side effect, and that is all!

And that should be sufficient. But gcc then violates it, because gcc
doesn't understand the side effects.

Now, the side effects may be *subtle*, but they are very very real.
Just placement of code wrt a branch will actually affect memory
ordering, as that one example was.

> > Something like this *does* seem to work:
> >
> >    #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
> >    #define __barrier(id) ____barrier(id)
> >    #define barrier() __barrier(__COUNTER__)
> >
> > which is "interesting" or "disgusting" depending on how you happen to feel.
>
> __COUNTER__ is a preprocessor thing, much more like what you want here:
> this does its work *before* everything the compiler does, while %= does
> its thing *after* :-)
>
> (Not that I actually understand what you are trying to do with this).

See my previous email for why two barriers in two different code
sequences cannot just be joined into one and moved into the common
parent. It actually is semantically meaningful *where* they are, and
they are distinct barriers.

The case we happen to care about is memory ordering issues. The
example quoted may sound pointless and insane, and I actually don't
believe we have real code that triggers the issue, because whenever we
have a conditional barrier, the two sides of the conditional are
generally so different that gcc would never merge any of it anyway.

So the issue is mostly theoretical, but we do have code that is fairly
critical, and that depends on memory ordering, and on some weakly
ordered machines (which is where all these problems would happen),
actual explicit memory barriers are also <i>much</i> too expensive.

End result: we have code that depends on the fact that a read-to-write
ordering exists if there is a data dependency or a control dependency
between the two. No actual expensive CPU instruction to specify the
ordering, because the ordering is implicit in the code flow itself.

But that's what we need a compiler barrier for in the first place -
the compiler certainly doesn't understand about this very subtle
memory ordering issue, and we want to make sure that the code sequence
*remains* that "if A then write B".

             Linus
