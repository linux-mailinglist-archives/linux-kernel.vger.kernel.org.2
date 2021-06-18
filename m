Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164003ACBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFRNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhFRNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:12:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:10:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m17so1467566plx.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeflnMpXCc8lQl488t2UyqqllAHiO3IjtrjGZgwxjE8=;
        b=l4JvENXKS+0wuXa9Dd7ASyOi+R2Ra1aLIyA3k6/hFxsit72DMEgc04M2UT1qYk5Sb0
         WspU0VkFFL2rOaKiwcWlw6iLuFtDYrkBFGTYnoWKOx0j5yPXk6liOpjHGfCyYCF/WXSb
         uXLJ80qb0RBPXArA/ItZJI05DK9fbVDKsCbP3OrZS+F9FIA+kjubUgtL33FY+wHQvdqA
         IlUzws0eoYgmiXbL1Aog1Fxp9UDyg8ViwDqml0U9R5abh5W+c3OtLIc3PDV145QF493k
         5OazSdv+z0dulHEsk7iosWreirruFs8y3ZBkwSFKYQtqA7QikIbxeVkqaV7+ISh+MZWf
         fr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeflnMpXCc8lQl488t2UyqqllAHiO3IjtrjGZgwxjE8=;
        b=ErEl/w2cHnHW03Q4WRKQXO7EHysHlSlWjEUXFXrt1nK4fNboLadX8gUTG2hY/S9PMU
         cv+NTjmxE6Yv7hiRY58zQq/2QgIQq3wQzPozTB2AXaBjYpXaM+3zuhEDVFVoxViaTFeB
         9hsrsWXT/8xuS10kR1YQDtgVzUAMW1IInBvrQ1pz4ngnWFQrekePlLeeOmp+BnpPFeaX
         wfAiQ4CJajcoqpJKFc2WJm5E+NEPwx5irQD0P0w9xgdS0efFROQhhqnsDIxi88LKOebI
         3Mvd7lyZ4LdYQfneAiql8MBIVRhpHZ1ffeuQCMiprkBBmOZQIAw8KOXCFJGgHHRsnkXn
         KA6w==
X-Gm-Message-State: AOAM532Np2KfWPIGCEdYBhAjdUeRyMFvtUaGEOYnjIBJnN5i6uCHPJiI
        vgs2E8pev+0AYjI8vlstJkV4dbZRvYksaMpYXbg=
X-Google-Smtp-Source: ABdhPJzcSX6tm09hnesQWqlEKd9p2OWaX9DN17n4s3XcCvm5NLcAdCBgDPUZFvnKjiSXNhS667ToHT0D90tnVJ9s7Nk=
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr11065571pjn.66.1624021846430;
 Fri, 18 Jun 2021 06:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210203091306.140518-1-jagan@amarulasolutions.com>
In-Reply-To: <20210203091306.140518-1-jagan@amarulasolutions.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Fri, 18 Jun 2021 23:10:33 +1000
Message-ID: <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com>
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
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, 3 Feb 2021 at 09:13, Jagan Teki <jagan@amarulasolutions.com> wrote:
> @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>         dw_mipi_dsi_debugfs_init(dsi);
>         pm_runtime_enable(dev);
>
> +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> +                                         &panel, &bridge);
> +       if (ret)
> +               return ERR_PTR(ret);

On RK3399 if the error is EPROBE_DEFER, __dw_mipi_dsi_probe can be
called again and result in the following errors:
[    0.717589] debugfs: Directory 'ff960000.mipi' with parent '/'
already present!
[    0.717601] dw-mipi-dsi-rockchip ff960000.mipi: failed to create debugfs root
[    0.717606] dw-mipi-dsi-rockchip ff960000.mipi: Unbalanced pm_runtime_enable!

Regards,
Jonathan
