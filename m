Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629763A10F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhFIKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhFIKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:24:05 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F003FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:21:59 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w14so15215422ilv.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6UzJhB8g25TMzOtGb3r8/gh9ASR2geRTCyrguQiy0w=;
        b=GJET2NWNYXS+LFAAxUpFrmk9Zs7bAnwHE3iuLB/rW1YsDSh9m8c4wKe+w0WDgnF6h1
         L0P0t98uOT2QI8Eu6XEGTuekKwVpnefqz68t3F6ymbfd+Woiao0MnygGP9Gf33kpDqcr
         dC9RsRwfgledY4JWR/EWy/EEAoptSenxW2M8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6UzJhB8g25TMzOtGb3r8/gh9ASR2geRTCyrguQiy0w=;
        b=MtS6PRdSC+4gIR1SnlPFmdcU4/0xHlfXCvJizKny0h8NjqFCUVXCx5ryQe2KQR1Oel
         8c5f+Mj9LQskaQYNo/s06GYbToh9KHN8FWzBs0nVpAH/pF1GA+d49adXgQeXKBjIcnc2
         /DB/9zogU5bqzBSDl+DNV7yhz6iTbF2KYKw5MnD48GFLg5JRbYS3iIXX2b7szw0NVB9b
         iefgIndN2zdNJoG6E9OfPXqLKiy4mVz69hoR+m26S9eIaD69dyrYO6HSFRVQeZWk7Gp2
         0oX2PHgtun/G86BJ6+0aPa7GvzjwMzReUI2aAovE4C37OM5byi/w0/MEVHqWj0MUPz0Y
         CZdw==
X-Gm-Message-State: AOAM533SWswd47XmC4gUPaYLkWa5nROC4ISIXX751/uWubyTe2+G7kI3
        ZqyAIh2zOBWM7bdN+sgESP4e7uxvlviIpA==
X-Google-Smtp-Source: ABdhPJyY9nyAH1OgIbs++cpx9fhfIau+n+VbrMEVfYc+OhQbPsbTkVoZ9SMF2RBKiMo26fsDh3bOTw==
X-Received: by 2002:a92:b30d:: with SMTP id p13mr5750014ilh.142.1623234119026;
        Wed, 09 Jun 2021 03:21:59 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id d12sm1349514ilr.38.2021.06.09.03.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:21:58 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id i13so19097827ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:21:58 -0700 (PDT)
X-Received: by 2002:a92:d312:: with SMTP id x18mr22776588ila.90.1623234117697;
 Wed, 09 Jun 2021 03:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
 <20210517173314.140912-9-gene.chen.richtek@gmail.com> <CAC=S1niBX4cL7EaROvG9NKSrnFFqCj+EPAZx0KASNTcF9F6E0Q@mail.gmail.com>
In-Reply-To: <CAC=S1niBX4cL7EaROvG9NKSrnFFqCj+EPAZx0KASNTcF9F6E0Q@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 9 Jun 2021 18:21:21 +0800
X-Gmail-Original-Message-ID: <CAC=S1njdq2jbjxzAp6tG50T5o7kt_RCSEZRaBEKdcraPHRe3dw@mail.gmail.com>
Message-ID: <CAC=S1njdq2jbjxzAp6tG50T5o7kt_RCSEZRaBEKdcraPHRe3dw@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] mfd: mt6360: Fix flow which is used to check ic exist
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 6:02 PM Fei Shao <fshao@chromium.org> wrote:
>
> On Tue, May 18, 2021 at 1:36 AM Gene Chen <gene.chen.richtek@gmail.com> wrote:
> >
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Fix flow which is used to check ic exist.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 50a170065a98..cdd99770f94a 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
> >                     NULL, 0, 0, "mediatek,mt6360-tcpc"),
> >  };
> >
> > +static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
> > +{
> > +       u32 info;
> > +       int ret;
> > +
> > +       ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
> > +       if (ret < 0)
>
> A dev_err() to indicate the read info error? (it used to be there)

Oops sorry I didn't realize that the patches are applied. Will send
another one for the minor fixes.


>
> > +               return ret;
> > +
> > +       if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
> > +               dev_err(ddata->dev, "Device not supported\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       ddata->chip_rev = info & CHIP_REV_MASK;
> > +
> > +       return 0;
> > +}
> > +
> >  static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> >         MT6360_PMU_SLAVEID,
> >         MT6360_PMIC_SLAVEID,
> > @@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> >  static int mt6360_probe(struct i2c_client *client)
> >  {
> >         struct mt6360_ddata *ddata;
> > -       unsigned int reg_data;
> >         int i, ret;
> >
> >         ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> > @@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
> >                 return PTR_ERR(ddata->regmap);
> >         }
> >
> > -       ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> > -       if (ret) {
> > -               dev_err(&client->dev, "Device not found\n");
> > +       ret = mt6360_check_vendor_info(ddata);
> > +       if (ret)
> >                 return ret;
> > -       }
> > -
> > -       ddata->chip_rev = reg_data & CHIP_REV_MASK;
> > -       if (ddata->chip_rev != CHIP_VEN_MT6360) {
> > -               dev_err(&client->dev, "Device not supported\n");
> > -               return -ENODEV;
> > -       }
> >
> >         ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
> >                                        0, 0, &mt6360_irq_chip,
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
