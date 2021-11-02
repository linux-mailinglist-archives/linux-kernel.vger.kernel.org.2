Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9BA4428FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBH65 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Nov 2021 03:58:57 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:41542 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKBH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:58:54 -0400
Received: by mail-vk1-f181.google.com with SMTP id a129so4046557vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1P0LsVIvE+AG3u8MwJwSv25HKxzeAiGwQ6mKU7x6TU=;
        b=BWw2Xb1S26mhSIGW1EqObrxcQOWsFTkL59Ih4jf8Yo3BgIcWPF+vHHiVwt+bVYPDEN
         JDsBCCsWk8fqrjQLeLLM9PSL0EQ/zFK2IDoxHwm62FCUHz9elWx8Mj0jkPk+kZud0MJp
         H39cgdewl6nv7JX14so8Z2GZmYgULLSp7lU9UnVB7VJ8vsZUul73n119fsJ6kHSaewRp
         RmUKwVvIde77lfAvnnjM4/S73V0gMSohjnql74wLVpAu/cTjEPzJpJoUru4gYQhsyavK
         atGZGzK/SdnvUSR8fad+lG7SM3oYCJESpWRMouaHcJoKyqbvRNw/3RKfKn8ONQVzXcat
         qi9g==
X-Gm-Message-State: AOAM531O9xnXjwiISM2IwfqC+kHTsNj7z1WWEKJRW4yXEeR2KLyvERnT
        hIFsgOuOnVf22ZIwCpfK0ex6/wNbQzvt5Q==
X-Google-Smtp-Source: ABdhPJxlXokNg+uNBNYWIREHgC305MF4yF4BpwgAaVFV2hgameBYQ+xmzBYzCII5cEAxbPzKxZMPlA==
X-Received: by 2002:a1f:a08e:: with SMTP id j136mr36246288vke.14.1635839779201;
        Tue, 02 Nov 2021 00:56:19 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id z18sm912005vkb.20.2021.11.02.00.56.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 00:56:18 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id e2so36344863uax.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:56:18 -0700 (PDT)
X-Received: by 2002:a05:6102:370a:: with SMTP id s10mr22499703vst.37.1635839778225;
 Tue, 02 Nov 2021 00:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211102043024.449478-1-linux@roeck-us.net>
In-Reply-To: <20211102043024.449478-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Nov 2021 08:56:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW_0Q9oGfCqrdj9w=1n0CtTRZErZAeynToMQNrs--+oCg@mail.gmail.com>
Message-ID: <CAMuHMdW_0Q9oGfCqrdj9w=1n0CtTRZErZAeynToMQNrs--+oCg@mail.gmail.com>
Subject: Re: [PATCH] string: uninline memcpy_and_pad
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

Thanks for your patch!

On Tue, Nov 2, 2021 at 5:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> When building m68k:allmodconfig, recent versions of gcc generate the
> following error if the length of UTS_RELEASE is less than 8 bytes.
>
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_disc_identify' at
>         drivers/nvme/target/discovery.c:268:2:
> arch/m68k/include/asm/string.h:72:25: error:
>         '__builtin_memcpy' reading 8 bytes from a region of size 7
>
> Discussions around the problem suggest that this only happens if an
> architecture does not provide strlen(), if -ffreestanding is provided as
> compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
> for m68k. The exact reasons are unknown, but seem to be related to the
> ability of the compiler to evaluate the return value of strlen() and
> the resulting execution flow in memcpy_and_pad(). It would be possible
> to work around the problem by using sizeof(UTS_RELEASE) instead of
> strlen(UTS_RELEASE), but that would only postpone the problem until the
> function is called in a similar way. Uninline memcpy_and_pad() instead
> to solve the problem for good.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  include/linux/string.h | 19 ++-----------------
>  lib/string.c           | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 17 deletions(-)

Given this now conflicts with commit cfecea6ead5f1588 ("lib/string:
Move helper functions out of string.c"). perhaps you should move this
to lib/string_helpers.c when respinning?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
