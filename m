Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA9325FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBZJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhBZJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:21:31 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:20:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k12so805706ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+uOWPFzzCIa7OYqY/m1Q3ZpjqDPg+5pHoY+BALxZ/U=;
        b=Z3rbVEuy27QsFeKZW3PXq2Elhy38QzYQkMGUZuaCQQteEwN/jhUxUY9fbtCQqwK6Kv
         GtdHt/k67d1Ys2qI21wo0X7bE1OF+QmLJ93Exj34/bVHBj7R5sIlBbHKDc3nTW73Ppjq
         eEu5TGjUhTY97dEIDA2t2vH/U8wS282yAlXa3lKedB4ugsHCO66ax74UJd9cMM+0iWcx
         FpamZupq+ysl+W7OvoUNBKNLecDKkaA0rTZzu+/N7CgA4lraiGD9vFWgYo/ap31MTvWO
         izW4Byrt8c5/UbHRdMJuFPTUHWn68zRckOwMhhtTsKgExEpgYclhGzZaVyZpX/ITRh6c
         ED8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+uOWPFzzCIa7OYqY/m1Q3ZpjqDPg+5pHoY+BALxZ/U=;
        b=RvLaeQZ+cl1ttVJCvs4k1DrrlG208otYvCs1dCldDo44DzwOiSgflv05wcf0ZDiGlZ
         lTpVNl7fS/0X0tz+q70SOxcafO3SkR6zq5pE6hAviltVpBfgXNjxq+C/LtG6l3x+AMsY
         CdOi2rnw2w+/cPkR92+V3JH30b3FgSOunkSvKagmqDGxHoOBiR5a1O9em73E8wJktnbj
         4T6lIuX4Fm2jwPbZyamYW1/KFRLn64mHk1Qsage7ajHnd9ER/avSbCfkHq8NndzUZH6R
         wX4zsHsucStm5n5AG3HrxUVdWKrbnMj5xuy/iTb/rnoB+QC9mOEhoD5BZZjPJ+RSyucS
         wg0g==
X-Gm-Message-State: AOAM5312R1KGVhjTqj5Mq2AdItW4UFg8lDm0cl61tgyu4cDABZFxyfuh
        G4F54TkjORH8FLo4pTpeBpiNP8JTbiN1LYvnBnPG8QwsWn6O3w==
X-Google-Smtp-Source: ABdhPJxHwDkk2RC7PSi6k/SLb9+txpNmUX6H23sBPggngMR9pIJX2L7M/PBPNvFd01zy6xoKYhf/pi55HjzF21w3+1U=
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr1185265ljk.40.1614331249049;
 Fri, 26 Feb 2021 01:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
 <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
 <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com> <CAKXUXMyShHc8wu1HhVvr5tJYNL+sc_Yc-mfeoosK6hAL-HF_gQ@mail.gmail.com>
In-Reply-To: <CAKXUXMyShHc8wu1HhVvr5tJYNL+sc_Yc-mfeoosK6hAL-HF_gQ@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 26 Feb 2021 14:50:48 +0530
Message-ID: <CABJPP5BTLzQHVBtyqHofiRxZ4QkQ-OxBECvnQJE8e-yKmuUJWA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:29 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 7:08 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:
> > > > Add a new verbose mode to checkpatch. The verbose test
> > > > descriptions are read from the checkpatch documentation
> > > > file at `Documentation/dev-tools/checkpatch.rst`.
> > > >
> > > > The verbose mode is optional and can be enabled by the
> > > > flag -v or --verbose.
> > > >
> > > > The documentation file is only parsed by checkpatch.pl
> > > > if the verbose mode is enabled. The verbose mode can
> > > > not be used together with the --terse option.
> > >
> > > I don't have any real objection to this patch set, but as this
> > > might be added to the Documentation tree and in .rst format,
> > > perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> > > some opinion.
> > >
> > > Also I do not want to be a maintainer of this .rst file and
> > > likely neither Jon nor Mauro would either.  Perhaps you?
> > >
> >
> > I could take it up if everybody is okay with it!
> >
>
> And as I set Dwaipayan on this task on documenting checkpatch, I will
> assist in maintaining this file as well. I will also pull some strings
> to increase chances that Dwaipayan becomes a longer-term member in
> this community and on this maintainer task.
>
Sounds nice to me! I would definitely love to remain as a active
member even after the mentorship period ends. So I think this is a good
start :)

> > > Ideally, the patch order would be reversed so the .rst file
> > > is added first, then checkpatch updated to use it.
> > >
> >
> > Sure, if Jonathan or Mauro has no objections to it, I will be happy
> > to resend it so that it can be picked up properly.
> >
> > > And _a lot_ more types and descriptive content should be added.
> >
> > Yes that's for sure. If this makes it I will try to get all of the
> > other types in.
>
> I agree as well, probably a critical mass for inclusion is that we
> have at least 25% (so roughly 50 rules) documented.
>
> > And if Lukas agrees, a little help from my fellow kernel mentees will
> > be nice as well!
> >
>
> Completely agree. I will recruit new mentees and go through the
> exercises with them, until they are ready to send proper patches to
> checkpatch.rst. As the designated maintainer of that file, you will be
> busy reviewing, consolidating that content and pushing back if it is
> not good enough for inclusion (so just as in the typical "good cop-bad
> cop" game: I will motivate and help them to submit, you make sure you
> get good content).
>
That is a nice plan! Certainly looking forward to it.

Thanks & Regards,
Dwaipayan.
