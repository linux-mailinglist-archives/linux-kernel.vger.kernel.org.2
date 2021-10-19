Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB204336E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhJSNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhJSNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:23:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D5C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:20:57 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h19so8619471uax.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yakjl3k2K+eVxhNNWDfRDoKIqXUztjprPOzVgOncdWQ=;
        b=zkN1LOShPIaJLCCuJKUVdZXh8rfBKPDQq7AQULRZLfLQfG4UW0nnf6Ly3xtLBJlTU9
         iM0ceOmIGLZcBdyt0cQqrkWmdpgUFVAyoXrHS6zozluOWh62tgUkpmh54su7Ck8U2oIt
         wOU+c/ISp3063otRZJKkJ7nxC0rw+SFfhkvNR6HJgwFFJV7/N6sfQFp2Xp4+oVq/9ZPV
         Mu3EkqEprpIVcuQsE9XjwHNsidgTeLs5AaXMdyzWtlqjVG8zebe/Jg/iCMRxOlWKFU7Q
         Pv5TTAI3NG7mqhEwNocdQOC0Ziw0xP3r98/0TwFWpsWeH5Fbko1Bk4Rz76jhito2YnEX
         DbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yakjl3k2K+eVxhNNWDfRDoKIqXUztjprPOzVgOncdWQ=;
        b=BdI3VsgCuajfatiadjtlqKUNrovNvwilOzrzDUkU0STpE30+c9w8p2mhQ6kyDV9zQL
         9JsAbLHkCPWlze5sjfOaWvPGL2HWZar1deHAct61AXrLB5vz8MzfIDmILL6/DPff2WTo
         ztpgA/Vb0LJdmse5TIdnyDPmEvEj8AzLEBCpRaRkDl1mGpfvmw+Ux81vkGKhXPZ4Y5Kk
         LnGi6KQXt9C3SfhDHwaTaWWBLLONR8DV7TTIQhxurZNj8Q++9MQzqZ+qowbbFOS25uvJ
         XPXS8uTCqEqy7mUvlONHa8roX6mVGj3SNohbr+692FVmKbgimmv52vxt8cGIH79W1FeY
         b1ng==
X-Gm-Message-State: AOAM530G0BOa1F1L5U54eOlPRbF7ZcRfJ+xj2O45RSHPdY2wPbPYHAPJ
        bTyEaqs+zoaucaLE3UK2U3F4sVGTcfghIvfsaa7Kng==
X-Google-Smtp-Source: ABdhPJzEXTNc1bgO5xY3Fz7Wp7BiIO+u3gIQlsaK3t6XTvo2QR/edpc1j0onYDbLRZc+kiVFbJ88kbsY/xppDBq4YeE=
X-Received: by 2002:a67:1781:: with SMTP id 123mr35032706vsx.1.1634649656361;
 Tue, 19 Oct 2021 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211018173201.2166-1-semen.protsenko@linaro.org> <YW3DjEuszEZ1Uw6/@piout.net>
In-Reply-To: <YW3DjEuszEZ1Uw6/@piout.net>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 19 Oct 2021 16:20:45 +0300
Message-ID: <CAPLW+4mLdu-QGhhpFMsMK-GCS9vY9r-L0NnjyijtohfeRSiC3g@mail.gmail.com>
Subject: Re: [PATCH] rtc: s3c: Remove usage of devm_rtc_device_register()
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-rtc@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 at 21:57, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 18/10/2021 20:32:01+0300, Sam Protsenko wrote:
> > devm_rtc_device_register() is deprecated. Use devm_rtc_allocate_device()
> > and devm_rtc_register_device() API instead.
> >
>
> If you do that, please also set the range properly, either in the same
> patch or as a follow-up.
>

No problem. Just sent patch series [1], which supersedes this one.
Time range setting is present there in [PATCH 2/4].

[1] https://lkml.org/lkml/2021/10/19/632

> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/rtc/rtc-s3c.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > index e57d3ca70a78..10e591794276 100644
> > --- a/drivers/rtc/rtc-s3c.c
> > +++ b/drivers/rtc/rtc-s3c.c
> > @@ -447,15 +447,18 @@ static int s3c_rtc_probe(struct platform_device *pdev)
> >
> >       device_init_wakeup(&pdev->dev, 1);
> >
> > -     /* register RTC and exit */
> > -     info->rtc = devm_rtc_device_register(&pdev->dev, "s3c", &s3c_rtcops,
> > -                                          THIS_MODULE);
> > +     info->rtc = devm_rtc_allocate_device(&pdev->dev);
> >       if (IS_ERR(info->rtc)) {
> > -             dev_err(&pdev->dev, "cannot attach rtc\n");
> >               ret = PTR_ERR(info->rtc);
> >               goto err_nortc;
> >       }
> >
> > +     info->rtc->ops = &s3c_rtcops;
> > +
> > +     ret = devm_rtc_register_device(info->rtc);
> > +     if (ret)
> > +             goto err_nortc;
> > +
> >       ret = devm_request_irq(&pdev->dev, info->irq_alarm, s3c_rtc_alarmirq,
> >                              0, "s3c2410-rtc alarm", info);
> >       if (ret) {
> > --
> > 2.30.2
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
