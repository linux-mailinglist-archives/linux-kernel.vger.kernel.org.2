Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82C38C727
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhEUMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhEUMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:52:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FDC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:51:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id w1so16008839ybt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1031xvHox3IqpUP8Gjv1QFEbAZ7S49fD5R5PiXK2yYg=;
        b=DLPG6z39HWjkxmpSqFUVCek0GlAQ1nb3A4zG8N44ISIo/yHAWk3QMs+Ty0UCv/P7Fe
         CBKsJmbQ/pWH1BAGQlWGyMeFlopMoCG2OqTIgg+hFaG1NzlvdKJTjgBDHEfHUmWLzZm2
         dW8abifNbkrsW1h6G24EFgaBHGhJS82Dx6Jg+DGsGIYDMgE5nepOEOMfE9y8V1CswX8m
         AgAsrnfobg20HP+s6frD0Zi4ngys79ksTfpMc8otFYqcfkW6BgkbEYw2ZPWx0AXt6kib
         SoxFLTO8YCP+/N/+CDYUVNjR9cFjCYGbx1AV705Kp51tLnUPHCX7Nodh0ozoQ1pLsw1g
         2H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1031xvHox3IqpUP8Gjv1QFEbAZ7S49fD5R5PiXK2yYg=;
        b=mTvbIYRTfd4x8NLrTJ2miJMX/kMVYfxEcEhIJCABS6mK4l799W0Svl10H/Ii0CVixE
         YjUvVDZWijYOG1rubol27hx6E2UsMkh4SshWn6x1D+yP683/Ed2H1Q5LVuUVkJJ6Zih0
         oAjzbPCQFQlZS/n+nVw1Q4jIuSzaFfXAwIPmv3QGnSavwWlo2uOoXavs7aTWQA2D+NkI
         9ttEEDfW3E74sTwrOHPF7bbiubWI10XIzYL5cRwQyNBh4Z3qPs9wjZtD+DbTt+ka7Krw
         osjsNO/QfHDV6QIi3H3MBiidfn2OMwlR0nhec3V4nf9QuiqVKZ571hH1hCd/nqokwDEi
         B8iQ==
X-Gm-Message-State: AOAM530gPJJoQZjcJ5pFTmUVOv2V+u63NL90sSyYil24h/TYQtpgiRme
        g4GADLcZ7kUo+y8MtRHjU/5LxCAsM8uP8bLs5ah+Bw==
X-Google-Smtp-Source: ABdhPJx3gTH4ovT/cdCks76OeioQC7H7qLDbHfby4Rjjwj7m33rMzDXkAs3x6D36pyAaUZj8Tyv3wuHazQeW0FTLWKA=
X-Received: by 2002:a25:287:: with SMTP id 129mr14691259ybc.312.1621601490936;
 Fri, 21 May 2021 05:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210510195221.12350-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510195221.12350-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 21 May 2021 14:51:20 +0200
Message-ID: <CAMpxmJWiqaD6bYLSvzOA8CjgvYnswiEmBnZEzAfOskAZ3hOewg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Drop duplicate offset check in gpiochip_is_requested()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> gpiochip_get_desc() already does the check, drop a duplicate in
> gpiochip_is_requested().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 1427c1be749b..220a9d8dd4e3 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2004,9 +2004,6 @@ const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct gpio_desc *desc;
>
> -       if (offset >= gc->ngpio)
> -               return NULL;
> -
>         desc = gpiochip_get_desc(gc, offset);
>         if (IS_ERR(desc))
>                 return NULL;
> --
> 2.30.2
>

I applied this some time ago just forgot to comment here.

Bart
