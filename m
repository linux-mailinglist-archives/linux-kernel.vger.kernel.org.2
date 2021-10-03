Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE30741FFCC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 06:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhJCEkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 00:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCEkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 00:40:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7EBC0613EC;
        Sat,  2 Oct 2021 21:38:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i4so56710454lfv.4;
        Sat, 02 Oct 2021 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBzF2o/olSqI5VSwY6RloUi89r97A89V2tyJ+1MXYw0=;
        b=TjRRMhTY8qWrT+y4fk6cuBRqBqFP/B2X2PH92VXDEB1WfEKwxcf7mae0f0w72Pe5/v
         6GsIMy5suA9690UZN1fyitqUtyEO1Qrgqg7tCiIezHeakrVsSOzYjtNq1ALWJRzx4J7U
         8oVcJaIQMz/kzguefgyN8xCoyIv4eUiK+UuVEBUZnYCo9iCmQpZx0A9mBGYqgMqAr5/w
         +rREZHO2Z5CEqgYxPX+1OJkHa32IJMQJtJ5xvpd5iFgmEheAllJ4m4g5FcLFqps7pvYx
         ZpEFWxWA/uQDx7htGr2nb75cJNiUy2o2sZDfb/xlEVL0ii/VA4pibPDd9WCHuSQQb2zC
         WuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBzF2o/olSqI5VSwY6RloUi89r97A89V2tyJ+1MXYw0=;
        b=NnCrULC135CDTWc4HCWMdRWjgpZ6cHIILwEENaafhpsEdVTdA4hoB28mzVTDGYc8sZ
         wLPuVOYp8AnkD9CziF9dVyAWmBOu4DGlt0ZFCww8uRIqVKveEf314F4+3ATs5nZIA4bM
         w/RdcEAQJv0YnKigKKYgAjWPzrUjfC4BmDT8DN4ZdaECUbI+WnyHyfwK8m/OPRQoOrvt
         oVOsOHsH+VyRs8hGJj3krQu7wWUGlwLfoHHyLsejRacsK5OEYsCDjOa5qOoH5eK/rnLG
         hS477ydsfFObht/+ig9VztPFDpB4fscVN2F+pTdgF/HDq4fh5NW8uZH3QpmHR0bcoOn1
         fBtg==
X-Gm-Message-State: AOAM530frq3GEuMUpbOiNMjNbniQOr2rHn8PXIxCFSBoExwbMnl2kj40
        sbu4kwqq8ixOnehzl1f07+lAu8HOUn/3v5hy7Vw=
X-Google-Smtp-Source: ABdhPJwqNDiATd6Ic8j+bXMYMemj3oTRLXV/smqCd5DUvmymaQtt+oiG1dUuE9ZF4P0j4Q9n3tWYzuhUWioTjn2C1uk=
X-Received: by 2002:a05:6512:3c95:: with SMTP id h21mr7316515lfv.128.1633235908556;
 Sat, 02 Oct 2021 21:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211001120218.28751-1-utkarshverma294@gmail.com> <20211002144506.29974-1-utkarshverma294@gmail.com>
In-Reply-To: <20211002144506.29974-1-utkarshverma294@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 3 Oct 2021 10:08:17 +0530
Message-ID: <CABJPP5Bpc_0c=b8kymo0fgXZARNZJ8EM5F=Gpx1=y+vOfPWM8Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 8:15 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Added and documented UNNECESSARY_ELSE message type.
>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
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

s/unnecesary/unnecessary
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

I think this message is unnecessarily long for a warning that's understandable
at best without the verbose part. Try to shorten it up with only what's
required for a user to understand why the warning is there.

Dwaipayan.
