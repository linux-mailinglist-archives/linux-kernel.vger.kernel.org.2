Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5C3FAEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhH2WOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:14:38 -0400
Received: from dnyon.com ([82.223.165.189]:56182 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbhH2WOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:14:36 -0400
X-Greylist: delayed 23025 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Aug 2021 18:14:36 EDT
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id B9FFC40442;
        Sun, 29 Aug 2021 22:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630275223; bh=aw1SvFqyWFMuJYWbD3SZOO+rClzP6Lw/Acya+RIY0Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Rm6SJJkrMKPuF+qpFkge2kUEP2OnceG6Oj82j5mVk5rpJ5ifwekPM3xIcBdpVKax
         guOds/fzBIIN3+sEkB4s1Fp9HtUlr1/h4Uv08V2rinlaUaTJc8lL29/5Ha4F+dYDgx
         B4E7w15wun17uk/RXfxooBui4QdPCc60SOfzBdHIo1KCXqPLLFMbpQ+2y7hAMTWFLB
         iOTzEORaqZO9+ueEg+7vyGzdApzmR6Bk6ybW2A3J1ZTkk3eGxfslMVDbb0kY3y4g9w
         yOlJCrN23bjtoj0b8zE40rkjOmMtmAq5HPN7d7TbuLOyS3D+aQvDURkklfNeMu5IZu
         +xhjR9EBwcRbA==
Date:   Mon, 30 Aug 2021 00:13:41 +0200
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: max98927: Handle reset gpio when
 probing i2c
Message-ID: <YSwGlXEFRuUvNGZ7@dnyon.com>
References: <20210829170019.384632-1-atafalla@dnyon.com>
 <20210829170019.384632-2-atafalla@dnyon.com>
 <CAHp75VdY9uoTWeJEroi3iChnToUSxe+Henmg7Yux+UWkK59jQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mensaje
In-Reply-To: <CAHp75VdY9uoTWeJEroi3iChnToUSxe+Henmg7Yux+UWkK59jQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Sun, Aug 29, 2021 at 11:22:35PM +0300, Andy Shevchenko wrote:
> > +       max98927->reset_gpio
> > +               = devm_gpiod_get_optional(&i2c->dev, "reset",
> > GPIOD_OUT_HIGH);
> > +       if (IS_ERR(max98927->reset_gpio)) {
> > +               ret = PTR_ERR(max98927->reset_gpio);
> > +               dev_err(&i2c->dev,
> > +                       "Failed to request GPIO reset pin, error %d\n",
> > ret);
> > +               return ret;
> 
> 
> 
> Spamming logs is not good. Use
> 
> return dev_err_probe(...);
Okay.
 
> > +       }
> > +
> > +       if (max98927->reset_gpio) {
> > +               gpiod_set_value_cansleep(max98927->reset_gpio, 0);
> 
> 
> 
> You may request the pin in a proper state, also with current code you seems
> mishandle the conception of the logical pin level vs. physical one.
Right, i made the mistake of basing off an old driver that use legacy
functions.
 
> > diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
> > index 05f495db914d..5c04bf38e24a 100644
> > --- a/sound/soc/codecs/max98927.h
> > +++ b/sound/soc/codecs/max98927.h
> > @@ -255,6 +255,7 @@ struct max98927_priv {
> >         struct regmap *regmap;
> >         struct snd_soc_component *component;
> >         struct max98927_pdata *pdata;
> 
> 
> 
> > +       struct gpio_desc *reset_gpio;
> 
> 
> Why? Are you using it outside of ->probe()?
No, I'll delete it and use a local variable.

> With Best Regards,
> Andy Shevchenko
Thank you for the feedback, I'll address all the issues in a V2.

Alejandro Tafalla
