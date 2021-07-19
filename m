Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85A3CCE23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhGSG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhGSG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:58:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A58C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 23:55:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w15so18014127pgk.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+6yGoau3aQvc6RIl0I2KR/4JCvjXnSHM4sVzJrYS06E=;
        b=YyMrE+FD5G+7FSMOJSFu4WYFJsnsgzQFoEJoUueIDQpJOym0IAIC+tgfbZxHsAUyK6
         jUSuRJQkEuXi+47Tvg4SE5R71SfxeR8qxHhtwLrFx7zyas7n+k7Jzcy89iV1hg316vwx
         +KVHHnzeLdyeAr2SrPcEWpTvTRKTK+ErFq/+/j7/ofp6jMSwE4Y/Nore6I9lSoyMWsNa
         bCT0mw/UPaulIFAmbNlHurTvWXkLE7pBasyYzMbPrPuz5IrdTjAZ3+d2Nqyg9SynL8GG
         0FI3ryDpmgqM+/rnKugn8x0Q8ZPoIu5XwBB8QEGX2JkvVu+zXcQysvEmLEBJ6F9ef25K
         F7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+6yGoau3aQvc6RIl0I2KR/4JCvjXnSHM4sVzJrYS06E=;
        b=GK4BvzRGX2VSk1eMv+CcvbKvrgiQHkRa2EtXu/KKJQAeBf9XJKbkQPTc2FKHp8dOP5
         vE3M5anPFdlW50Wg7HlgoQkhyRpP0EY580Z23pWrIMYZ83OtT10IedFStqX7a941G243
         0/E1+P0WsqbgHYJs1j7RTFH5XExOq1PiLvj4XIYdMAK379HCZYqtYTM8mz3ihqqbPzQ8
         TG3emj8auHdtm39nieID1aMwvd+fZ4PCsF0B4HbdE4vYpXC+CuFCqHpAEfl1usYxgZUm
         /v+Sn+1T0G44Olpigp+ZzsSNy6vv1YmW9OJkXZrIUYN9LRS5QNOw0ew/FFMLe+qhq1ax
         88zQ==
X-Gm-Message-State: AOAM531YSRzL3d/j625jhTWsjaKYHHu9R7o+5SpEJ3HvHHKUcrF4LTfd
        SCocEmn1EA7UcKp/vPVOzicFGQ==
X-Google-Smtp-Source: ABdhPJxG1rvnF9yI/mCoWeevIkrdHkOS6c4LlopRJQZePwTOvDI4YMYzpxAvaOacyc8fcMlUhyTjMw==
X-Received: by 2002:a62:1bc7:0:b029:328:f2c:8ff1 with SMTP id b190-20020a621bc70000b02903280f2c8ff1mr24353758pfb.18.1626677738126;
        Sun, 18 Jul 2021 23:55:38 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.137.169])
        by smtp.googlemail.com with ESMTPSA id g19sm4946096pjl.25.2021.07.18.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 23:55:37 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Mon, 19 Jul 2021 12:25:26 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Ani Sinha <ani@anisinha.ca>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
 <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com> <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo> <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2021, Lukas Bulwahn wrote:

