Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D023835E485
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbhDMRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhDMRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:02:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:02:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so5137141pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEvaouwR6lKKsvFUe8XHeQdwyMiT3upsGjjAA793nvs=;
        b=XCUdCrTs7PS2BCOHvUAl8I29Ib8v3H0FphqThvZBwx3NKViGWKDBWGWD/pgO443/V4
         YagaA48DTdz+gCXgGiM2BlSeuJiRLr9HpUbz7S+5t6h6gnNOxHIPU8Wn2ZN3wF4KpPx8
         4B7hXBQ5I6RSCAnCnyc/kmo0I3pRj0I4AY8Iy6mEB2J+NGpFLwhMk/S3JIkcALC3C8Pj
         fbXpVTF50wEPQbcFlijwEmjbGD5swOK+my/KO9EPgDav6lX+j0GH+VoSnwHDF+Xw8jnr
         UIuSuW5wg37/iRhT29CuS/2berWbmZzfq/OrLVy5mD/LNUS7FmzjMtdkARKB2aRe3JoJ
         Y/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEvaouwR6lKKsvFUe8XHeQdwyMiT3upsGjjAA793nvs=;
        b=J35sQODQaFhkRS8fGQ54bito4W9GBDItYCW1rc3MGYUquzmTv/x2+Y4Z7Jaj6WJi6S
         Nq27GB7qhcbRksVau7ZHzyaF0EXYD8zMSVEjyAgpHuM+WY16WeNv8NjKXwfFvOn4ncsf
         ALVw3ldyDfkmAH0irAlguircFDZg4qeG8CAEjioCwMn/cV6SIdfiYaaE0DD7sI5vr5aZ
         nVusKqyVMttXzthxY3/A61fymZfyA/DkXHv38JO5WatgDPgKuVkHFb/tuuB24dCzLixF
         lh5R5SERFdY8wNSKNL16bJRaW6SZz/BlyUrCYktdZn1+aunCb/q2Yac4jpiCezxzexrl
         J5iw==
X-Gm-Message-State: AOAM5311IbzweLTWskY+kZ6wOx+OQBLzrCJP77bD8k+D7O5ub9XUZFLp
        w2AT6WFLgx3WsNkJg3LKDXn+PSsMlIYq93KHVdJz4ojb/b4REg==
X-Google-Smtp-Source: ABdhPJw4Xf7iLvL5C5ojXqkG49c+zHbpQq2lLokzmBbfykkgXcvLHiS+M+BX1uBFsPDo7JNSVhjzjvaVB40CDKZXky4=
X-Received: by 2002:a17:90b:392:: with SMTP id ga18mr989125pjb.222.1618333345157;
 Tue, 13 Apr 2021 10:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210408130746.175358-1-robert.foss@linaro.org> <f1d5f9d4-cb98-cc1c-83ef-74e7e8005b1f@infradead.org>
In-Reply-To: <f1d5f9d4-cb98-cc1c-83ef-74e7e8005b1f@infradead.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 13 Apr 2021 19:02:14 +0200
Message-ID: <CAG3jFys1xF9qrhDziUNm9fY8uDY0LSt6xvsnNohY7z0Qp6hMaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge/sii8620: fix dependency on extcon
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Randy,

Thanks for looking at this!

On Fri, 9 Apr 2021 at 18:38, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/8/21 6:07 AM, Robert Foss wrote:
> > The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
> > on EXTCON, which causes issues when sii8620 is built
> > as a builtin and EXTCON is built as a module.
> >
> > The symptoms are 'undefined reference' errors caused
> > by the symbols in EXTCON not being available
> > to the sii8620 driver.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >
> > Changes since v1:
> >  - Fix typo on comment
> >
> >  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 22a467abd3e9..2289b44613af 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -169,7 +169,7 @@ config DRM_SIL_SII8620
> >       tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >       depends on OF
> >       select DRM_KMS_HELPER
> > -     imply EXTCON
> > +     depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
> >       depends on RC_CORE || !RC_CORE
> >       help
> >         Silicon Image SII8620 HDMI/MHL bridge chip driver.
> >
>
> That gives me: (on linux-next 20210409)
>
> drivers/gpu/drm/Kconfig:77:error: recursive dependency detected!
> drivers/gpu/drm/Kconfig:77:     symbol DRM_KMS_HELPER is selected by DRM_SIL_SII8620
> drivers/gpu/drm/bridge/Kconfig:168:     symbol DRM_SIL_SII8620 depends on EXTCON
> drivers/extcon/Kconfig:2:       symbol EXTCON is selected by CHARGER_MANAGER
> drivers/power/supply/Kconfig:499:       symbol CHARGER_MANAGER depends on POWER_SUPPLY
> drivers/power/supply/Kconfig:2: symbol POWER_SUPPLY is selected by OLPC_XO1_SCI
> arch/x86/Kconfig:2757:  symbol OLPC_XO1_SCI depends on GPIO_CS5535
> drivers/gpio/Kconfig:1156:      symbol GPIO_CS5535 depends on GPIOLIB
> drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by I2C_MUX_LTC4306
> drivers/i2c/muxes/Kconfig:47:   symbol I2C_MUX_LTC4306 depends on I2C
> drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:83:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> For a resolution refer to Documentation/kbuild/kconfig-language.rst
> subsection "Kconfig recursive dependency limitations"

I'm not sure how to avoid this circular dependency. The above solution
is what I've seen w/r to issues like [1]. Clearly it doesn't work in
this situation. `select EXTCON` doesn't seem to cause this dependency
error, but I'm not sure it accurately represents the dependency
sii8620 has on extcon.

[1] https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/
