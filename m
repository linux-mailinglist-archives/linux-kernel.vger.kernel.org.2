Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D128310836
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhBEJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBEJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:44:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8323C061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:43:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i63so3961523pfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqJqQl1xSKavN+wug0hZ0iZc5i9bwB3JAakaDPcsm9k=;
        b=XC2yhAyepEIPdSWE2JxIt4ZGw87uQrdwLP8NeaGMO5mX/WpdJUWa6sD99Vrk6phbGS
         3K459KZwzP0oMf4STCMaFC7U+M7tbH9p1YZLq9k79DyGkTKC8tj1mMvKi9t03tuD3MjS
         J5Rt4IjddHqU09Qu/stJrezWoMk68xnRPnKYi4FOtCV/NHO7ZOJM6eE8W9ly/dxahTQv
         I27QWH/L0CCsXWOq2802VE0wWECAUCbRZqV+tQ9oBEPEEDeILYKSGIfPdeJrV2dyHsmn
         LmUNqezFR3aqybKv4qExPnXb+J/zzoVZ0Z3BDcawpV4AsCZKKRmc8V89i8+997nzRnVO
         B4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqJqQl1xSKavN+wug0hZ0iZc5i9bwB3JAakaDPcsm9k=;
        b=aprLFICUvu7SSIuLRYv0J0+T3LBNs3susI9EA9Q1z4TLkTi4cFUyqubJlkWyXYcOqy
         LQ+9EXPwH4fC6UnQdtHXkhlrYVfqetc0s+4Y5oTM/yFFGp9FsOh+T+hKNcSlXPJ/tYej
         3zZnkninOp3UJNFjzSne8D6jV6QLMClXRxBCevG6dfByjTibKxCyEhQbeVTIkJ5GeblO
         PZnoephggWezh9hrNMAxlWOaR64a/LEiZx2WFQTxl3mY0Ewfcm7eGzjsQ4LHDOztiXad
         /Qlnuv+62treAFqM0ObhLdTywTdm0+V6GL32r55KdihYqf41MhDSyRre7Nh663FX6PgQ
         5oYA==
X-Gm-Message-State: AOAM531dzb7Xl7kxhwzFdswgl+vLzfB5ch1feDnaTfz4UcHX8HN3gMZZ
        gwIKxHVntSe3WqKXuagyQpZKAyX/3ooKG2HO+Pwo0w==
X-Google-Smtp-Source: ABdhPJyT4HMsF2dGuzPGOpl0Fmmj/5h+d6AATcrI1yEQ9m4uXBupaw+02kQjwB+emw72k0yf/4XBLFESW2s0tB5X0S0=
X-Received: by 2002:a65:654e:: with SMTP id a14mr3609659pgw.265.1612518205362;
 Fri, 05 Feb 2021 01:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20210128111549.GA8174@zhaomy-pc> <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
 <CGME20210204123452eucas1p1eb8fd9dc5b62b036ebd9e9208e796cb9@eucas1p1.samsung.com>
 <CANMq1KAuUTqgM2mDR5WN6Ad+cATFXLPE+5rstyhfNE9Lc716+g@mail.gmail.com>
 <b680fef2-7c8a-183b-443a-6b2b9fe595d7@samsung.com> <CANMq1KAVMhFAdy_s4R-h1yzNWXRgWgZ4s9kQL11LDze3+Qv5_w@mail.gmail.com>
In-Reply-To: <CANMq1KAVMhFAdy_s4R-h1yzNWXRgWgZ4s9kQL11LDze3+Qv5_w@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 5 Feb 2021 10:43:14 +0100
Message-ID: <CAG3jFyu4JvH7iDriQWdwgkVaHH=vjGaVwF3P7DWLRbb19pKxsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: enable DSI EOTP
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, devel@driverdev.osuosl.org,
        Nicolas Boichat <drinkcat@google.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sheng Pan <span@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, Xin Ji <xji@analogixsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 23:25, Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Feb 4, 2021 at 8:59 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >
> >
> > W dniu 04.02.2021 o 13:34, Nicolas Boichat pisze:
> > > On Thu, Feb 4, 2021 at 8:07 PM Robert Foss <robert.foss@linaro.org> wrote:
> > >> Hi Xin,
> > >>
> > >> Thanks for the patch.
> > >>
> > >> On Thu, 28 Jan 2021 at 12:17, Xin Ji <xji@analogixsemi.com> wrote:
> > >>> Enable DSI EOTP feature for fixing some panel screen constance
> > >>> shift issue.
> > >>> Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.

Does "constance shift" have a typo? Should it be "constant shift"?

With that sorted out feel free to add my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

> > >> I don't think I quite understand how removing the
> > >> MIPI_DSI_MODE_EOT_PACKET flag will cause DSI EOTP to be enabled. Could
> > >> you extrapolate on this in the commit message?
> > > That confused me as well, but it turns out that's how the flag is defined:
> > > ```
> > > /* disable EoT packets in HS mode */
> > > #define MIPI_DSI_MODE_EOT_PACKET BIT(9)
> > > ```
> > > (https://protect2.fireeye.com/v1/url?k=5bd95ebd-044267fb-5bd8d5f2-0cc47a3003e8-ce9db8ea264d6901&q=1&e=900556dc-d199-4c18-9432-5c3465a98eae&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Finclude%2Fdrm%2Fdrm_mipi_dsi.h%23L129)
> > >
> > > I'm almost tempted to put together a mass patch to rename all of these flags...
> >
> >
> > Yes that would be good, many of these flags were just copy pasted from
> > some hw datasheet, without good analysis how to adapt them to the framework.
>
> I'll look into it (but that shouldn't block this patch).

Thanks for clearing this up Nicolas & Andrzej!
