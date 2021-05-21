Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48DA38CB28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhEUQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhEUQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:37:26 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17648C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:36:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id d14so20330918ybe.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1dOqFSSZPpQ9Fgo3UhWdWkVJF/jVeCSjCFheVI4a2ik=;
        b=RoTVA2NgHUbxRJhBJ/luJ49b3as6mCmRsiOebUYm7u0Af1Dv4jYhCFuxRUolVEHw5k
         Rh/Hm5ZrO40SNvD0NOyzH7CNaLyrCAjFz1XR+jT5yQajxGx61DlJIX3hlc1Kjl/Vduw8
         zSM2qx65ETxEx6K6IrATwctFyiuiB7zv5ZHqvrdCPjYLG/cVnHMbCFi/wW59xMkp3P18
         kcfDMAF7VXuyXLUOE4e5E76wvPsWKP2M+YVKBX0mr5GwHoFdQRJ+FPfMc700uBzIK+Bd
         F/MvTVIke6bfpVCwcMli5uF5HEY99M7WI09Ov33IjJztIYA4lH6ke2vhSvJUBIlEkrWg
         wm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1dOqFSSZPpQ9Fgo3UhWdWkVJF/jVeCSjCFheVI4a2ik=;
        b=ZSAbVeSPBA6DE+l019QkiYoyJTeKd+6m+8AhVfeLadGy9loW8Y84S8nPz/3cwH6we0
         VGE0bY6hhJlIAYw1VrI7/0YYDcNtVaOkRUmJON0j0mpak5qzMSlY35aUDL5ecns/zI5p
         qmobPqhSeLAA/gwsBqDnB/C7pmpXafcuRZ7ibusmuxhdiD9/HV7admuVJyQyV/0uCVoL
         MfqAZ5/SrKzIDsM+e5/m1kYaSmNXdv1yCf7q3EjWTGn1d+5rjjjRCaJm/2k4+FoOoqqb
         +L4F10jcZ6t/VwrSHtmdu+TRnJuk9wc7VKBv1dYoLzBOPzwWqMaNwyWR10hOXuDf2h6f
         ULTw==
X-Gm-Message-State: AOAM533mSF+B28D0n9f4rRPewsm4/xoB/bUL794FmDJzliavGJqvKlBk
        c3YrskibFHmeJz2YUT9QMWQ+GQYkvv/nDP/FLBRWCA==
X-Google-Smtp-Source: ABdhPJzcuGIGx/pxw8hsmVSOoMBfMrfo9cnaLqQndAXSfql50m/o1R/dwloSkOOvXmhlfSpY7l2MnV0Osiziuq3zeLE=
X-Received: by 2002:a25:287:: with SMTP id 129mr16144124ybc.312.1621614961384;
 Fri, 21 May 2021 09:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621577204.git.matti.vaittinen@fi.rohmeurope.com>
 <e3d3e704804668d1403f3630c181010b34409c8f.1621577204.git.matti.vaittinen@fi.rohmeurope.com>
 <12bb40f022be0378ed493e7ad33122b0@walle.cc> <87a6ooh46s.fsf@miraculix.mork.no>
 <d6bb1e458d5aa6a32f31f7731e1a6097a225d634.camel@fi.rohmeurope.com>
In-Reply-To: <d6bb1e458d5aa6a32f31f7731e1a6097a225d634.camel@fi.rohmeurope.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 21 May 2021 18:35:50 +0200
Message-ID: <CAMpxmJXkYZ7mZA426Jgm_zL+L1ZFB1ToRf2L8oGmyBuOHQo=UQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: gpio-regmap: Use devm_add_action()
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "michael@walle.cc" <michael@walle.cc>,
        "bjorn@mork.no" <bjorn@mork.no>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:31 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
>
> On Fri, 2021-05-21 at 10:38 +0200, Bj=C3=B8rn Mork wrote:
> > Michael Walle <michael@walle.cc> writes:
> >
> > > Am 2021-05-21 08:28, schrieb Matti Vaittinen:
> > > > Slightly simplify the devm_gpio_regmap_register() by using the
> > > > devm_add_action().
> > >
> > > Hm, nice, but what bothers me a bit is that no other subsystem
> > > does it that way, eg. hwmon/hwmon.c or watchdog/watchdog_core.c.
> > > They also store just one pointer, thus could be simplified in the
> > > same way. What I don't know is if devm_add_action() was intended
> > > to be used this way. So I can't say much for this patch ;)
> >
> > There are some examples.  Like:
> >
> > int devm_i2c_add_adapter(struct device *dev, struct i2c_adapter
> > *adapter)
> > {
> >         int ret;
> >
> >         ret =3D i2c_add_adapter(adapter);
> >         if (ret)
> >                 return ret;
> >
> >         return devm_add_action_or_reset(dev, devm_i2c_del_adapter,
> > adapter);
> > }
> >
> >
> > You should probably use the devm_add_action_or_reset() wrapper here
> > too,
> > catching the unlikely devm_add_action() alloc failure.
> >
>
> I was thinking of it but as the gpio registration succeeded I was
> thinking that we could go on with it - (which means we can proceed but
> the gpio is never released.)
>
> I am not sure how much difference it makes in the case of small alloc
> failure ;)
>
> But as it seems I am in any case re-spinning this I can change this to
> the devm_add_action_or_reset() and fail the gpio_regmap registration if
> alloc fails.
>
> Best Regards
>         Matti Vaittinen

Hi Matti,

Please use the reset variant. We always want to roll-back the changes
done in a function before the failure and propagate the error code.

Bart
