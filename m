Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19E43FB42A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhH3K5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhH3K5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:57:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F08C061575;
        Mon, 30 Aug 2021 03:56:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so13572965pjr.1;
        Mon, 30 Aug 2021 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuLKz1s8t6PFtB3h5yQO3vsoV8BYc4QlCilxBHWTOcY=;
        b=gN/rIRJ+8Mk/MKOcw84CamLKnAejx1PZuqVsRV51WgkCvcJS7L9PiWIKt0TnmceP+T
         LWRDkoPqbMr9zTFv9XJG9Xj6TvqGCnYGa2ohFlCriTb69HjNgWfGichEWUseAQJg8Qsl
         iStTTO2OwqYvqYUWFGIDNLosinsIhEUxZjbRsO/5KlbtLOoVF5GvI5t+lsvGViaPBnQw
         G1mpqa0KY8zOeAIG0D/9eXsQNhPiHz0rsAnndZfMmWCv2GlWNdHhtwzjFXWD865dWSqo
         SaOF8r+DOgfxRSRI67JQUnYEoeorL/SCpBhsnCahpdVRGWchqt58a1hlZ8GGQUVWuvH1
         fz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuLKz1s8t6PFtB3h5yQO3vsoV8BYc4QlCilxBHWTOcY=;
        b=pGlxPNvk73Iy/5Q739JMOQScsxoRtFmyCF38I8VaUKTtivk6S5QTV4H3Y/FoboLzq+
         moxA69QduikECkXp78SIkb9j0K/EWZNVzuQd1pBAqgc2vY0xSXetwzOpbO1SLiUL7rik
         eaZ0UYzi+iFeqnVs5TfPfOIiS0dYw89+Knl/CAT83o+OR4hEjbSL52OEcrRXdjsgz9Qo
         v+cKfvx+entxr+kNe1tul4MyGMQkYQHwwenuGQKrXBQUj6Gkns9++pNiyRkZWJHh89fr
         nLE2ar8dAzk+trLO1V/mYCjD1y58lgjSr39I8SPu7MnsuGzl66oCIMKudcKQ9P/vzzRB
         JmMw==
X-Gm-Message-State: AOAM532iPJzPNUiG4wcjM1PsPszjNzYe15dl99IGsHnqLqBfqPLVQs0v
        +Ty97P78F7AJ0wpQWBacmIAVvuzZdYoSsgBM2ak=
X-Google-Smtp-Source: ABdhPJw9OgY3Xxn2H4QQ1g1xlibhj/dL2aOLnV1zyaaGrMut4CoMdwiVwchEgR4QZ2kpD0o9m8nYPxIOOJnVw03hs7U=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr21312883pls.17.1630321019360; Mon, 30
 Aug 2021 03:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830104426.487246-1-atafalla@dnyon.com> <20210830104426.487246-2-atafalla@dnyon.com>
In-Reply-To: <20210830104426.487246-2-atafalla@dnyon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Aug 2021 13:56:23 +0300
Message-ID: <CAHp75VfgbA0upoHyDLPCRGrN+7H5mZiDu-GbQPxHid++Z9UqQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: max98927: Handle reset gpio when probing i2c
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:48 PM Alejandro Tafalla <atafalla@dnyon.com> wrote:
>
> Drive the reset gpio if defined in the DTS node.

...

> +       reset_gpio
> +               = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);

A bit of a strange indentation, shouldn't it be one line?

> +       if (IS_ERR(reset_gpio)) {

> +               ret = PTR_ERR(reset_gpio);
> +               return dev_err_probe(&i2c->dev, ret,
> +                       "failed to request GPIO reset pin");

It simply as

               return dev_err_probe(&i2c->dev, PTR_ERR(reset_gpio),
                       "failed to request GPIO reset pin");

> +       }

-- 
With Best Regards,
Andy Shevchenko
