Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6243B3E60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFYIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFYIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:22:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B3C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:20:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nb6so13793951ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij57ec/kT6vqdj3SkA9+UxDinMRytbLturPpNw8vjWU=;
        b=fUPOg7qJFU4+Ky55nonbhHO3m4gsmtHJ5JR19iPaBEvYjk3/idyXrnOzPF0RETsFki
         aon0d55/n0DgoLxhyqvpHSMAzPTz5otjiNSZ/KZCVwhjW1FHTLiHnWh/CM8AwwZZpldx
         Kdh+7y5JjZRwPrcv7S0CsQpczGiUAYa472kT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij57ec/kT6vqdj3SkA9+UxDinMRytbLturPpNw8vjWU=;
        b=VPLtNYkViPALh5oJxYzbrWpySiDCJe6XO5m83iMyHNo3EtsU9CBTuPzd1UxXfjpgPd
         S/XE6spFnNPjvkL5EjP24lwvQtv7O9aWMrnsWAW9T9l6ZrGJw/Kc9G+DUz8+Pmi0N1Of
         nL8gd+HuM4BrxxrXcgHA6bSzDhbDQD5aALyoBqKWjjq6ewuxs0gKYqHbQ/Fug+YE/B/l
         BPll+S0cSxKmo8ssMmBeIw0KqZFSLtEWxwIJ8rBP4AoHaaxEoN4GAbVjI7nHfJwmyWLw
         mJOMgR9Xnp2R/UK20bkKAdcg06XUjp9f4rdp4/PVZo2GVehxLEmdhy4gDGQTasOwjph9
         oZOg==
X-Gm-Message-State: AOAM531hWwu3/cy65RAov2jHweE8mxKnPpU6Xjn/c3DAn54/6QwUiLpX
        rXaFQTPZLyaP1US33EwFN7pubz/2Zxph//kcYQM5DA==
X-Google-Smtp-Source: ABdhPJxPYVWDTuNQnGVZcTr/J+zl2QMfQDE1LFW7NWpHcZf0GBIjnlowThGs9yNuKiJWJssteOsB7NCRRWQI1Rw+mOk=
X-Received: by 2002:a17:906:bb10:: with SMTP id jz16mr5890056ejb.252.1624609200411;
 Fri, 25 Jun 2021 01:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
 <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
 <CAMty3ZAtObU-bf6FuxvSBaZn2cotj_NxASW9g9on-kBJ7iW3OA@mail.gmail.com>
 <YNR37NWkxq0mZyq5@pendragon.ideasonboard.com> <CAMty3ZA=1xreRB+SZOwj6khH6+nLsE_ND5599xfV8J=LzGFYYQ@mail.gmail.com>
 <YNR+r3G7crWS+wcx@pendragon.ideasonboard.com>
In-Reply-To: <YNR+r3G7crWS+wcx@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 25 Jun 2021 13:49:49 +0530
Message-ID: <CAMty3ZBuPCGYrC=Poucrotvaf3ZT2PnAeCbv-iq7vnQLS=KgNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
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

On Thu, Jun 24, 2021 at 6:17 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Jun 24, 2021 at 06:02:36PM +0530, Jagan Teki wrote:
> > Hi Laurent,
> >
> > On Thu, Jun 24, 2021 at 5:48 PM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Jagan,
> > >
> > > On Thu, Jun 24, 2021 at 05:42:43PM +0530, Jagan Teki wrote:
> > > > On Thu, Jun 24, 2021 at 8:18 AM Fabio Estevam wrote:
> > > > > On Wed, Jun 23, 2021 at 7:23 PM Laurent Pinchart wrote:
> > > > >
> > > > > > Looking at the register set, it seems to match the Exynos 5433,
> > > > > > supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> > > > > > that driver instead of adding a new one for the same IP core ?
> > > > >
> > > > > Yes. there was an attempt from Michael in this direction:
> > > > > https://patchwork.kernel.org/project/dri-devel/cover/20200911135413.3654800-1-m.tretter@pengutronix.de/
> > > >
> > > > Thanks for the reference, I will check it out and see I can send any
> > > > updated versions wrt my i.MX8MM platform.
> > >
> > > Thanks.
> > >
> > > I had a brief look at the exynos driver, and I think it should be turned
> > > into a DRM bridge as part of this rework to be used with the i.MX8MM.
> > >
> > > Is there someone from Samsung who could assist, at least to test the
> > > changes ?
> >
> > I have hardware to verify it on i.MX8MM but from exynos I don't have
> > any contact from Samsung to suggest or test. Maybe I can add Tomasz
> > Figa while sending the changes?
>
> Tomasz hasn't been working for Samsung for a loooong time (I've dropped
> his Samsung address from the CC list for this reason).

Okay. I think exynos drm maintainers might help out here, but not sure of it.

>
> > I understand that there are 2 key implementations.
> >
> > 1. Adjust the exynos_drm_dsi.c by dropping component_ops as i.MX8MM
> > flow with LCDIF doesn't have component_ops (make sure it works with
> > exynos platform first)
>
> I think it should be turned into a real drm_bridge, it's currently
> implemented based on drm_encoder.

Yes, ie what I'm trying for.

Jagan.
