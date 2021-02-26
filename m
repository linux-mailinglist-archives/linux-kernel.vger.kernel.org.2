Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC22325D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBZGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZGAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:00:31 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:59:51 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 81so4879722iou.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUbJkX3+ChwFs5viSnYM7S9ECtxTPFKeIwcxjjxFkE8=;
        b=e3YOIj91iZfaskr8kUU3POmC1+y3wMjvg+H27v7mBd7E/msI941MLffxWLme+copNS
         jDHFWkKw1YeFJs5PVKrcMmcK4LJ9gRxLZdWaQ4f7aGjC/NgfYNOORFaowoz1Su9//5rg
         xn4JQ61vEP1+oLtotjYKy3DshBwjnGNGhyskbW+Lz1f7vKSJwhMB70+Uc1MlA4cL7SsR
         E/hjE4UYPGhviTCkwNXgV4R74Fgx2IAHJggbCqqC5/8MqqQTa4quNpjLR1+ctf3mdeaC
         jQbd0rD39oZroLEkgmFyNPJccNMHp8aRQBOX4ihMkaderKRB+nq6FzmQBHRbj3S0+FBW
         Nzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUbJkX3+ChwFs5viSnYM7S9ECtxTPFKeIwcxjjxFkE8=;
        b=hRa7YbkMmAUcNpgVEe3ahWZfDnNxujrxjgFF0f8WvqKxFvzWqZp9iOQ8gmU4XvwPzG
         WP//f2heBXeeKzwXxxN6iaZtzxQn0TVpuK18RThBqlCXKOVbrpKeFex34K6OEuKjQqXH
         eJByQrM3vhcDhd2VBoI7VQxIt1kMOZK9PoemI1gKiti/D0MSZJT9XwyGul0O18amSh6n
         /5fnPmimJ7N4Suf0/4Qc7JCEmXi5CYEgP9StF+1ihjcXR9MCt+bivJV5WCXCsdECx+IH
         uhs9ZPWQtvQbbP+jLttEVC5LvLEVUB9sWFHzEsbapnlPHv1lf7pgFgdehMXtiwzwmWx3
         Fqog==
X-Gm-Message-State: AOAM533S8EUjTqVpO+tmPgE2naPRzumLPQEwgHwPcrwJm6xCHE8kWAPf
        NyYPqMiObVBJ6de0Uq4Asu+Q1MspfKrLGofc5tyhQTS70mQ=
X-Google-Smtp-Source: ABdhPJzuSg1UQWeKsgrDpYfnjKaISZo81CZ+CD+r3v2tNd4ZN9NqxgPQtyYHWp0llkR1l6tNb6+g5hOxTccejJtgdoQ=
X-Received: by 2002:a02:866d:: with SMTP id e100mr1347002jai.139.1614319190497;
 Thu, 25 Feb 2021 21:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
 <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com> <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
In-Reply-To: <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 26 Feb 2021 06:59:39 +0100
Message-ID: <CAKXUXMyShHc8wu1HhVvr5tJYNL+sc_Yc-mfeoosK6hAL-HF_gQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 7:08 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:
> > > Add a new verbose mode to checkpatch. The verbose test
> > > descriptions are read from the checkpatch documentation
> > > file at `Documentation/dev-tools/checkpatch.rst`.
> > >
> > > The verbose mode is optional and can be enabled by the
> > > flag -v or --verbose.
> > >
> > > The documentation file is only parsed by checkpatch.pl
> > > if the verbose mode is enabled. The verbose mode can
> > > not be used together with the --terse option.
> >
> > I don't have any real objection to this patch set, but as this
> > might be added to the Documentation tree and in .rst format,
> > perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> > some opinion.
> >
> > Also I do not want to be a maintainer of this .rst file and
> > likely neither Jon nor Mauro would either.  Perhaps you?
> >
>
> I could take it up if everybody is okay with it!
>

And as I set Dwaipayan on this task on documenting checkpatch, I will
assist in maintaining this file as well. I will also pull some strings
to increase chances that Dwaipayan becomes a longer-term member in
this community and on this maintainer task.

> > Ideally, the patch order would be reversed so the .rst file
> > is added first, then checkpatch updated to use it.
> >
>
> Sure, if Jonathan or Mauro has no objections to it, I will be happy
> to resend it so that it can be picked up properly.
>
> > And _a lot_ more types and descriptive content should be added.
>
> Yes that's for sure. If this makes it I will try to get all of the
> other types in.

I agree as well, probably a critical mass for inclusion is that we
have at least 25% (so roughly 50 rules) documented.

> And if Lukas agrees, a little help from my fellow kernel mentees will
> be nice as well!
>

Completely agree. I will recruit new mentees and go through the
exercises with them, until they are ready to send proper patches to
checkpatch.rst. As the designated maintainer of that file, you will be
busy reviewing, consolidating that content and pushing back if it is
not good enough for inclusion (so just as in the typical "good cop-bad
cop" game: I will motivate and help them to submit, you make sure you
get good content).

Lukas
