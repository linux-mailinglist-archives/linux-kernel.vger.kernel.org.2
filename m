Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792114058BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbhIIOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbhIIOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:16:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAD3C08EDF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:33:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a12so998146qvz.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCZWh7t0fiDuebnxXV+Da06p0DKn6S0nC/3dScWfDqQ=;
        b=YCuYJEpD68js0MzLC4P4YrHL5iNk2IQesIQ/duiGjqr2TTYRhypWaBAhqree0QHoXr
         Uq1kKgbvVJZcESooLTbwGZHT33xQRb20vGmW9KMnxq3XkmElPFdiMnF91isH6ZvhvSBt
         F/owFqXLRlQ6kd0xF29y+cfwBqQoF75vP7HJhyC7lQ9DFWfHb5rF8xwveM+moDH1NKYF
         uxUtWXIl0/h1E8GguRUC8guwMxYn5eBNRRzWxtMXRSMQS8Rc6A1k/i0OemaHEg4JbGyl
         XstxC8Pk+NJ5ih7kRkqd+n1dikBKmpLCQVgAVmCAu+Hc+JouVRD3DlDpMtBJCYvjCRZJ
         FvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCZWh7t0fiDuebnxXV+Da06p0DKn6S0nC/3dScWfDqQ=;
        b=SvTuO7xIxU9QR4glDYyE27g4UE0irgzjq/vcmMyWWEfuZ6Ocsk5PpGgi7jwcQGGqix
         qezFUS4EuAcUBHgEyyikmH6AgFtnPEBsZBgtBuSiFN/gOOMDbnbmr4lORwbNARgHLTPe
         hXDjVraNMjA9ZpIqkwGjwdEaYPTblu2M2hjHif6/SlpiQe3QfxJw5Muu3VZHmOY5r45A
         MBsVNDiJNK0qDn85KejtsX7MCkyXhwfhJMTZOTNEPKb63jKo3aTZAx0UTUFaPC4XPWNa
         t5wIMUfoiYp6PfzK6hZ7cC8/YbrQgKVJYFNZbk7Pn9gcwp6/puxgCkQyt7jmIyxJGHiT
         dyNQ==
X-Gm-Message-State: AOAM531VyhM2KxNDK3oTfav2SgI4whJFoeJWwZXTcwBA+OoatmyFYE66
        J6H8btmRXjroSBnksVWXpq6vAbQvj9/vfpwSbXUGGA==
X-Google-Smtp-Source: ABdhPJzKUJigy0WZqHh3GTpws0zvDq54w5g9lDb16+Cqy40v3Fe42JJsLAYBaw9SA9dXSZLU4vj87/UqdDh/RB16pyQ=
X-Received: by 2002:ad4:4623:: with SMTP id x3mr791665qvv.17.1631190822661;
 Thu, 09 Sep 2021 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210625074325.9237-1-aardelean@deviqon.com> <20210704190158.6676ab99@jic23-huawei>
In-Reply-To: <20210704190158.6676ab99@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Thu, 9 Sep 2021 15:33:31 +0300
Message-ID: <CAASAkob02JJA0WGyfXMAWQrwrvJr_uKqVSkeK6O8QR4tZo-KiQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: initialize regulators as needed
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2021 at 20:59, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 25 Jun 2021 10:43:25 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > The driver tries to initialize all possible regulators from the DT, then
> > match the external regulators with each channel and then release all unused
> > regulators.
> >
> > We can change the logic a bit to initialize regulators only when at least
> > one channel needs them.
> >
> > This change creates a mx25_gcq_ext_regulator_setup() function that is
> > called only for the external regulators. If there's already a reference to
> > an external regulator, the function will just exit early with no error.
> >
> > This way, the driver doesn't need to keep any track of these regulators
> > during init.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> whilst I agree this is a bit cleaner, I definitely want to see review from
> those more familiar with the device before I take it!

