Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6840EA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348809AbhIPSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348648AbhIPSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:43:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EFC0F01D8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:11:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b18so19735106lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+xeI9yNXCRkaG2d0rWpuTXTwxQ1L7t4JGBuCSwYlzY=;
        b=PFIdI8hSfGl/I/xLyCIqrAdtOipwHOMnM/RyAYcDQkuyozGgPcpYOe1yCL1znEHH2w
         PZo07PwBe/dE/VSPPXejOD4Gh7yB+icrX/G0pi4+4Wt4MmKKgQSqWx6yucj4cJQZ7DCt
         MdH7Jl6HJp7gVYHNdUdASZna3EaLkWmrEhOfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+xeI9yNXCRkaG2d0rWpuTXTwxQ1L7t4JGBuCSwYlzY=;
        b=k2z66aj6bEOYGZjT5OOqGL4YaOkkk7e9VSGYSQgoGbpQtBNRsHuV27hP3n62mYIxic
         8rjnEgbieL+d94d9WjvfKuJx+MIc2bs2FgoYdryiT8e2SatOvrbTzPLXPOOb8EhAnc6C
         jXYEJIYu+Ma0Us3fwuLWyacfznPM5m5Tmv/OiB4p5vu8bQAkuROGlX+CyKEZJFsue7hZ
         rSUum7ssHefQrmy/c0+JdtiqFhezaeR1+eON37iKuRDH0pFpmIbwM44ktxCBUs1yysFQ
         k00N/EZjqP6AuBPe1RuA+jAh/SZIajtnYdqJ8qDegmncQMCDDQxtApavUfFnoJ6Cloa7
         IsIQ==
X-Gm-Message-State: AOAM5326PC1wCZR38MtxIsVpt6vK3jszCWA8VnmjoRDAGwe0mIv/P2bV
        MCGiCo6EJLxUtyC5GJs8nZ1EiV63X3bsj649
X-Google-Smtp-Source: ABdhPJy77zmenTToMP2bDnrThfBZEQZLsF4oSurCQC7g+P5bHollHFUNUUWJbnjzZrZPutzVk5pntg==
X-Received: by 2002:a05:6512:1029:: with SMTP id r9mr5105237lfr.688.1631812299784;
        Thu, 16 Sep 2021 10:11:39 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q2sm308840lfo.174.2021.09.16.10.11.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 10:11:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id y28so21294417lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:11:39 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr5622718ljg.31.1631812298752;
 Thu, 16 Sep 2021 10:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47>
 <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com> <2677927.DK6gFqPMyL@devpool47>
In-Reply-To: <2677927.DK6gFqPMyL@devpool47>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 10:11:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
Message-ID: <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
Subject: Re: data loss when doing ls-remote and piped to command
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 5:17 AM Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Donnerstag, 16. September 2021, 12:12:48 CEST schrieb Tobias Ulmer:
> > > The redirection seems to be an important part of it. I now did:
> > >
> > > git ... 2>&1 | sha256sum
> >
> > I've tried to reproduce this since yesterday, but couldn't until now:
> >
> > 2>&1 made all the difference, took less than a minute.

So if that redirection is what matters, and what causes problems, I
can almost guarantee that the reason is very simple:

Your git repository (or more likely your upstream) has some problem,
it's getting reported on stderr, and because you mix stdout and stderr
with that '2>&1', you get randomly mixed output.

Then it depends on timing where the mixing happens.

Or rather, it depends on various different factors, like the buffering
done internally by stdio (where stdout generally will be
block-buffered, while stderr is usually line-buffered, which is why
you get odd mixing of the two).

But timing can be an effect particularly with "git ls-remote" and
friends, because you may get errors from the transport asynchronously.

So the different buffering ends up causing the effect of mixing things
in the middle of lines, while the timing differences due to the
asynchronous nature of the remote access pipeline will likely then
cause that odd mixing to be different.

End result: corrupted lines, and different sha256sum every time.

> > Running the same on Archlinux (5.13.13-arch1-1, 2.33.0) doesn't show the
> > problem.
> > This may well turn out not to be git, but a kernel issue.

Much more likely that the other box just doesn't have the error situation.

> since you have been hacking around in pipe.c recently, I fear this isn't
> entirely impossible. Have you any idea?

Almost certainly not the kernel. Kernel - and other - differences
could affect timing, of course, but the whole "2>&1" really is
fundamentally bogus.

If you don't have any errors, then the "2>&1" doesn't matter.

And if you *do* have errors, then by definition the "2>&1" will mix in
the errors with the output randomly and piping them together is
senseless.

Either way, it's wrong.

So what I'd suggest Tobias should do is

    git ... 2> err | sha256sum

which will send the errors to the "err" file. Take a look at that file
afterwards and see what is in it.

Basically, '2&>1" is almost never the right thing to do, unless you
explicitly don't care about the output and just want to suppress it.

So "2&>1 > /dev/null" is common and natural.

Of course, people also use it when they just want to eyeball the
errors mixed in, so doing that

   ... 2&>1 | less

thing isn't necessarily *wrong*, but it's somewhat dangerous and
confusing. Because when you do it you do need to be very aware of the
fact that the errors and output will be *mixed*. And the mixing will
not necessarily be at all sensible.

Finally: pipes on a low level guarantee certain atomicity constraints,
so if you do low-level "write()" calls of size PIPE_BUF or less, the
contents will not be interleaved randomly.  HOWEVER. That's only true
at that "write()" level. The moment you use <stdio> for your IO, you
have buffering inside of the standard IO libraries, and if your code
isn't explicitly very careful about it, using setbuf() and fflush()
and friends, you'll get that random mixing.

Anyway. That was a long email just to tell people it's almost
certainly user error, not the kernel.

            Linus
