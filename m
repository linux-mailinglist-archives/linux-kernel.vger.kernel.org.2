Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8835653E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbhDGHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhDGHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:31:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6BC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:31:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so18310505iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vo0QZz25bVs/2wmsHRn68V68W2L/UX3nLq5t9B4qTO4=;
        b=CJAEOD5aeMlKoM1hzsZ82mfcFqX0wXQLRiDLPpVwA8eL6sw1FhbiTSZeDa5ZQTGHG7
         LQkMYNnxW++y+rUKTMoFljoeCAt+uadx9x1TFj7rxa4HNYWdAmPMCF/HrZHmYwStkzTQ
         YwAAALsXptK9Yhkho8mWNf8m17qt2IDCX001A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vo0QZz25bVs/2wmsHRn68V68W2L/UX3nLq5t9B4qTO4=;
        b=lUWCIsLO4EK/m0Wf4PSWqsKrQRyKkFlu+bYlMjh4D55vEJA4xy2WDqUHyqWpHktjK4
         6aloWF/SfQ7aOgN7EHoMfCbUG1Dry0mBoZ+pKe5Rz6xEXiprcEO18HbYsruuhVCvzg+1
         gc3zZ98G8ICNoD2IUTVIzQ5YahyHd1HjFbKw6EMcwaLSH8Jp3VZlrY/iv7thhbNpYPNf
         LJM2ODHyqeS1iJsKpYPlA1dGlyI9m9vtsJrniZkbUSMFn0uwnCwYSvanNLfUb13MJ5Ow
         08obg2vrqKFxoZaC2q2FMq6MS/k5LvsOh/8kh7A6DXHP88ZkI18JaU7gqIHChtxnu21A
         UViA==
X-Gm-Message-State: AOAM533AHdPGwZv+NZ+LixSLfpNuHjZcaKbYBsqK+a86FvmjvJ9qkr7X
        Goh/FNBRrg7kAHRG1/XJBLgzczcwY5WAvhORkhTslA==
X-Google-Smtp-Source: ABdhPJz+T5nPKW6gbNnL+LY7rqVL5oNR3VGj+Ica36EvSu5VCzeBQypy3KADhZS8Ye27TvIjvcdTakDpI+xV315kTKY=
X-Received: by 2002:a05:6638:43:: with SMTP id a3mr2064309jap.102.1617780682970;
 Wed, 07 Apr 2021 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210308043607.957156-1-hsinyi@chromium.org> <20210308043607.957156-3-hsinyi@chromium.org>
 <20210308171644.GE4656@sirena.org.uk> <CAJMQK-jZnQ1pt435Dz=xAbuU=wJcMJkSFSnTtuARTW_rGwRCFg@mail.gmail.com>
In-Reply-To: <CAJMQK-jZnQ1pt435Dz=xAbuU=wJcMJkSFSnTtuARTW_rGwRCFg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 7 Apr 2021 15:30:57 +0800
Message-ID: <CAJMQK-jqrBdfROr_XZakQb4v+jB31hvLejcSBZjPo=TYqKar1w@mail.gmail.com>
Subject: Re: [PATCH v16 2/2] i2c: core: support bus regulator controlling in adapter
To:     Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 9:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Mar 9, 2021 at 1:17 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Mon, Mar 08, 2021 at 12:36:07PM +0800, Hsin-Yi Wang wrote:
> >
> > > +     adap->bus_regulator = devm_regulator_get(&adap->dev, "bus");
> > > +     if (IS_ERR(adap->bus_regulator)) {
> > > +             res = PTR_ERR(adap->bus_regulator);
> > > +             goto out_reg;
> > > +     }
> >
> > Idiomatically supplies should be named as they are by the chip datasheet
> > rather than just a generic name like this, and I'm guessing that systems
> > that have supplies like this will often already have something
> > requesting the supply (eg, it's quite common for consumer drivers to do
> > this) under that name.  I can see this being a useful thing to factor
> > out into the core but it seems like it'd be better to have it enabled by
> > having the controllers (or devices) pass a supply name (or possibly
> > requested regulator) to the core rather than by just hard coding a name
> > in the core so bindings look as expected.
> >
>
> I'll move the regulator request into device instead of core in the
> next version. Thanks.
>
Hi Mark,

v17 is sent here:
https://patchwork.kernel.org/project/linux-mediatek/cover/20210309133131.1585838-1-hsinyi@chromium.org/

Thanks.

> > I do also wonder if it's better to put the feature on the clients rather
> > than the controller, I don't think it makes much difference though.