ping on this

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/fsl-imx25-gcq.c | 57 ++++++++++++++++-----------------
> >  1 file changed, 28 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> > index ab5139e911c3..31776f80f847 100644
> > --- a/drivers/iio/adc/fsl-imx25-gcq.c
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -172,13 +172,37 @@ static const struct regmap_config mx25_gcq_regconfig = {
> >       .reg_stride = 4,
> >  };
> >
> > +static int mx25_gcq_ext_regulator_setup(struct device *dev,
> > +                                     struct mx25_gcq_priv *priv, u32 refp)
> > +{
> > +     char reg_name[12];
> > +     int ret;
> > +
> > +     if (priv->vref[refp])
> > +             return 0;
> > +
> > +     ret = snprintf(reg_name, sizeof(reg_name), "vref-%s",
> > +                    mx25_gcq_refp_names[refp]);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     priv->vref[refp] = devm_regulator_get_optional(dev, reg_name);
> > +     if (IS_ERR(priv->vref[refp])) {
> > +             dev_err(dev,
> > +                     "Error, trying to use external voltage reference without a %s regulator.",
> > +                     reg_name);
> > +             return PTR_ERR(priv->vref[refp]);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >                              struct mx25_gcq_priv *priv)
> >  {
> >       struct device_node *np = pdev->dev.of_node;
> >       struct device_node *child;
> >       struct device *dev = &pdev->dev;
> > -     unsigned int refp_used[4] = {};
> >       int ret, i;
> >
> >       /*
> > @@ -194,19 +218,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >                            MX25_ADCQ_CFG_IN(i) |
> >                            MX25_ADCQ_CFG_REFN_NGND2);
> >
> > -     /*
> > -      * First get all regulators to store them in channel_vref_mv if
> > -      * necessary. Later we use that information for proper IIO scale
> > -      * information.
> > -      */
> > -     priv->vref[MX25_ADC_REFP_INT] = NULL;
> > -     priv->vref[MX25_ADC_REFP_EXT] =
> > -             devm_regulator_get_optional(&pdev->dev, "vref-ext");
> > -     priv->vref[MX25_ADC_REFP_XP] =
> > -             devm_regulator_get_optional(&pdev->dev, "vref-xp");
> > -     priv->vref[MX25_ADC_REFP_YP] =
> > -             devm_regulator_get_optional(&pdev->dev, "vref-yp");
> > -
> >       for_each_child_of_node(np, child) {
> >               u32 reg;
> >               u32 refp = MX25_ADCQ_CFG_REFP_INT;
> > @@ -233,11 +244,10 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >               case MX25_ADC_REFP_EXT:
> >               case MX25_ADC_REFP_XP:
> >               case MX25_ADC_REFP_YP:
> > -                     if (IS_ERR(priv->vref[refp])) {
> > -                             dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
> > -                                     mx25_gcq_refp_names[refp]);
> > +                     ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
> > +                     if (ret) {
> >                               of_node_put(child);
> > -                             return PTR_ERR(priv->vref[refp]);
> > +                             return ret;
> >                       }
> >                       priv->channel_vref_mv[reg] =
> >                               regulator_get_voltage(priv->vref[refp]);
> > @@ -253,8 +263,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >                       return -EINVAL;
> >               }
> >
> > -             ++refp_used[refp];
> > -
> >               /*
> >                * Shift the read values to the correct positions within the
> >                * register.
> > @@ -285,15 +293,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> >       regmap_write(priv->regs, MX25_ADCQ_CR,
> >                    MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
> >
> > -     /* Remove unused regulators */
> > -     for (i = 0; i != 4; ++i) {
> > -             if (!refp_used[i]) {
> > -                     if (!IS_ERR_OR_NULL(priv->vref[i]))
> > -                             devm_regulator_put(priv->vref[i]);
> > -                     priv->vref[i] = NULL;
> > -             }
> > -     }
> > -
> >       return 0;
> >  }
> >
>
