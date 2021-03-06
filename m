Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EF32F8AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCFHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 02:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 02:02:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF70C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 23:02:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o11so4489416iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Fp1azj+m08KvPokDH/dDsmmfjJ40eYQpB9xtJQ8Uf8M=;
        b=cSlseZyhI8yzZrmsLOa5pBAIBsncRXxv4QVQZ/fDkEujp10+5WReM5UoVl8Ocj8RyL
         m2INd0as2X3YzMeaKKWf/O3NZ21z14HbZVpFUa0YjMwYHK/WO489EVUiiV1AxkwlZOVx
         /sc1MB8paFMTrIvpINL73ku56g8iJsPpG3DJT3H2RGvTFMmmNGKFtAnREezZAM4BiV4Q
         q6E99I3hvxJpeab4nSW/B3zLqu58XQ8aP7jn0BEliAStvuItz/FY6vI914UDtO4LOlrj
         Uf2yhUjUgOc7Zr6lldFKrKlFFDDJCfRg52xRlcgmWRy49V3YItUtBzcrbRQVbfsfE6Xp
         B3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Fp1azj+m08KvPokDH/dDsmmfjJ40eYQpB9xtJQ8Uf8M=;
        b=Q4Oxz7alnAONIHp6JPycFpwoDPjk/A2txTs9cNkq32GjM3GnxBTnUkz54uESQIlkv9
         cgkP2PEQP/Hxj7TjezPERWHgeSyWmgALmPv+ijMaltDk2PTh36+PHxjHmgw6H4/nkxrh
         reY8gTqk9p9YevwBjOS6K9kbQIOO7WGLqKMSQ19RV6CgbDXTqP740YcBhapAif78r5m0
         G2esCeFxLdh6C0Gp4gZj2RcMK7sRewYhcWHOqFt+P5scNnyMpTik3CzbAV1cs6jx0rBj
         Na7MCTqykmVGH8XjIxNg61oHPmYy7RZnPkPOyH9Q8kkmNC4kXkBmBQgsWC/EhBUOUBd3
         jiMQ==
X-Gm-Message-State: AOAM5320Yig20dG3k2TEGIwBgqf3LWD/K1oiGvhrpXlRfuAleZ+mbsFs
        nRYdVYTsRyiHQ/xIPryEDSGgnLhy3CLjQdLX78Jt5BhUezd+xw==
X-Google-Smtp-Source: ABdhPJxSPSl1Ab1UY8krWwU65CN6hKlrpSJhOPz3j+iBaAM6AbIvGgu50uKp/DsShPBSILSfYA3lhm0s3eUY0gJZ7nE=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr11286803ioj.156.1615014152374;
 Fri, 05 Mar 2021 23:02:32 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUjVnBjC4AJTT9LYS4J+QbuQZUVj5XdW+iPmjxxuODVmA@mail.gmail.com>
 <CAHk-=wivYUWarZQNObmi7ZbO5rz1SPD1YmTJhne-8E352Ab=eg@mail.gmail.com>
In-Reply-To: <CAHk-=wivYUWarZQNObmi7ZbO5rz1SPD1YmTJhne-8E352Ab=eg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 08:01:55 +0100
Message-ID: <CA+icZUX9Uf0y+m0Qqh0Jq3vsuUX+ytRx_ZrbeLjsf--GngzjLQ@mail.gmail.com>
Subject: Re: Linux 5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 1, 2021 at 12:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> >
> > I wondered why there was approx. for 6 days no commits and got an
> > answer from an LWN posting "5.12 Merge window delayed".
> > Unsure, if there was a posting to LKML?
>
> There was no posting to lkml because lkml doesn't take html emails,
> and I only had mobile data (and not even that for the first 24 hours
> or so - even cell towers were down).
>
> I did send updates to several top-level maintainers and to the
> users@kernel.org mailing list, so a lot of people knew about it, but
> they in turn probably only ended up mentioning it on a need-to-know
> basis. As you mention, LWN did have a mention of it, but you'd have to
> find it.
>
> In normal times I would have just taken a laptop to the nearest
> Starbucks and worked that way, but not in the pandemic. Plus the local
> highway was actually shut down for three days because of downed trees
> on the road (this was not a Texas-style electricity generation problem
> - it was literally thousands of trees falling all over. We had one
> miss our house by a couple of meters).
>
> Two weeks later, and the roadways are still littered with trees and
> tons of branches everywhere you drive.
>
> And I didn't have a generator because our local power lines are
> actually buried, and we very seldom lose electricity. But when all the
> feeder lines are down because trees fell over, and it takes a week
> first for the tree crews to clear the roads and then the electric
> crews to replace literally miles of electric cable, it doesn't really
> help all that much that the local lines are buried and all in good
> working order ;)
>
> > Anyway, if you are not able to make your work someone else should jump
> > in like Greg did once.
>
> It was an option, it didn't seem worth it.
>
> And part of _that_ was that it looked like "ok, a couple of days", and
> then it just kept being "one more day" for several days.
>
> A lot of people lost power for just a day or two.
>
> The area I live in probably wasn't a huge priority, because it's
> somewhat sparsely populated, and nice and wooded.
>
> Which is really nice most of the time. It's not quite so nice when you
> can hear the trees keep falling around you, and you know you have a
> few really big ones right next to the house.. ;^p
>

Based on / Freely adapted from Goethe: I answer just when it suits me!

I can hardly imagine your feelings and/or emotions as I was NOT in
such a situation.

I remember "Blackout M=C3=BCnsterland - M=C3=BCnsterl=C3=A4nder Schneechaos=
 2005" [1]
seen on German TV.
150km (approx. 92 miles) from my new home-town.

To make a story short:
Be proud you made a merge-window happen in real 14 -6 =3D 8 days.
That is amazing, really!

There exist emergency plans - especially for pandemic situations -
here in Germany.
For me it looks like no one cares - including the responsibles.
Exceptional circumstances or you might say "CHAOS".
Sometimes having no plan is good - but never forget your focus or targets.

I wanted to hear from you: Next time in such an exceptional situation
I/we will do ...

And hey yah: Linux v5.12-rc2 on a Saturday Morning @ 06-Mar-2021.
Congrats!

- Sedat -

[1] https://www.youtube.com/watch?v=3DjfKeGHqrip8
