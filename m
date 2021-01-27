Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9345E306253
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhA0RmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbhA0Rlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:41:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E42C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:40:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q20so1654428pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea2hEewa2SHaOq7KTISxKb0uWCugTMJMw8rLnU/K26k=;
        b=A9rWu8zWZNwCAp4Yi6QT6Y4P8HPZIqyIgcCK82nBm46RHjsY/bZdkmNYGU0hJpgxOy
         tKdfR499wkYJc7ge5DyhAfvv0iLNqW+cMrxx/Sfp72vwRBXBV8wJq5HynY9P4zDyoRG9
         67N+ZR+KeIZxPyAMBJgIyBQE8wbf6bXPaj1yz62/vC626dzGUDF03uNkDa3dhsiJLrW4
         ugvUvx2Hr33AgSh4nGQvuF6NxJ4iacf8vRChm6RkfPoBxa2eCpz/r2x0COUg2VpiJXvX
         RYQkEfetuyD6E/OEtrjG9Lxlhz3Prja7tl8e8FSFklkui/00mUGYDIZkgyxrQ9Sd0GPO
         KKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea2hEewa2SHaOq7KTISxKb0uWCugTMJMw8rLnU/K26k=;
        b=gjhXz4skcz8+1oPT6qgiyQbM9D8/KF/CZ+FUbM/edxu9m+9fdxJUTVFaT4tzj0+Hmf
         S5ZtagDG7o7yj0/bDqJG6Az6JdqBXmRbiMeANeHJXwA55lIhiXIH3Q+AOfJwTL1GO0S2
         PqYdDfUftWnCt4H0xt9NN/JMZvhWVHyL0BpQ/i5Z9his4KJFBp8ap+cRiR1HuViP5Ly5
         uzD4XgTmdECGYmEw20LLryqfwz4EuFfn9/+83Tjn1N1k0ueD9WHAtFBZa3AM3Q6JlnyI
         OPGrcsYypt4oGfFHtz2sGGF8OuO+2Myxc8dT2xTLZqJA+53zWq+kfDsDGbKaR0t3sD8A
         NBbw==
X-Gm-Message-State: AOAM530e1iZLqdatpWIxAQ2UwqkgXLUyi5raU/bna6MA3PpZahDYhO28
        /Y6/gm+rnlt2LvALa+G+G2d3JluNQ4C/oSjKczI6lw==
X-Google-Smtp-Source: ABdhPJys8tiehR0/NaIh15+L73F2p+5mchrd0vD23tiXISAnyxVH7mL6/nmQ7mB4394degpjdVRVkbdvMpFHV92GNO0=
X-Received: by 2002:a62:7896:0:b029:1b6:7319:52a7 with SMTP id
 t144-20020a6278960000b02901b6731952a7mr12149664pfc.30.1611769250944; Wed, 27
 Jan 2021 09:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20210127110510.24492-1-candlesea@gmail.com>
In-Reply-To: <20210127110510.24492-1-candlesea@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Jan 2021 09:40:38 -0800
Message-ID: <CAKwvOdm4XaoW+yrtj=7C7ct5dvNuxT81zs1Wp=X0MBFceukd9g@mail.gmail.com>
Subject: Re: [PATCH v2] lkdtm: fix memory copy size for WRITE_KERN
To:     Candle Sun <candlesea@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        candle.sun@unisoc.com, David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 3:05 AM Candle Sun <candlesea@gmail.com> wrote:
>
> From: Candle Sun <candle.sun@unisoc.com>
>
> Though do_overwritten() follows do_nothing() in source code, the final
> memory address order is determined by compiler. We can't always assume

^ "by the compiler."

> address of do_overwritten() is bigger than do_nothing(). At least the
> Clang we are using places do_overwritten() before do_nothing() in the
> object. This causes the copy size in lkdtm_WRITE_KERN() is *really*

Hopefully nothing else gets placed in between the two, otherwise we're
going to overwrite that, too.

> big and WRITE_KERN test on ARM32 arch will fail.
>
> Get absolute value of the address substraction for memcpy() size.

^ typo: subtraction

>
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> ---
> Changes in v2:
> - Use abs() in place of address comparison.
> ---
>  drivers/misc/lkdtm/perms.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 2dede2ef658f..fbb7f4554054 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
>   * This just returns to the caller. It is designed to be copied into
>   * non-executable memory regions.
>   */
> -static void do_nothing(void)
> +static noinline void do_nothing(void)
>  {
>         return;
>  }
>
>  /* Must immediately follow do_nothing for size calculuations to work out. */

^ This comment is now obsolete and should be removed together with
this patch.  That will also fix the typo in it.

> -static void do_overwritten(void)
> +static noinline void do_overwritten(void)
>  {
>         pr_info("do_overwritten wasn't overwritten!\n");
>         return;
> @@ -113,7 +113,7 @@ void lkdtm_WRITE_KERN(void)
>         size_t size;
>         volatile unsigned char *ptr;
>
> -       size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> +       size = (size_t)abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing);
>         ptr = (unsigned char *)do_overwritten;
>
>         pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> --
> 2.17.0
>


-- 
Thanks,
~Nick Desaulniers
