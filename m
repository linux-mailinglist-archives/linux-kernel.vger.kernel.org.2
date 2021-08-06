Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4F3E29EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhHFLmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbhHFLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:41:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADEC061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:41:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k4so10731088wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nQLD+6skjkbCbAXtRVxzYJblr69u3sgrGea1Kimdkhg=;
        b=YMTY0G5M62cdPoLzxttQkyu20HRsdhcn5QFufOxWmckQ6BoOiXNuMogNIMvO3y8Gqd
         M9q814P+EwEhgqIl6V/jY65oG35Yl9whB0N8+RcDzLnNy0jY+/MLLe9sxBDRWnpBIW74
         UxzkxRgoNIeke97eqbkc+kxukeufMwgDn0Ivj81TNMnNGSsx+3++GFJD3dUXfXIPHsRU
         4UVMNRyjGJJG3rrjlx1jf/tL7WOCRiaAA6jmjwFaHjKG9vHpOOa5uONprUIG19E/Kl5i
         zV2+t0yuv/fmE/KhPSQzyS67TzGwKowetfINbKZLNzdYG6yulUfh1cNOfU4cs5YU7Tb4
         T5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nQLD+6skjkbCbAXtRVxzYJblr69u3sgrGea1Kimdkhg=;
        b=sUCnhrumQt/hPAniVwt1PyXCAobxEi9Vz+3tWNVX5rK58813zY5WhImb1nysDWSYvQ
         i1cEgI1F5nysNaGEkYDpz+wnLxR2b2X5PbKLRR3/TMi8CjIAYBqXN+no8fiX0EgXvhcE
         BIovgUCgp/vnjzSd0LEux5kNKFczed479/AcGz1e57/Oe8ErZiH907dk5cV4+sTMUblN
         MNtOVDy+S74Je/Vsgpb6PO6RBdb74oTJaODj0VnB3BIzpC8K5xwXKZwu9mX5PlCTktSz
         aB1PYhz9SJpMXUWPn8KDgzx6nXM6Obh5yTcT7AIO99IdymOpK1NAXocGHw/ACcIr7WwJ
         PJCQ==
X-Gm-Message-State: AOAM531kf7HyFjBjQZgecUkh5fHwCBDFaqIgjHu4kZrCp6wtCbbpw4a3
        K6HrNmjZH1cJzBKZA2TVVG/iWA==
X-Google-Smtp-Source: ABdhPJxPrgNnqnmshXFC0/HxY+BGRcJNzx350Z8+o4pEaKCHvdJ5mFiFOMqdP4FbQcyb0DKcWqNxHw==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr10407911wrs.290.1628250101656;
        Fri, 06 Aug 2021 04:41:41 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id f5sm9367814wrs.5.2021.08.06.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:41:41 -0700 (PDT)
Date:   Fri, 6 Aug 2021 12:41:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
Message-ID: <YQ0f8hJSuLqR3SGQ@google.com>
References: <20210805085611.864188-1-lee.jones@linaro.org>
 <CAKmqyKMPg8kikB7Ym6qc+VYAwt0DvyXK+xqu3SwgJwcaCyUrbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMPg8kikB7Ym6qc+VYAwt0DvyXK+xqu3SwgJwcaCyUrbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021, Alistair Francis wrote:

> On Thu, Aug 5, 2021 at 6:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > More devices are cropping up requiring only Regmap initialisation and
> > child registration functionality.  We currently only support that if
> > all required devices are represented by their own Device Tree nodes
> > complete with compatible strings.
> >
> > However, not everyone is happy with adding empty nodes that provide no
> > additional device information into the Device Tree.
> >
> > Rather than have a plethora of mostly empty, function-less drivers in
> > MFD, we'll support those simple cases in here instead via MFD cells.
> >
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Alistair Francis <alistair23@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > v2:
> >  - Check for empty of_device_id .data entry
> >
> >  drivers/mfd/simple-mfd-i2c.c | 41 +++++++++++++++++++++++++++++-------
> >  drivers/mfd/simple-mfd-i2c.h | 32 ++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/mfd/simple-mfd-i2c.h
> >
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index 87f684cff9a17..583e8c7924af0 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -2,39 +2,64 @@
> >  /*
> >   * Simple MFD - I2C
> >   *
> > + * Author(s):
> > + *     Michael Walle <michael@walle.cc>
> > + *     Lee Jones <lee.jones@linaro.org>
> > + *
> >   * This driver creates a single register map with the intention for it to be
> >   * shared by all sub-devices.  Children can use their parent's device structure
> >   * (dev.parent) in order to reference it.
> >   *
> >   * Once the register map has been successfully initialised, any sub-devices
> > - * represented by child nodes in Device Tree will be subsequently registered.
> > + * represented by child nodes in Device Tree or via the MFD cells in this file
> > + * will be subsequently registered.
> >   */
> >
> >  #include <linux/i2c.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> >  #include <linux/module.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/regmap.h>
> >
> > -static const struct regmap_config simple_regmap_config = {
> > +#include "simple-mfd-i2c.h"
> > +
> > +static const struct regmap_config regmap_config_8r_8v = {
> >         .reg_bits = 8,
> >         .val_bits = 8,
> >  };
> >
> >  static int simple_mfd_i2c_probe(struct i2c_client *i2c)
> >  {
> > -       const struct regmap_config *config;
> > +       const struct simple_mfd_data *simple_mfd_data;
> > +       const struct regmap_config *regmap_config;
> >         struct regmap *regmap;
> > +       int ret;
> > +
> > +       simple_mfd_data = device_get_match_data(&i2c->dev);
> >
> > -       config = device_get_match_data(&i2c->dev);
> > -       if (!config)
> > -               config = &simple_regmap_config;
> > +       /* If no regmap_config is specified, use the default 8reg and 8val bits */
> > +       if (!simple_mfd_data || !simple_mfd_data->regmap_config)
> > +               regmap_config = &regmap_config_8r_8v;
> > +       else
> > +               regmap_config = simple_mfd_data->regmap_config;
> >
> > -       regmap = devm_regmap_init_i2c(i2c, config);
> > +       regmap = devm_regmap_init_i2c(i2c, regmap_config);
> >         if (IS_ERR(regmap))
> >                 return PTR_ERR(regmap);
> >
> > -       return devm_of_platform_populate(&i2c->dev);
> > +       /* If no MFD cells are spedified, use register the DT child nodes instead */
> > +       if (!simple_mfd_data || !simple_mfd_data->mfd_cell)
> > +               return devm_of_platform_populate(&i2c->dev);
> > +
> > +       ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > +                                  simple_mfd_data->mfd_cell,
> > +                                  simple_mfd_data->mfd_cell_size,
> > +                                  NULL, 0, NULL);
> > +       if (!ret)
> 
> Shouldn't this be `if (ret)` instead?
> 
> With that changed this works for me as well:

You're right.  Will fix.

> Reviewed-by: Alistair Francis <alistair@alistair23.me>
> Tested-by: Alistair Francis <alistair@alistair23.me>

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
