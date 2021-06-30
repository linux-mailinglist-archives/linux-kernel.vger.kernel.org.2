Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2A3B80C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhF3KYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhF3KYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:24:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66410C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:21:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l24so3311307ejq.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pRd6pcMdNebp+pN5HMRRgF54QAuGLj+u/RVF3wGoo18=;
        b=ATKO+gmm4xEc6zgEP7S6/Z+diDreHx/sUxeSyYuhtT7zwrtOsR0ZtMcFTiDUA8ZlOu
         JX/hOLoFLa8O29+0/knSdMZQB3/yImsXIvJjt86mYMGf9u0OexWOBu65f8ZHwyBpAxzX
         Cu5psuErLV+VoTcyFiT/zThG5MBdf/A632cx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pRd6pcMdNebp+pN5HMRRgF54QAuGLj+u/RVF3wGoo18=;
        b=FPeKJjrvgiT/ENuwPy0MF17x9BymYg7dz83H06etfpzef3XAvZAjLWoxzigV6FFiix
         nrLS5GA/pcnbbVDPGi11Z84EfVh4SK8Ha8dl0TgmF8azsnyB1dvDmO6qnuF4h+EYVkmr
         boL6VLrDTj2ytvQQaYJZQ4p9sG+4aPEXYkFa1GGeFX4PcR5QkPP1pDQYoSP3S6uBZDLm
         0gGh8FOFB+WG0Ex/d0RbuEV7OpyQMt5qaDPKyF1b8sQ3Fg4C5Nbrrsg077CeBnnpS8IU
         vAVmAhkf7UtO33hVlBN833GY3/H0VGKKmE585bRgaPL4M3rwOBahYIX2bzVpnqBrB99n
         EvWw==
X-Gm-Message-State: AOAM531QPlpwms2a2feAfvsZ/icKnqHZkamohnsA0weyjmITHYlSKvQ/
        bLykelkfOjMPHXCh0vLLgiR7TWOqehjNGVBqUiZTHA==
X-Google-Smtp-Source: ABdhPJywNEi1yzvhH5/eMxuTSgQsZfHFd6bpKgnli8ZWpww+T6iw62Wvl6+Irx61qHcOCFQlQ5wjQ3GqF0XI0jyTfjM=
X-Received: by 2002:a17:906:bb10:: with SMTP id jz16mr31357635ejb.252.1625048505958;
 Wed, 30 Jun 2021 03:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
 <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
 <2decfea3-3659-2a3b-7706-326c97f57f8e@canonical.com> <3aa47f60-94ab-cf0f-3777-3a872dd0e6d4@kontron.de>
In-Reply-To: <3aa47f60-94ab-cf0f-3777-3a872dd0e6d4@kontron.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 30 Jun 2021 15:51:34 +0530
Message-ID: <CAMty3ZBnj6AwdrGXKx1jsqVnrk9abShzamM4H++WE7mcU09sYA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Tomasz Figa <t.figa@samsung.com>,
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
        NXP Linux Team <linux-imx@nxp.com>,
        "marex@denx.de" <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Thanks for sharing the details.

On Mon, Jun 28, 2021 at 1:49 PM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Jagan,
>
> On 24.06.21 10:30, Krzysztof Kozlowski wrote:
> > On 24/06/2021 04:48, Fabio Estevam wrote:
> >> Hi Jagan/Laurent,
> >>
> >> On Wed, Jun 23, 2021 at 7:23 PM Laurent Pinchart
> >> <laurent.pinchart@ideasonboard.com> wrote:
> >>
> >>> Looking at the register set, it seems to match the Exynos 5433,
> >>> supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> >>> that driver instead of adding a new one for the same IP core ?
> >>
> >> Yes. there was an attempt from Michael in this direction:
> >> https://eur04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.kernel.org%2Fproject%2Fdri-devel%2Fcover%2F20200911135413.3654800-1=
-m.tretter%40pengutronix.de%2F&amp;data=3D04%7C01%7Cfrieder.schrempf%40kont=
ron.de%7C52db05459ef0462d5a9b08d936eab1ba%7C8c9d3c973fd941c8a2b1646f3942daf=
1%7C0%7C0%7C637601203901391193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DLTYk9kpUe=
B9bgfRITQT6wIij3XTOIk37AHXbzQ2UI4Y%3D&amp;reserved=3D0
> >
> > That's the proper direction (maybe as Marek suggested - sharing common
> > code like for Analogix DP), not duplicating a driver.
> >
>
> Just to make sure that you are aware of the previous patches and discussi=
ons here are some additional pointers:
>
> * i.MX8MM glue code from Marek (+ Cc): [1]
> * DPHY driver from Marek: [2]
> * General discussion about driver implementation: [3]
> * Daniel's (+ Cc) suggested direction to move forward: [4]

It Looks like Daniel's suggestion is to have a common bridge driver
without sharing a code between platforms. It makes sense and clean but
the key issues lie on the exynos side, the exynos drm drives require
potential changes and tests, which indeed are hard but possible -
IMHO. However there is another issue with component_ops the i.MX8M
side MXSFB doesn't use any component_ops but the exynos are fully
component aware.

>
> It looks like you already did a fork of the Exynos driver, so your approa=
ch might be generally in line with what Daniel suggested.

I did use PMS computation from exynos and reference driver from imx8
tree. Last 2 days I worked on exynos_drm_dsi.c (with some additions)
and converted a bridge driver and it worked on my i.MX8MM platform.

Right now, I'm checking the possible implementations and will come
back to my approach for further comments.

Jagan.
