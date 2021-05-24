Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7538E740
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhEXNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:19:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B0C061574;
        Mon, 24 May 2021 06:18:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w7so20171500lji.6;
        Mon, 24 May 2021 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYeENMZqICNqwNEdOZ74tQtw/Ef3oNWWuv3P25XAd+U=;
        b=eIGrKvllk269Xsalcub08+tKQrLaQMeAD9UDifih7ZgmeRLps2KJ2P/AXnToTWWyEt
         mD1CzB9k0znR9KScbxl8/AnNn3Ska3pEysogZVGBoStwa6riVNktMI/FnofSPciOXObk
         o4lUHQlpNcY81p/uZANB0hSaC35WlCJbV5+XpoypMQWIYxOHAODxDHqDj54xaRyKQ/qe
         COi7+DXFb8cCrZkph9Gi6PxJIHiYbsQX6TdUk4n3v8UanedGfgSFn7I+pTt5R+Z20fqj
         iQ3AhhQ+OkPTNPvJVveqb97BXVaJocNkW5bZVIV9OwAU3wI//uzRPmgDt90ZTR+84k+W
         grDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYeENMZqICNqwNEdOZ74tQtw/Ef3oNWWuv3P25XAd+U=;
        b=MzIUmdXp9+gYMHuPk/iQB5pRH2tTjV7kfmQWL61OrfDT1UOKptZaDrB/fIs4DpHxau
         GRvh+6jxqiqHTzShWTt2KVOp9ewSldv6v+UMl52S9YAu7k6Q3aeEuZSdHII+EMJnBQJZ
         IqayW7OdvPXOKkpV26JdMGOb/RlJoXsds0U/dhQMoCsuYSNTHIhinY4l4PZZFag2NnnB
         x7MEQuUhwAXTJwcK//vtvZAwSbeaCuXUFbPUVeUv43V4yPlXJnebOm4oKpP1QzgBamFi
         Rvpmop4X40uVyMPDGP89b+K96eSk9cJMxYwPLwLsZoWXkxiiDpzAhSZSAsqw+7iWaZbt
         FhIA==
X-Gm-Message-State: AOAM532EeqBvG2230Bqb8nG1Q1yDquKUDddeXEuFl2aetvur5FXOKw3o
        WguysIlQzxoxvHFBDGoOhxCjefT4vd5LgogGpFM=
X-Google-Smtp-Source: ABdhPJxMdkP9zbJg3gLbxKU38KxPES/NtdhxQc+eYMNFikv0NMD5gXBnld/mMwch97MCypWOUJ1DM60xDEVzJ5HgtYM=
X-Received: by 2002:a2e:b4ed:: with SMTP id s13mr17008484ljm.86.1621862298712;
 Mon, 24 May 2021 06:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
 <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com> <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
 <YKuAvt3WXBVASuhY@boqun-archlinux>
In-Reply-To: <YKuAvt3WXBVASuhY@boqun-archlinux>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 24 May 2021 21:17:52 +0800
Message-ID: <CAEVVKH-Tun1Bh2BoYq_3UXXWgZMOHbmDu1jCMowWBj4uJ1MZuw@mail.gmail.com>
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 6:33 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, May 24, 2021 at 12:24:00PM +0800, Xiongwei Song wrote:
> > On Fri, May 21, 2021 at 11:17 PM Waiman Long <llong@redhat.com> wrote:
> > >
> > > On 5/21/21 2:29 AM, Xiongwei Song wrote:
> > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > >
> > > > The block condition matrix is using 'E' as the writer noation here, so it
> > > > would be better to use 'E' as the reminder rather than 'W'.
> > > >
> > > > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > > > ---
> > > >   Documentation/locking/lockdep-design.rst | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> > > > index 9f3cfca..c3b923a 100644
> > > > --- a/Documentation/locking/lockdep-design.rst
> > > > +++ b/Documentation/locking/lockdep-design.rst
> > > > @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
> > > >       | R | Y | Y | N |
> > > >       +---+---+---+---+
> > > >
> > > > -     (W: writers, r: non-recursive readers, R: recursive readers)
> > > > +     (E: writers, r: non-recursive readers, R: recursive readers)
> > > >
> > > >
> > > >   acquired recursively. Unlike non-recursive read locks, recursive read locks
> > >
> > > I would say it should be the other way around. Both W and E refer to the
> > > same type of lockers. W emphasizes writer aspect of it and E for
> > > exclusive. I think we should change the block condition matrix to use W
> > > instead of E.
> >
> > The doc uses 'E'  to describe dependency egdes too. Should we change them
> > to 'W'? Personally,  both 'W' and 'E' are fine.
> >
>
> I also think Waiman's suggestion is solid, there are two ways to
> classify locks:
>
> 1.      W (Writers), R (Recursive Readers), r (Non-recursive Readers)
>
> 2.      E (Exclusive locks), S (Shared locks), R (Recursive Readers),
>         N (Non-recursive locks)
>
> And the relations between them are as follow:
>
>         E = W
>         R = R
>         N = W \/ r
>         S = R \/ r
>
> , where "\/" is the set union.
>
> The story is that I used the way #1 at first, and later on realized way
> #2 is better for BFS implementation, also for reasoning, so here came
> this leftover..

Thanks for the explanation.

>
> If you are interested, go ahead sending a patch fixing this, otherwise,
> I will fix this.

Ok.  Let me fix.

Thanks,
Xiongwei
>
> Regards,
> Boqun
>
> > Thanks,
> > Xiongwei
> > >
> > > Cheers,
> > > Longman
> > >
