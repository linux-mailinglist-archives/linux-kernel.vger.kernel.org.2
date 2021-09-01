Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F23FE601
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbhIAXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbhIAXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:11:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F53C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:10:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk29so71355qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y+GVokmV9xV7i0Kbyl+zT81HcVIXennIBiGTGbWIfQ=;
        b=Ss78CZppoDiVB5zdMTBxQWBVResulcnOWqd8Qi3UkjhRlNgSbjSTQDveLQ4owdMFOd
         mgwlrVIyuyDeGaBwBWxBoZvXlIJfVMzhnF2/tIAtLNZqNqrIQMexqtyQHl+M/z23jDJt
         /l6kSthz2Kvx8zBGuz1IIWMUwzkcbS3DLX0UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y+GVokmV9xV7i0Kbyl+zT81HcVIXennIBiGTGbWIfQ=;
        b=FcNptiXluHp8WwW1s456ZLNc4fDbq68GvDPWTshE5IwEDz50jci6PsCaTgwmF33miD
         JoN0bil32GgXkXz3e/ab8TO6BzC53bZ0Qx74gVExRB/nH0yGZXQJyNAzUuRVhhRgMbmA
         8Mj9J/peUlwUYy4wVEwg+DjtsuBH6k8nzUZx2FHrQovtcPlmIcpsTjbxxw23cvkdrjfd
         TT6xI4n3SCO7hrW6FmUvYVZbgSWnB6jcluWUAVxUs0ydQqa2nfrds3R9XtC23czAfok1
         Ag6yTWHJkB3t0eJztVuXVtuvL9vH1Vwip3bXo4s1y7hNdvBuVLzytdfMlotrrvXGieMh
         Iztg==
X-Gm-Message-State: AOAM533mcflPG6IP4OOjVuEU2lGsrzGfPLM21wmLFA4IH0ZCDyRgThhU
        HwvYVLfP0EDlI+Kiap/22cYaGa26NApg5Q==
X-Google-Smtp-Source: ABdhPJzKOVjZC23c9RGpXZ2RwFG+q6aIdcl+MHtGYwYemlb3ZaETiEuIYdAo99ILw/i7iXFFJXAACw==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr367880qkg.403.1630537840119;
        Wed, 01 Sep 2021 16:10:40 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id e25sm87326qka.83.2021.09.01.16.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 16:10:39 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id y144so78202qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:10:39 -0700 (PDT)
X-Received: by 2002:a02:ca0b:: with SMTP id i11mr277172jak.84.1630537827704;
 Wed, 01 Sep 2021 16:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210901201934.1084250-1-dianders@chromium.org>
 <20210901131531.v3.6.I02250cd7d4799661b068bcc65849a456ed411734@changeid> <CAOesGMjp4pscuxciHZo7br-acgbkZSdRA_mUWNpcz0OfF7zOSA@mail.gmail.com>
In-Reply-To: <CAOesGMjp4pscuxciHZo7br-acgbkZSdRA_mUWNpcz0OfF7zOSA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Sep 2021 16:10:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPXAUyuAHb1jKx9F_aw+JGX4MWB3or=Eq5rXoKY=OQMw@mail.gmail.com>
Message-ID: <CAD=FV=WPXAUyuAHb1jKx9F_aw+JGX4MWB3or=Eq5rXoKY=OQMw@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] ARM: configs: Everyone who had PANEL_SIMPLE now
 gets PANEL_SIMPLE_EDP
To:     Olof Johansson <olof@lixom.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        DTML <devicetree@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Robert Richter <rric@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, linux-sunxi@lists.linux.dev,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 1, 2021 at 2:12 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Sep 1, 2021 at 1:20 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In the patch ("drm/panel-simple-edp: Split eDP panels out of
> > panel-simple") we split the PANEL_SIMPLE driver in 2. By default let's
> > give everyone who had the old driver enabled the new driver too. If
> > folks want to opt-out of one or the other they always can later.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Isn't this a case where the new option should just have had the old
> option as the default value to avoid this kind of churn and possibly
> broken platforms?

I'm happy to go either way. I guess I didn't do that originally
because logically there's not any reason to link the two drivers going
forward. Said another way, someone enabling the "simple panel" driver
for non-eDP panels wouldn't expect that the "simple panel" driver for
DP panels would also get enabled by default. They really have nothing
to do with one another. Enabling by default for something like this
also seems like it would lead to bloat. I could have sworn that
periodically people get yelled at for marking drivers on by default
when it doesn't make sense.

...that being said, I'm happy to change the default as you suggest.
Just let me know.

-Doug
