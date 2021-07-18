Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57833CC70B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhGRAfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 20:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhGRAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 20:34:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FEC061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 17:32:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so16716521lfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiOcA9fDhX332QQkbECnDAuU57MnDvjKhHt74brAsd4=;
        b=QqbnQgsv/ajdlgCbOM0gq0g7FZNs0AbFigA/0ipXJiEXJGly+tlK9erNMERE8PA2rQ
         fV/gVY5xNUty2kHdSElmFKDGFoS+yMK3mf7CiRP6LrqKaFPtW5EDm9I4uFh2ZtZh4s3m
         z4bMO4lo51Dd3Qwhrc++2IKRxPSBmqwPAiUYFMlSPYHp9flltp5ibXqvq61dJlPGJTaQ
         0okiiInLKbfmBTEFnH1VyZdD2Ug8K3mh4o2jS+fAxh6J1K14jl3StwsfqWVPhzPYeRRp
         H45cRIUF/dYngweD8xQ0drMSaJrVAdN3Yn8w3t1wXnRcgfvCknH9ovNC64WK2NC7ho+i
         WMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiOcA9fDhX332QQkbECnDAuU57MnDvjKhHt74brAsd4=;
        b=rKShc4uAoxzPBkmX1aXgEKNFMBKXVcdc189M+ExUOnWBRJMa1c4Mzlfc1ywfUohxS6
         NdQgP8pgS0RoHLQOpDHlRjfMsrL+9n2/IZp3TmwswJbAWjmbuDH6BiU8eePuwONL1IjL
         362pA3rUZNr8R7o+vE45G0988kDSK7XSKM2T7W4gvdIyPZ8MXKpdmNT/r6dWjhm8p+Xs
         SWYnka9IeOOvWt7eanskOlU4yb1ODrhEI/2eL56IrgeVEoikC3dmta6jraVy6tMnLMYZ
         +EbBl+9xwKLEfdt7t+14Yq2mB9kpoaFxGB2zthjAA3YTkrNY+IIGSIobCwWy2zcC5OrM
         c5tQ==
X-Gm-Message-State: AOAM530AMIj1zPt1syIBHTaBbzWbH6UEWAB6tRkm9mOx/A+olFvGOiTU
        H/0nXrnEl/gGMV3LcqdFawJRnmJqEuwf0kF/3IVijg==
X-Google-Smtp-Source: ABdhPJzUE4mwcMvftXDt9OelhGDF5Xj2/T270B5egWGsaIKWTNtuSaIt9NhYbKXb4xTog5SSevqmX/HoABHDg7tXXbs=
X-Received: by 2002:a05:6512:3f1f:: with SMTP id y31mr6296371lfa.29.1626568319143;
 Sat, 17 Jul 2021 17:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com> <1626430843-23823-3-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1626430843-23823-3-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Jul 2021 02:31:48 +0200
Message-ID: <CACRpkdZZyN_8ND52+piHYaksujwwwTMigkv6eL0fih_2dYZ4Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: Add ilitek ili9341 panel driver
To:     dillon min <dillon.minfei@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Doug Anderson <dianders@chromium.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon,

thanks for your patch!

On Fri, Jul 16, 2021 at 12:20 PM <dillon.minfei@gmail.com> wrote:

> From: Dillon Min <dillon.minfei@gmail.com>
>
> This driver combine tiny/ili9341.c mipi_dbi_interface driver
> with mipi_dpi_interface driver, can support ili9341 with serial
> mode or parallel rgb interface mode by register configuration.
>
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>

Nice!

> +config DRM_PANEL_ILITEK_ILI9341
> +       tristate "Ilitek ILI9341 240x320 QVGA panels"
> +       depends on OF && SPI
> +       depends on DRM_KMS_HELPER
> +       depends on DRM_KMS_CMA_HELPER
(...)
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_atomic_helper.h>

Hm now there is a (partial) KMS driver in the panel driver, kinda, sorta.
Is this the right split? I'm not the best with DRM infrastructure,
just asking.

> +struct ili9341_config {
> +       u32 max_spi_speed;
> +       /** @mode: the drm display mode */
> +       const struct drm_display_mode mode;
> +       /* @ca: TODO: need comments for this register */
> +       u8 ca[ILI9341_CA_LEN];

These are all in the datasheet but I guess you plan to add these
TODOs later. (It's fine I suppose, the driver is already very nice.)

> +       struct regulator *vcc;

Use the right name of the pin for the regulator. I guess this is actually
vci. I would implement all three regulators and get them as bulk.
See e.g. drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
for an example on how to get and enable several regulators
using bulk.

The regulator framework will provide dummy regulators if you
didn't define some of them so it is fine to just provide one or two.

Yours,
Linus Walleij
