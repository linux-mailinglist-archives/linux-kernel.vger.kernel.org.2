Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7233FB01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCQWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQWXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:23:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6204C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:23:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b184so2092605pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=RZEKJdaq0V9wtqqXxPUbM9eFMZIGKO+oIBHl3RZ/clg=;
        b=RZnFlLbj+h0fD+khd1c1DwBlD8SwMkyXlQ48JxicRxVZphgGnat81u/asaG7NN10dD
         VONZG+h2F/5BK5McnwfWB39N8MXytyVl9Swt8PMDzHfvzbrPzTeq6NrqdZWAbjIKvake
         v60ZCp21j4SiTwATeUwn5URW/O9XLOlJ2AzmkBAk5XKirHGDimxQXhgRlwqcI1jtaFzI
         14wrwBqlZUApyZ0armmOReq/luJaxx5hnM+yIMms3TCTJh/REW0lVZds/Zksg0+sytXX
         IJriOR+QnUOeRH0GWdxvIwSvho0fAfOKjEkn90nof8exkhNKvpZmt+I2vY7+xu2sqnTM
         z5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=RZEKJdaq0V9wtqqXxPUbM9eFMZIGKO+oIBHl3RZ/clg=;
        b=uGADmSwpmn37AbG17CsHIx5wUdDTG3owvA+XSDvIJqyNLTUnZn7JUzUT6kLJYA6504
         c8aA46OzcxNEmjqaVojxEGWaoTBwhaIUlYIg3QrHnOuMDmZsPVpvG2vIDtyccSpWxal1
         LMK9zSuT76yREfNDf2SKpCF2PCxoRn/E0nFV6ZZeXQFPoL2Mg8yVqIdQwm4fO4sc37dA
         0OYAm0i82jmy3a0Q5SM44Y14KCSxYndAdTfoujWugTISNDyo8EWQlXDqIAoY9ghU3/uo
         KX23M7Wubmh1JmlZ+kuUblMuSXtY2WoqNf+PEhU4zernawAUnX72w4K6DHwcIH0NmEbR
         nYIg==
X-Gm-Message-State: AOAM533WEhUpIbxmdi3gj5xDLts8INlsA9gvrJsbEs8CXHc/5Hio0RMU
        ixvYQLVKPWzYqxa5ZI60ZT8=
X-Google-Smtp-Source: ABdhPJxpz/ExboVKk5U/bOB6GZxeEG5n2ISzVKfpLZD5yaSSNW6X+02HyAOnx2dxAtETBVgc7RcQag==
X-Received: by 2002:a63:4761:: with SMTP id w33mr4395880pgk.118.1616019784274;
        Wed, 17 Mar 2021 15:23:04 -0700 (PDT)
Received: from localhost ([58.84.78.96])
        by smtp.gmail.com with ESMTPSA id v7sm105585pfv.93.2021.03.17.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:23:03 -0700 (PDT)
Date:   Thu, 18 Mar 2021 08:22:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>
References: <20210317075427.587806-1-npiggin@gmail.com>
        <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
        <1615977781.fijkhk7ep5.astroid@bobo.none>
        <CAHk-=whKnamUnZaJQ+fcqYoLJfc8QB8dv6=2P7o-XPBDOtbF3w@mail.gmail.com>
In-Reply-To: <CAHk-=whKnamUnZaJQ+fcqYoLJfc8QB8dv6=2P7o-XPBDOtbF3w@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1616017462.cmzed2nj60.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Linus Torvalds's message of March 18, 2021 5:26 am:
> On Wed, Mar 17, 2021 at 3:44 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> Argh, because I didn't test small. Sorry I had the BASE_SMALL setting in
>> another patch and thought it would be a good idea to mash them together.
>> In hindsight probably not even if it did build.
>=20
> I was going to complain about that code in general.
>=20
> First complaining about the hash being small, and then adding a config
> option to make it ridiculously much *smaller* seemed wrong to begin
> with, and didn't make any sense.
>=20
> So no, please don't smash together.

Fair point, fixed.

>=20
> In fact, I'd like to see this split up, and with more numbers:
>=20
>  - separate out the bit_waitqueue thing that is almost certainly not
> remotely as critical (and maybe not needed at all)
>=20
>  - show the profile number _after_ the patch(es)

Might take some time to get a system and run tests. We actually had=20
difficulty recreating it before this patch too, so it's kind of
hard to say _that_ was the exact case that previously ran badly and
is now fixed. We thought just the statistical nature of collisions
and page / lock contention made things occasionally line up and
tank.

>  - explain why you picked the random scaling numbers (21 and 22 for
> the two different cases)?
>=20
>  - give an estimate of how big the array now ends up being for
> different configurations.
>=20
> I think it ends up using that "scale" factor of 21, and basically
> being "memory size >> 21" and then rounding up to a power of two.
>=20
> And honestly, I'm not sure that makes much sense. So for a 1GB machine
> we get the same as we used to for the bit waitqueue (twice as many for
> the page waitqueue) , but if you run on some smaller setup, you
> apparently can end up with just a couple of buckets.
>=20
> So I'd feel a lot better about this if I saw the numbers, and got the
> feeling that the patch actually tries to take legacy machines into
> account.
>
> And even on a big machine, what's the advantage of scaling perfectly
> with memory. If you have a terabyte of RAM, why would you need half a
> million hash entries (if I did the math right), and use 4GB of memory
> on it? The contention doesn't go up by amount of memory, it goes up
> roughly by number of threads, and the two are very seldom really all
> that linearly connected.
>=20
> So honestly, I'd like to see more reasonable numbers. I'd like to see
> what the impact of just raising the hash bit size from 8 to 16 is on
> that big machine. Maybe still using alloc_large_system_hash(), but
> using a low-imit of 8 (our traditional very old number that hasn't
> been a problem even on small machines), and a high-limit of 16 or
> something.
>=20
> And if you want even more, I really really want that justified by the
> performance / profile numbers.

Yes all good points I'll add those numbers. It may need a floor and
ceiling or something like that. We may not need quite so many entries.

>=20
> And does does that "bit_waitqueue" really merit updating AT ALL? It's
> almost entirely unused these days.

I updated it mainly because keeping the code more similar ends up being=20
easier than unnecessary diverging. The memory cost is no big deal (once=20
limits are fixed) so I prefer not to encounter some case where it falls=20
over.

> I think maybe the page lock code
> used to use that, but then realized it had more specialized needs, so
> now it's separate.
>=20
> So can we split that bit-waitqueue thing up from the page waitqueue
> changes? They have basically nothing in common except for a history,
> and I think they should be treated separately (including the
> explanation for what actually hits the bottleneck).

It's still used. Buffer heads being an obvious and widely used one that
follows similar usage pattern as page lock / writeback in some cases.
Several other filesystems seem to use it for similar block / IO
tracking structures by the looks (md, btrfs, nfs).

Thanks,
Nick
