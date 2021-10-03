Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32742003A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhJCFdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhJCFdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:33:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA23C0613EC;
        Sat,  2 Oct 2021 22:31:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z5so29930018ybj.2;
        Sat, 02 Oct 2021 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA8BpNVx/07HEt9LkRmrDBd1h/iounEe1GX4FH457YY=;
        b=cL3s9DqfYNLIQCFByg0DyDdAc/lhproKnLj93ca9B3WcXS8TW6AH44dg8VEzrUs7TE
         CaX0EyCkRNW9kz/D4QZVC5q0idDO6RwWgmFShX4Qrk5t0+EMfd5zRUTWYcfezAq4m0r/
         DneYlrTtG9c1QGMxSvx3UvwlEY3iqYJm2N4PDQCI7FPynDrb247MYmM5F958NCGHhpb6
         aElDUdbobNoePEb6Cb2AOBIfp2XMoP80KviNDT5H0k7wRgnhyA8jDP5YYsfZx71RDKo+
         d2sumE0Ht73gnGwT4ZBfqLG10wckze09q9OH8PZpFbjmC/k3/dgc/y7Msz8xP9cKvnby
         5LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA8BpNVx/07HEt9LkRmrDBd1h/iounEe1GX4FH457YY=;
        b=kZ3Quf3HjfKJuRB2djMqiGgvgnVCPWV4RfEKCCVzdxw79FXMwKIk6Q4NgXEs2CKzbH
         ZQjJgS2dUVqLOEO7JLFihaXyPIY+0iVlfmDhIF4Tf5W1PFVK1VFm9UYtLpeeUM6I33jI
         WMwUqf3Y1o47kU5l0YPv0xfOksr1YjXxVLqiz4/WuDmNPnAy4/HzRkwCbxWdIoNVE5nn
         lLmMB3D3Si+nqqq36E5rrwN5Uo/7RvEiczpwCWadaVPkWJXkW362v8QNA/qhpakR5LP+
         aLYRS+8IskjL/Fus3k+4MIxb4RLwIRa39YjxywiCm9lTokM2QlUlB26WLcHY0pKHiGIW
         O58Q==
X-Gm-Message-State: AOAM533QYicCRPZ5gRB7fFBpDnhNsX2zcKTejOP+hZH4kZ2ZzT5AbNQP
        +B9TW0Kh/L6ahfvNJ/b9tErNw+KtfYHl177TvD8=
X-Google-Smtp-Source: ABdhPJzkiTANOK4MzORReAXu0NcfiYqTNJmg0e0AflmHFVNb1wrNvWZFW2/bHn1pcNtB7lBV5fAM0jv7VB3pIEKczgc=
X-Received: by 2002:a25:5604:: with SMTP id k4mr7761232ybb.359.1633239088499;
 Sat, 02 Oct 2021 22:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211001120218.28751-1-utkarshverma294@gmail.com>
 <20211002144506.29974-1-utkarshverma294@gmail.com> <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
 <20211003051935.GA2687@uver-machine>
In-Reply-To: <20211003051935.GA2687@uver-machine>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 3 Oct 2021 07:31:17 +0200
Message-ID: <CAKXUXMz=nGRQyTUfXjmMdqLo2m9fSU23O+EOkyEVNWk19v3gOA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 7:19 AM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> On Sun, Oct 03, 2021 at 10:08:17AM +0530, Dwaipayan Ray wrote:
> > On Sat, Oct 2, 2021 at 8:15 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> > >
> > > Added and documented UNNECESSARY_ELSE message type.
> > >
> > > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Included the continue statement.
> > >
> > >  Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > > index f0956e9ea2d8..b7c41e876d1d 100644
> > > --- a/Documentation/dev-tools/checkpatch.rst
> > > +++ b/Documentation/dev-tools/checkpatch.rst
> > > @@ -1166,3 +1166,80 @@ Others
> > >
> > >    **TYPO_SPELLING**
> > >      Some words may have been misspelled.  Consider reviewing them.
> > > +
> > > +  **UNNECESSARY_ELSE**
> > > +    Using an else statement just after a return/break/continue statement is
> > > +    unnecessary. For example::
> > > +
> > > +      for (i = 0; i < 100; i++) {
> > > +              int foo = bar();
> > > +              if (foo < 1)
> > > +                      break;
> > > +              else
> > > +                      usleep(1);
> > > +      }
> > > +
> > > +    is generally better written as::
> > > +
> > > +      for (i = 0; i < 100; i++) {
> > > +              int foo = bar();
> > > +              if (foo < 1)
> > > +                      break;
> > > +              usleep(1);
> > > +      }
> > > +
> > > +    It helps to reduce the indentation and removes the unnecessary else
> > > +    statement. But note, there can be some false positives because of the
> > > +    way it is implemented in the checkpatch script. The checkpatch script
> > > +    throws this warning message if it finds an else statement and the line
> > > +    above it is a break/continue/return statement indented at one tab more
> > > +    than the else statement. So there can be some false positives like::
> > > +
> > > +      int n = 15;
> > > +      if (n > 10)
> > > +              n--;
> > > +      else if (n == 10)
> > > +              return 0;
> > > +      else
> > > +              n++;
> > > +
> > > +    Now the checkpatch will give a warning for the use of else after return
> > > +    statement. If the else statement is removed then::
> > > +
> > > +      int n = 15;
> > > +      if (n > 10)
> > > +              n--;
> > > +      else if (n == 10)
> > > +              return 0;
> > > +      n++;
> > > +
> > > +    Now both the n-- and n++ statements will be executed which is different
> > > +    from the logic in the first case. As the if block doesn't have a return
> > > +    statement, so removing the else statement is wrong.
> > > +
> > > +    Always check the previous if/else if blocks, for break/continue/return
> > > +    statements, and do not blindly follow the checkpatch advice. One
> > > +    patch (https://lore.kernel.org/all/20200615155131.GA4563@sevic69/)
> > > +    even made it to the mainline, which was again reverted and fixed.
> > > +    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
> >
> > s/unnecesary/unnecessary
>
> It is a spelling mistake in the commit message itself, and I have quoted
> that message, so I didn't change the message.
>
> > > +    after return statement.")

I wonder if this detailed description of the example belongs here; and
we summarize it as:

Do not blindly follow checkpatch's advice here, as blind changes due
to this rule have already caused some disturbance, see commit ....

> > > +
> > > +    Also, do not change the code if there is only a single return statement
> > > +    inside if-else block, like::
> > > +
> > > +      if (a > b)
> > > +              return a;
> > > +      else
> > > +              return b;
> > > +
> > > +    now if the else statement is removed::
> > > +
> > > +      if (a > b)
> > > +              return a;
> > > +      return b;
> > > +
> > > +    there is no considerable increase in the readability and one can argue
> > > +    that the first form is more readable because of the indentation. So
> > > +    do not remove the else statement in case of a single return statement
> > > +    inside the if-else block.
> > > +    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
> > > --
> > > 2.25.1
> > >
> >
> > I think this message is unnecessarily long for a warning that's understandable
> > at best without the verbose part. Try to shorten it up with only what's
> > required for a user to understand why the warning is there.
> >
>
> Okay, I will try writing it more precisely as Lukas said.
>
> > Dwaipayan.
