Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26703CC9B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGRPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhGRPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 11:08:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C30C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 08:05:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o4so11453061pgs.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fDw/ha5zjGj8owgUVOsPzCfgoiM+JmH5+kl6Ian73s8=;
        b=myhRqoAjAHKqS22/UycYGaYrPaTHV7Yvc7TrG/mTAozPz1WyUf2nmk1tjULGAaNr+k
         VEsYPveySKTj/1KH+CZ6GsIizGfF1Sg/+LdoalBOl8xN3HQNgt5xcyn46UMqxvS7ghFv
         O0BVFmIu8b5GkhNQBvYW/3Wamkr8WZQVnD9ftjlZ/VWro5CtEzUg5LgfWfNV9nmuV7YP
         z0UZ8zLMG9W5zhH9AQkucdehcPKpFt65X/pJvCtplFR+dMYNHbBO68z9XsPWoIubacwc
         4RG2kylP1BraD/8SSzDcIfyCi+98Zul6rSqqbQLqhZB3oiiPXt7heiqNx/21/SsAB0Hf
         bsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fDw/ha5zjGj8owgUVOsPzCfgoiM+JmH5+kl6Ian73s8=;
        b=looaLjWsQyU9gm8f2s4Joqee9NNqf5Khu2AaIgzwqbjtFUNOYeecuXq74juEvtVH/3
         YqYUJDwkzo6T/4cg+SwboFt9dUXudB8W9KCKnOE3d/1hYCoBN+wkltquzvgSPfQXBM9M
         6pFzElCpXU2Xfx/9wAo7VPw5f0O6Atv8+f9cS4d4RGDOVTX4OaWKOTWfnJZzTy0ZLFQA
         qHmTiB0Cre3tFzajpSvowMUu7iM1HAjSjdQ7aNJOrHZtZoulmDkKeAmmRIUp/WfcfoqU
         Hr0/FtKfhqF10m+3sBMpRlvDgmWPVehgTYzJN4XT4W8uAAoYsrTLHMg7PYKmKSxBQEKh
         S6tA==
X-Gm-Message-State: AOAM530rjmmvTFgaGNtqyjfLVU2TnPMPiMy0IKzfQxB+xOLlP5iMUMcA
        VdQxqY165nIPAQOUKMM5dma/wA==
X-Google-Smtp-Source: ABdhPJwgyniWo0EoEmwg5R+KaZayZkFU0JdIApb6ZTR2U/ykbvBnMl7GuU2ElGlH3VEDw/wWSI4VjQ==
X-Received: by 2002:a65:4382:: with SMTP id m2mr20543865pgp.205.1626620716757;
        Sun, 18 Jul 2021 08:05:16 -0700 (PDT)
Received: from ani-ubuntu ([115.96.122.116])
        by smtp.googlemail.com with ESMTPSA id 11sm18724564pge.7.2021.07.18.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 08:05:16 -0700 (PDT)
Date:   Sun, 18 Jul 2021 20:34:59 +0530 (IST)
From:   Ani Sinha <ani@anisinha.ca>
X-X-Sender: ani@ani-ubuntu
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <CABJPP5Cyv=0EgMy-Y3AHHHAY0n1OUZ_cDH0Svd=6SkFYOwmPjA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2107182026070.56046@ani-ubuntu>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
 <CABJPP5Cyv=0EgMy-Y3AHHHAY0n1OUZ_cDH0Svd=6SkFYOwmPjA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Jul 2021, Dwaipayan Ray wrote:

