Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6061F4261A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhJHB0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhJHBZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:25:59 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:24:04 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n63so11591726oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=naG1P+MZ79esuZZtF4hMLGLIc5QCJUK3N1b3eboxXww=;
        b=AeoKT6PhHNW1H+jjEz0WRm7QsKDIw2r9uDW8cmImCp6oNqJQEfV7B5dnkPNljyhMyI
         9L1wWLtJRw2kOFJtji2bs6M4Beav2bPeAYCyttEMkPZv3cBVsQcz0BIB7PHcoHoJ4gIu
         qxHqzKAWcNYfnDYcmi9gv+3MVqTtYh9/pQ5No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=naG1P+MZ79esuZZtF4hMLGLIc5QCJUK3N1b3eboxXww=;
        b=UM4uOS8DhLVeJnXpzNdXjRBpQtUKhyEFhtp05k6XuswowIZpXgAOSdXd0Zawa/9L2k
         XO0HYRKAG83ZAdQqZEZLLVGbNhAHl7SFwzLFj0a+C3/xyz826y95rvONt5OHZIhTxFWD
         T4SINCFQbgM99yr0PXbo5PHI75yhzHAIGY+oh7TvSgOs8oZ/Se4AdYiqUHRZQ1H5dVN/
         p9PF2tNsSwb3mvnBk+yz0ljDU5uFmzfmO2uewUVME866dT3yPmS4mna0FBTVoiovQMUY
         8q5bk/v6I1PPMnyUDeP7E7ANIFQyEaQkm70z+lpx5gjTQp4VcANSzSZ2QLFNlbQGxTTW
         3gzw==
X-Gm-Message-State: AOAM533IZGN9kfNKg5KFHRA1h2WdlUmTfpYs41tZ84I7t04y6o2rl2zY
        8KvHy4kz+xYzgzzauk5djtS2qlrDPpczwW3XI6ACEA==
X-Google-Smtp-Source: ABdhPJxZpYNZdTIYUswnJFAZN5d8OgMx7wQAnRve3zAEDw9kNgGvNb0KWpe4QGeS/wAmqHDijcq6btR/ht/K/Y5dYwo=
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr14247028oiw.164.1633656244097;
 Thu, 07 Oct 2021 18:24:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 21:24:03 -0400
MIME-Version: 1.0
In-Reply-To: <CAGETcx_0GRg7u3dAxP9u0qO-hfJ0N3V44CGLwFFX1kVxZ00g+w@mail.gmail.com>
References: <20211006193819.2654854-1-swboyd@chromium.org> <20211006193819.2654854-3-swboyd@chromium.org>
 <CAGETcx9T59dHXodt9MW=tTV_hYhtNOZzYFT=35D--VN7WJ0GqQ@mail.gmail.com>
 <CAE-0n50YqKr1nKy-4WaxsfuwPiJ5kZcf46t-U_4i-TpfXzOX1g@mail.gmail.com>
 <CAE-0n532XYgT=dTTCyLcwikvxgUyGi=TcybDh=v3wQTNb=wqyw@mail.gmail.com> <CAGETcx_0GRg7u3dAxP9u0qO-hfJ0N3V44CGLwFFX1kVxZ00g+w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 21:24:03 -0400
Message-ID: <CAE-0n52ytNtf5atojYrLviuAKOt3v+mLVoPeqtRUf-6uBpkiJA@mail.gmail.com>
Subject: Re: [PATCH v2 02/34] component: Introduce the aggregate bus_type
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-10-07 18:10:24)
> On Thu, Oct 7, 2021 at 1:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Stephen Boyd (2021-10-07 11:40:07)
> > > Quoting Saravana Kannan (2021-10-06 20:07:11)
> > > > On Wed, Oct 6, 2021 at 12:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > > > > index 0a41bbe14981..d99e99cabb99 100644
> > > > > --- a/drivers/base/component.c
> > > > > +++ b/drivers/base/component.c
> > > [...]
> > > > > +                       continue;
> > > > > +
> > > > > +               /* Matches put in component_del() */
> > > > > +               get_device(&adev->dev);
> > > > > +               c->link = device_link_add(&adev->dev, c->dev,
> > > > > +                                         DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> > > >
> > > > Remove the STATELESS flag and you'll get a bunch of other stuff done for free:
> > >
> > > I tried that and it didn't work for me. The aggregate device never
> > > probed and I was left with no display. Let me see if I can reproduce it
> > > with logging to provide more details.
> >
> > This patch fixes it (whitespace damaged sorry).
>
> Not sure why you have to trigger an explicit rescan, but instead of
> this patch below, you could also try setting this flag instead?
> DL_FLAG_AUTOPROBE_CONSUMER
>

I'd rather not conflate component driver probe with component_add()
being called. It's simpler if that is the case, i.e. all component
drivers are calling component_add() in their driver probe routine, but I
don't know if that's always true. I did this poor audit of the kernel

$ git grep -p \[^_]component_add | grep \.c=  | grep -v probe
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=static int
amdgpu_dm_audio_init(struct amdgpu_device *adev)
drivers/gpu/drm/i915/display/intel_audio.c=static void
i915_audio_component_init(struct drm_i915_private *dev_priv)
drivers/gpu/drm/i915/display/intel_hdcp.c=void
intel_hdcp_component_init(struct drm_i915_private *dev_priv)
drivers/gpu/drm/nouveau/dispnv50/disp.c=nv50_audio_component_init(struct
nouveau_drm *drm)
drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c=static int
dw_mipi_dsi_rockchip_host_attach(void *priv_data,
drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c=static int
dw_mipi_dsi_dphy_init(struct phy *phy)
drivers/gpu/drm/vc4/vc4_dsi.c=static int vc4_dsi_host_attach(struct
mipi_dsi_host *host,

and then peeking at rockchip above I see that component_add() is called
in the mipi dsi attach ops and then I got lost trying to figure out
where it ends up. Maybe it is still in some probe call?

Anyway, I think we still have to do a rescan so that we can try to bind
the aggregate device. Is there a better API to use for that?
