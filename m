Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C643CC95D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhGRNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhGRNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 09:42:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60FC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 06:39:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p36so13717468pfw.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=60rcoz3RcG2baJYIgEap2kwJmfAU9tTeuTQt00zmIRY=;
        b=bTr40rXzFZivgw9F73USH10vTce5h7nOgT7egTw8Y3Q9SNhwH2+yuCwscp2UEntDFF
         UsfLP5IhrtvGqfqHm7uvatxLw3cJcdpindfn4C/rwcNPCc/lMfuBl+GyJ+5ms2kR64ZA
         Ibr+ASACss9EGj+C47U7UXN5QeTJKEVxYNzre0PE/yORbtxQW6oPGtLaunxxRU3NHEuw
         4GXHCvh5Mry5Jo+ls80P3edIEDCPm5O9nxiH9MtkveoNCFX9NuE8AG7YTjlppXzxtDTt
         USQIcNAdOcCR4TMLi++No2+QN9NDk0swDY6KA2CBcWaHICk7Y3JAHf3bf48Yc/48uyGk
         aFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=60rcoz3RcG2baJYIgEap2kwJmfAU9tTeuTQt00zmIRY=;
        b=eWJ7SBr43uKOOP5xnAQpK1eGGrelGlibT8BDn+0m2Q3GNhe0mZjtiGsa70LkddzE78
         4KuouAEiE1frUzkN8i5p6lU4Sb5eAfmBiNBC6XzKy8pdC4BpSPb72krwZMRQA+Eq04No
         hD29PV4+RjfzgoO+CFSQCJVMmZ1pOI2T2FgRzVd73HlQ4fYtpta7dudSIho8PKGd0nyv
         2PFpawdxniG80+j9FlTlwIbcQs1jpvYrUJIkrTFutVtyhfnU5KR3BzQ2M7YF3A7KIcOZ
         Kx5BNNaM7p6WjTA61ujSrzJ5ERigQVzBEnjqy7JX1Y+m4EhTuZVF4wUwdJQg94WiSS1V
         YbCA==
X-Gm-Message-State: AOAM533brltZccSsKl2YZAoKyg6V+/bSOiXZMzQyQjfqrxx5eadaOdjQ
        gOm4J9XZNeqGOB23iW1ojQ23/A==
X-Google-Smtp-Source: ABdhPJzHicEbOXiHXaak8boZ7kVzIvxNk0S1DuzGMO0tTGkvKONe1pzuLuiZ2OBcw1QIGKpp2NahYg==
X-Received: by 2002:a63:530b:: with SMTP id h11mr20384989pgb.302.1626615547231;
        Sun, 18 Jul 2021 06:39:07 -0700 (PDT)
Received: from ani-ubuntu ([115.96.122.116])
        by smtp.googlemail.com with ESMTPSA id s15sm16459420pfw.207.2021.07.18.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 06:39:06 -0700 (PDT)
Date:   Sun, 18 Jul 2021 19:08:19 +0530 (IST)
From:   Ani Sinha <ani@anisinha.ca>
X-X-Sender: ani@ani-ubuntu
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Jul 2021, Lukas Bulwahn wrote:

> On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > checkpatch maintainers, any comments?
> >
> > On Wed, 14 Jul 2021, Ani Sinha wrote:
> >
> > > The preferred style for long (multi-line) comments is:
> > >
> > > .. code-block:: c
> > >
> > >       /*
> > >        * This is the preferred style for multi-line
> > >        * comments in the Linux kernel source code.
> > >        * Please use it consistently.
> > >        *
> > >        * Description:  A column of asterisks on the left side,
> > >        * with beginning and ending almost-blank lines.
> > >        */
> > >
> > > It seems rule in checkpatch.pl is missing to ensure this for
> > > non-networking related changes. This patch adds this rule.
> > >
> > > Tested with
> > > $ cat drivers/net/t.c
> > >     /* foo */
> > >
> > >     /*
> > >      * foo
> > >      */
> > >
> > >     /* foo
> > >      */
> > >
> > >     /* foo
> > >      * bar */
> > >
> > > $ ./scripts/checkpatch.pl -f drivers/net/t.c
> > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > line #1: FILE: drivers/net/t.c:1:
> > > +    /* foo */
> > >
> > > WARNING: networking block comments don't use an empty /* line, use /* Comment...
> > > line #4: FILE: drivers/net/t.c:4:
> > > +    /*
> > > +     * foo
> > >
> > > WARNING: Block comments use a trailing */ on a separate line
> > > line #11: FILE: drivers/net/t.c:11:
> > > +     * bar */
> > >
> > > total: 0 errors, 3 warnings, 0 checks, 11 lines checked
> > >
> > >
> > > For a non-networking related code we see the following when run for
> > > the same file:
> > >
> > > $ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
> > > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > > line #1: FILE: arch/x86/kernel/t.c:1:
> > > +    /* foo */
> > >
> > > WARNING: Block comments use a leading /* on a separate line
> > > line #7: FILE: arch/x86/kernel/t.c:7:
> > > +    /* foo
> > >
> > > WARNING: Block comments use a leading /* on a separate line
> > > line #10: FILE: arch/x86/kernel/t.c:10:
> > > +    /* foo
> > >
> > > WARNING: Block comments use a trailing */ on a separate line
> > > line #11: FILE: arch/x86/kernel/t.c:11:
> > > +     * bar */
> > >
> > > total: 0 errors, 4 warnings, 11 lines checked
> > >
> > > In the second case, there is no warning on line 4 and in the first
> > > case, there is no warning on line 10.
> > >
>
> Honest feedback: IMHO, your commit message is unreadable and incomprehensible.

