Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED63CC812
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhGRHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGRHdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 03:33:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FBC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 00:30:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r132so22328138yba.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPuKdYD+gCxw+hIq4DlYyBo14oaSLuRan7hSPXPJ5t0=;
        b=Uj84IzB7M/l56RX60HFxaoEpM4xqb5jVG0w1qT6BT2c+5hNzGRo42MsgaMPUZxnTO5
         0ueVlZ0bowE+etwjdnzpNUTn/sGpqtXVp2LKtMM0XuJjwfO41M0Ob8g7pmLpayt/uMmw
         im8m4q2WOkib6foRGYIwkmkl1dBG20HFnHMiy9c27R55+nBJxOeWPd4WoZ5v/YMxpU2M
         gg71WKnCnlGQ+kxJKL4DGjKv1RLayiYVNozNzPGz5JmUOWPOeSPelErSyEMlM94ScGw7
         96SICJO8yfM6Vby6NFeAe7vR3QqfIKy1IM7LZrxcFzm+JR6MulWBdzGu/nxYm580E/aC
         y4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPuKdYD+gCxw+hIq4DlYyBo14oaSLuRan7hSPXPJ5t0=;
        b=CzTVisI1EeT6mu/pO2RNmaLyzQiwFwjVpXpaiB5pJGa5liJBnNXp4pQRtO/Aph0SmD
         X76PY+I3/+nNaAW7j+B5aLDtKqzpsd9eaNiuZgoCFV/qCXOcmmKGd2+RN2dz4pjb5tFU
         FVY7LQbIFL0qkN2xb6RvJ09p30TjZ+tnNjmVqatPAeqvDAFXhDReNZ9btQEgEAEq+q4q
         OR3CzOGCir/a3Pg4vsNo1o/avGlGfugJvqhycHtHGzdyOo3z5n93K85OwKjZfS/Lc5lZ
         1oDvnkBV1hCxnQPBWM4Uu2wRRzImRU1ofVLwEWwuy0CyVYLTg1f8E09lLNuRNRcwpM6V
         Dyjw==
X-Gm-Message-State: AOAM533goZVGCdg+uhqknIma0+3Y/QpFwx+J/YJFl4qcBw9JkbxiTEQa
        V3niyQXP8IpTj651amtNZ8oRcGB4mzgat+2AZDA=
X-Google-Smtp-Source: ABdhPJxYF9qZ7C40AtBTfxhjXyOlPlEKsZ8sahKqtHdAauAYNHwRvI100bkiVf+27QaPlYEbNYc/9DFzVe9mzR4H2NA=
X-Received: by 2002:a25:ab26:: with SMTP id u35mr24666027ybi.151.1626593421842;
 Sun, 18 Jul 2021 00:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 18 Jul 2021 09:30:11 +0200
Message-ID: <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment style
To:     Ani Sinha <ani@anisinha.ca>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> checkpatch maintainers, any comments?
>
> On Wed, 14 Jul 2021, Ani Sinha wrote:
>
> > The preferred style for long (multi-line) comments is:
> >
> > .. code-block:: c
> >
> >       /*
> >        * This is the preferred style for multi-line
> >        * comments in the Linux kernel source code.
> >        * Please use it consistently.
> >        *
> >        * Description:  A column of asterisks on the left side,
> >        * with beginning and ending almost-blank lines.
> >        */
> >
> > It seems rule in checkpatch.pl is missing to ensure this for
> > non-networking related changes. This patch adds this rule.
> >
> > Tested with
> > $ cat drivers/net/t.c
> >     /* foo */
> >
> >     /*
> >      * foo
> >      */
> >
> >     /* foo
> >      */
> >
> >     /* foo
> >      * bar */
> >
> > $ ./scripts/checkpatch.pl -f drivers/net/t.c
> > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > line #1: FILE: drivers/net/t.c:1:
> > +    /* foo */
> >
> > WARNING: networking block comments don't use an empty /* line, use /* Comment...
> > line #4: FILE: drivers/net/t.c:4:
> > +    /*
> > +     * foo
> >
> > WARNING: Block comments use a trailing */ on a separate line
> > line #11: FILE: drivers/net/t.c:11:
> > +     * bar */
> >
> > total: 0 errors, 3 warnings, 0 checks, 11 lines checked
> >
> >
> > For a non-networking related code we see the following when run for
> > the same file:
> >
> > $ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
> > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > line #1: FILE: arch/x86/kernel/t.c:1:
> > +    /* foo */
> >
> > WARNING: Block comments use a leading /* on a separate line
> > line #7: FILE: arch/x86/kernel/t.c:7:
> > +    /* foo
> >
> > WARNING: Block comments use a leading /* on a separate line
> > line #10: FILE: arch/x86/kernel/t.c:10:
> > +    /* foo
> >
> > WARNING: Block comments use a trailing */ on a separate line
> > line #11: FILE: arch/x86/kernel/t.c:11:
> > +     * bar */
> >
> > total: 0 errors, 4 warnings, 11 lines checked
> >
> > In the second case, there is no warning on line 4 and in the first
> > case, there is no warning on line 10.
> >

Honest feedback: IMHO, your commit message is unreadable and incomprehensible.

Now to the feature you are proposing:

I do not think that it is good if checkpatch would point out a quite
trivial syntactic issue that probably is currently violated many times
(>10,000 or even >100,000 times?) in the overall repository. That will
make checkpatch warn on many commits with this check and divert the
attention from other checks that are more important than the style of
starting comments.

Further, some evaluation by Aditya shows that the distinction between
NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
easily split as currently encoded in the checkpatch script,
https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
So, this checkpatch check is largely wrong already as of now and most
probably ignored by many contributors.

I would suggest submitting patches correcting this issue for a
significant subsystem, such that this subsystem is clean of violations
and then only activate the check in checkpatch for that subsystem.
If such patches are accepted and the largest part of the kernel is
cleaned up of such violations, we should consider adding such a rule
to checkpatch.


Lukas

> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  scripts/checkpatch.pl | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > Changelog:
> > v1: initial patch
> > v2: commit log updated to reflect the output from checkpatch.pl
> >     when run against the same file both in networking and
> >     non-networking case. This helps in comparing results apples to
> >     apples.
> > v3: line numbers got lost in the commit log as git eliminated all lines
> >     starting with '#'. Fixed it by prefixing with word 'line'. The work
> >     'line' does not however appear in the checkpatch.pl output.
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 23697a6b1eaa..5f047b762aa1 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3833,6 +3833,14 @@ sub process {
> >                            "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> >               }
> >
> > +# Block comments use /* on a line of its own
> > +             if (!($realfile =~ m@^(drivers/net/|net/)@) &&
> > +                 $rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&    #inline /*...*/
> > +                 $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
> > +                 WARN("BLOCK_COMMENT_STYLE",
> > +                      "Block comments use a leading /* on a separate line\n" . $herecurr);
> > +             }
> > +
> >  # Block comments use * on subsequent lines
> >               if ($prevline =~ /$;[ \t]*$/ &&                 #ends in comment
> >                   $prevrawline =~ /^\+.*?\/\*/ &&             #starting /*
> > --
> > 2.25.1
> >
> >
