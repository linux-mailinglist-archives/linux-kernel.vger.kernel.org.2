Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B53CCDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhGSGCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhGSGCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:02:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F0C061765
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:59:07 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v189so26052722ybg.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSPuZ3a4uXlxuhdBRuBaWJal0g7rnXic+tEbYjedUiM=;
        b=MYLiyAndFeOsRMonNV1uTiW1aT0ReE48tJbTy1f2ohcCd8J5LHXGtGKeVLU44Qpgq4
         gXJ1BuMSB2lybCeZhBdJ21z53jidFmfOC15Stc+rlQmv3PlK0UPx1PTvrkAS+Odjn/If
         58IKyvppHNaNVlLw48TTFaw4E35JJGsmHVLLkGfs09kaSyFcITGyafYs+nCjm1p7tO6I
         bvspldhTVKurrPtqVzfB0l0PrJ7UaxhsqjUcolV8rGdbj2dhb0dkBwjBavEXiynebszs
         oploIffizzn8I1VXNzfa7uV4zNpKxGw9QnHe9QwBk0EiPg6PwqwIDmUpbUdrrpdYqjpQ
         c7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSPuZ3a4uXlxuhdBRuBaWJal0g7rnXic+tEbYjedUiM=;
        b=ahu74F9AH8v7FspSlth9zjZIMIistTGXSzNkZamM7+33Nv/8ektcDAaJab4FUZwwmk
         X7xSJzeNRbb2X194pTLSTW2jVfXNH7Al9/Hr8UDHc2seKQMQ7mveJ57MU65m9tTc3mWk
         jZw8te5JVXBkgH0OdPKVUph4MZ/MLO0cg+exIQA6Cz2euawqpmDODJNrbhRXuxmYU2WN
         Ec2tnld4GJKsBUL2MCbwVMDQdvAjwVrckkQ+TtGGMXrnygcBAUOkXyy3/TPbXftJssGY
         Mo59MnlJij0Fp5JKNtOwlnphF20/1HKKk8+3aGVM3eDXiHd71b21YuuThYyPgRLVUBRl
         TyFA==
X-Gm-Message-State: AOAM531OXPottlYUrBBUNqgv3qO6hhOm5aVqkdSXX7SMD4HkYB04waIf
        dhgL9vhzZwo1Atogk36etJEQTv2xolG6pJXuxHk=
X-Google-Smtp-Source: ABdhPJwJsTmcItBw+F3DLu/7zggk5LGlRZsgT7j+C1j37Eq7rUC8Q7HN300Fhqc4jnDTj7Y0K9c085VJ2XhydXQ6tzw=
X-Received: by 2002:a25:ca54:: with SMTP id a81mr9674817ybg.157.1626674346276;
 Sun, 18 Jul 2021 22:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
 <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
 <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu> <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
 <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 19 Jul 2021 07:58:55 +0200
Message-ID: <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com>
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

On Mon, Jul 19, 2021 at 7:28 AM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Sun, 18 Jul 2021, Joe Perches wrote:
>
> > On Sun, 2021-07-18 at 19:08 +0530, Ani Sinha wrote:
> > > On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
> > > > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > > checkpatch maintainers, any comments?
> > > > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > > > > > The preferred style for long (multi-line) comments is:
> > > > > >
> > > > > > .. code-block:: c
> > > > > >
> > > > > >       /*
> > > > > >        * This is the preferred style for multi-line
> > > > > >        * comments in the Linux kernel source code.
> > > > > >        * Please use it consistently.
> > > > > >        *
> > > > > >        * Description:  A column of asterisks on the left side,
> > > > > >        * with beginning and ending almost-blank lines.
> > > > > >        */
> > > > > >
> > > > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > > > non-networking related changes. This patch adds this rule.
> > []
> > > > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
> > >
> > > OK. However, I fail to see how your above comment is useful without any
> > > suggestion as to how to improve the commit log. I find having some test
> > > data with the commit message valuable so that there is some sort of record
> > > as to how the change was tested and with what arguments. Beyond that this
> > > is not something I am really worried about. The commit message can be
> > > modified and improved in any way reviewers like.
> > >
> > > >
> > > > Now to the feature you are proposing:
> > > >
> > > > I do not think that it is good if checkpatch would point out a quite
> > > > trivial syntactic issue that probably is currently violated many times
> > > > (>10,000 or even >100,000 times?) in the overall repository. That will
> > > > make checkpatch warn on many commits with this check and divert the
> > > > attention from other checks that are more important than the style of
> > > > starting comments.
> > >
> > > I have some strong opinions on this. Just because a rule has been violated
> > > in the past does not mean it can continue to be violated in the future.
> >
> > Intensity of opinion varies considerably here.
> >
> > > > Further, some evaluation by Aditya shows that the distinction between
> > > > NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
> > > > easily split as currently encoded in the checkpatch script,
> > > > https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
> > > > So, this checkpatch check is largely wrong already as of now and most
> > > > probably ignored by many contributors.
> >
> > The only reason the rule exists at all is because the networking maintainer
> > was constantly telling people to change the comment style in patches.
> >
> > I don't care one way or another.
> >
> > // comments are fine
> > /* comments are fine */
> >
> > In networking, multiline comments are almost exclusively like
> > what Linus himself does not like:
> >
> >       /* comment
> >        * ...
> >        */
> >
> > but in other subsystems, the styles of multiline comments varies.
> >
> > Either works, there is no single standard.
> >
>
> OK then in that case, maybe update
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.14-rc2#n584
>

The rule may still hold.

> It is confusing to patch submitters (and it happened to me with a recent
> patch) that the reviewer insists on a particular commenting style when
> checkpatch does not enforce it. Its confusing for reviewers too.
>

I think this is more about the confusion of what you should really
expect from checkpatch.

Checkpatch does some checking, but this checking is not sound, i.e.,
perfect wrt. expectations on submissions, i.e., there are various
cases where checkpatch's suggestion is NOT the
community's/maintainer's preference. Some rules are even quite basic
heuristics, and can get confused by unexpected patterns.

Hence, in its current state, with all rules enabled, you could not
enforce a checkpatch pre-commit hook as you suggested.

Further, checkpatch is not complete either: just because checkpatch
did not complain on some stylistic issues does not mean that all rules
on style that might be automatically checkable are followed in a
patch. During the patch submission, reviewers might still ask for
further stylistic improvements, even if checkpatch did not point them
out.

Contributing to checkpatch improvements is certainly welcome. However,
it is a non-trivial task to include checks that make checkpatch more
usable (more accepted among developers and maintainers) with the
current submission practice and the currently existing code in the
kernel repository.

Lukas

>
> > And as the referenced link by Aditya somewhat shows, the nominal
> > rule compliance varies by the age of the code.  No one care much
> > about code submitted a couple decades ago for subsystems and drivers
> > that are effectively obsolete...
> >
> >
> >
