Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13623CC989
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhGROZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhGROZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 10:25:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCEC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 07:22:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b29so693012ljf.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07WbgLjlqMCtunWp4bTw36q+TjPByVCzImKvog9Kja0=;
        b=d67rQSDkpv45hkzVuF0CzRyHcXCiyBuPuIcRrauI0mr7sk4xKBjFTeUgCPlcpPg2rg
         c7FD0TZ3vUXSBJnJiKBMhkLnhhkveIpmxK5E2qr0GMn34Yeqvp2M3x0qPmezBOAeTqRv
         Aaz9rt+8iti7ZCeHgeedWt2EXCBFXxRtU1k6miYlFVE3axgWuT3MBAWQSkpKiZfKypZQ
         tr/Oj5hawM2GBTG2SUpsjP8MxCtknCxwxoHJg2cbyT7M+zpYM8ZG3l83Mw1i4F/rdtmb
         6J/dD2uBkXpv3cWOqbUPb0EV1VzurMnrG/2sciZ4tyD7dqDbORYxsZpB1GMTgxS9FvnX
         1bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07WbgLjlqMCtunWp4bTw36q+TjPByVCzImKvog9Kja0=;
        b=Ouyo2cGIF+Y1EqzBmf2NkxMl0RFXsptc1IclzzlbRJBNku0ZQt0wA7ZxDJ4CxOoVh4
         21LlJAqVWNX3zA3T64i4NQDD6sIZ7iAD5Rw/luqegCjFWAGUya4jWcbbo8SXiC+IjH08
         CKzJIyLpSOOgFCaSLvZ/6TVWsgdRdHTkDCB1NeXyE0ZEE/stett+UxNdvo9jOgKpQlM4
         /cKqZ6jU13txIm+womOW866Wmia4yJyhU/Cmi9c1VIYojYrMz+zBZiLE8/9UP/3M2Oxa
         pAttWz5uz+XbjKE81UwrB0WxUMSB9MpmnWxWr1ksTt7gxLKr0kWgL8m4zdTnv73GexcI
         2ZFA==
X-Gm-Message-State: AOAM533YMnfW/UNvqYRuvNI9+HI7ivO2uu+SZuf6+mrszPMWRSkjl3Rf
        ZI4oy1DCwOyMgsZs1Rd6E0vjaJXJFN0cJ41ask8=
X-Google-Smtp-Source: ABdhPJzLVZPaf0fr570xSY3fw3BTm6VXA2ds6bM7mCZbQeqk6Wk0CrLGchFLqm8ZzRjo1hiHZvIz7QG9X4MIoEiTOqE=
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr18518751ljj.482.1626618166603;
 Sun, 18 Jul 2021 07:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
 <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
