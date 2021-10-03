Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F970420032
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhJCFZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:25:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF735C0613EC;
        Sat,  2 Oct 2021 22:23:28 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u32so29782137ybd.9;
        Sat, 02 Oct 2021 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pvKG3VlY9jG9HCh27Dsw+nIy8Q2O4bRkxhbomGPdRU=;
        b=mYA1ZoW+T79P48QYIOv3W49NiUO+Pv1kT1U8LQsZtR7qnBo7A9jfJ2TlSsRSydeZS8
         ItWxrdArp15ynSLYoy/bfGENHJDTIEDX7ILLI9/3qH/ua6tLLWxEhXhJh7JWTU17ng1w
         VGo9SwR0c2rv6HqcEjQLhB9xVs6YNBL6t2rQC0BhZQzEaastaiZTff9JjcoTkpWAtnBr
         h33Sh/XI9WmZrjdc9uLxbw7JJ/X1yoQkhfzjbS64xdjmtdHmlyVCIp3v+hvrS3aUGSPu
         2KviKsJV/2qlCPozFG87wcOXbeAv9CFgn6Js0eGlEzBXYoz0wESNEbS29yqn9c9MS/qj
         5Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pvKG3VlY9jG9HCh27Dsw+nIy8Q2O4bRkxhbomGPdRU=;
        b=KMoAVA8RITXLyWD0zuPrCAvz81DdW0IpvPBPotflcCWp8lbRRj9Z8YMWncOhJdjbJ9
         r599cLa6jiOWxpJ1YAwMEJrbUhjs9xghsQ5zaF/41rolgy67YbKLR7l80+ouSM4jFFc0
         kYmmxrvff2XgQK6+BQB7kyuGNP3ik7EoZUIuL0g+QEMJcQRzECy81WVwp8RvX7BEd0JN
         CgBCDO16Mov29TH9K/khpkWPeWQnxrdC4OPpGj3fk7UKvLLKBZLApR7psL70Nk4PCtMg
         ANt0nI+ak8Lqx6XqzBZeMxtlOlc9VC7rQrTwJ114DhDOfyRN+Ne4ZNgUS4+v3pJAqkrb
         KI9g==
X-Gm-Message-State: AOAM531gTNRdJI8MHSCGb2G4rQCoQuzPkCHzgq4PPMF/ULY6I9F1P17a
        goDTeHZYsTKRzFk4KCvJfkiY0sUrl6F5JwrAx0o=
X-Google-Smtp-Source: ABdhPJxk1rlYonzHtfbNF+rKjxXjmU2H2qm3fFJi4senWX+exvtKnPwMETQtrSX8I1zXFVE2oWB3EgHAjj6nkX4lOkg=
X-Received: by 2002:a25:5604:: with SMTP id k4mr7734678ybb.359.1633238607769;
 Sat, 02 Oct 2021 22:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211001120218.28751-1-utkarshverma294@gmail.com> <20211002144506.29974-1-utkarshverma294@gmail.com>
In-Reply-To: <20211002144506.29974-1-utkarshverma294@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 3 Oct 2021 07:23:17 +0200
Message-ID: <CAKXUXMyrLu8N6Q-jtLFGf_tTVc4VDWwuK7ob1NHeg=kP8qM-1w@mail.gmail.com>
Subject: Re: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

also to: Julia Lawall for the idea on a cocci rule.

On Sat, Oct 2, 2021 at 4:45 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Added and documented UNNECESSARY_ELSE message type.
>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>

1. Julia, below is the description of a syntactic rule for unneeded
else branches; checkpatch implements a simple incomplete heuristics.
While reading this, I wondered if a student/learner for coccinelle
could actually write a cocci rule that does detect this pattern a bit
better than checkpatch. Maybe, you can add this to your (for
students'/newcomers') TODO list? It would certainly be interesting to
see some first evaluation.

2. Utkarsh, please send new patch versions v2, v3, etc. always as new
email threads, not as responses to the original patch.

See: https://lore.kernel.org/lkml/20211001120218.28751-1-utkarshverma294@gmail.com/T/#t

As you see, the email thread is very confusing; developers,
maintainers and tools have a hard time to find the latest version of
the patch and link the discussion. The process documentation should
already point out to NOT send next version patches as reply to older
patches.

Lukas

> ---
> Changes in v2:
>   - Included the continue statement.
>
>  Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index f0956e9ea2d8..b7c41e876d1d 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1166,3 +1166,80 @@ Others
>
>    **TYPO_SPELLING**
>      Some words may have been misspelled.  Consider reviewing them.
> +
> +  **UNNECESSARY_ELSE**
> +    Using an else statement just after a return/break/continue statement is
> +    unnecessary. For example::
> +
> +      for (i = 0; i < 100; i++) {
> +              int foo = bar();
> +              if (foo < 1)
> +                      break;
> +              else
> +                      usleep(1);
> +      }
> +
> +    is generally better written as::
> +
> +      for (i = 0; i < 100; i++) {
> +              int foo = bar();
> +              if (foo < 1)
> +                      break;
> +              usleep(1);
> +      }
> +
> +    It helps to reduce the indentation and removes the unnecessary else
> +    statement. But note, there can be some false positives because of the
> +    way it is implemented in the checkpatch script. The checkpatch script
> +    throws this warning message if it finds an else statement and the line
> +    above it is a break/continue/return statement indented at one tab more
> +    than the else statement. So there can be some false positives like::
> +
> +      int n = 15;
> +      if (n > 10)
> +              n--;
> +      else if (n == 10)
> +              return 0;
> +      else
> +              n++;
> +
> +    Now the checkpatch will give a warning for the use of else after return
> +    statement. If the else statement is removed then::
> +
> +      int n = 15;
> +      if (n > 10)
> +              n--;
> +      else if (n == 10)
> +              return 0;
> +      n++;
> +
> +    Now both the n-- and n++ statements will be executed which is different
> +    from the logic in the first case. As the if block doesn't have a return
> +    statement, so removing the else statement is wrong.
> +
> +    Always check the previous if/else if blocks, for break/continue/return
> +    statements, and do not blindly follow the checkpatch advice. One
> +    patch (https://lore.kernel.org/all/20200615155131.GA4563@sevic69/)
> +    even made it to the mainline, which was again reverted and fixed.
> +    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
> +    after return statement.")
> +
> +    Also, do not change the code if there is only a single return statement
> +    inside if-else block, like::
> +
> +      if (a > b)
> +              return a;
> +      else
> +              return b;
> +
> +    now if the else statement is removed::
> +
> +      if (a > b)
> +              return a;
> +      return b;
> +
> +    there is no considerable increase in the readability and one can argue
> +    that the first form is more readable because of the indentation. So
> +    do not remove the else statement in case of a single return statement
> +    inside the if-else block.
> +    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
> --
> 2.25.1
>
