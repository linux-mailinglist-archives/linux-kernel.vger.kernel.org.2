Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ECE3B2F12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFXMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhFXMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:37:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:34:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w13so2302442edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrS4IPVgEYnoiDcj56Qmce7AHyXhyRxqB9J3hfr4IBs=;
        b=cqiPcWcohbI63n9hvXxwO0W8g2GbPxBdWjUdDvwSpT59P80Oyl8Ixgx26WIHDJ6WEY
         Ssm887eDP93Z3vkJzGZCF9mPfnHNrXDkbN0ix2RJPNwFpdHsaww0zGAIuu1O5bHEMFdi
         5EMGwBwNy/rhXYegxrbmzylxSWadgu+ec6WbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrS4IPVgEYnoiDcj56Qmce7AHyXhyRxqB9J3hfr4IBs=;
        b=dW77WRZv0mZcR3xZiX37zpXlLk9ffPzJz5o1Z695x63KfV3/SAiyA4uerbwSXuNNqx
         r67V20rVNFonagAx5AzXco/h42D8lKOwLD/uEnnhCKihpQksj391h90fSzvjb7Dbwdvl
         90P5cfqsV5joXCZ73vTRxLUk1bJLzJgwMNT6hcULinTYpVxjK3FspHxI97ZJGDbrC3a1
         23J5uwU9GoLf1d3xIoNK80qK9wISSuvi3z0NnIHGTJo/nu3kgSHEHtQXWDScktM75R8F
         KxwxBjC4YSnVPZ5JEgrpZTvLha1DnGec0sVjLITWGuBaH3WtCkRqTTjloTzwy+NSw2kO
         7BVQ==
X-Gm-Message-State: AOAM530U8+2mv9fJBPBn6lL4+/hxPY4DH6ZWY7PeVEmybCpP8b6H99Sw
        jBI1NpAiw+u6E2hdxh6fhNgvT+tBJteFaDn2B2UvIA==
X-Google-Smtp-Source: ABdhPJxyWnFVcyuQihVaxmHjYBMJxJgEhs4wXx3hV/aL+veRIkFDuNLNgmY0d/BR54XT9OYOwi5pJw7DmxvANqXwT7o=
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr6915604edy.27.1624538088480;
 Thu, 24 Jun 2021 05:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210203091306.140518-1-jagan@amarulasolutions.com> <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com>
In-Reply-To: <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 24 Jun 2021 18:04:37 +0530
Message-ID: <CAMty3ZAY7Ez9UYvfftSmqLEVWgN7xE5HevqfWirmrExZH=RMWA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
To:     Jonathan Liu <net147@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, Jun 18, 2021 at 6:40 PM Jonathan Liu <net147@gmail.com> wrote:
>
> Hi Jagan,
>
> On Wed, 3 Feb 2021 at 09:13, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> >         dw_mipi_dsi_debugfs_init(dsi);
> >         pm_runtime_enable(dev);
> >
> > +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> > +                                         &panel, &bridge);
> > +       if (ret)
> > +               return ERR_PTR(ret);
>
> On RK3399 if the error is EPROBE_DEFER, __dw_mipi_dsi_probe can be
> called again and result in the following errors:
> [    0.717589] debugfs: Directory 'ff960000.mipi' with parent '/'
> already present!
> [    0.717601] dw-mipi-dsi-rockchip ff960000.mipi: failed to create debugfs root
> [    0.717606] dw-mipi-dsi-rockchip ff960000.mipi: Unbalanced pm_runtime_enable!

Is this when you test bridge on rk3399 or panel?

Jagan.
