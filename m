Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509DA305670
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhA0JGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:06:00 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36705 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhA0JBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:01:05 -0500
Received: by mail-oi1-f182.google.com with SMTP id d18so1436547oic.3;
        Wed, 27 Jan 2021 01:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6RprSXYvoMC4UVhQo7yoMn9BtMVGW5pIMAX/4sOotk=;
        b=I0JBxGA0tR4Rk4C3BTxflPqPHPc1TZBuPHjpEIZrfmXN0jh+b+X+RS+4pFyhKqf3eb
         hpE+CdQT3zYwfT4QZl3CUoIOA+dAn6YdJAwQ8VRyVCEm4pYjH503QVPK2H4hbV+crpq+
         lfbRwpDmwgQU1sLkZKtxTzDQtmj6UD6J2QvbJVhkqnhSbEym2U3Qts8hulAu/6W9+3U/
         K6mIi58MKPLFug40JzQ3HxhF87WlHQFL9+wPkreFxlyFs8toxyHPX62FMwCKIDAcuh6V
         +6jtr+POu2HJ5yXsHfmTNEwzMo1j6iS4WCYcDkpN163SxAHh/+vFxsolvgJmpGaj7R0h
         fp/A==
X-Gm-Message-State: AOAM532EHrRYZNr8+Mpst6t5LHIoZ2P/avzFtd1dYEyAnMQfxMa3k9Wm
        HPS+DuQ6c0rAWxgEPg3ZTA4rZ+0WsrTTi5YppVU=
X-Google-Smtp-Source: ABdhPJyoJzAs8/wKsxJ/K1jb7LeAbfGa10f2NI3SY3Q2AP1Px64nQ1dkLKkwuvc9IT5UbP+RktcFytWHSl+rDLQ8KQg=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr2476402oiy.148.1611738024632;
 Wed, 27 Jan 2021 01:00:24 -0800 (PST)
MIME-Version: 1.0
References: <1611732502-99639-1-git-send-email-zhangxuezhi3@gmail.com>
In-Reply-To: <1611732502-99639-1-git-send-email-zhangxuezhi3@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 10:00:13 +0100
Message-ID: <CAMuHMdV5VxNBNV-UMswKKZmQRFUvG+pnBbOOW8XJT8pbbvmp5Q@mail.gmail.com>
Subject: Re: [PATCH v6] fbtft: add tearing signal detect
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, Stefano Brivio <sbrivio@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlis,

On Wed, Jan 27, 2021 at 9:52 AM Carlis <zhangxuezhi3@gmail.com> wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
>
> For st7789v ic,add tearing signal detect to avoid screen tearing
>
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>

Thanks for your patch!

> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c

> @@ -82,6 +111,34 @@ enum st7789v_command {
>   */
>  static int init_display(struct fbtft_par *par)
>  {
> +       int rc;
> +       struct device *dev = par->info->device;
> +
> +       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0, GPIOD_IN);
> +       if (IS_ERR(par->gpio.te)) {
> +               rc = PTR_ERR(par->gpio.te);
> +               pr_err("Failed to request te gpio: %d\n", rc);
> +               par->gpio.te = NULL;

Errors (e.g. -EPROBE_DEFER) should be propagated upstream,
not ignored.

> +       }
> +       if (par->gpio.te) {
> +               init_completion(&spi_panel_te);
> +               mutex_init(&te_mutex);
> +               rc = devm_request_irq(dev,
> +                                     gpiod_to_irq(par->gpio.te),
> +                                    spi_panel_te_handler, IRQF_TRIGGER_RISING,
> +                                    "TE_GPIO", par);
> +               if (rc) {
> +                       pr_err("TE request_irq failed.\n");
> +                       devm_gpiod_put(dev, par->gpio.te);
> +                       par->gpio.te = NULL;

Errors (e.g. -EPROBE_DEFER) should be propagated upstream,
not ignored.

> +               } else {
> +                       disable_irq_nosync(gpiod_to_irq(par->gpio.te));
> +                       pr_info("TE request_irq completion.\n");
> +               }
> +       } else {
> +               pr_info("%s:%d, TE gpio not specified\n",
> +                       __func__, __LINE__);
> +       }
>         /* turn off sleep mode */
>         write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>         mdelay(120);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
