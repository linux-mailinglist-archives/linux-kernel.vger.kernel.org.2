Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3790733D0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhCPJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhCPJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:23:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:23:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dx17so70958234ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IXhW1O63bmJ8Yd0S7dPhigetZgdpUG2XeBEZKEoOTk=;
        b=UBceE/SRPgNInEgr1e11s95rOpMzM2O0jAasYVdA1+zDUwLsSJJV5qTVQb3ZGitrtc
         i2014J51k8OMFvFsEQkmZZ67kycqGpkDu/6F2hLbyjgSXYi3cFNGbX/A1ByyWM7+ZpoM
         ++SdsHTuNUfognYkuXKo6pnAMCuTgr27vUVLVgycxx5Jf4DD9iJAljX0wlmIjl8jtIif
         2vlpovJcZq1i1wBQicpzin7jnUN9aQ+rX0RPRlgq9KnUD6oxljr8TxV8Tuwi05F4p32d
         nmqZ01mh1diT89Qx8Bvu3F4LMWZhwdRFbv8qXzefgPkH/z8rR5p7Kr29kB1XkgOLFa4z
         ozaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IXhW1O63bmJ8Yd0S7dPhigetZgdpUG2XeBEZKEoOTk=;
        b=Tg+hp0RNksd4xhqwAdFTwh2st9CdsC/Jv4LkM9zYb0W9XfSGGeHLh2DvF8pDn9vIIV
         6hkZEgy3dszv2xalaDahqveXH/Kl1/4ZlBz0sV+aqgeLVe2gbnl3PenetGfzdGaspfp2
         uV/cssn3IpnXGPSuL61qTEKDwFlb64MK6dkYwGz6PnlCV1/XtpWc4t5kFfPzIdD+tIur
         0xzO5RvN5JUPwYK77SwXAYEtkhtbMLGkHyOXLIOvGR/2537JUn+Esgbtef6DlHKPS8PC
         z1h7XBO6Lq+PCnJcwoPA7ubTCuadNeqLihTqSOra1OcH5EVsWfffQfWs+jVBz9O+JgcX
         5jkA==
X-Gm-Message-State: AOAM530wy0sM7Fn3syS63ViQwFXMB8TEwyIan8SGKJstIdVtL1dVuaKy
        n2l290OsjsJB6aViJjgchakHayLv55zQujDg6ihl3w==
X-Google-Smtp-Source: ABdhPJx58TefNTCARrYlDvqMTau3fnzMU3RG+L1/JXTagjaemGGfsmD89Dj1Lvs3d9ajASHalOeUuGNkYfcWyI9ZhOo=
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr28225514ejb.445.1615886581573;
 Tue, 16 Mar 2021 02:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210315185141.18013-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210315185141.18013-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 16 Mar 2021 10:22:50 +0100
Message-ID: <CAMpxmJWtuH6JAQxbkqeAJeR99A8N4+RJF=AABK7HfrJ19WJMqA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mockup: Drop duplicate NULL check in gpio_mockup_unregister_pdevs()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 7:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since platform_device_unregister() is NULL-aware, we don't need to duplicate
> this check. Remove it and fold the rest of the code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-mockup.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 28b757d34046..d7e73876a3b9 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -479,15 +479,10 @@ static struct platform_device *gpio_mockup_pdevs[GPIO_MOCKUP_MAX_GC];
>
>  static void gpio_mockup_unregister_pdevs(void)
>  {
> -       struct platform_device *pdev;
>         int i;
>
> -       for (i = 0; i < GPIO_MOCKUP_MAX_GC; i++) {
> -               pdev = gpio_mockup_pdevs[i];
> -
> -               if (pdev)
> -                       platform_device_unregister(pdev);
> -       }
> +       for (i = 0; i < GPIO_MOCKUP_MAX_GC; i++)
> +               platform_device_unregister(gpio_mockup_pdevs[i]);
>  }
>
>  static __init char **gpio_mockup_make_line_names(const char *label,
> --
> 2.30.2
>

Applied, thanks!

Bartosz
