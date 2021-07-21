Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820293D0A96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhGUHpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhGUHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:34:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7DC061766;
        Wed, 21 Jul 2021 01:14:20 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d9so1438443ioo.2;
        Wed, 21 Jul 2021 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zvyrqp/UiJLUSpPijKljeCZXxIIqF9RIC0PiIvCr1Pc=;
        b=YHbAswGhLee0N+Emn5lEa2mnxeWp0JHz22Ld3I9on15E/bPLibsLiCietabGvkQB5a
         mj1lIzYxotna3vOidXeyj9J8ywUVQ/BAhmR6/+GF7E+6QxygzlZwlVVisr7v/Q9ZrJ8M
         unBkgAx2JXUvG6YpocgBvVbsRsXkPyWcRBxl9mYqmOf/f8+EcWUCIeNGLFDY/tFOKjT7
         SKDZcLtB8OnVL6KZs3nHzzUpJ6EBZnN2NB7FVO83wVkCEcSnFhMMgfGkI2h5nhzRQJta
         Xzd3bu6PV5ieLDatzAhFVfgruPzv1Drt4CfyPdxMLQ4Lv7AE+Bh5EYV0+K2Ve0tpzF09
         XGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zvyrqp/UiJLUSpPijKljeCZXxIIqF9RIC0PiIvCr1Pc=;
        b=eJl3NIk2XpkehJ92D6JQ0KI5uMY415/3MATRoet4vmdAPJw5sTyITgzMYa1Pt80a88
         mrzqgXahbBNIr1EiUxfhsQzEsaPGlb5L9FXvGHa9ezJyMHXOujm+PyrrZkFuNnZRFrRI
         6udGJ6Shknewi0eysoJcVnkXLNXn+3I0W0C1U26erPf+aRbkBu1xd8YJmE/S5oHdtzUq
         XmthPbUiHCwzqywUZ4Ca60teekKiv2u0Z+1RWta4pYwoe2DQ6sUHF6U3upHjIGNcG6b9
         MEtgB9bd1Vi2ZyusmWg+vyPhB8T6eIacI86RLuDFDsaBtIe6d1vFhLJa1fcNShXFFuyZ
         B/DQ==
X-Gm-Message-State: AOAM531QOZSVx5HrURHj78oPyyJ9v5fraPsMr3eRXrlRp+xKFfRCGkFM
        +rV951WujGCEjRfuLUsoQqXCS9SbtD/r/ti8w4qrdXRDLg7GHA==
X-Google-Smtp-Source: ABdhPJyk5M7TapH3hnfm34501XGhBzdpKlPpbfZED0UHT6nRGIi4gJ+W+GBMrZhgP8YMQruHyvgPg9I3AGvKtu6IQXY=
X-Received: by 2002:a02:774a:: with SMTP id g71mr29784429jac.137.1626855259588;
 Wed, 21 Jul 2021 01:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com>
 <1626430843-23823-3-git-send-email-dillon.minfei@gmail.com>
 <CACRpkdZZyN_8ND52+piHYaksujwwwTMigkv6eL0fih_2dYZ4Lg@mail.gmail.com> <CAL9mu0+C1p1mMEbw90Z66KCt1Rp2=GV=RcXgZizJRxu8rVaOGw@mail.gmail.com>
In-Reply-To: <CAL9mu0+C1p1mMEbw90Z66KCt1Rp2=GV=RcXgZizJRxu8rVaOGw@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 21 Jul 2021 16:13:43 +0800
Message-ID: <CAL9mu0JcL2td_tfeBOe8vCMjOsARL2kxDY4AGcf_S1xchXXMig@mail.gmail.com>
Subject: Fwd: [PATCH 2/2] drm/panel: Add ilitek ili9341 panel driver
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for your detailed review.

On Sun, 18 Jul 2021 at 08:31, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Dillon,
>
> thanks for your patch!
>
> On Fri, Jul 16, 2021 at 12:20 PM <dillon.minfei@gmail.com> wrote:
>
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > This driver combine tiny/ili9341.c mipi_dbi_interface driver
> > with mipi_dpi_interface driver, can support ili9341 with serial
> > mode or parallel rgb interface mode by register configuration.
> >
> > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
>
> Nice!
>
> > +config DRM_PANEL_ILITEK_ILI9341
> > +       tristate "Ilitek ILI9341 240x320 QVGA panels"
> > +       depends on OF && SPI
> > +       depends on DRM_KMS_HELPER
> > +       depends on DRM_KMS_CMA_HELPER
> (...)
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_fb_helper.h>
> > +#include <drm/drm_gem_atomic_helper.h>
> > +#include <drm/drm_atomic_helper.h>
>
> Hm now there is a (partial) KMS driver in the panel driver, kinda, sorta.
> Is this the right split? I'm not the best with DRM infrastructure,
> just asking.


I tried to remove one of these two headers, but got compile errors:

linux/drivers/gpu/drm/panel/panel-ilitek-ili9341.c:719:3: error:
implicit declaration of function 'drm_atomic_helper_shutdown'
[-Werror=implicit-function-declaration]
  719 |   drm_atomic_helper_shutdown(drm);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
or

linux/drivers/gpu/drm/panel/panel-ilitek-ili9341.c:562:16: error:
'drm_gem_simple_display_pipe_prepare_fb' undeclared here (not in a
function)
  562 |  .prepare_fb = drm_gem_simple_display_pipe_prepare_fb,
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Actually, these two headers are merged from tiny/ili9341.c to support
only-DBI interface, I'm
not sure whether the maintainers will ask me to remove
(tiny/ili9341.c) code from this patch.
If so, I will remove these headers.

But, It's a little strange to support different interfaces from
different drivers.

>
> > +struct ili9341_config {
> > +       u32 max_spi_speed;
> > +       /** @mode: the drm display mode */
> > +       const struct drm_display_mode mode;
> > +       /* @ca: TODO: need comments for this register */
> > +       u8 ca[ILI9341_CA_LEN];
>
> These are all in the datasheet but I guess you plan to add these
> TODOs later. (It's fine I suppose, the driver is already very nice.)


Yes, I didn't get detailed information about these registers from this
panel datasheet, so leave TODOs here.

>
> > +       struct regulator *vcc;
>
> Use the right name of the pin for the regulator. I guess this is actually
> vci. I would implement all three regulators and get them as bulk.
> See e.g. drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
> for an example on how to get and enable several regulators
> using bulk.
>
> The regulator framework will provide dummy regulators if you
> didn't define some of them so it is fine to just provide one or two.
>

Really appreciate your suggestion, will add to v2.

>
> Yours,
> Linus Walleij