In-Reply-To: <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 18 Jul 2021 19:52:34 +0530
Message-ID: <CABJPP5Cyv=0EgMy-Y3AHHHAY0n1OUZ_cDH0Svd=6SkFYOwmPjA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment style
To:     Ani Sinha <ani@anisinha.ca>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 7:09 PM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
>
> > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > checkpatch maintainers, any comments?
> > >
> > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > >
> > > > The preferred style for long (multi-line) comments is:
> > > >
> > > > .. code-block:: c
> > > >
> > > >       /*
> > > >        * This is the preferred style for multi-line
> > > >        * comments in the Linux kernel source code.
> > > >        * Please use it consistently.
> > > >        *
> > > >        * Description:  A column of asterisks on the left side,
> > > >        * with beginning and ending almost-blank lines.
> > > >        */
> > > >
> > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > non-networking related changes. This patch adds this rule.
> > > >
> > > > Tested with
> > > > $ cat drivers/net/t.c
> > > >     /* foo */
> > > >
> > > >     /*
> > > >      * foo
> > > >      */
> > > >
> > > >     /* foo
> > > >      */
> > > >
> > > >     /* foo
> > > >      * bar */
> > > >
> > > > $ ./scripts/checkpatch.pl -f drivers/net/t.c
> > > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > > line #1: FILE: drivers/net/t.c:1:
> > > > +    /* foo */
> > > >
> > > > WARNING: networking block comments don't use an empty /* line, use /* Comment...
> > > > line #4: FILE: drivers/net/t.c:4:
> > > > +    /*
> > > > +     * foo
> > > >
> > > > WARNING: Block comments use a trailing */ on a separate line
> > > > line #11: FILE: drivers/net/t.c:11:
> > > > +     * bar */
> > > >
> > > > total: 0 errors, 3 warnings, 0 checks, 11 lines checked
> > > >
> > > >
> > > > For a non-networking related code we see the following when run for
> > > > the same file:
> > > >
> > > > $ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
> > > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > > line #1: FILE: arch/x86/kernel/t.c:1:
> > > > +    /* foo */
> > > >
> > > > WARNING: Block comments use a leading /* on a separate line
> > > > line #7: FILE: arch/x86/kernel/t.c:7:
> > > > +    /* foo
> > > >
> > > > WARNING: Block comments use a leading /* on a separate line
> > > > line #10: FILE: arch/x86/kernel/t.c:10:
> > > > +    /* foo
> > > >
> > > > WARNING: Block comments use a trailing */ on a separate line
> > > > line #11: FILE: arch/x86/kernel/t.c:11:
> > > > +     * bar */
> > > >
> > > > total: 0 errors, 4 warnings, 11 lines checked
> > > >
> > > > In the second case, there is no warning on line 4 and in the first
> > > > case, there is no warning on line 10.
> > > >
> >
> > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
>
> OK. However, I fail to see how your above comment is useful without any
> suggestion as to how to improve the commit log. I find having some test
> data with the commit message valuable so that there is some sort of record
> as to how the change was tested and with what arguments. Beyond that this
> is not something I am really worried about. The commit message can be
> modified and improved in any way reviewers like.
>

A simple tested with:
$cat test.c
/* This is a
 * multi-line comment
 */

would have worked IMO. The commit log proposed is highly
incomprehensible as to what the patch adds. I don't find
it readable either.

> >
> > Now to the feature you are proposing:
> >
> > I do not think that it is good if checkpatch would point out a quite
> > trivial syntactic issue that probably is currently violated many times
> > (>10,000 or even >100,000 times?) in the overall repository. That will
> > make checkpatch warn on many commits with this check and divert the
> > attention from other checks that are more important than the style of
> > starting comments.
>
> I have some strong opinions on this. Just because a rule has been violated
> in the past does not mean it can continue to be violated in the future.
> When violating patches were pushed, perhaps the commenting rule was not in
> place? Perhaps, due to the absense of the checkpatch rule, the author of
> the patch did not pay attention to the comment rule which, btw, exists in
> written form in the kernel doc? Perhaps the people who reviewed the patch
> overlooked it because of the very same reason - checkpatch allowed it?
> If we put the rule in checkpatch, what it means is that all future commits
> will not ignore the commneting rule because checkpatch will draw
> attention to it. Further, this means that there will be potentially no new
> violations. While that is being ensured, we can incrementally fix the
> existing code elsewhere in the tree so that eventually we can converge (no
> violations of this rule anywhere in the kernel source tree).
>

Comment style is one of the top violations we have in the kernel today.
It's a rather trivial thing. See the top checkpatch rule violations:

1797862 CHECK:LONG_LINE:
667040 CHECK:CAMELCASE:
247672 ERROR:SPACING:
168415 CHECK:PARENTHESIS_ALIGNMENT:
124413 CHECK:SPACING:
108615 WARNING:LEADING_SPACE:
64225 CHECK:LINE_SPACING:
54424 CHECK:PREFER_KERNEL_TYPES:
45502 CHECK:BIT_MACRO:
43045 WARNING:BLOCK_COMMENT_STYLE:

I highly disagree that it's because checkpatch allowed it.
We wouldn't be seeing such a high quantity of
other violations otherwise which checkpatch doesn't like.

Coming to what adding this change would mean:
$ git grep -P "^\s*/\*\s*[^/\*]+$" | wc -l
80635

This shall triple the number of WARNING:BLOCK_COMMENT_STYLE
violations. Not sure that's a good thing. And even more unsure
that's a thing anyone should even attempt fixing with other
important things existing.

Dwaipayan.
