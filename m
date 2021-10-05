Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C972422CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhJEPl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhJEPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:41:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC7C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:39:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p68so199764iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jn/8ah9SoyFj7/AW/wHvLR/E0NKkVYESoUG4F0G7wes=;
        b=f9xqUyzRkkv5jK2D9eJy++YNj6qTjlTkV8LNjYsHXR5hvKLfMpJp7XMAHvfc1LXbza
         fukG3CzYA7x41zb93VjrPWya2JERm8bljAH1iIC1Ex4rMw1onFVPtSEU722Laf/p58V5
         wRh9Pwz/I9diTXBAUmMJfu2fjeu4HjskBTB1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jn/8ah9SoyFj7/AW/wHvLR/E0NKkVYESoUG4F0G7wes=;
        b=ShgFP6oEwTlSdKxjtK7L1ceOxQteGPdBk1PEvXZvl52vgZ35mN4CmlRZqABy/oazbC
         E9RLDvsjz/7SC18ZyaZRxcHE73UTFfolxoODFFuJ0u4piPTZ4OnuRGtFWIFrDwv2erR4
         0N2nJ7nVOMgpgiiG/agLW0JJ+nDAsjdv1YeemIqCa0FMjxuAzk1xEhCz51FPUrMZEIJz
         cQmPX8iWwrTNPLDLejI0Hwf5DKyEppbimjn5/9lVRqT0qHaXv4sgdagkLutZmc5exo3A
         BzM8I6V6/12JXwsDdotQrq1Jqbc5JMBOHTb7TPOcc57A15giIhrDiz1sxTHmINyMI1PQ
         M+UQ==
X-Gm-Message-State: AOAM533IZGTIMwbVfrho0i2rZ0CKHPI4bKfYUBhMjb70YPQIv8U/2QMs
        lw6gX0r2evOjzGPrGlj9LqJGwTf37UIjSA==
X-Google-Smtp-Source: ABdhPJzfVbP9FCPyzKPRh1wCPaiAgls0wUWinwV7gSMuCQxsiPPPvcLoY5LAtTniPYZ6eK5Y5b7lpA==
X-Received: by 2002:a6b:7118:: with SMTP id q24mr2794190iog.103.1633448376459;
        Tue, 05 Oct 2021 08:39:36 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id j20sm11177859ioo.35.2021.10.05.08.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:39:34 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id y15so22234547ilu.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:39:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr2013043ilf.165.1633448374264;
 Tue, 05 Oct 2021 08:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210726231351.655302-1-bjorn.andersson@linaro.org>
 <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
 <YVd3YdfgFVc0Br5T@ripper> <CAD=FV=U=xVLuKOYHbGPTkLjGa8_U+F1ZtEvJt4LGaRuR5SsKFw@mail.gmail.com>
 <YVumL1lHLqtb/HKS@ripper>
