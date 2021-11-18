Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D04560AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhKRQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhKRQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:41:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69255C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:38:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so29975662edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSppPk3DPCX/InvfqFTPS/l3REWdYaf45cm5tdKXOlY=;
        b=y8iXcU/CZw/Cu7843SW3MJSyGKMeXrFPDcO8PvkoglapriCkEvzvvjFtInuYb1tY40
         TtDDUD5LINgmlfU9WMtgCNf0EFmfxyhj7HXc431tSnWE63lpp8FENhdrve4dD0Z8HWWK
         HU6mAhWi7HUsVVmOvmIfd5NE3Tz6WCIMTO95Jt2a5fr3auw8x21TbyLhjWsUcMWpmIl1
         n2ePm53jtvmaaGEi4zdNpBp1Of7QISc+Q2PcrAoGwOLn6LZ/TY7TbpIjxleVZq4sxLWe
         5g9nmgehFZS6tFomVQert0wXXZBwmcxHOaxTcMbBa/qU2a7TIYnx0WQrIO8eiBJJ7EWG
         4C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSppPk3DPCX/InvfqFTPS/l3REWdYaf45cm5tdKXOlY=;
        b=REZ5cL2FpAyaE12M5XNvmiyoNiu/cewLkcjFAOk/GcN/uGIZ/3eDfTTUypjB2cWwe8
         TiQ0tMlJLyyxRGLQnUZyCqCG9uUD15la0p6Eu7XxTka4Tx+t6L/BBKXMvE5ZbyBSTMs6
         71MCaKwV4cMMiEq4DHZPzo1D/zRDBFi3c4kpnGWPeJcUCExZN8R3ZdttL1WOkO2dUGqe
         M2v38yYdDEzK35+DNZ9FkYAoIqVEdIGPefSv90ZCiTpR/kQE6jhlCUABC9OBlm71HJBc
         e4q0plajqII0xX44Gym32N96RXj2hgIoapGwzwNbnoDZKA2IJFRgIrNbNHCHXyHcPH8e
         DIbQ==
X-Gm-Message-State: AOAM5300+cjTAVfy3XTFT0R0oqFBmiVHPmKKwIluzxv3uDOCHvqwex0M
        n0u6Fwm6VonOnSWgXujjSLlObUKSWQ5fY02819VrQw==
X-Google-Smtp-Source: ABdhPJyDp/dxu5CdyRi5uKo5rhAx52nwL5NmSIQpkm0xMjwlt2b0dHHw8LI+iYNyZl9JkYoj/dVIhiJD4CPEChKaAps=
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr13401339edt.178.1637253504982;
 Thu, 18 Nov 2021 08:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20211118132317.15898-1-brgl@bgdev.pl> <20211118132317.15898-2-brgl@bgdev.pl>
 <YZZ0xPU207qDaOpX@smile.fi.intel.com>
In-Reply-To: <YZZ0xPU207qDaOpX@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 18 Nov 2021 17:38:14 +0100
Message-ID: <CAMRc=McHCUsO430t618EW92G-B_mgxXucYye3qb85697MHW_KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 4:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 18, 2021 at 02:23:17PM +0100, Bartosz Golaszewski wrote:
> > Several drivers read the 'ngpios' device property on their own, but
> > since it's defined as a standard GPIO property in the device tree bindings
> > anyway, it's a good candidate for generalization. If the driver didn't
> > set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> > device's firmware node before bailing out.
>
> Thanks for update, my comment below.
>
> ...
>
> >       if (gc->ngpio == 0) {
> > -             chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > -             ret = -EINVAL;
> > -             goto err_free_descs;
> > +             ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> > +             if (ret) {
> > +                     chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>
> > +                     ret = -EINVAL;
>
> Sorry, forgot to ask, why this is needed?
>

What do you mean? 0 lines doesn't sound like a valid value so -EINVAL
is in order.

Bart
