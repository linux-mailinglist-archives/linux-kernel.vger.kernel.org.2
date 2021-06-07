Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6151239E4F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFGRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhFGRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:29 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03477C061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:07:25 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so4290248ooa.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmeYQ/ZjjCaIyjItMjlP85jvXRjCl3Zk4JkEtkJYSBY=;
        b=oISc4cU4YTQkjp0n9pgdr1lbPZXsWrFmqBytfBGf/VTDke+AUi5NgsMmgMWBNX7pOi
         yz01vx6nHE34B+5QvYaAy5AIp1leR3my8AuccPTtPbCsKKS/0rgd+vFejAGV+pC2337M
         Hyu649c0Y6FMGVBtvNZni1VLAGOPfx5AL2Blg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmeYQ/ZjjCaIyjItMjlP85jvXRjCl3Zk4JkEtkJYSBY=;
        b=DTDHYwJXMkUXOxx67CSheQhrM2ptHnrLFPX0gtxBzu5qZmSon3meY8TGQ0UDXuST8x
         ejdIWeFm3b+rxk5Pm2TX7wJam48mU0zY2fo5Dd4Me0fLPfNUGtrJiu/p2FuhcDaHOzVQ
         6ZNI9586E571vTdGlTaksrZhphYRuVRJjDodaia5y5DKMOS640mZ4lElAsNUZBKKldnC
         eZd/GKD0ug0E3ru/kfpFTEbqa6coUlh89Kyksd97MTAreMWw7wskqUrAoDqEeTe5ZuFr
         wXZgagyLCMbZCYkKCg1EZrm2wlp6JUCfGXadugx+UUeaWE2fPialxL1rT0mF2SJgzOlF
         Bgug==
X-Gm-Message-State: AOAM530SHKK6ow172EfnZyfB1N39Kn1cR2oJriOusXnz3qnGwk0Ofzl3
        7R6hZH0X+nyh5FZ2qA/QgogeDO19klutUA==
X-Google-Smtp-Source: ABdhPJymx7sz2N+eY5vfWlsZIroHTtyy043f2mtk9T/0U0C6eam/xXpGTEaRBzqptOi/V6Ur+tk0aA==
X-Received: by 2002:a4a:6142:: with SMTP id u2mr13809190ooe.9.1623085644185;
        Mon, 07 Jun 2021 10:07:24 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id q1sm2265560oos.32.2021.06.07.10.07.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:07:24 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso17423621otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:24 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr25004184ybk.79.1623085632738;
 Mon, 07 Jun 2021 10:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210525000159.3384921-1-dianders@chromium.org>
 <20210524165920.v8.7.I18e60221f6d048d14d6c50a770b15f356fa75092@changeid> <6e0cd667a8a776e524b42f1535827208@codeaurora.org>
In-Reply-To: <6e0cd667a8a776e524b42f1535827208@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jun 2021 10:07:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEUsP4qRB-zj31ykS2UznnY=6WF2pD26=FDnVZy6rxCg@mail.gmail.com>
Message-ID: <CAD=FV=UEUsP4qRB-zj31ykS2UznnY=6WF2pD26=FDnVZy6rxCg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] drm/panel: panel-simple: Stash DP AUX bus; allow
 using it for DDC
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus W <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 4, 2021 at 9:10 AM <rajeevny@codeaurora.org> wrote:
>
> Hi Doug,
>
> >       panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
> >       if (!panel->no_hpd) {
> > @@ -708,6 +712,8 @@ static int panel_simple_probe(struct device *dev,
> > const struct panel_desc *desc)
> >
> >               if (!panel->ddc)
> >                       return -EPROBE_DEFER;
> > +     } else if (aux) {
> > +             panel->ddc = &aux->ddc;
> >       }
>
> In panel_simple_probe(), the put_device(&panel->ddc->dev) call is
> causing issue when the aux->ddc is used to assign panel->ddc
> It works well when "ddc-i2c-bus" is used to assign panel->ddc
>
> static int panel_simple_probe(...)
> {
> ...
>
> free_ddc:
>          if (panel->ddc)
>                  put_device(&panel->ddc->dev);
>
>          return err;
> }

Thanks for catching! Fixed in v9.


-Doug
