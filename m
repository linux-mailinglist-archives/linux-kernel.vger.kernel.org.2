Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C273B2F51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhFXMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:48:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310EC061756;
        Thu, 24 Jun 2021 05:46:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f30so10127551lfj.1;
        Thu, 24 Jun 2021 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTH8vR4RixbXkriAwojNaOEycEezf1HsxVW3e2HYh0I=;
        b=m6xiTmK+5YqywiWU2SER1AgOl/l82/y/T4MGDg0zdo5hkygLuOcecQwPHTaN78mPcc
         Buc8c1nAfwLyqw7sQxd9FMd6whPlM1zabBySHWaTiSQpHXDT8meOhc69vK7n0IrO8T76
         wh6wbVUwDx6v5WkJZsw2V5f8TpjAFxdSiELGAMzKMr2wDtt/jIPxT6jbSZO7bZn8c+mw
         Gq0dDod9ydm7j3hmuTbId1ywAQIbzYr0N+ZKy2CBe3UzblKKiq0e12gJtEApxR+ojbJ/
         pTEb6vxJGW84DsuP5q7K40hxtfRF4BM1Cl5T3kCAHmJ01xM+Hz5Gu0Fx1tT4XVdPSb74
         erVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTH8vR4RixbXkriAwojNaOEycEezf1HsxVW3e2HYh0I=;
        b=npDaPsB2fEoyKIXHtl6GaYYe2J7S8K+mFemWDyOrg+AKphcNxY3WrZSRzRHa052qI1
         mkl4+xw4XkaJqX7eLv8S7/MV/cfVzm1D/AtELx4u3Wzg8cGw4ejTIu45SPaE6WP40Cod
         ErGAuKiYqbDwXgHiK3AIBM9p2kPRBwn+J3eYOjOQnZE1LbUGPsCIKSr0C1LRwSq6K7IM
         c/XrQIrOngc0lF/3/510xkQNGVNICgLXhhoACV+mc5hYfSQd3DA4OcQY9PzvkzBpuEMH
         KzPmioKk3zCNbVDz/oec4kG4XU08OhSQSvyYSAlUYzurgxVAM5UChSFQGlBSlalPRndH
         2Ncw==
X-Gm-Message-State: AOAM532dmw51Noe7eRSZy8iE2yPcakRQEEQQc8xAyO/xv66N3jzz/pHg
        pjLZQla0uYqJMCxhQGzGywaXg11RaAjhR6Agen0=
X-Google-Smtp-Source: ABdhPJyT8BsP7EuS9DD/tQXewK7uBCyS9K2u42ed17KyvX5CdnnqwRSlHjBz+bCRnG+XthX/bMhDCntdoUBccksmKi0=
X-Received: by 2002:a19:6d06:: with SMTP id i6mr3624988lfc.223.1624538782003;
 Thu, 24 Jun 2021 05:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
 <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
 <CAMty3ZAtObU-bf6FuxvSBaZn2cotj_NxASW9g9on-kBJ7iW3OA@mail.gmail.com>
 <YNR37NWkxq0mZyq5@pendragon.ideasonboard.com> <CAMty3ZA=1xreRB+SZOwj6khH6+nLsE_ND5599xfV8J=LzGFYYQ@mail.gmail.com>
In-Reply-To: <CAMty3ZA=1xreRB+SZOwj6khH6+nLsE_ND5599xfV8J=LzGFYYQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Jun 2021 09:46:10 -0300
Message-ID: <CAOMZO5C4n0nnD0y_Ouoo70C4dN+BKg_D8iEO_wgN4_fDx0E2DA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

Hi Jagan,

On Thu, Jun 24, 2021 at 9:32 AM Jagan Teki <jagan@amarulasolutions.com> wrote:

> > I had a brief look at the exynos driver, and I think it should be turned
> > into a DRM bridge as part of this rework to be used with the i.MX8MM.
> >
> > Is there someone from Samsung who could assist, at least to test the
> > changes ?
>
> I have hardware to verify it on i.MX8MM but from exynos I don't have
> any contact from Samsung to suggest or test. Maybe I can add Tomasz
> Figa while sending the changes?

Adding Inki Dae and Marek Szyprowski from Samsung who helped to review
Michael's series.

> I understand that there are 2 key implementations.
>
> 1. Adjust the exynos_drm_dsi.c by dropping component_ops as i.MX8MM
> flow with LCDIF doesn't have component_ops (make sure it works with
> exynos platform first)
> 2. Sec DSIM Bridge driver common cross Exynos and i.MX8MM platform
> drivers or only one Sec DSIM bridge driver to handle both the
> platforms by differentiating compatible and driver data
>
> Any more suggestions would be appreciated?
>
> Jagan.
