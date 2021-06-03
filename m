Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4839AD30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFCVvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:51:02 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:33507 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFCVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:51:01 -0400
Received: by mail-pj1-f45.google.com with SMTP id k22-20020a17090aef16b0290163512accedso4081913pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqXRTpXf7sx1+OokWNkO2qG4MJggJMiTrRyc0ECoLWE=;
        b=hkT3hbUI1YBMsByk48wopSF97/Fwy4pqJHtvWITZ2dTFR/Rxwdg3us4HvlF8PtKaH+
         tpfSmq74QsTvxl7eyQQ+CN2eythJ0AorLh7v14h69oPro+ldUv5+V7LBVAEItcqmzABg
         j8hmYXZONQqIDFKrLWUHhGTggeoxM3keaJHTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqXRTpXf7sx1+OokWNkO2qG4MJggJMiTrRyc0ECoLWE=;
        b=WFhD0f9w4L6+QsrFTlqziCnLnTL6556w1v43JqnUGy1cA0kP3GwDx1T4uNaLtiQmDy
         4fdl+WC8tIM9riSakdAarcUNGrwNxJpyJJ0OJUSEE+TyibDD/+pny/x3s+N6VJ7gLLMB
         rIJkd0+ZY3V7LF+161Vfp/Iw6tQbotL3jO+/55dEtYGAhmDzUd68uuNX6NSdp8U8fNoL
         0Sme+hCpmvAPzPsBv6Byc1KbaQvhqgjXC4W/Nz0F2taTCSiIich1DO5/cpyxuGUDbtBS
         mqdGIbkmHT9JWFL3T4DxLtmMmGRm2VrurQO11ftE+9lQWK3VP5pg7kMCkizmBF/Mq2+y
         yRcw==
X-Gm-Message-State: AOAM5320BYwBRwWmExpRi/nJQXSC2OD5POiVZvM+KDYGnJpktrysHepl
        b2hqbWYnvpFea2XQLAP6UpOSG5sc4ZlFSg==
X-Google-Smtp-Source: ABdhPJwnxxBuRrDoQVbRE7Noh8VcVCpr7l9zfI0XLSh6GWGnTE5M/mMzheRi1/2Aks7qGmHQeNoYMw==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr1334461pjb.148.1622756884311;
        Thu, 03 Jun 2021 14:48:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 141sm49184pgf.92.2021.06.03.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:48:03 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:48:02 -0700
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
Message-ID: <202106031447.09F7AE9EE4@keescook>
References: <20210602215252.695994-1-keescook@chromium.org>
 <20210602215252.695994-4-keescook@chromium.org>
 <CAL_JsqLO_YbT3VU0+uHH2t6ONs_dWfBhqds9okYD0254ZiBf=A@mail.gmail.com>
 <CAKMK7uFBQk+KA0fPdjkB9=7By2a9V5i=u84ufO+n3dmjayq+vw@mail.gmail.com>
 <202106031357.BE2A09DA8F@keescook>
 <202106031422.FD9E3C5755@keescook>
 <CAKMK7uG8ZiToP2vFsr7TuhntWWh0yiaHkwU5mx5EaESoy+tTHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG8ZiToP2vFsr7TuhntWWh0yiaHkwU5mx5EaESoy+tTHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:41:01PM +0200, Daniel Vetter wrote:
> On Thu, Jun 3, 2021 at 11:29 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 03, 2021 at 02:19:52PM -0700, Kees Cook wrote:
> > > On Thu, Jun 03, 2021 at 09:19:42PM +0200, Daniel Vetter wrote:
> > > > On Thu, Jun 3, 2021 at 8:43 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 2, 2021 at 4:53 PM Kees Cook <keescook@chromium.org> wrote:
> > > > > >
> > > > > > Avoid randconfig build failures by requiring VEXPRESS_CONFIG:
> > > > > >
> > > > > > aarch64-linux-gnu-ld: drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_vexpress_clcd_init':
> > > > > > pl111_versatile.c:(.text+0x220): undefined reference to `devm_regmap_init_vexpress_config'
> > > > >
> > > > > pl111_vexpress_clcd_init() starts with:
> > > > >
> > > > > if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
> > > > >                 return -ENODEV;
> > > > >
> > > > > Isn't that supposed to be enough to avoid an undefined reference?
> > >
> > > Ah! I missed that when reading the code. I see the problem now. It's
> > > because of:
> > >
> > > CONFIG_VEXPRESS_CONFIG=m
> > > CONFIG_DRM_PL111=y
> > >
> > > I think the right fix is:
> > >
> > > diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> > > index 80f6748055e3..662fc38f92ba 100644
> > > --- a/drivers/gpu/drm/pl111/Kconfig
> > > +++ b/drivers/gpu/drm/pl111/Kconfig
> > > @@ -3,6 +3,7 @@ config DRM_PL111
> > >       tristate "DRM Support for PL111 CLCD Controller"
> > >       depends on DRM
> > >       depends on ARM || ARM64 || COMPILE_TEST
> > > +     depends on VEXPRESS_CONFIG=y || VEXPRESS_CONFIG=DRM
> >
> > Oops, no, I had this backwairds:
> >
> >         depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM
> 
> Can you pls throw this into an incremental patch on top of
> drm-misc-next? It's a non-rebasing tree and all that (linux-next
> should have it next day too I guess).

Ah! Yes, sorry. I wasn't sure if you'd reverted it yet. One moment...

-Kees

-- 
Kees Cook
