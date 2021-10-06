Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C85F423B31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhJFKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhJFKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:16 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5BC061749;
        Wed,  6 Oct 2021 03:02:24 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id g13so724887uaj.3;
        Wed, 06 Oct 2021 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uau9/pR+8X0YYImoS0Wg4cgXBZAlRqGIWfRwQoTAlIs=;
        b=FqojcO+6S1vzBTjYbWbeynWCuPHepeTAT1FG+f7XggYRcYHFl2NcgAaFsGUz/WQF/J
         osO5xGm/MsCLkelJrr/BzPvAv8HIa84pyjyLbs0KX3evk7wEGs80Qhe3mYmEiIgcN5uG
         TaThcXRoYFOIrfAFeFAgD12BzFzzmH/YHX8Zzmwd4remXoiWpHXVDeVD920edl5SR896
         rWR/pWGkDTTjHxc9pjNmdFsNB4Ikvq75kYEliY3zH58Wau8goW+mNCBtJwWynW42Jk2/
         hJeKDbd0ttf7WP1sTQqhwM5oZf7bBp7ZtULYYJQtBbSP+Ki7cmrSVGEdLKts7ivbVwXe
         uMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uau9/pR+8X0YYImoS0Wg4cgXBZAlRqGIWfRwQoTAlIs=;
        b=Lw99BchxYEKvh301aUMWA2BnimWl26+QJ4L1HyUF3mHPXhQfif3ArsXOF88oZ+ZkeZ
         rQkBE/AqBwv/xteZtZJD1HkzQGNAueIYquGiiuzmT+BIdlUxOo9lWM6+9YD8owNDE4VC
         97U/gbHiZgm7jaV1hyWJrxuwholvgSZKqrpJjLS4UcUjRphlMZVh2OO6pmVF3SYU72vn
         mQxLZD9OKoqrWKshPlGXn2wBHSqSIxVROFftzC94+A+0ueXshd0Yv7HgLkSxkXob2w0M
         LFGSoGedfqE9QqchQENNNRx3up9ros4l8yMC5UKBoPrembOWnPbSyQFNOfbSECUSql0h
         2IsQ==
X-Gm-Message-State: AOAM530LJZQ15TpuJnk0p34RUDXEOqLH36H1Q5MpQR7fJcVyuiCsr8xR
        DzM0irBKpXnBIkJsbvvoC780h9eGVN0Jrq8G9z4=
X-Google-Smtp-Source: ABdhPJzfTPCIqF75XYHBa+La5Pd+QBvj9phqUfquQvBKUdk8ClsF1hEHLmwPcrVcniX/f0yPaOZWmW7JcncYMW+6iPI=
X-Received: by 2002:ab0:5548:: with SMTP id u8mr16315316uaa.0.1633514543473;
 Wed, 06 Oct 2021 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
 <20211006061204.2854-4-sergio.paracuellos@gmail.com> <20211006082903.GZ2048@kadam>
In-Reply-To: <20211006082903.GZ2048@kadam>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 6 Oct 2021 12:02:12 +0200
Message-ID: <CAMhs-H_qb=goRmfhO1P+mt_NKhJFuJgH6a483-6Wk8M9MA1cJQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: ralink: make system controller node a reset provider
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the review. Comments below.

On Wed, Oct 6, 2021 at 10:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Oct 06, 2021 at 08:12:03AM +0200, Sergio Paracuellos wrote:
> > @@ -398,6 +401,76 @@ static void __init mt7621_clk_init(struct device_node *node)
> >  }
> >  CLK_OF_DECLARE_DRIVER(mt7621_clk, "mediatek,mt7621-sysc", mt7621_clk_init);
> >
> > +struct mt7621_rst {
> > +     struct reset_controller_dev rcdev;
> > +     struct regmap *sysc;
> > +};
> > +
> > +static inline struct mt7621_rst *to_mt7621_rst(struct reset_controller_dev *dev)
>
> No need to mark this as inline.  The compiler should do it automatically
> or it will ignore the inline.

Ok, I have other functions to_* with the same inline syntax, that's
why I have added also here. I think I will maintain it to be coherent
and can be removed afterwards with another patch not belonging to this
series.

>
> > +{
> > +     return container_of(dev, struct mt7621_rst, rcdev);
> > +}
> > +
> > +static int mt7621_assert_device(struct reset_controller_dev *rcdev,
> > +                             unsigned long id)
> > +{
> > +     struct mt7621_rst *data = to_mt7621_rst(rcdev);
> > +     struct regmap *sysc = data->sysc;
> > +
> > +     if (id == MT7621_RST_SYS)
> > +             return -1;
>
> Please, return proper error codes.

Current code at 'reset.c' of the arch was returning -1 in this case. I
guess it is better to change it to -EINVAL.

>
> > +
> > +     return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
> > +}
> > +
> > +static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
> > +                               unsigned long id)
> > +{
> > +     struct mt7621_rst *data = to_mt7621_rst(rcdev);
> > +     struct regmap *sysc = data->sysc;
> > +
> > +     if (id == MT7621_RST_SYS)
> > +             return -1;
>
> Here too.

Will change to -EINVAL.

>
> > +
> > +     return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
> > +}
> > +
> > +static int mt7621_reset_device(struct reset_controller_dev *rcdev,
> > +                            unsigned long id)
> > +{
> > +     int ret;
> > +
> > +     ret = mt7621_assert_device(rcdev, id);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return mt7621_deassert_device(rcdev, id);
> > +}
> > +
> > +static const struct reset_control_ops reset_ops = {
> > +     .reset = mt7621_reset_device,
> > +     .assert = mt7621_assert_device,
> > +     .deassert = mt7621_deassert_device
> > +};
> > +
> > +static int mt7621_reset_init(struct device *dev, struct regmap *sysc)
> > +{
> > +     struct mt7621_rst *rst_data;
> > +
> > +     rst_data = kzalloc(sizeof(*rst_data), GFP_KERNEL);
>
>
> Can we use devm_ to allocate this or do we need to clean up if
> devm_reset_controller_register() fails?  Also a free in the release
> function I suppose.  (Please, use devm_).

True, yes we can use devm_ for this. Will change it, thanks.

>
>
> > +     if (!rst_data)
> > +             return -ENOMEM;
> > +
> > +     rst_data->sysc = sysc;
> > +     rst_data->rcdev.ops = &reset_ops;
> > +     rst_data->rcdev.owner = THIS_MODULE;
> > +     rst_data->rcdev.nr_resets = 32;
> > +     rst_data->rcdev.of_reset_n_cells = 1;
> > +     rst_data->rcdev.of_node = dev_of_node(dev);
> > +
> > +     return devm_reset_controller_register(dev, &rst_data->rcdev);
> > +}
>
>
> regards,
> dan carpenter
>
I will properly take into account your comments and send v2.

Thanks,
     Sergio Paracuellos
