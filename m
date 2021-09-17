Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC8F40F80E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbhIQMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIQMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:41:30 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E8C061574;
        Fri, 17 Sep 2021 05:40:08 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id v9so6019696uak.1;
        Fri, 17 Sep 2021 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSw5+PWfzGPv1mvGOdKXsMBSDlzDCpHpboFu5HmJ6bs=;
        b=bGyH98Wb2bl/RHkaOAUDmNC03B10hQsbdUVcgDHJ7XmvZW2xtUNqbBJ0KnVtUG1Sql
         gWvG5kxbGPmuEuPVKfZZTmjbC9n46Mtqi0p6kVhW7GnNLys5ECnjSiCCfFkuBq7Hdv1U
         8UmuQtbKgU+D08o6qaI/+llPM11fAvC4+fJL14fpgMY8J40UEOe9y6Urn9CX0m6wUIzr
         927W+IqHDdi7SH4EKpp8lUewKJkmOy901SukLDiF0+SAnZO2xiSHCQpDDUpJRlTiTSrE
         dsMk3axG1sdbfx4ZmKkhQaWsgxwV0FtdemhfDiCRRMfA2GDYBubSXYCtuTXB5oOvua/n
         VQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSw5+PWfzGPv1mvGOdKXsMBSDlzDCpHpboFu5HmJ6bs=;
        b=jUT30fKv4aBZnpTfwHdZvw/+hWaH8qA2Kefk1Wu5BqlYlDes217tkB72wMmHwCSxGs
         NpHblfBZGDJoF+iL+Yt5tQUig5/NOyDmoXj9yFZB5yabzdj6s9H5OWJ81J09A9CNnErB
         2saNXRzi+y4OA+3vd8TFP+smaSYEFUPS+uDtd+5xFZ+1nQM7+DlprFq/RKcGtrWpEfnQ
         mYVhi9shHnOUUko8D8XAreSj0+oMRUrPMkLQqVej4oPyQV4be9lYgKCbpTeHU1l1U0vl
         6WDQf36TUZ/DBehQQSIqbYmy9f4MUSSFwWV9CPSxYoUgZLVvZ6UNinmwJ035ghBkSpgB
         brrA==
X-Gm-Message-State: AOAM532j/aq3pf9TiRhSdAlYerQAkzC/w/9wRHAD27q/5GIljpd/c+LO
        OZVmcNGAg3H8bsRF5DrJqM74n+QnGr0hQvEWxPk=
X-Google-Smtp-Source: ABdhPJwQHyS0M91oIii/Y9xWFL25H8j+O7B5EkBo6fu8FlTP0FtqQpFtLz0/T/4C6RF+e4YPbJ4mIh//I/xYPJEW3tc=
X-Received: by 2002:ab0:171:: with SMTP id 104mr4212314uak.67.1631882407860;
 Fri, 17 Sep 2021 05:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210917101507.8380-1-utkarshverma294@gmail.com>
In-Reply-To: <20210917101507.8380-1-utkarshverma294@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 17 Sep 2021 18:09:56 +0530
Message-ID: <CABJPP5ABOAe2jkaH0fA7+9WMPp79=8i5+-sO99-pyBV-aMcWCQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message types
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

On Fri, Sep 17, 2021 at 3:46 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Added and documented 4 new message types:
> - INCLUDE_LINUX
> - INDENTED_LABEL
> - IF_0
> - IF_1
>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index f0956e9ea2d8..ea343a7a5b46 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -435,6 +435,11 @@ API usage
>    **EXPORT_SYMBOL**
>      EXPORT_SYMBOL should immediately follow the symbol to be exported.
>
> +  **INCLUDE_LINUX**
> +    Whenever asm/file.h is included and linux/file.h exists, a
> +    conversion can be made when linux/file.h includes asm/file.h.
> +    However this is not always the case (See signal.h).
> +

Can you suggest why? And is this true for every use?

>    **IN_ATOMIC**
>      in_atomic() is not for driver use so any such use is reported as an ERROR.
>      Also in_atomic() is often used to determine if sleeping is permitted,
> @@ -661,6 +666,10 @@ Indentation and Line Breaks
>
>      See: https://lore.kernel.org/lkml/1328311239.21255.24.camel@joe2Laptop/
>
> +  **INDENTED_LABEL**
> +    goto labels either should not have any indentation or only a single
> +    space indentation.
> +

Some reference here maybe?

>    **SWITCH_CASE_INDENT_LEVEL**
>      switch should be at the same indent as case.
>      Example::
> @@ -790,6 +799,19 @@ Macros, Attributes and Symbols
>    **DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON**
>      do {} while(0) macros should not have a trailing semicolon.
>
> +  **IF_0**
> +    The code enclosed within #if 0 and #endif is not executed and is used
> +    for temporarily removing the segments of code with the intention of
> +    using it in the future, much like comments. But comments cannot be
> +    nested, so #if 0 is preferred. But if the code inside #if 0 and #endif
> +    doesn't seem to be anymore required then remove it.
> +
> +  **IF_1**
> +    The code enclosed within #if 1 and #endif is always executed, so the
> +    #if 1 and #endif statements are redundant, thus remove it.
> +    It is only useful for debugging purposes, it can quickly disable the
> +    code enclosed within itself by changing #if 1 to #if 0
> +

These two are good.

>    **INIT_ATTRIBUTE**
>      Const init definitions should use __initconst instead of
>      __initdata.
> --
> 2.25.1
>

Thanks,
Dwaipayan.