OK. However, I fail to see how your above comment is useful without any
suggestion as to how to improve the commit log. I find having some test
data with the commit message valuable so that there is some sort of record
as to how the change was tested and with what arguments. Beyond that this
is not something I am really worried about. The commit message can be
modified and improved in any way reviewers like.

>
> Now to the feature you are proposing:
>
> I do not think that it is good if checkpatch would point out a quite
> trivial syntactic issue that probably is currently violated many times
> (>10,000 or even >100,000 times?) in the overall repository. That will
> make checkpatch warn on many commits with this check and divert the
> attention from other checks that are more important than the style of
> starting comments.

I have some strong opinions on this. Just because a rule has been violated
in the past does not mean it can continue to be violated in the future.
When violating patches were pushed, perhaps the commenting rule was not in
place? Perhaps, due to the absense of the checkpatch rule, the author of
the patch did not pay attention to the comment rule which, btw, exists in
written form in the kernel doc? Perhaps the people who reviewed the patch
overlooked it because of the very same reason - checkpatch allowed it?
If we put the rule in checkpatch, what it means is that all future commits
will not ignore the commneting rule because checkpatch will draw
attention to it. Further, this means that there will be potentially no new
violations. While that is being ensured, we can incrementally fix the
existing code elsewhere in the tree so that eventually we can converge (no
violations of this rule anywhere in the kernel source tree).

>
> Further, some evaluation by Aditya shows that the distinction between
> NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
> easily split as currently encoded in the checkpatch script,
> https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
> So, this checkpatch check is largely wrong already as of now and most
> probably ignored by many contributors.
>

If this rule is being ignored, then another option is to simply remove the
rule. A rule without eny enforcement and which is easy to ignore is bogus,
IMHO.

 > I would suggest submitting patches correcting this issue for a
> significant subsystem, such that this subsystem is clean of violations

Seems a subsystem clean of all violations is a non starter IMHO. We should
not expect any such subsystems in the tree. Rather, a better approach is
to put the rule in place today and then incrementally clean up the
subsystems of existing violations.

> and then only activate the check in checkpatch for that subsystem.
> If such patches are accepted and the largest part of the kernel is
> cleaned up of such violations, we should consider adding such a rule
> to checkpatch.

Without a tool enforcing a rule, we will never be able to converge. I am
speaking from experience of writing post commit hooks for a company which
enforced pylint violations.

Ani

 >
>
> Lukas
>
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  scripts/checkpatch.pl | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > Changelog:
> > > v1: initial patch
> > > v2: commit log updated to reflect the output from checkpatch.pl
> > >     when run against the same file both in networking and
> > >     non-networking case. This helps in comparing results apples to
> > >     apples.
> > > v3: line numbers got lost in the commit log as git eliminated all lines
> > >     starting with '#'. Fixed it by prefixing with word 'line'. The work
> > >     'line' does not however appear in the checkpatch.pl output.
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 23697a6b1eaa..5f047b762aa1 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3833,6 +3833,14 @@ sub process {
> > >                            "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> > >               }
> > >
> > > +# Block comments use /* on a line of its own
> > > +             if (!($realfile =~ m@^(drivers/net/|net/)@) &&
> > > +                 $rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&    #inline /*...*/
> > > +                 $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
> > > +                 WARN("BLOCK_COMMENT_STYLE",
> > > +                      "Block comments use a leading /* on a separate line\n" . $herecurr);
> > > +             }
> > > +
> > >  # Block comments use * on subsequent lines
> > >               if ($prevline =~ /$;[ \t]*$/ &&                 #ends in comment
> > >                   $prevrawline =~ /^\+.*?\/\*/ &&             #starting /*
> > > --
> > > 2.25.1
> > >
> > >
>
