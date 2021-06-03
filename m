Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25039ACAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFCVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:22:53 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37468 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:22:52 -0400
Received: by mail-pf1-f171.google.com with SMTP id y15so5881936pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dARTyUZkFV2V3Q8vjvHyg7kS20ldU3oA95Zvf/0nmmU=;
        b=RlGC85OmMDvj9lLQelmvTphzRZUs6Q32p0QF5Bg/Q2LMe0D5/UBCSIT/e0xPeW669f
         wZykzI7Gzu/ws2t4xm7q6ufYUKBKRZNLT3vq29CWutNeOaq7WsAwIYnxLA4QacqjfaiA
         tRO+qG0wBC/biL0C5sEWiMiV65bjw7Ef7FY8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dARTyUZkFV2V3Q8vjvHyg7kS20ldU3oA95Zvf/0nmmU=;
        b=RoJA0DczScersq1f5cUTE3zfjW93G069gDjD1igVAr8qtLil6XUaOW6ZGgZxUrPmTt
         ooCLkyCoABBgPBlPEMbrtnn1E1NsNUaGl4Hs9MC0aiZ4brQQ3wEi9fvYMER0KRqm4pZC
         qp7ZbvgwO10mgbg0wEX97z1j4x+hoIsBaLcOwqWG/i7X9Di7GvvQyZCt64jCy6wDa7m+
         T8sabRcwSFqV3fgKO0AHJ2wcUF4slSg8yUpitKHhJZJjGk62AXmuFXOYQt7nkxhTPnhO
         kBKWPQ618l/AWUKN2QQIS4mTdUCCEJ/6UKL6OyKefibtYvECytcV50hNE+9IBEGLw9o/
         Ku1w==
X-Gm-Message-State: AOAM533UWckQVGNoV6psAkP5B/VIoU1Cps9s5MtatyqdaqJd4CUi2rfL
        NZIGw+pDpJjHbKnxXNp/rYXwuQ==
X-Google-Smtp-Source: ABdhPJwJXHGlpcsXLY0UNfMnVi/6rllTy6mVSbumQm6UnltHqjQajeBgs1+0pT0Sh7Rsg7Iw58a7fg==
X-Received: by 2002:a63:5c5d:: with SMTP id n29mr1373666pgm.131.1622755194914;
        Thu, 03 Jun 2021 14:19:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15sm22746pfc.29.2021.06.03.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:19:53 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:19:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh@kernel.org>, Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Arnd Bergmann <arnd@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/pl111: depend on CONFIG_VEXPRESS_CONFIG
Message-ID: <202106031357.BE2A09DA8F@keescook>
References: <20210602215252.695994-1-keescook@chromium.org>
 <20210602215252.695994-4-keescook@chromium.org>
 <CAL_JsqLO_YbT3VU0+uHH2t6ONs_dWfBhqds9okYD0254ZiBf=A@mail.gmail.com>
 <CAKMK7uFBQk+KA0fPdjkB9=7By2a9V5i=u84ufO+n3dmjayq+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFBQk+KA0fPdjkB9=7By2a9V5i=u84ufO+n3dmjayq+vw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:19:42PM +0200, Daniel Vetter wrote:
> On Thu, Jun 3, 2021 at 8:43 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jun 2, 2021 at 4:53 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Avoid randconfig build failures by requiring VEXPRESS_CONFIG:
> > >
> > > aarch64-linux-gnu-ld: drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_vexpress_clcd_init':
> > > pl111_versatile.c:(.text+0x220): undefined reference to `devm_regmap_init_vexpress_config'
> >
> > pl111_vexpress_clcd_init() starts with:
> >
> > if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
> >                 return -ENODEV;
> >
> > Isn't that supposed to be enough to avoid an undefined reference?

Ah! I missed that when reading the code. I see the problem now. It's
because of:

CONFIG_VEXPRESS_CONFIG=m
CONFIG_DRM_PL111=y

I think the right fix is:

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index 80f6748055e3..662fc38f92ba 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -3,6 +3,7 @@ config DRM_PL111
 	tristate "DRM Support for PL111 CLCD Controller"
 	depends on DRM
 	depends on ARM || ARM64 || COMPILE_TEST
+	depends on VEXPRESS_CONFIG=y || VEXPRESS_CONFIG=DRM
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER

I will go check the defconfigs Rob mentioned...

> > Making the whole file depend on VEXPRESS_CONFIG is not right either.
> > Not all platforms need it.
> 
> It needs a compile-time status inline then for the functions we're
> using in pl111.

FYI, this is the config I was working from, which was throwing link errors:
https://lore.kernel.org/lkml/202105300926.fX0MYySp-lkp@intel.com/

> -Daniel
> 
> >
> > >
> > > Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/gpu/drm/pl111/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> > > index 80f6748055e3..c5210a5bef1b 100644
> > > --- a/drivers/gpu/drm/pl111/Kconfig
> > > +++ b/drivers/gpu/drm/pl111/Kconfig
> > > @@ -2,7 +2,7 @@
> > >  config DRM_PL111
> > >         tristate "DRM Support for PL111 CLCD Controller"
> > >         depends on DRM
> > > -       depends on ARM || ARM64 || COMPILE_TEST
> > > +       depends on VEXPRESS_CONFIG
> > >         depends on COMMON_CLK
> > >         select DRM_KMS_HELPER
> > >         select DRM_KMS_CMA_HELPER
> > > --
> > > 2.25.1
> > >
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Kees Cook
