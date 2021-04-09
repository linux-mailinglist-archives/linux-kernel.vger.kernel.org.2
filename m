Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABD35A2F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhDIQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbhDIQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:22:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EDC061760;
        Fri,  9 Apr 2021 09:22:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so5242471pjh.1;
        Fri, 09 Apr 2021 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7xFBcWlzYhkzF0WJIFSviLducCgzZ0CokBZ31tudr8=;
        b=QBGtFUpxtyST88wpT2VS1e6bxUVNLEU3isT8LbSz2sjUN67usjspo0zLuXLHg5ftPr
         BxtX+hEvwiHAksy4TUZNqb/fOESLtTU7O3x9lCAQBxsUMepp8icZmyIrQYj7yUGMVRRQ
         9bi6caEfDqwrp96z94DwqYDPHhfsu41Dv25sa3n8FpWKGaxqIVbHt8NDj64T0b5LAw49
         GPXGLFw17N5Gu/b9Oh/hz9Dr1VpocZNDK3SScYjFEzqKhdlNrOeXrILfA1ZcgZxt4pHU
         IFePyE7Wf0wA/SnOn8ngEBVSAeHW0aboJDYud4jOpq0ozjGNp54uJFE3MTvTqrQUbSTC
         9aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7xFBcWlzYhkzF0WJIFSviLducCgzZ0CokBZ31tudr8=;
        b=ZmcafCvko2hgRqz80myii74H0GZnIT9B9YcmhoNEfUoByQkOrJos5arqh0o6yxpOzW
         gxBZj+FvTN9f1/UVD7ZGb54Q71tLdlWDkgGTKjRf+nguuAHZxJ7+5spVOAPz+a8hMOPh
         AFt31QaYwNKBm63+j8/YL3Yi++CW2pJzVPkEjPcf1rdQTqWPdV0ID+Uaf9h9m38hCIZe
         iBCnK8OPYm1Szsi0trjpo9GwlgEDdU6JYbQpsX8rjQYFsj5FbOxnKySFTnfvu8Bpgr5R
         QjOy141BeAc/JvRPJjFtRVlHepvXUvZ8oTcXJjW/aezAxUqH0FvU7PurufDoc1G3lWRt
         hy7A==
X-Gm-Message-State: AOAM532oyhYm9GBQOKUz/mSVEXj/RJ1q/SotMGPNaiuftRpuXgqd9Icm
        VevWDuGruUT3MZJDzf7TSrFc0i3qsUnZqTsR8hs=
X-Google-Smtp-Source: ABdhPJzHulcDtkpv4/jVHu4ZJ3AL1cpR1QPajGhCJtU749k98+sXH4kPAbU0LNRTIISGw79xEitiTU7U/Qor3y/kjxs=
X-Received: by 2002:a17:90b:1e0a:: with SMTP id pg10mr14589038pjb.129.1617985363066;
 Fri, 09 Apr 2021 09:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210409155216.31867-1-johan@kernel.org> <20210409155216.31867-3-johan@kernel.org>
In-Reply-To: <20210409155216.31867-3-johan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 19:22:26 +0300
Message-ID: <CAHp75VdEgDuwrRPFm1BXQXQFSNZzC2qQnBG-DJt+GqLzJ+HwuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] USB: serial: cp210x: add gpio-configuration debug printk
To:     Johan Hovold <johan@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 6:52 PM Johan Hovold <johan@kernel.org> wrote:
>
> Add a debug printk to dump the GPIO configuration stored in EEPROM
> during probe.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/cp210x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index ceb3a656a075..ee595d1bea0a 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1543,10 +1543,16 @@ static int cp210x_gpio_init_valid_mask(struct gpio_chip *gc,
>  {
>         struct usb_serial *serial = gpiochip_get_data(gc);
>         struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +       struct device *dev = &serial->interface->dev;
>         unsigned long altfunc_mask = priv->gpio_altfunc;
>
>         bitmap_complement(valid_mask, &altfunc_mask, ngpios);
>
> +       if (bitmap_empty(valid_mask, ngpios))
> +               dev_dbg(dev, "no pin configured for GPIO\n");

Shouldn't we drop the GPIO device completely in such a case?
Bart, wouldn't it be a good idea for GPIO library to do something like
this on driver's behalf?

> +       else
> +               dev_dbg(dev, "GPIO.%*pbl configured for GPIO\n", ngpios,
> +                               valid_mask);

A nit-pick:
I would change GPIO -> pin in the second message in the first occurrence.

>         return 0;
>  }
>
> --
> 2.26.3
>


-- 
With Best Regards,
Andy Shevchenko
