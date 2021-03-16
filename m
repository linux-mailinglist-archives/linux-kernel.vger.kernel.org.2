Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496E833D3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhCPMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhCPM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:29:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6740C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:29:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dm8so21286291edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frS6cCLPOhoy6WT0w0VG2Zdhbvi3Fgut+iQRwiWciZM=;
        b=YbgzcrArNyGLlL04bYdE/q4fB1g3O2g7a5l713GEu5fNEryQecu/1Z3UxakkDw8ojo
         ZVzeZA05ZZ6ZEqaEnGW3Q1EEyENRD/4B8laSjyqDLfiTJMTh2ZsTljIJt4zbb535pV/l
         dXJ+j+FWboYJoDHWX2gJZu5BXn9qmnyzzViwQ2vSClrpOZ5Jzj0yDxhyXFyd+VWI9198
         gdZn+d4RVXwYT3MeiYteW3OfwFZMhU/U+Q6gpBVeON/EchAg97u7QfUkoe872zC2af3o
         4a4aK62qhCGgYfOTpKviLHonayFBEIellXQ/T8AWs+rD0qtxkRG9LQWax41QP0RQIUe5
         Sm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frS6cCLPOhoy6WT0w0VG2Zdhbvi3Fgut+iQRwiWciZM=;
        b=Uio7ijAFJ55FNoSGRVn2ZuRGuxAjPIx/Jao16j6W1GJFHyrTfnqHJ6m1C7KKlWzOWz
         1i3CduO99Ba1/qInveRgHGEIKS7wBtAdtMJhkEe7Wy0El6I7+wIJtEf1snz/hx4QG6ji
         Bakg+hexAckRw4RvJP3kZx60rmUQZlw3MlXJENQiXRJY2Md83UAg6fAxjQ60xQdm83xe
         HoV795u1/DXIsFG+vOZa283nidKGtIUldiAGDaPz0I58Wo3i1sHzpAJ5kaP3rneVCfmr
         1JMGywwfBJKCGTaW/BChtj6TCgvxlrGgqj501WVcL8y6WfiWk6uzl3S8J5l3F07LIIFj
         GjMQ==
X-Gm-Message-State: AOAM532bGKBW6YZ3QlNmt5AK+RbO4HsBMgedPU9GEiINZaN+DEYMX7js
        Jcxwj4H98Clm+duaKA0krceY03AQq16gHgGRkNt/uA==
X-Google-Smtp-Source: ABdhPJx2Ejcwpp4xgO5liW2B5NUm/mY2puj2eqrCQhl327oaZ05ACdKJVa5h+tRxPhEvirjf9wez1kpAGiQdHt4b01Y=
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr35716883edb.113.1615897778669;
 Tue, 16 Mar 2021 05:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210315165940.90055-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210315165940.90055-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 16 Mar 2021 13:29:28 +0100
Message-ID: <CAMpxmJVZVD9mRGSkpVKV2jJdWUVOKtQfquuHo7toi2TWqf+ddQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mockup: Adjust documentation to the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 5:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> First of all one of the parameter missed 'mockup' in its name,
> Second, the semantics of the integer pairs depends on the sign
> of the base (the first value in the pair).
>
> Update documentation to reflect the real code behaviour.
>
> Fixes: 2fd1abe99e5f ("Documentation: gpio: add documentation for gpio-mockup")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/admin-guide/gpio/gpio-mockup.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
> index 9fa1618b3adc..493071da1738 100644
> --- a/Documentation/admin-guide/gpio/gpio-mockup.rst
> +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> @@ -17,17 +17,18 @@ module.
>      gpio_mockup_ranges
>
>          This parameter takes an argument in the form of an array of integer
> -        pairs. Each pair defines the base GPIO number (if any) and the number
> -        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
> -        will assign it automatically.
> +        pairs. Each pair defines the base GPIO number (non-negative integer)
> +        and the first number after the last of this chip. If the base GPIO
> +        is -1, the gpiolib will assign it automatically. while the following
> +        parameter is the number of lines exposed by the chip.
>
> -        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
> +        Example: gpio_mockup_ranges=-1,8,-1,16,405,409
>
>          The line above creates three chips. The first one will expose 8 lines,
>          the second 16 and the third 4. The base GPIO for the third chip is set
>          to 405 while for two first chips it will be assigned automatically.
>
> -    gpio_named_lines
> +    gpio_mockup_named_lines
>
>          This parameter doesn't take any arguments. It lets the driver know that
>          GPIO lines exposed by it should be named.
> --
> 2.30.2
>

Applied, thanks!

Bartosz
