Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08342E140
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJNSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhJNSbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:31:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C981C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:29:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p16so31043741lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Q08MJAaZlA776YK6MXdrO/QEwzpx3n27ZLpuwXkThw=;
        b=pxjIkxUamfFNklraVabacOoKg9PxYf64xqV6vkb+E8xtgwBcjApEw8QVlqy8y9NQc4
         l7t4KRR713efMFF2eby6vS9A+DT8bI2rw+y8gyiqq9I7uaj9rK3jW4cPoqpTSB8BcOMM
         PsGMLXiAgyfp64xQxCnaZG6itTW5tkL0De5/qQmrNMY1L2NhgG3wgAMFlXfBArAITK3B
         e4uJXWX0Vy0c4BIrZzmS8F1OpV5d5WcyZY/ryQH0pdxhogPSkxjpLO8TOV+cmdraiib4
         rHgNFKCgJ9Vl1KAFxP5Ujp2ufyOs/I2qupsTcKXWOTrwfwJcd0gYHojDuURacGpV+DPx
         TFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Q08MJAaZlA776YK6MXdrO/QEwzpx3n27ZLpuwXkThw=;
        b=8BVSH9baqRerAtfE3JN+3IPJ+2LBOIW31WbRtjz0E5aKyxFafKc8kZaaA3RPczVc5L
         3qo/2gdDYJqR6JJzIljke22GlwP1CP43Rpl64JOoCXJDphlHaW4eJey/4e6plDksg5tf
         23ZJTj8Wc5FldKW5XvL60dvKJU5nqbEs3X1Izd8VcDv7icBb1t5dTdWA4MURVri5oNzu
         Wz+38Pcp75+6NLIid3I0akZqs4sx06XhJSH7vM2jco2puVeJLotqE7gs23BX+pooG4Vl
         IN2XC3iOc+UzIh7nmHU0eNULMRjJwcctimj1QFrsXW0Ff1ZXty1C6UidbDzZjfMn2Rgw
         GEEw==
X-Gm-Message-State: AOAM532tdKlwZULJSxLV2nVAmjPWUT3NfE8ppmpvRDxRx8hhqQn2Taj9
        4aH17gXIcrAYTyEXnbnho/+ZO6AljWtpPhQyNb0J/w==
X-Google-Smtp-Source: ABdhPJyKR+RB+D/OF/p1a4F3CYr/Kz9iXpBrgzmwtW/yTV0/APsr5xhTwj04ogi2RSCb8ISgYBwfNjxdOKXvPteeWNo=
X-Received: by 2002:a2e:81d6:: with SMTP id s22mr7447338ljg.128.1634236186376;
 Thu, 14 Oct 2021 11:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211014031413.14471-1-jiangshanlai@gmail.com> <20211014033414.16321-1-jiangshanlai@gmail.com>
In-Reply-To: <20211014033414.16321-1-jiangshanlai@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 11:29:34 -0700
Message-ID: <CAKwvOd=znqwGT_FmUPbWPodjrnFHf+FtHMaYCTfvUeukBCM3xw@mail.gmail.com>
Subject: Re: [PATCH V3 06/49] compiler_types.h: Add __noinstr_section() for noinstr
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 8:34 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> And it will be extended for C entry code.
>
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  include/linux/compiler_types.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index b6ff83a714ca..3c77631c68bd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -208,10 +208,12 @@ struct ftrace_likely_data {
>  #endif
>
>  /* Section for code which can't be instrumented at all */
> -#define noinstr                                                                \
> -       noinline notrace __attribute((__section__(".noinstr.text")))    \
> +#define __noinstr_section(section)                             \
> +       noinline notrace __attribute((__section__(section)))    \

Can we use __section(section) here (from
include/linux/compiler_attributes.h)? I kind of can't stand seeing
attributes open coded.

>         __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
>
> +#define noinstr __noinstr_section(".noinstr.text")
> +
>  #endif /* __KERNEL__ */
>
>  #endif /* __ASSEMBLY__ */
> --
> 2.19.1.6.gb485710b
>


-- 
Thanks,
~Nick Desaulniers