> On Mon, Jul 19, 2021 at 7:28 AM Ani Sinha <ani@anisinha.ca> wrote:
> >
> >
> >
> > On Sun, 18 Jul 2021, Joe Perches wrote:
> >
> > > On Sun, 2021-07-18 at 19:08 +0530, Ani Sinha wrote:
> > > > On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
> > > > > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > > > checkpatch maintainers, any comments?
> > > > > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > > > > > > The preferred style for long (multi-line) comments is:
> > > > > > >
> > > > > > > .. code-block:: c
> > > > > > >
> > > > > > >       /*
> > > > > > >        * This is the preferred style for multi-line
> > > > > > >        * comments in the Linux kernel source code.
> > > > > > >        * Please use it consistently.
> > > > > > >        *
> > > > > > >        * Description:  A column of asterisks on the left side,
> > > > > > >        * with beginning and ending almost-blank lines.
> > > > > > >        */
> > > > > > >
> > > > > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > > > > non-networking related changes. This patch adds this rule.
> > > []
> > > > > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
> > > >
> > > > OK. However, I fail to see how your above comment is useful without any
> > > > suggestion as to how to improve the commit log. I find having some test
> > > > data with the commit message valuable so that there is some sort of record
> > > > as to how the change was tested and with what arguments. Beyond that this
> > > > is not something I am really worried about. The commit message can be
> > > > modified and improved in any way reviewers like.
> > > >
> > > > >
> > > > > Now to the feature you are proposing:
> > > > >
> > > > > I do not think that it is good if checkpatch would point out a quite
> > > > > trivial syntactic issue that probably is currently violated many times
> > > > > (>10,000 or even >100,000 times?) in the overall repository. That will
> > > > > make checkpatch warn on many commits with this check and divert the
> > > > > attention from other checks that are more important than the style of
> > > > > starting comments.
> > > >
> > > > I have some strong opinions on this. Just because a rule has been violated
> > > > in the past does not mean it can continue to be violated in the future.
> > >
> > > Intensity of opinion varies considerably here.
> > >
> > > > > Further, some evaluation by Aditya shows that the distinction between
> > > > > NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
> > > > > easily split as currently encoded in the checkpatch script,
> > > > > https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
> > > > > So, this checkpatch check is largely wrong already as of now and most
> > > > > probably ignored by many contributors.
> > >
> > > The only reason the rule exists at all is because the networking maintainer
> > > was constantly telling people to change the comment style in patches.
> > >
> > > I don't care one way or another.
> > >
> > > // comments are fine
> > > /* comments are fine */
> > >
> > > In networking, multiline comments are almost exclusively like
> > > what Linus himself does not like:
> > >
> > >       /* comment
> > >        * ...
> > >        */
> > >
> > > but in other subsystems, the styles of multiline comments varies.
> > >
> > > Either works, there is no single standard.
> > >
> >
> > OK then in that case, maybe update
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.14-rc2#n584
> >
>
> The rule may still hold.
>

Hence, I do not see why we cannot add this rule to checkpatch. If the
reviewer likes the other style of commenting they can always ask for a
correction. Having checkpatch agree with Linus' preferred style of
commenting and the preferred documeted style of commenting (which seems to
be the same) does make everything uniform and agreeable.

> > It is confusing to patch submitters (and it happened to me with a recent
> > patch) that the reviewer insists on a particular commenting style when
> > checkpatch does not enforce it. Its confusing for reviewers too.
> >
>
> I think this is more about the confusion of what you should really
> expect from checkpatch.
>
> Checkpatch does some checking, but this checking is not sound, i.e.,
> perfect wrt. expectations on submissions, i.e., there are various
> cases where checkpatch's suggestion is NOT the
> community's/maintainer's preference. Some rules are even quite basic
> heuristics, and can get confused by unexpected patterns.
>
> Hence, in its current state, with all rules enabled, you could not
> enforce a checkpatch pre-commit hook as you suggested.
>
> Further, checkpatch is not complete either: just because checkpatch
> did not complain on some stylistic issues does not mean that all rules
> on style that might be automatically checkable are followed in a
> patch. During the patch submission, reviewers might still ask for
> further stylistic improvements, even if checkpatch did not point them
> out.
>
> Contributing to checkpatch improvements is certainly welcome. However,
> it is a non-trivial task to include checks that make checkpatch more
> usable (more accepted among developers and maintainers) with the
> current submission practice and the currently existing code in the
> kernel repository.
>
> Lukas
>
> >
> > > And as the referenced link by Aditya somewhat shows, the nominal
> > > rule compliance varies by the age of the code.  No one care much
> > > about code submitted a couple decades ago for subsystems and drivers
> > > that are effectively obsolete...
> > >
> > >
> > >
>
