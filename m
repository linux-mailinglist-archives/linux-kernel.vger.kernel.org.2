Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092DF41BEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 07:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhI2FaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 01:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbhI2FaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 01:30:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98224C06161C;
        Tue, 28 Sep 2021 22:28:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 71so2731077ybe.6;
        Tue, 28 Sep 2021 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkRkJ9qOjdjrGLosz4wxC8UOCk09ebTeALx75shmRHk=;
        b=mzW3OnabL+IyaZEEYwb+JP61g7PYaOMCzO9n4qA7286IkbinbiIx/EULISPQNRQp2+
         TF06RuuYmsIt0+1EKvpSDHzO6/7O/Vver5NMYu+N81CN5ZXrEMp+uvd1TH/Qd5plEqW3
         MP9lOC6NxdNcC1qjM0DPlMRBrPXmmnxncYvlaaJVz9khH8M3gPu5pMTZsmW/A2KQziul
         euEkDURO1Fe86yyKlf6n7g2a433A86/5mKsJjQLdwfKujbSM6/IgPCz4XfInO6tdG6h/
         3vKyHS2tHfcKvNkSPyKyxBfUjqtRsHc0gnNS9IMSquho0JIM1hmaRD0P+SzA0p7a7YWI
         FMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkRkJ9qOjdjrGLosz4wxC8UOCk09ebTeALx75shmRHk=;
        b=W6qmb6KOmsw1xFkvqCrHFkRTV5bR7ZyTJjl+jAhtq1mvIdrHdQIqIhSkXMTT9afshU
         FHyqtD2bj6B4WuU4xOZKv59WjNskLURyo+T8RScljYGL9xD0FbNCh1rQGc5E47mGFZ/l
         DeWLgL++WLbM1OUXOwOhqW5GTx3LPAhRMGUWjiFiz7dr6iyClrl5huxWtEY+r/jCRhgp
         nE9nlpsdheJL852eeWgL6MnBbaO7V+VRQ2FRsZkXINAKbUtKEvj+ZEMZWvR9PI4DLOk1
         0S1UpjOhEe7iHxDMVAQhyWatKrBOa6fNC0qGs3TUDpxikmFSzKHijxvKd08VHstBtZbP
         oplQ==
X-Gm-Message-State: AOAM532+PLyQSRh2M5i/PAkLX00BZEvFG6Xh4ZzuSpxv0d7wvDBpa/DP
        juTY4Z996VVyU23uHAkTClntNZLftsqWghQHYz/t+MMCKHU=
X-Google-Smtp-Source: ABdhPJzSlhEi3lM53/OYhkNRr9objwPo45o2Dy8CwQsN3BInbB7m0HUIMJZreYXf2rayc+OI7UqMw81jttGlCl6YDjw=
X-Received: by 2002:a25:f20b:: with SMTP id i11mr10834957ybe.534.1632893301827;
 Tue, 28 Sep 2021 22:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210925201746.15917-1-utkarshverma294@gmail.com>
In-Reply-To: <20210925201746.15917-1-utkarshverma294@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 29 Sep 2021 07:28:19 +0200
Message-ID: <CAKXUXMzEFQd1JJhx4ZbBQiuSB7Fk3bd7dwJYmPOvEtMqZopxpg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message types
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

Overall conclusion: Patch needs more work. So a NACK from my side.

Jonathan, could you drop this patch from your queue again? Sorry for
this inconvenience.

Further comments inline.

On Sat, Sep 25, 2021 at 10:18 PM Utkarsh Verma
<utkarshverma294@gmail.com> wrote:
>
> Added and documented 3 new message types:
> - UNNECESSARY_INT
> - UNSPECIFIED_INT
> - UNNECESSARY_ELSE
>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index f0956e9ea2d8..2dc74682277f 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -929,6 +929,13 @@ Functions and Variables
>
>        return bar;
>
> +  **UNNECESSARY_INT**
> +    int used after short, long and long long is unnecessary. So remove it.
> +

This does not add significantly more explanation than what is already
there in the checkpatch warning without the --verbose option.

As we said multiple times before:
- A reference to documentation, mailing list thread, or (in this case)
even the section of the C standard helps. Then summarize that
discussion or the rationale you got from that documentation.
- Further, pointers to typical cases of false positives of this rule
also helps developers to judge if they should address the warning or
not.

> +  **UNSPECIFIED_INT**
> +    Kernel style prefers "unsigned int <foo>" over "unsigned <foo>" and
> +    "signed int <foo>" over "signed <foo>".
> +

Same comment as above.

>
>  Permissions
>  -----------
> @@ -1166,3 +1173,43 @@ Others
>
>    **TYPO_SPELLING**
>      Some words may have been misspelled.  Consider reviewing them.
> +
> +  **UNNECESSARY_ELSE**
> +    Using an else statement just after a return or a break statement is
> +    unnecassary. For example::

spelling mistake in unnecassary -> unnecessary.

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
> +    So remove the else statement. But suppose if a if-else statement each
> +    with a single return statement, like::
> +
> +      if (foo)
> +              return bar;
> +      else
> +              return baz;
> +
> +    then by removing the else statement::
> +
> +      if (foo)
> +              return bar;
> +      return baz;
> +
> +    their is no significant increase in the readability and one can argue

s/their/there/

> +    that the first form is more readable because of indentation, so for
> +    such cases do not convert the existing code from first form to second
> +    form or vice-versa.

I am confused. So what is the recommendation the documentation is
providing here?

Lukas

> --
> 2.25.1
>
