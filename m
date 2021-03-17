Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF02933F922
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhCQT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhCQT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:27:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:27:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s17so4626110ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7PfSQ478H4gL+ePUwNmtoQqfcCoytqCVvRBHHB4kK4=;
        b=HysRjg5Vm8PBkWcawhMQ9e8rTUA0qSCOQ5N7lqw7nKYmH4Jh2LscIStkT50FshfSWy
         S+lRXzzxscxhDGbI5SfGjeRh+XLEC5PZHDk6kM9yLX+sRcXCX1J5yrzAm6KGX0JWnuFJ
         VrHwd5Si03mYfj8Fd7mivuEsEwmiRHXQAZ9g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7PfSQ478H4gL+ePUwNmtoQqfcCoytqCVvRBHHB4kK4=;
        b=HrhutP0viD0052JuLyXPWp1e/GO+1igwV+4ybClvEkNCWzYb5teR8mUyURwMLL1gxM
         C7tUn6VbHrFFkPiKtliPrl5+AHnaOclwJZTbDe9GMx5HKDYIeHQ9wx+JCmqXjKRbIBzr
         RYetuLctlh7MgRXEo5DusooxjW7qbKiK5sjRc6HRIGiF7jyd34uWlNmdnUH0t4VpijDU
         a9AN6K88ZMuQSh7/OfeKcQilv5WYOQoOd3u0UboE1X+rAe2Hgq7qy8Y7xqW5Yh28/Wgi
         WuJvBsDqQN6GnQWrbrLMHiwDa4mZU4wloPN6WHq6WwXuVXJsVaW9uhkXt8Fib9jqYfv2
         J+yw==
X-Gm-Message-State: AOAM533gorZfDbh7JZDvqG99m81mgSmMK3Aca0D1Ygwls2NwwnhWXT2Y
        4k44BJw6vqKkXfCbtzJRZtxozqVe+TVznQ==
X-Google-Smtp-Source: ABdhPJylTwyoXjEpybMXb6zxoi3JSqDbgcJnBOc6KzGYsNiJmtECR6i49akBcXnW8JFFqgiXyJ2MfA==
X-Received: by 2002:a2e:8159:: with SMTP id t25mr3355290ljg.437.1616009228980;
        Wed, 17 Mar 2021 12:27:08 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x36sm3451405lfu.129.2021.03.17.12.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:27:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s17so4625982ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:27:07 -0700 (PDT)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr3180718ljj.48.1616009226982;
 Wed, 17 Mar 2021 12:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210317075427.587806-1-npiggin@gmail.com> <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
 <1615977781.fijkhk7ep5.astroid@bobo.none>
In-Reply-To: <1615977781.fijkhk7ep5.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Mar 2021 12:26:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKnamUnZaJQ+fcqYoLJfc8QB8dv6=2P7o-XPBDOtbF3w@mail.gmail.com>
Message-ID: <CAHk-=whKnamUnZaJQ+fcqYoLJfc8QB8dv6=2P7o-XPBDOtbF3w@mail.gmail.com>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:44 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Argh, because I didn't test small. Sorry I had the BASE_SMALL setting in
> another patch and thought it would be a good idea to mash them together.
> In hindsight probably not even if it did build.

I was going to complain about that code in general.

First complaining about the hash being small, and then adding a config
option to make it ridiculously much *smaller* seemed wrong to begin
with, and didn't make any sense.

So no, please don't smash together.

In fact, I'd like to see this split up, and with more numbers:

 - separate out the bit_waitqueue thing that is almost certainly not
remotely as critical (and maybe not needed at all)

 - show the profile number _after_ the patch(es)

 - explain why you picked the random scaling numbers (21 and 22 for
the two different cases)?

 - give an estimate of how big the array now ends up being for
different configurations.

I think it ends up using that "scale" factor of 21, and basically
being "memory size >> 21" and then rounding up to a power of two.

And honestly, I'm not sure that makes much sense. So for a 1GB machine
we get the same as we used to for the bit waitqueue (twice as many for
the page waitqueue) , but if you run on some smaller setup, you
apparently can end up with just a couple of buckets.

So I'd feel a lot better about this if I saw the numbers, and got the
feeling that the patch actually tries to take legacy machines into
account.

And even on a big machine, what's the advantage of scaling perfectly
with memory. If you have a terabyte of RAM, why would you need half a
million hash entries (if I did the math right), and use 4GB of memory
on it? The contention doesn't go up by amount of memory, it goes up
roughly by number of threads, and the two are very seldom really all
that linearly connected.

So honestly, I'd like to see more reasonable numbers. I'd like to see
what the impact of just raising the hash bit size from 8 to 16 is on
that big machine. Maybe still using alloc_large_system_hash(), but
using a low-imit of 8 (our traditional very old number that hasn't
been a problem even on small machines), and a high-limit of 16 or
something.

And if you want even more, I really really want that justified by the
performance / profile numbers.

And does does that "bit_waitqueue" really merit updating AT ALL? It's
almost entirely unused these days. I think maybe the page lock code
used to use that, but then realized it had more specialized needs, so
now it's separate.

So can we split that bit-waitqueue thing up from the page waitqueue
changes? They have basically nothing in common except for a history,
and I think they should be treated separately (including the
explanation for what actually hits the bottleneck).

          Linus
