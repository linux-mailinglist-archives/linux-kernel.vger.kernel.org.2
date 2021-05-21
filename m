Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2838C73C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEUM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhEUM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:56:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D7C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:55:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g38so27292147ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vztkWmHQgKWPGJn4DJHohOXTvYdeCFCMfmSXs9/hr3M=;
        b=L0vrt59WhxgD223N4WjstHuvb3x0kMuwpTPtDH7AKGHLMPTAg6ba6ZHaKOSxexwizv
         HYv4WxhsA1Kc0qdYd9P5oheM3mP8jlxq3oh9uLtPy1nQ1hy+vEBYulp6c8jTtbbdNmmV
         nYvgc/pGqkKZE3Ye6hrEJ61lMl2Cn3P8uPsLbDTj7pmB92IMhUEPso406xRnnb2zbsKS
         SP3fWuHDx4ihrXo7HUBeGmfaknoTUtR4K2NMmFxU5YVgEesXJeogXu6FqC0Y6PfmvNyk
         QXuJTtOr3OKbEx2wAVcJgxmx2+CvX8LAgseksMQcMGwv/U1pZsbqdLOdOvK5xIWgY4Pv
         t+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vztkWmHQgKWPGJn4DJHohOXTvYdeCFCMfmSXs9/hr3M=;
        b=RPl8RSYPXMJ5S8h5WJGCXu4ob5PyE7yF21KzhPyJUTN4IqkFhv1UEbQpu+6l2+43Pv
         vpZ6W0Q9iWNmejItja5buDvo3tJCuh0vGFgLHKQlMg2iC4WHJ1pcZxv3NU9X0AgYcFpW
         PvIjbe82nb1LuGfd3GahlWypqIaLOnml1T7cL3Sw3FqCwAJf/4jcreDDCxNvT0KXdkHC
         1t4YBqgfd7MpzSIWNAstokDTwQm6YCy5Fyx1th7w43r4HzBgynnhXs59EP2NwAZJ69sF
         hHkFkuWoNdXdmviZFJdF6qjQnobEPcZ2h5vfWx1bpIk7p12Cv+OwI/p8uEgJx31vBV6U
         sAnA==
X-Gm-Message-State: AOAM530YtPTVYDTZETrfxC4eHMdDBJbTaw9GfvY+mVBVMFENUXS2DIpU
        khSBz5mfOa1lB27xqYksmUETpskF9zU/HmOB/XDf5A==
X-Google-Smtp-Source: ABdhPJz6/p+C7UeedeeY3v244grS/khR9g2n2Vg622QKjp5XuojoNGUsMaNRh+rB6XoU7bh6JtrGJBgcirO0fh7x+jI=
X-Received: by 2002:a25:748f:: with SMTP id p137mr14497003ybc.25.1621601724740;
 Fri, 21 May 2021 05:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210518084619.29949-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210518084619.29949-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 21 May 2021 14:55:14 +0200
Message-ID: <CAMpxmJVGGhDfEAJNZoMsSw6Y05wRgDOtfqaYZyTzjsn_7uPfVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Make use of assign_bit() API (part 2)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:46 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We have for some time the assign_bit() API to replace open coded
>
>         if (foo)
>                 set_bit(n, bar);
>         else
>                 clear_bit(n, bar);
>
> Use this API in GPIO library code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 41b3b782bf3f..7c5afd999210 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -312,10 +312,7 @@ static int gpio_sysfs_set_active_low(struct device *dev, int value)
>         if (!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) == !!value)
>                 return 0;
>
> -       if (value)
> -               set_bit(FLAG_ACTIVE_LOW, &desc->flags);
> -       else
> -               clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
> +       assign_bit(FLAG_ACTIVE_LOW, &desc->flags, value);
>
>         /* reconfigure poll(2) support if enabled on one edge only */
>         if (flags == GPIO_IRQF_TRIGGER_FALLING ||
> --
> 2.30.2
>

Patch applied, thanks!

Bartosz
