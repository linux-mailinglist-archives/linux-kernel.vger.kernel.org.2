Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531F23B4C45
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFZDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFZDou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:44:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:42:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w13so10220017edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRVdCcPcCziowTNJTVv4QnxvuJfCULnuUiYke2HSea0=;
        b=SoLCPl3ZtO7L/E+xZKlqWCOkCFJi1KRpPwGUJ8oaq0gdyKdy89PZIttZzRunNSCDGI
         cRSyUpvniO7eF6C+qYnKg8+WnU+TnE3Tr/1cXPWHcJ7jJdU37wWrr4WlhlAxx5pC7Bix
         +mfc8DMNiYhx5+1mEcfwjXEjUTGBPQE5nOzL0/6aXg3EIzgrIwT+2sksRnfRCOEPfy+S
         BNeA7Iv3sxBnpAy5MTeO7QEnVowbesdyJaR3yQZtnqnD83dm9S3MV89WbFmBmHixOPn0
         1Onx99kcDTKY0qaZSnU38fNcTzzTelJtafNJKAmW0F+q9++r0CW2c37eon6+W/R7qYA7
         anzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRVdCcPcCziowTNJTVv4QnxvuJfCULnuUiYke2HSea0=;
        b=ClF7HnJiN+HhoM/vfUet21veYVvpKggFfxLD22Yid0BPRsIxKJMkKmFWzcj7BC6k7L
         LFiC90du/ogN0C3JnoqCY5AWLRfm/F/Oyk+1EOlHOusKyUmgK6wDwWi47iDCYUQgIa0n
         MzaZOokT1PaUwNOsnRrLUPaiXlwN23UnXLqgBeIwADP/MI+GmL1H8CXMVdVKCsljjwVY
         7pe2/OW60XPop2OVBOGH79YtMpPnfU8cBVOWjHImdH8LRWhOCr4HaoMHqpmIpiDXaRqL
         17B3nYzDo5zQlvw53Y+GD7KT+hlwvDc576EU6QjyGGIwAn+Pw+yhC2Ji5O83rh0cHNHb
         YvKA==
X-Gm-Message-State: AOAM533CyTB/Tm3hIZGdUJBbFh5ZT76WdQXH0hIXAHC+5kNjsMHtbRNj
        OpqRzq5LJANO8Bi4zgTWuXB1xmN3vZXVfnykg/mZsA==
X-Google-Smtp-Source: ABdhPJzmKzoxYw8suupbNSOYdXWy275N44i/jZoncsm9PrFhiafmJ3OobDTQE8hwye7Zpln8CcA1+anLTaaAZACHx0M=
X-Received: by 2002:a50:ee13:: with SMTP id g19mr19116888eds.147.1624678946571;
 Fri, 25 Jun 2021 20:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624640087.git.mchehab+huawei@kernel.org> <ef0ff659a875b91b454df12b57888f2b473877fa.1624640087.git.mchehab+huawei@kernel.org>
In-Reply-To: <ef0ff659a875b91b454df12b57888f2b473877fa.1624640087.git.mchehab+huawei@kernel.org>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 26 Jun 2021 11:41:50 +0800
Message-ID: <CAFRkauBcXDVihxN8MHoStGHjDyx-VyOe6tT8dkY2tAisHoeE8w@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] regulator: hi6421v600-regulator: fix platform drvdata
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -231,7 +228,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>  {
>         struct device *pmic_dev = pdev->dev.parent;
>         struct regulator_config config = { };
> -       struct hi6421_spmi_reg_priv *priv;
> +       struct hi6421_spmi_reg_info *sreg;
>         struct hi6421_spmi_reg_info *info;
>         struct device *dev = &pdev->dev;
>         struct hi6421_spmi_pmic *pmic;
> @@ -247,18 +244,17 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>         if (WARN_ON(!pmic))
>                 return -ENODEV;
>
> -       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> +       sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
> +       if (!sreg)
>                 return -ENOMEM;
>
> -       mutex_init(&priv->enable_mutex);
> -       platform_set_drvdata(pdev, priv);
> +       sreg->enable_mutex = &pmic->enable_mutex;
>
>         for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
>                 info = &regulator_info[i];
>
>                 config.dev = pdev->dev.parent;
> -               config.driver_data = info;
> +               config.driver_data = sreg;

This won't work and that was what my patch fixed.
e.g. When you call
struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
sreg->eco_mode_mask and sreg->eco_uA will always be 0.

Regards,
Axel
