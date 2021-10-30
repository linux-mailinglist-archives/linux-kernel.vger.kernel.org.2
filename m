Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7A4409C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhJ3PCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhJ3PBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 11:01:55 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B35C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 07:59:24 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id f4so23677861uad.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IjuqMahHdNyaBa78KGlOS1qX5NWSlF1KJ8cpnmB4bo=;
        b=z1sF5/OAquI+FlHqfRehlQbtZOKE6BKQgQDa9tdlQeULWC6/Ql4LeRHjP9b2mbwnbF
         ZoW2XP3sRQA13MFiEknh9tI2OhyaSd0BlzOyyLHgLxcIjw85jL0jSDyONyU3MZTjqZV9
         gR/RqBEfuo4LIqFfDSSWApS+ZOVlDRLIi801eWZHvgmfiYGnB7ZgZzU9gc/nWL54CPtI
         pse+3G0VG2wguiPseWMWc6XjNi0/q3utmrI+mBFuCvB3BL8cIO4mNKIKBWPDMgoAquZw
         z/SOgVPxeBf6SGknKPVRgh7O9e9H7PBT0zQwZEZOfM4J6huX4O/xCWciWwdQ5qYzm9OJ
         jZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IjuqMahHdNyaBa78KGlOS1qX5NWSlF1KJ8cpnmB4bo=;
        b=64+hrNq9xDkRPki9qZq9oEy4NIDNHgkam/R+fZ4a8IxyXjOnjIo6ZeAtpXInlNZkid
         RrpzGyc0W6+llMiYoix3yCP3kTZ3XjTExHshbvzXvtYkxl/jJQ5XxURedtMsqM0LTXTK
         X4uF7t110eW1lrtgaQtx7X/g28ToOtmtPcXfT3rxtmxaflU/rBd3HhdEjGFDdRJ3+SDF
         6sXdXr6sVHKASf8TFDNLKI3pyh1rZ468IBTfE0YtRU2x/bS2Q1KVkehehlP4sLLEwUUD
         pklwxilKU6sgbp5K46sVgwbucVqtX9QAkr2MuoMblUEwnR1+PhsdOIr8nKLUgMG+XP2w
         BhmA==
X-Gm-Message-State: AOAM531/MSEzN1SeB4qmxdqj3lsQV5LwaReXfAbgUlXEBwrEXMMg02ph
        VYfHyhf9ecnCY0EJ4aK1WSvp48hzd4cQ96kbl2WTpQ==
X-Google-Smtp-Source: ABdhPJxDhOV4vhLCRmEjPxZkOuXxUpyliwM+EbagMxU4ME2yXJ2VOL2OJ15KLaUPqo4z2kLfTiMBauGtOVfyan2d8j0=
X-Received: by 2002:a67:ed5a:: with SMTP id m26mr20207720vsp.35.1635605963872;
 Sat, 30 Oct 2021 07:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
 <20211028183527.3050-8-semen.protsenko@linaro.org> <94e19dfb-5283-8826-c421-0ff140a370ab@canonical.com>
In-Reply-To: <94e19dfb-5283-8826-c421-0ff140a370ab@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 30 Oct 2021 17:59:12 +0300
Message-ID: <CAPLW+4nLNkvLf=5KZTmBFe8JFU0=srT9X0m_bYR7V4Vz7A2LeQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] watchdog: s3c2410: Let kernel kick watchdog
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 11:20, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 28/10/2021 20:35, Sam Protsenko wrote:
> > When "tmr_atboot" module param is set, the watchdog is started in
> > driver's probe. In that case, also set WDOG_HW_RUNNING bit to let
> > watchdog core driver know it's running. This way wathcdog core can kick
>
> s/wathcdog/watchdog/
>
> > the watchdog for us (if CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED option is
> > enabled), until user space takes control.
>
> This does not explain why you move the code around. I guess you miss
> here information that we should start the watchdog before registering
> it? If so please explain why.
>

Will do in v2, thanks.

> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/watchdog/s3c2410_wdt.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > index ca082b1226e3..9af014ff1468 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -732,6 +732,21 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >       wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
> >       wdt->wdt_device.parent = dev;
> >
> > +     /*
> > +      * If "tmr_atboot" param is non-zero, start the watchdog right now. Also
> > +      * set WDOG_HW_RUNNING bit, so that watchdog core can kick the watchdog.
> > +      *
> > +      * If we're not enabling the watchdog, then ensure it is disabled if it
> > +      * has been left running from the bootloader or other source.
> > +      */
> > +     if (tmr_atboot && started == 0) {
> > +             dev_info(dev, "starting watchdog timer\n");
> > +             s3c2410wdt_start(&wdt->wdt_device);
> > +             set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> > +     } else if (!tmr_atboot) {
> > +             s3c2410wdt_stop(&wdt->wdt_device);
> > +     }
> > +
> >       ret = watchdog_register_device(&wdt->wdt_device);
> >       if (ret)
> >               goto err_cpufreq;
> > @@ -740,17 +755,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >       if (ret < 0)
> >               goto err_unregister;
> >
> > -     if (tmr_atboot && started == 0) {
> > -             dev_info(dev, "starting watchdog timer\n");
> > -             s3c2410wdt_start(&wdt->wdt_device);
> > -     } else if (!tmr_atboot) {
> > -             /* if we're not enabling the watchdog, then ensure it is
> > -              * disabled if it has been left running from the bootloader
> > -              * or other source */
> > -
> > -             s3c2410wdt_stop(&wdt->wdt_device);
> > -     }
> > -
> >       platform_set_drvdata(pdev, wdt);
> >
> >       /* print out a statement of readiness */
> >
>
>
> Best regards,
> Krzysztof
