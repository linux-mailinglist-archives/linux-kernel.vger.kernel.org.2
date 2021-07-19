Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436813CD012
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhGSI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:27:08 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40513 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhGSI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:27:06 -0400
Received: by mail-ot1-f48.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so5769380otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwusH84r9x2LzGFqnZYrdKKl2ZcND/PvCJYkrIcjE98=;
        b=XBPjXyB4aNXLeANEjJ14SHcEJi/z6KEwmweKhzlTJh+2MPbrr81+MFqP9nwEmuXQS4
         2ksfYfK5/YammV87uiWL28u1uKHvCydxExYICVtsAwzv3wIphd/cYXQseGrsp6hHR7R5
         H96lHE6z3K368IvUXgA4TtVcGomO8VcDkpghqpBVbI0I6ysUgW4xM3s1l22xbmOMDbH3
         K4IXQXvaCoKOWu4YYJXdFQaI2X4rCFuxhWAVUTdkbP6A0u6xb8XGVnm8bh9dMKz7DP6S
         MSuP43fvCfkd1kISFuhg9d1IizxRjqyf0tIwgnSnBywOggfimd3GFDgVwBuUnPk0RsP/
         EqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwusH84r9x2LzGFqnZYrdKKl2ZcND/PvCJYkrIcjE98=;
        b=rkQ5Az0SySEBJgLbxcuM/hIB04K5hni5pDd40wMU8qtTciqk+jnEy6hCH+0nV74jKT
         IDwEeLp5V5xiQICURroLiwEw7+MTzbX1iLCIQyiFmnUI95faT5w389Q1/hPCACsh4Gj/
         kpZ95NhflT5rGr+3jn8hWBh63tJ9p+6DPbS3p6Vk8Yd/L4o5bUoEvQhya6GWO6ur5+GU
         7csHRcrGxjbxvo6bJ80LsTHJ+TguD2E1BtaK8vhTWdq12TwZ8m7G7hnKi3e9smI4nSKt
         p7HaQ+GO65zLdF7uWa6x6fPEH0wj86CemSiWI5KwudqGZvqWaiA5YWZ0Jvw4jMwEyfPX
         l1RA==
X-Gm-Message-State: AOAM532g+dzyT+ZRrRryY/Zd8FqDW/o6NVykJqrPKZaELC/LomX7Fhw2
        Z2nRMX2s4vw5/uzJzaM1m7qyCAPIKHxEgB5qvmL09C+R
X-Google-Smtp-Source: ABdhPJx4vdH3GoQuycMGgANG2swilYnbNFbFA9xysFVfgCdcDnCXejZl5UqnFbjjtHaqrfbKOLxTDKmufzD+sSNrZOo=
X-Received: by 2002:a25:f30d:: with SMTP id c13mr29482344ybs.134.1626683980682;
 Mon, 19 Jul 2021 01:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
 <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
 <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu> <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
 <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo> <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo> <4e42f2580d8b473ac7e25642b039adf73b5efe06.camel@perches.com>
 <alpine.DEB.2.22.394.2107191324330.14021@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2107191324330.14021@anisinha-lenovo>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 19 Jul 2021 10:39:29 +0200
Message-ID: <CAKXUXMyVaQ1CKiLpUAqsj9++H1QoTkP8DmdsHA44ttxOt-ov9Q@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment style
To:     Ani Sinha <ani@anisinha.ca>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:08 AM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Mon, 19 Jul 2021, Joe Perches wrote:
>
> > On Mon, 2021-07-19 at 12:25 +0530, Ani Sinha wrote:
> >
> > > I do not see why we cannot add this rule to checkpatch. If the
> > > reviewer likes the other style of commenting they can always ask for a
> > > correction. Having checkpatch agree with Linus' preferred style of
> > > commenting and the preferred documeted style of commenting (which seems to
> > > be the same) does make everything uniform and agreeable.
> >
> > Too many novice developers take checkpatch output as dicta.
> >
> > It's not.
> >
>
> Well those "novice" developers have perhaps worked in companies where
> tooling like pre-commit sanity hooks have provided immense value in
> ensuring certain basic rules and code quality is maintained across the
> board, particulay when the company scales. Existing violations did not
> deter them from adding stricter rules to make sure all future commits
> follow certain patterns. Ofcourse at the end of the day, common sense
> trumps any tooling, goes without saying.
>
> > It's just produces suggestions that should _always_ be taken
> > not very seriously.  Those suggestions should perhaps be
> > considered, but good taste should always override a brainless
> > script.
>
> At the very very least, checkpatch should lay this out in clear terms
> every time this is run. Different communities have different rules and for
> me, I always run all my patches through checkpatch to make sure that the
> patch I sent out of review at least is checkpatch clean. This makes sure
> that I am not violating any obvious code submission rules laid out by that
> community. This is particularly true for kernel community where flaming
> people for even small issues seems to be the culture!
>

You are assuming that there is THE one consistent style in the kernel
repository and within the whole kernel community. But, IMHO, there is
not; the repository is too large and the community is too diverse in
its preferences. Do an evaluation of coding style in the whole
repository and share which one rule is consistently followed in all
directories (and how many are not).

Further, checking as pre-commit hooks requires that a repository is
rather clean wrt. to rule violations, but often in the kernel, it is
not. So, you then need to clean up the existing code, which causes
dangerous large syntactic refactorings and drowns maintainers. That
has been tried, but has been not successful in the past.
Hence, with the current state, the checkpatch tool needs to be handled
much more with care and critical consideration of the state of the
actual code base and the rationales of the rules that checkpatch
points out.

Surely, we need better documentation to point out how to use
checkpatch, what the reasons for certain rules are, and why some
simply need to be ignored on certain files. Evaluations and
contributions are welcome.

> >
> > _Very_ few senior developers really care that much about any
> > particular comment style.
>
> I disagree on this.
>
> >
> > These are the same senior developers that would be burdened
> > with unnecessary patches to review from those novice developers
> > that believe checkpatch should always be followed.
> >
>
> Well for those "novice" developers, the doc tells us to run checkpatch
> and address the complaints :
>
>  Are you sure your patch is free of silly mistakes?  You should always
>    run patches through scripts/checkpatch.pl and address the complaints it
>    comes up with.
>
>
> Anyways it seems this conversation is self serving for the kernel's sr
> developers so that they can take any stance convenient to them.
> There is no value.
