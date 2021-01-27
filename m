Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880F305E25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhA0OXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:23:07 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39893 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhA0OWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:22:41 -0500
Received: by mail-ot1-f47.google.com with SMTP id i30so1792576ota.6;
        Wed, 27 Jan 2021 06:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=587D5sQwzOQpISnpuw/zLfl/khiQsRKiyrXe7742FuI=;
        b=VXLB/yVSp5Lw5FXpgK3vsCrnsKuEgXVSbPAkDlJkLlq+CD/mjl9fq12PsEEQsfoJFi
         MCtkUIJz+3uE2UZx749l80sMaLUlQymJmwNfvgT3mEWBgh0xs0zKD86OOND6Q33M2cnv
         zgZTwtVIkYZxx4UWMcAfvivaxNXssgI+XMZ+0Yd8hYU0HgEXgAXJN8PCdrbrdRinzW/u
         NOcgXo/weY+5D+UZAeErgSuncuq6+zNmhCn0yJT2rb1mf3RYuAuCsvEk4eEIh4InWM3h
         SGDU2DyM/lZg1AF1ksPX7Y84n18W0IiaZk3sN2Tu1D+qBaXzF1W4AhO+nP6R+56LdfkA
         XK9g==
X-Gm-Message-State: AOAM533sRXeR5Kfbvkv8lbg4uUkUw+2PWhGGvto9YN8E2yYLf14wRD8L
        e1j2z/9rCwSPIx3+K7HgIkKj2UxB47Zf2anxnjODNiy0
X-Google-Smtp-Source: ABdhPJwldt+lZlYPhu/osH7yMBd55aPChuGJkaBrux0jWPyiIyO2mGqr+Ap0Sk51b3A5BrSya3weIUzfrYMlEzvbK80=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr7855321otr.145.1611757320011;
 Wed, 27 Jan 2021 06:22:00 -0800 (PST)
MIME-Version: 1.0
References: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
In-Reply-To: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 15:21:48 +0100
Message-ID: <CAMuHMdV81xSOBkw9Rfeuc8U4g3vRcucXMvVv1_1hoMexX62s7A@mail.gmail.com>
Subject: Re: [PATCH v11] staging: fbtft: add tearing signal detect
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

On Wed, Jan 27, 2021 at 3:07 PM Carlis <zhangxuezhi3@gmail.com> wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
>
> For st7789v ic,when we need continuous full screen refresh, it is best to
> wait for the TE signal arrive to avoid screen tearing
>
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> ---
> v11: remove devm_gpio_put and change a dev_err to dev_info

> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c

> @@ -82,6 +111,32 @@ enum st7789v_command {
>   */
>  static int init_display(struct fbtft_par *par)
>  {
> +       int rc;
> +       struct device *dev = par->info->device;
> +
> +       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0, GPIOD_IN);
> +       if (IS_ERR(par->gpio.te)) {
> +               rc = PTR_ERR(par->gpio.te);
> +               dev_info(par->info->device, "Failed to request te gpio: %d\n", rc);

Please slow down and read the feedback.
I said "dev_err_probe()", not "dev_info()".

> +               return rc;
> +       }
> +       if (par->gpio.te) {
> +               init_completion(&spi_panel_te);
> +               mutex_init(&te_mutex);
> +               rc = devm_request_irq(dev,
> +                                     gpiod_to_irq(par->gpio.te),
> +                                    spi_panel_te_handler, IRQF_TRIGGER_RISING,
> +                                    "TE_GPIO", par);
> +               if (rc) {
> +                       dev_err(par->info->device, "TE request_irq failed.\n");

Same here.

> +                       return rc;
> +               }
> +
> +               disable_irq_nosync(gpiod_to_irq(par->gpio.te));
> +       } else {
> +               dev_info(par->info->device, "%s:%d, TE gpio not specified\n",
> +                        __func__, __LINE__);
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
