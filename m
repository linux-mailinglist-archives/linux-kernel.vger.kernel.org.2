Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D83B4124
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhFYKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFYKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:11:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71326C061760
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:09:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d16so10786756ejm.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTHgculPydhzpEVBph2GMT4tKo+Bdruk5MQJ3Xil02M=;
        b=iYwJpzc2B1Vz6C+1VFuga00mnTGnb9YkGQ/i60e24srUZeXEivl90uhEWHDaJdJdZl
         KAzTXfCP1HsostkzLKSNkcqzvh761bcFXJlvAuEcnKTdvLVOEw4iKFyeLOUgsTVIicbR
         6DM31e2rJS4bq7LbZAzi05Pn6ATJrDukYOReg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTHgculPydhzpEVBph2GMT4tKo+Bdruk5MQJ3Xil02M=;
        b=sHBAYsGP49lv9qnbi4nunHIQ7lfVDdiaqD4XX4yI/vw+DAq2mXbkDdh3uq8HPn3j6J
         Cwa/XRiJ/DTCxA1GIbEcHiy5LatR1+3E40TjC41OSh3cJ9L8RtzxBePeTGIhQUV7WDqJ
         NPvbs7w35TEYu63iVLQe9MI+MiOYwQg4zJYzP/EvvnoLEQnRoIb4gBRvt9PafPSmEslZ
         D48CVj/PSStk3f39U2CaA/pk8+/lxwKYHxvrdVYpzf/Al0bDbx7Tzk6Fn8U4bJv1mrdN
         2W6rDH0HM0H/Mz4T+kWXn2Uyt2gQz0USG0Q17X43YmB2opiBxgG0tQYFqpPhmPJ6nHrt
         Y0QA==
X-Gm-Message-State: AOAM533DRUe9Ca5yvTlHrm2p0gBB0mWRXIzlc9LsA8iMI8EV+FP4sQlq
        LqNqA0eaaRHh10goVrYoqlSkyzppYyD26VlRD/pPmw==
X-Google-Smtp-Source: ABdhPJx5YzGyXwGKXbBwpGfmUZFM2l/3b+DgX10TOcWtu9LgUc8/68VvsFeIkZnC3ePSCoBaMYF/unXbPoA2N3GfeR0=
X-Received: by 2002:a17:906:bb10:: with SMTP id jz16mr6339523ejb.252.1624615750910;
 Fri, 25 Jun 2021 03:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
 <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
 <CAMty3ZAtObU-bf6FuxvSBaZn2cotj_NxASW9g9on-kBJ7iW3OA@mail.gmail.com>
 <YNR37NWkxq0mZyq5@pendragon.ideasonboard.com> <fdd446c6-c8ce-9dae-f7ac-e06241f76250@canonical.com>
In-Reply-To: <fdd446c6-c8ce-9dae-f7ac-e06241f76250@canonical.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 25 Jun 2021 15:38:59 +0530
Message-ID: <CAMty3ZCEQeRi53yuLYyWVU8o=Lo2ZKy+kgjU+9PC33QJEq2LQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        linux-phy@lists.infradead.org, Fancy Fang <chen.fang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Jun 25, 2021 at 2:51 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Thu, 24 Jun 2021 at 14:19, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Jagan,
> >
> > On Thu, Jun 24, 2021 at 05:42:43PM +0530, Jagan Teki wrote:
> > > On Thu, Jun 24, 2021 at 8:18 AM Fabio Estevam wrote:
> > > > On Wed, Jun 23, 2021 at 7:23 PM Laurent Pinchart wrote:
> > > >
> > > > > Looking at the register set, it seems to match the Exynos 5433,
> > > > > supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> > > > > that driver instead of adding a new one for the same IP core ?
> > > >
> > > > Yes. there was an attempt from Michael in this direction:
> > > > https://patchwork.kernel.org/project/dri-devel/cover/20200911135413.3654800-1-m.tretter@pengutronix.de/
> > >
> > > Thanks for the reference, I will check it out and see I can send any
> > > updated versions wrt my i.MX8MM platform.
> >
> > Thanks.
> >
> > I had a brief look at the exynos driver, and I think it should be turned
> > into a DRM bridge as part of this rework to be used with the i.MX8MM.
> >
> > Is there someone from Samsung who could assist, at least to test the
> > changes ?
>
> Yes, I mentioned few guys in reply to PHY. Around the DRM drivers you
> can get in touch with:
> Inki Dae <inki.dae@samsung.com>
> Seung-Woo Kim <sw0312.kim@samsung.com>
> Marek Szyprowski <m.szyprowski@samsung.com>
> Andrzej Hajda <a.hajda@samsung.com>

Thanks for the information.

>
> The easiest testing of the display stack would be on Hardkernel's Odroid
> XU4 (https://www.hardkernel.com/shop/odroid-xu4-special-price/) however
> you will not test the DSI/DSIM directly (it has only HDMI port).

Look like I found one board with Exynos5430 with DSI. Does this SoC is
same as mainline Exynos5433?

Jagan.
