Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5053B2531
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFXCvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXCvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:51:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE980C061574;
        Wed, 23 Jun 2021 19:48:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i13so7603913lfc.7;
        Wed, 23 Jun 2021 19:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gXOkfW5QLdmxd3Wj2w+c9EViV9eI5MsnrUKf2z8FYs=;
        b=RUUtNGr5bfoevPXn+E3jhYX17ZhytUijcdcizuV5g4jQ4csAcRk/aeza4+qR2lvWm2
         nApl7i4P87KW/V3VmdWmT5rnNucE6KyVawrkZY/mYM6BrTB22om8kojGB0aoqBrGivyD
         ablP9MZHGlP/9wsmaXfsHq6WuEEMnrJMmmoJHij/4TS+w5DTgKyVWjOVbirOyDH7zKC4
         CW0N7U316rWwH6l4ydjxnV6Tes4O/Wgx6zcPcGySg2HNEfV5tFcYL5ymVYDAjIkY8+fZ
         mPEekWg9dqIadP4zouGwK4hPDmzZAQ0OO5uNK8m4HyR0np44kKJi6eE+jR92wFXrpABb
         UElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gXOkfW5QLdmxd3Wj2w+c9EViV9eI5MsnrUKf2z8FYs=;
        b=pF5vNfpcLJUFdxZ7B3rgWzN4gd0+aIoag2Vw6VWW6YF8vm6nElAJdpZoGDZtn/kdfD
         A1RufWed6f5sOsdgX99Lj7/VZYpu9k1AegCxhEmQls5H8nKnhcFyLzhNtPfDr4qFZnbH
         G9nn1GCVSoDVH8XwZdO6QDSnwsH1Kt/0GzOmgheKwdiBLIXxa4DVxtCn/dCN6sQNzH1Q
         m8XWUCt8xb9xaCx2zVpPA3UYihuJJd0u8PkuXGYTk4ONd31xOenSSW6Ga560rofxvJd8
         /0yV/UYrnuFsGu+6wp46FkYzU9A5gEonShGtiSiE/zOIxDxoJc6d4TDGfc4XN4sMqgVZ
         SPhA==
X-Gm-Message-State: AOAM533CwNYpBOaTtjRWHk6EGcpME/V1ymlf6VvefPyfTHIKmICFtZU+
        6sjmbgecLm6Ol5wcFas/sqp3yqjL2J3CZ3vyWoVFs0x+Iad5Zw==
X-Google-Smtp-Source: ABdhPJx3C4pME09Z+lCozESHkQ/9SDrguEu+2in3VcwEc05cxMVQ7T7rVyGEQn/CiFUVy/CuhM/rCWbxw+m+VilD2fQ=
X-Received: by 2002:a05:6512:3b24:: with SMTP id f36mr1930656lfv.443.1624502923336;
 Wed, 23 Jun 2021 19:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
In-Reply-To: <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 23 Jun 2021 23:48:32 -0300
Message-ID: <CAOMZO5Ahbu4mohtMDOQOv_y5B_TDesbdYEUZTF1RL7_y-bS+RA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan/Laurent,

On Wed, Jun 23, 2021 at 7:23 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Looking at the register set, it seems to match the Exynos 5433,
> supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> that driver instead of adding a new one for the same IP core ?

Yes. there was an attempt from Michael in this direction:
https://patchwork.kernel.org/project/dri-devel/cover/20200911135413.3654800-1-m.tretter@pengutronix.de/

Cheers
