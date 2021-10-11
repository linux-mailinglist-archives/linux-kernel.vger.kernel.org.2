Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D081C42982E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhJKUfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhJKUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:35:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03BCC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:33:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y26so79222569lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pvgUFmhqno3hkvinzM9GJYIuqct0rlA5JN/JE3/6p6E=;
        b=JWv7JJo1PEIvFtClnOAZKWU7mTLcs369BR5aLLU5mcEn1FCmc0+eyKMkGnHjBgdZE7
         5ZRhIynxYyIIyEV3FtpEgdNl4pILceVRV5s1wM0DOqIRlunYt2pWEPblofOpeuFy7YSG
         Uq6o4venOdMaUH1WUCCzCGcMDKqN01DZ2ma9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pvgUFmhqno3hkvinzM9GJYIuqct0rlA5JN/JE3/6p6E=;
        b=37uaqz1gGb1FYX+c+gTgUUqI+urzhNHhc5gYw+ee15Cs2/Glt9surAbelOSg2tUnoK
         gL0+Fu+nDdOtyAlX55+ToY8Xj2rqdZ4P3ovl0UNIxN3GqGAbC+b31vh+wjIMcKLeO7YO
         VmZL1V69wtvo2MinW0mGJcTfYTrOoPk3YJogdFlCJoEzTYCZrubv8bKPxz44xF9tClDY
         SNPdQWRkFFjFQOt2qwTClZavPixr+8vFYTOAjwnxCtF/77FNBk7iCHZ4lIliSu/M7Zl2
         YYVNlNiJyRdlI7ItqVS5w5FpmvtY5GxlvphZ68meYkWeE1P2vt8yoXKRZswgF5EugxSE
         HxVA==
X-Gm-Message-State: AOAM532vbqJFUoOe2RoZZbhZW1Ff47RPKYtHQgKJkkUbYH+knCesi3DT
        PMKmaPL94H7t2zNMTm577xN/SoBn2rvYYV1S
X-Google-Smtp-Source: ABdhPJx9Y1YfUexsTWcJkPOkaWKQ9bvAaDVKi4DP3aLBfBLx85fNaWu+0ZT61NWhtFfnmhnw4YLroA==
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr3947763ljp.421.1633984417629;
        Mon, 11 Oct 2021 13:33:37 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l27sm351714lfk.53.2021.10.11.13.33.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 13:33:37 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z11so69609428lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:33:37 -0700 (PDT)
X-Received: by 2002:a05:6512:2147:: with SMTP id s7mr27107761lfr.150.1633984416821;
 Mon, 11 Oct 2021 13:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211011194016.GA16788@codemonkey.org.uk>
In-Reply-To: <20211011194016.GA16788@codemonkey.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 13:33:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgx6VQW192hbUiZABmkmZjNDynH75OR=-wvg=un960nRA@mail.gmail.com>
Message-ID: <CAHk-=wgx6VQW192hbUiZABmkmZjNDynH75OR=-wvg=un960nRA@mail.gmail.com>
Subject: Re: Should EXIT_DEAD be visible to userspace ?
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 12:40 PM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> One of our users reported a crash in some userspace tooling this
> morning, which scrapes /proc/pid to gather stack traces, process states
> etc of everything running at the time.
>
> The crash occurred because it fell over an unexpected task state,
> which was 'X'.   According to the procps man-pages, this state should
> never be seen, but here it clearly was.

Heh.

> The kernel running at the time was kinda old (5.2) but I don't see much
> change in the EXIT_DEAD space that would explain something that got
> fixed subsequently.   It's also probably going to be difficult to
> reproduce unfortunately.
>
> So my question is, is procps wrong and code should expect to see X state
> processes in proc ?  The code in question is being hardened to handle
> unexpected inputs, but I'm curious if the kernel is leaking some state
> that it shouldn't.

My gut feel is that the man-pages have clearly been wrong - or at
least misleading - for at least the last couple of years (and possibly
longer), and this is the first report we've ever had of it actually
causing problems.

The docs *do* mention 'X'. Even if they say 'should never be seen',
it's not like it's not right there.

So we could either ask to just have the man-pages fixed to be a little
less strongly worded ("never" -> "seldom" or whatever). And apparently
procps is already getting fixed.

Or we could hide the 'X' state in newer kernels, and just call them
zombies to user space. We could literally just change the string from
"X (dead)" to "Z (dead)" and the "dead" part would still be there (and
different from "Z (zombie)").

And either way, it's likely not going to be something that people will
notice ever again. You update your system, and you wouldn't see the
problem, because whether the kernel was changed or not, procps was
updated.

And if the argument is that people didn't update procps, but *did*
update the kernel, then sure, that could avoid somebody hitting this
again, but that's where the "at least a couple of years and nobody has
noticed before" comes in.

So I can certainly take a patch that hides 'X', and we can even mark
it for stable.

But it feels like realistically nobody will actually care, and the
real fix is the one to procps, and that fix will make any kernel
change irrelevant (and possibly even a slight negative, since now
procps might report interesting cases?).

End result: if somebody cares enough and sends me a tested patch, I'll
apply it. But I personally wouldn't care much, and wouldn't push for
it unless we get somebody who does.

And I really think that "should never be seen" in the docs is just wrong.

Yes, we hold the task lock in task_state() when you look at
/proc/<pid>/status. So maybe it will never be seen there, because
maybe (I didn't check) we move from X->Z while holding the lock.

But other parts of /proc don't actually do that lock_task(), I think.
IOW, looking at /proc/<pid>/stat (which shows just the first letter of
the state), doesn't do that, I think. So it's not actually serialized
with the process going through its dying moments.

So I _think_ the "never" was always just "almost never".

In fact, take a look at commit ad86622b478e ("wait: swap EXIT_ZOMBIE
and EXIT_DEAD to hide EXIT_TRACE from user-space"). That 'X' has been
seen before. It's not great when it happens, but I think this is an
example of "the 'never' has never been true, and goes back to at least
2014".

.. and that 2014 was just when we happened on it before. The actual
issue of 'X' showing up looks like it probably predates it (and likely
goes back to before git history).

So I suspect that stray 'X' is not actually a regression. Just rare
enough to be _almost_ "never".

                     Linus
