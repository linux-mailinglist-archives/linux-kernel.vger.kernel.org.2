Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427D3B2F30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFXMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhFXMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:42:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF66C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:40:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i6so5076715pfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C38GYrWeEqn9ryL7zps8yOxhcW8ssLvsptRrONqKIew=;
        b=oPHof5ahVU78lKBca6qSqBEQlupAPft1mjL6zU5f5XTLP3hsB+DIYJgVYGTFXO6uv5
         zhvPSREczIT7PDEXa3sIyUoWEq/w4ltJZ3MAsDlmuwMPk6LbjaIuIM5Pg6MzJLhQMsgm
         BnnSvLMro1v1EzB+FOCmPvDuoq22wScXkFU0siaNsM03AqvMIFkiNGhPVhfIyGMemeMp
         fLQhwZtfI1cc8SePf+M9eV2vm+O+eoRCfCm4lFO3WJrNO4HZL5f7zki+It+g/Zgywz8b
         TQmklY4V+GYUKWn3gnRQSTp8NZc7w4bFBwqgyOZhJln+mwe/sdL1vWNeLlupJC9JFa8Z
         cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C38GYrWeEqn9ryL7zps8yOxhcW8ssLvsptRrONqKIew=;
        b=qYr2hxULNTCp2XfXbEiIOrHNQO+OTHUFBKi3j9SE1EHmj+JZg4pLfMQuRSz4Ezap8V
         urJLNyYMzWMyjSl3xIRZirLkBPOo4KiDQRgsZ2GzC8YEph0bQ5C1gk/XWVgL15fOVaqn
         3jeUJMIA2Ai9JhxmlCxZYMn3mZmWMS4iCSsa3x4h1BQCXaqZpR/+XMbqCJlI+vPEM4sG
         74Y+DhW1109j5b4FTV2PTO2VFAfWCWDU+I6t+skw0cggWQqsvillA/esaGfBU/shpgCR
         1PtC6QrDgXDL4ifW8jxn9D9eI7R10lWbDBgLK+5sJQkcFV3L4C89Cz/KFdxPhlmOm8Yi
         V/FQ==
X-Gm-Message-State: AOAM531dZa3rwzymQkDslrGtkk+IoclDXp6UjOYIRBN4pCPjfY6T+rPG
        gRWzjNgrMHczuZuAKzyqmrTbK+2pZ5XWVKIIBOA=
X-Google-Smtp-Source: ABdhPJwNnlaCJfFXIZrf+/lJ+Uih3hNkHuFBDvDdGKPZwqvnwUBK9Jg3kLd41iC+VIEjROxK5sKynkZqpLbeeUGdPdI=
X-Received: by 2002:a62:b502:0:b029:2ec:a539:e29b with SMTP id
 y2-20020a62b5020000b02902eca539e29bmr4753939pfe.37.1624538399388; Thu, 24 Jun
 2021 05:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210203091306.140518-1-jagan@amarulasolutions.com>
 <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com> <CAMty3ZAY7Ez9UYvfftSmqLEVWgN7xE5HevqfWirmrExZH=RMWA@mail.gmail.com>
In-Reply-To: <CAMty3ZAY7Ez9UYvfftSmqLEVWgN7xE5HevqfWirmrExZH=RMWA@mail.gmail.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Thu, 24 Jun 2021 22:39:48 +1000
Message-ID: <CANwerB1AiiT3oXCpwP83M1=ES9M-yQoLuZO5f=eVxA42MkEbiA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
To:     Jagan Teki <jagan@amarulasolutions.com>
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

Hi Jagan,

On Thu, 24 Jun 2021 at 22:34, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Jonathan,
>
> On Fri, Jun 18, 2021 at 6:40 PM Jonathan Liu <net147@gmail.com> wrote:
> >
> > Hi Jagan,
> >
> > On Wed, 3 Feb 2021 at 09:13, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> > >         dw_mipi_dsi_debugfs_init(dsi);
> > >         pm_runtime_enable(dev);
> > >
> > > +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> > > +                                         &panel, &bridge);
> > > +       if (ret)
> > > +               return ERR_PTR(ret);
> >
> > On RK3399 if the error is EPROBE_DEFER, __dw_mipi_dsi_probe can be
> > called again and result in the following errors:
> > [    0.717589] debugfs: Directory 'ff960000.mipi' with parent '/'
> > already present!
> > [    0.717601] dw-mipi-dsi-rockchip ff960000.mipi: failed to create debugfs root
> > [    0.717606] dw-mipi-dsi-rockchip ff960000.mipi: Unbalanced pm_runtime_enable!
>
> Is this when you test bridge on rk3399 or panel?

MIPI-DSI to LVDS bridge.

Regards,
Jonathan