> On Sun, Jul 18, 2021 at 7:09 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> >
> >
> > On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
> >
> > > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > >
> > > > checkpatch maintainers, any comments?
> > > >
> > > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > > >
> > > > > The preferred style for long (multi-line) comments is:
> > > > >
> > > > > .. code-block:: c
> > > > >
> > > > >       /*
> > > > >        * This is the preferred style for multi-line
> > > > >        * comments in the Linux kernel source code.
> > > > >        * Please use it consistently.
> > > > >        *
> > > > >        * Description:  A column of asterisks on the left side,
> > > > >        * with beginning and ending almost-blank lines.
> > > > >        */
> > > > >
> > > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > > non-networking related changes. This patch adds this rule.
> > > > >
> > > > > Tested with
> > > > > $ cat drivers/net/t.c
> > > > >     /* foo */
> > > > >
> > > > >     /*
> > > > >      * foo
> > > > >      */
> > > > >
> > > > >     /* foo
> > > > >      */
> > > > >
> > > > >     /* foo
> > > > >      * bar */
> > > > >
> > > > > $ ./scripts/checkpatch.pl -f drivers/net/t.c
> > > > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > > > line #1: FILE: drivers/net/t.c:1:
> > > > > +    /* foo */
> > > > >
> > > > > WARNING: networking block comments don't use an empty /* line, use /* Comment...
> > > > > line #4: FILE: drivers/net/t.c:4:
> > > > > +    /*
> > > > > +     * foo
> > > > >
> > > > > WARNING: Block comments use a trailing */ on a separate line
> > > > > line #11: FILE: drivers/net/t.c:11:
> > > > > +     * bar */
> > > > >
> > > > > total: 0 errors, 3 warnings, 0 checks, 11 lines checked
> > > > >
> > > > >
> > > > > For a non-networking related code we see the following when run for
> > > > > the same file:
> > > > >
> > > > > $ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
> > > > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > > > line #1: FILE: arch/x86/kernel/t.c:1:
> > > > > +    /* foo */
> > > > >
> > > > > WARNING: Block comments use a leading /* on a separate line
> > > > > line #7: FILE: arch/x86/kernel/t.c:7:
> > > > > +    /* foo
> > > > >
> > > > > WARNING: Block comments use a leading /* on a separate line
> > > > > line #10: FILE: arch/x86/kernel/t.c:10:
> > > > > +    /* foo
> > > > >
> > > > > WARNING: Block comments use a trailing */ on a separate line
> > > > > line #11: FILE: arch/x86/kernel/t.c:11:
> > > > > +     * bar */
> > > > >
> > > > > total: 0 errors, 4 warnings, 11 lines checked
> > > > >
> > > > > In the second case, there is no warning on line 4 and in the first
> > > > > case, there is no warning on line 10.
> > > > >
> > >
> > > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
> >
> > OK. However, I fail to see how your above comment is useful without any
> > suggestion as to how to improve the commit log. I find having some test
> > data with the commit message valuable so that there is some sort of record
> > as to how the change was tested and with what arguments. Beyond that this
> > is not something I am really worried about. The commit message can be
> > modified and improved in any way reviewers like.
> >
>
> A simple tested with:
> $cat test.c
> /* This is a
>  * multi-line comment
>  */
>
> would have worked IMO. The commit log proposed is highly
> incomprehensible as to what the patch adds. I don't find
> it readable either.

OK if there is any interest in this patch (which atm does not seem to be
any), I will shorten the commit log as per the above suggestion.

>
> > >
> > > Now to the feature you are proposing:
> > >
> > > I do not think that it is good if checkpatch would point out a quite
> > > trivial syntactic issue that probably is currently violated many times
> > > (>10,000 or even >100,000 times?) in the overall repository. That will
> > > make checkpatch warn on many commits with this check and divert the
> > > attention from other checks that are more important than the style of
> > > starting comments.
> >
> > I have some strong opinions on this. Just because a rule has been violated
> > in the past does not mean it can continue to be violated in the future.
> > When violating patches were pushed, perhaps the commenting rule was not in
> > place? Perhaps, due to the absense of the checkpatch rule, the author of
> > the patch did not pay attention to the comment rule which, btw, exists in
> > written form in the kernel doc? Perhaps the people who reviewed the patch
> > overlooked it because of the very same reason - checkpatch allowed it?
> > If we put the rule in checkpatch, what it means is that all future commits
> > will not ignore the commneting rule because checkpatch will draw
> > attention to it. Further, this means that there will be potentially no new
> > violations. While that is being ensured, we can incrementally fix the
> > existing code elsewhere in the tree so that eventually we can converge (no
> > violations of this rule anywhere in the kernel source tree).
> >
>
> Comment style is one of the top violations we have in the kernel today.
> It's a rather trivial thing. See the top checkpatch rule violations:
>
> 1797862 CHECK:LONG_LINE:
> 667040 CHECK:CAMELCASE:
> 247672 ERROR:SPACING:
> 168415 CHECK:PARENTHESIS_ALIGNMENT:
> 124413 CHECK:SPACING:
> 108615 WARNING:LEADING_SPACE:
> 64225 CHECK:LINE_SPACING:
> 54424 CHECK:PREFER_KERNEL_TYPES:
> 45502 CHECK:BIT_MACRO:
> 43045 WARNING:BLOCK_COMMENT_STYLE:
>
> I highly disagree that it's because checkpatch allowed it.
> We wouldn't be seeing such a high quantity of
> other violations otherwise which checkpatch doesn't like.
>

Perhaps the subsystems maintainers should mandatorily make sure the
patches they apply pass checkpatch? It is something like a pre-commit
hook where the commit fails if the pre-commit checks do not pass.

> Coming to what adding this change would mean:
> $ git grep -P "^\s*/\*\s*[^/\*]+$" | wc -l
> 80635
>
> This shall triple

43045 -> 80635 is barely double, not triple.

the number of WARNING:BLOCK_COMMENT_STYLE
> violations. Not sure that's a good thing. And even more unsure
> that's a thing anyone should even attempt fixing with other
> important things existing.

A rule without enforcement mechanism through tooling is useless. I rest my
case.

Ani