In-Reply-To: <YVumL1lHLqtb/HKS@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Oct 2021 08:39:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9uKq00wXn4H1ax0u2D=R8Wn3J-Je43uxcPyDtk7AK7Q@mail.gmail.com>
Message-ID: <CAD=FV=W9uKq00wXn4H1ax0u2D=R8Wn3J-Je43uxcPyDtk7AK7Q@mail.gmail.com>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vara Reddy <varar@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 4, 2021 at 6:09 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 04 Oct 17:36 PDT 2021, Doug Anderson wrote:
>
> > Hi,
> >
> > On Fri, Oct 1, 2021 at 2:00 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Fri 27 Aug 13:52 PDT 2021, Doug Anderson wrote:
> > >
> > > > Hi,
> > > >
> > > > On Mon, Jul 26, 2021 at 4:15 PM Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > > > >
> > > > > +static int dp_parser_find_panel(struct dp_parser *parser)
> > > > > +{
> > > > > +       struct device_node *np = parser->pdev->dev.of_node;
> > > > > +       int rc;
> > > > > +
> > > > > +       rc = drm_of_find_panel_or_bridge(np, 2, 0, &parser->drm_panel, NULL);
> > > >
> > > > Why port 2? Shouldn't this just be port 1 always? The yaml says that
> > > > port 1 is "Output endpoint of the controller". We should just use port
> > > > 1 here, right?
> > > >
> > >
> > > Finally got back to this, changed it to 1 and figured out why I left it
> > > at 2.
> > >
> > > drm_of_find_panel_or_bridge() on a DP controller will find the of_graph
> > > reference to the USB-C controller, scan through the registered panels
> > > and conclude that the of_node of the USB-C controller isn't a registered
> > > panel and return -EPROBE_DEFER.
> >
> > I'm confused, but maybe it would help if I could see something
> > concrete. Is there a specific board this was happening on?
> >
>
> Right, let's make this more concrete with a snippet from the actual
> SC8180x DT.
>
> > Under the DP node in the device tree I expect:
> >
> > ports {
> >   port@1 {
> >     reg = <1>;
> >     edp_out: endpoint {
> >       remote-endpoint = <&edp_panel_in>;
> >     };
> >   };
> > };
> >
>
> /* We got a panel */
> panel {
>     ...
>     ports {
>         port {
>             auo_b133han05_in: endpoint {
>                 remote-endpoint = <&mdss_edp_out>;
>             };
>         };
>     };
> };
>
> /* And a 2-port USB-C controller */
> type-c-controller {
>     ...
>     connector@0 {
>         ports {
>             port@0 {
>                 reg = <0>;
>                 ucsi_port_0_dp: endpoint {
>                     remote-endpoint = <&dp0_mode>;
>                 };
>             };
>
>             port@1 {
>                 reg = <1>;
>                 ucsi_port_0_switch: endpoint {
>                     remote-endpoint = <&primary_qmp_phy>;
>                 };
>             };
>         };
>     };
>
>         connector@1 {
>         ports {
>             port@0 {
>                 reg = <0>;
>                 ucsi_port_1_dp: endpoint {
>                     remote-endpoint = <&dp1_mode>;
>                 };
>             };
>
>             port@1 {
>                 reg = <1>;
>                 ucsi_port_1_switch: endpoint {
>                     remote-endpoint = <&second_qmp_phy>;
>                 };
>             };
>         };
>         };
> };
>
> /* And then our 2 DP and single eDP controllers */
> &mdss_dp0 {
>     ports {
>         port@1 {
>             reg = <1>;
>             dp0_mode: endpoint {
>                 remote-endpoint = <&ucsi_port_0_dp>;
>             };
>         };
>     };
> };
>
> &mdss_dp1 {
>     ports {
>         port@1 {
>             reg = <1>;
>             dp1_mode: endpoint {
>                 remote-endpoint = <&ucsi_port_1_dp>;
>             };
>         };
>     };
> };
>
> &mdss_edp {
>     ports {
>         port@1 {
>             reg = <1>;
>             mdss_edp_out: endpoint {
>                 remote-endpoint = <&auo_b133han05_in>;
>             };
>         };
>     };
> };
>
> > If you have "port@1" pointing to a USB-C controller but this instance
> > of the DP controller is actually hooked up straight to a panel then
> > you should simply delete the "port@1" that points to the typeC and
> > replace it with one that points to a panel, right?
> >
>
> As you can see, port 1 on &mdss_dp0 and &mdss_dp1 points to the two UCSI
> connectors and the eDP points to the panel, exactly like we agreed.
>
> So now I call:
>     drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
>
> which for the two DP nodes will pass respective UCSI connector to
> drm_find_panel() and get EPROBE_DEFER back - because they are not on
> panel_list.
>
> There's nothing indicating in the of_graph that the USB connectors
> aren't panels (or bridges), so I don't see a way to distinguish the two
> types remotes.

As far as I can tell the way this would be solved would be to actually
pass &bridge in and then make sure that a bridge would be in place for
the DP connector. In the full DP case you'll get an -EPROBE_DEFER if
the connector hasn't been probed but once it's probed then it should
register as a bridge and thus give you the info you need (AKA that
this isn't a panel).

I haven't done the digging to see how all this works, but according to
Laurent [1]: "Physical connectors are already handled as bridges, see
drivers/gpu/drm/bridge/display-connector.c"

So basically I think this is solvable in code and there's no reason to
mess with the devicetree bindings to solve this problem. Does that
sound right?

[1] https://lore.kernel.org/r/YUvMv+Y8tFcWPEHd@pendragon.ideasonboard.com/
