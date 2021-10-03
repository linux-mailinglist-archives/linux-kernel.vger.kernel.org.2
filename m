Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC516420026
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhJCFKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:10:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9BEC0613EC;
        Sat,  2 Oct 2021 22:08:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v195so29332594ybb.0;
        Sat, 02 Oct 2021 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UkWz5k0WV/y8LvAwEtD2XP2MGMBBuBGFHONnzIO9iw=;
        b=Wz59x82XdRMf2/xOOsvQtPAYd+ba7YtZoQ7/9D1NTP0jaW+8R4ERV3JcC5KAz2ciJ7
         VLmPzXBi+MwK5cfk6cUq5vsAqimEiuQuISyJO5U/dpy808vKv+Co6ztX/T7C4iDZPz5o
         F6qy564vuoAQHIkLMYX7QKpJGrAScRlD97GhcMFVcrMynAEcLoW4dlqZPkc7kXCfqy0p
         3/sNMvf7zWufkHCoRXhcUQFsmy53VRf4RURIaNsJC12WotbXQEws4SBkt0gm/UfIZdwR
         nEEqUiWpTUXYaaEm5mBoZ8gbP+GzpeZvMDcz2eQwdeqsA/N8SsKF1JHXtvsXycVKWVws
         24WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UkWz5k0WV/y8LvAwEtD2XP2MGMBBuBGFHONnzIO9iw=;
        b=7Z1QiWLt4rp1MRlMoSR6+g74k3NFKkvxQb+yEDN7D1pkzgvGRbjoSmgwZAzubylJBX
         vDf/5t4rzdCV94KEn2OgxI/1o91zQ96dYC+KlO+LMlvwxikfzcwwTtJFD+HKc1dgxU2Y
         alrl+Z9M5tGCeCJhMljcTFp8/w6fhmzimucSJrSwcBLqGYXr8R+VjQzPy5MigShSIN9b
         SaJi+XyiAvIrv5nYsxh4kdXO0vjvBEOq09h+doyTDGe2HxtzrxRDOjBHyiSLJFCsXiBE
         +zkRh1LJXE/hjQ9Yk/5sAjZufUZckV5FodNSRJFEDqVVCxLHHcIaRSY3fZRmBmggyHVI
         K1xg==
X-Gm-Message-State: AOAM5324pEEv8JZl4cg/XIF8uXtUIlcxiZ9mnvEz1ioUElO9KieZhFsZ
        GmAeP5y1k9UTVmr1hqRarZIoDKqjAoaAOFj5s9ySYnVm
X-Google-Smtp-Source: ABdhPJxH/MFd5jvyCo65EoMXVdBlNNCFTpN1VbRfiz7F5fvG0sbY0tbbFI6OJMqHd+G1IuRu5iRHfCTM9M+VV7gKlAo=
X-Received: by 2002:a25:42c9:: with SMTP id p192mr7149832yba.339.1633237738461;
 Sat, 02 Oct 2021 22:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211001120218.28751-1-utkarshverma294@gmail.com>
 <20211002144506.29974-1-utkarshverma294@gmail.com> <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
In-Reply-To: <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 3 Oct 2021 07:08:47 +0200
Message-ID: <CAKXUXMyWqKAAUOx=hKw07WbBkLiz804LiD=K7=Vr5iGzbjun3Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 6:38 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> On Sat, Oct 2, 2021 at 8:15 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> >
> > Added and documented UNNECESSARY_ELSE message type.
> >
> > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > ---
> > Changes in v2:
> >   - Included the continue statement.
> >
> >  Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > index f0956e9ea2d8..b7c41e876d1d 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1166,3 +1166,80 @@ Others
> >
> >    **TYPO_SPELLING**
> >      Some words may have been misspelled.  Consider reviewing them.
> > +
> > +  **UNNECESSARY_ELSE**
> > +    Using an else statement just after a return/break/continue statement is
> > +    unnecessary. For example::
> > +
> > +      for (i = 0; i < 100; i++) {
> > +              int foo = bar();
> > +              if (foo < 1)
> > +                      break;
> > +              else
> > +                      usleep(1);
> > +      }
> > +
> > +    is generally better written as::
> > +
> > +      for (i = 0; i < 100; i++) {
> > +              int foo = bar();
> > +              if (foo < 1)
> > +                      break;
> > +              usleep(1);
> > +      }
> > +
> > +    It helps to reduce the indentation and removes the unnecessary else
> > +    statement. But note, there can be some false positives because of the
> > +    way it is implemented in the checkpatch script. The checkpatch script
> > +    throws this warning message if it finds an else statement and the line
> > +    above it is a break/continue/return statement indented at one tab more
> > +    than the else statement. So there can be some false positives like::
> > +
> > +      int n = 15;
> > +      if (n > 10)
> > +              n--;
> > +      else if (n == 10)
> > +              return 0;
> > +      else
> > +              n++;
> > +
> > +    Now the checkpatch will give a warning for the use of else after return
> > +    statement. If the else statement is removed then::
> > +
> > +      int n = 15;
> > +      if (n > 10)
> > +              n--;
> > +      else if (n == 10)
> > +              return 0;
> > +      n++;
> > +
> > +    Now both the n-- and n++ statements will be executed which is different
> > +    from the logic in the first case. As the if block doesn't have a return
> > +    statement, so removing the else statement is wrong.
> > +
> > +    Always check the previous if/else if blocks, for break/continue/return
> > +    statements, and do not blindly follow the checkpatch advice. One
> > +    patch (https://lore.kernel.org/all/20200615155131.GA4563@sevic69/)
> > +    even made it to the mainline, which was again reverted and fixed.
> > +    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
>
> s/unnecesary/unnecessary
> > +    after return statement.")
> > +
> > +    Also, do not change the code if there is only a single return statement
> > +    inside if-else block, like::
> > +
> > +      if (a > b)
> > +              return a;
> > +      else
> > +              return b;
> > +
> > +    now if the else statement is removed::
> > +
> > +      if (a > b)
> > +              return a;
> > +      return b;
> > +
> > +    there is no considerable increase in the readability and one can argue
> > +    that the first form is more readable because of the indentation. So
> > +    do not remove the else statement in case of a single return statement
> > +    inside the if-else block.
> > +    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
> > --
> > 2.25.1
> >
>
> I think this message is unnecessarily long for a warning that's understandable
> at best without the verbose part. Try to shorten it up with only what's
> required for a user to understand why the warning is there.
>

Dwaipayan, I actually considered all this interesting information and
all valuable background information on this rule.

Now, I would like to see all this information in the checkpatch
documentation. Maybe here, the expectations for the --verbose option
and the checkpatch documentation are slightly different.
IMHO, the need for the checkpatch documentation beats the --verbose
option. If checkpatch users really ask for --verbose help on this
rule, they are already questioning the value of a rule that is already
quite understandable (as you said). So, then we should convince them
with all background information and known false positives we
encountered.

I vote for keeping all information; wordsmithing and writing more
precisely is certainly doable.

Lukas
