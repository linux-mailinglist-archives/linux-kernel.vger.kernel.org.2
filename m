Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F70412A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhIUBeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhIUBeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:34:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73BC08EB26
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:05:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v24so64649932eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU7cvM5PEGyRcNJxXhrz4KrtRbPr7EX5WBgJywTvWKY=;
        b=aJWKVw64oeyoRl5vGYArhl2y79yi8hMO1OwshxrjdyyZRGWk5o6rIqhC8bqga8F/uf
         onqA7Xqi28+eIiRjjA19DE4V2yRUHpNmU1Ph/7L/P10+BY1XO2FDq0ErARsb5p1wF4NC
         iFzwn2Byt9ASMrSF/TH2d21FsdNdzJQBneNIaVrhW0+mbcx71Cx/7XsLOTMUGOzodj/M
         KYMm3Tja/KFAP9VgccdgJKPvlh4xeW0k/qKUzhE/JdcsYbMWG+2/lPu1FUvXSKqScK7b
         UPWkxh7zbevO76IMjca79uSyqPYAKUUxIGmiS1vMmV2XJUhCcBeoHn1oTgaA+mh0dhPr
         BVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU7cvM5PEGyRcNJxXhrz4KrtRbPr7EX5WBgJywTvWKY=;
        b=ElB2ZLW1gIFwLWgu/4r0qUfNhrBmM6xVwDUawJDbBdAdaCukRyiVo0368jcD4eP4O4
         DsZ+ApU4S9qiUXAXOwbDNElrjD9u/vQ0Bl5YCd/JwAnHHjRNKOMg3c6iu23eCjMh4Xkn
         ENzCawDfx+JO8/X9gKmkZ7iLo/9XEgswzlOZpBDVbzCXTCh2JuVqjx2uwRSBn3bkSYOt
         1q/4G9e/HUSTQajaEoZmG0AI+4KPv3cfPKNwcM/0N1viO9YUZwjqeyh9jqpCSa6DeWxt
         ISFonXHszxOEdY6qRB57EZTxM8fjteVZXsij4azNIk6X7PsnHyvl2o5Nfsgrwkojjq6G
         f/nQ==
X-Gm-Message-State: AOAM532/slUrP1+Fsh3b9lNQV+NJIeaBTDEbljFSP6tjK+Tb36vPI+Wt
        3a3aVwbk6+g/jDLaISRsfry2WxpQedkum5v9m6r/TMnyIhvluA==
X-Google-Smtp-Source: ABdhPJxmR593/MPAQk2Xqg47pVQ+UDuYPO0btjpGJ3TcpM176eIGgymlOdP99yhb7I1zGmOOzWbUpDHD3PNYosB3ng8=
X-Received: by 2002:aa7:df09:: with SMTP id c9mr31090749edy.243.1632161129883;
 Mon, 20 Sep 2021 11:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210919211129.4364-1-linux.amoon@gmail.com> <7dcee097-9119-1987-9bb5-777d541cc9f7@baylibre.com>
In-Reply-To: <7dcee097-9119-1987-9bb5-777d541cc9f7@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 20 Sep 2021 23:35:18 +0530
Message-ID: <CANAwSgRtChYZWogwSVggqT1491oWx-eAf8d95dGvPkLy3=1DwQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 20 Sept 2021 at 13:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 19/09/2021 23:11, Anand Moon wrote:
> > devm_regulator_register can return -EPROBE_DEFER if the
> > regulator is not ready yet. Use dev_err_probe() for
> > pwm regulator resources to indicate the deferral reason
> > when waiting for the resource to come up.
> >
> > Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")
> >
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/regulator/pwm-regulator.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> > index 7629476d94ae..451e57a739f8 100644
> > --- a/drivers/regulator/pwm-regulator.c
> > +++ b/drivers/regulator/pwm-regulator.c
> > @@ -382,9 +382,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
> >                                           &drvdata->desc, &config);
> >       if (IS_ERR(regulator)) {
> >               ret = PTR_ERR(regulator);
> > -             dev_err(&pdev->dev, "Failed to register regulator %s: %d\n",
> > -                     drvdata->desc.name, ret);
> > -             return ret;
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "Failed to register regulator %s: %d\n",
> > +                                  drvdata->desc.name, ret);
>
> No need to keep ret and print it since it will be printed by dev_err_probe, pass directly PTR_ERR(regulator) and drop the ": %d" from the error string.
>
> Neil
>

Thanks for the input but it's a wrong fix I meant to fix another probe
defer with *devm_pwm_get*
I will correct this in the next version..

Thanks
-Anand

>
> >       }
> >
> >       return 0;
> >
>
