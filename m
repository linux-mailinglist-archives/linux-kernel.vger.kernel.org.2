Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89984430307
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhJPOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhJPOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 10:33:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41471C061764
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:30:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so8247961plk.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFWZxfrqmpWwQLq0xfWPpJ5XaJIZBKj5ajALk+Bkxto=;
        b=nfjH0k2fqlKU7tS6QzkeS+/Lrrk2A/0ANY7INB1MohH5AoBXTF6NXnS98kKs7wWzR3
         TYlWEHArvzQUcaoMEBTGHJIxRZvPUJrkxeEiD2JoMsFECCuN6s810xOXc9gcRinaruBG
         mcTPq4LruirCYtiHXRFcp5YwHhdYshOVdvDKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFWZxfrqmpWwQLq0xfWPpJ5XaJIZBKj5ajALk+Bkxto=;
        b=xHi9fvcUvxhADo2HoFj8j4aDEM/FSAnP1i4QO3uXczpaK2iJ5IdlqvwGqjCe8PJOGu
         ta8hf+3q2T7yTYiWXhcU0BgcERaCMv/AbwwmsGXpvoLyEPCeN+Atp7rvknRf0XtzvxmG
         bo82IUGDIsmMSt/rSa9Wag0ReEtqG1MvVl4vRxiiCTV/SQhcSZz3lnr/M3OANKeQoDBP
         0IAUfd+O0GlEBWru5+f9yD9dhugYKoXyknC2ulUnkeCVt6lD9SJcgLd2gxbKhGRQl9VY
         AH84npta3nVe4Nym6Q5l5kjvqtijHuOu66TFJAjiC+u+6+gDVhalGY0wdEX+ijh7dr5O
         pC6g==
X-Gm-Message-State: AOAM531Hr1DDIkEMsypqOWMsMxyQx+IVCPerTxF9ZkrbJdMjc1BSPWsE
        I1H7Phx//W95CeSOIKMD3qD9zH2SXe1Kql5vkp2eUw==
X-Google-Smtp-Source: ABdhPJxltGwAHceuSbPWQlv11/ubGTKQQsGFf8jMBzhOD3ZvI+RLJ5aiLG12tFpf5CIWoMykyx3HNUb/whrxyNNQP2E=
X-Received: by 2002:a17:902:9887:b0:13f:7704:425f with SMTP id
 s7-20020a170902988700b0013f7704425fmr17054769plp.20.1634394653339; Sat, 16
 Oct 2021 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211016102232.202119-1-michael@amarulasolutions.com>
 <20211016102232.202119-6-michael@amarulasolutions.com> <YWrEqStMPYuzUoUn@ravnborg.org>
 <CAOf5uwm0iiSNvDF9ambZPQ9O6OCkWWAobxXvKYd6ieDscnNXVw@mail.gmail.com>
In-Reply-To: <CAOf5uwm0iiSNvDF9ambZPQ9O6OCkWWAobxXvKYd6ieDscnNXVw@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 16 Oct 2021 16:30:42 +0200
Message-ID: <CAOf5uwmE0__Rv2oeY_Ddz_G9A4D7UGRwj5+jbWK+KH97XCdtvA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/bridge: dw-mipi-dsi: Fix dsi registration during
 drm probing
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Forget this one I can not replicate. We have another problem

 9862.010474] Hardware name: Rockchip PX30 EVB (DT)
[ 9862.015738] Call trace:
[ 9862.018471]  dump_backtrace+0x0/0x19c
[ 9862.022586]  show_stack+0x1c/0x70
[ 9862.026305]  dump_stack_lvl+0x68/0x84
[ 9862.030408]  dump_stack+0x1c/0x38
[ 9862.034125]  ili9881c_unprepare+0x1c/0x4c
[ 9862.038619]  drm_panel_unprepare+0x2c/0x4c
[ 9862.043212]  panel_bridge_post_disable+0x18/0x24
[ 9862.048390]  dw_mipi_dsi_bridge_post_disable+0x3c/0xf0
[ 9862.054153]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0
[ 9862.060399]  disable_outputs+0x120/0x31c
[ 9862.064785]  drm_atomic_helper_commit_tail_rpm+0x28/0xa0
[ 9862.070734]  commit_tail+0xa4/0x184
[ 9862.074642]  drm_atomic_helper_commit+0x164/0x37c
[ 9862.079902]  drm_atomic_commit+0x50/0x60
[ 9862.084298]  drm_atomic_helper_disable_all+0x1fc/0x210
[ 9862.090053]  drm_atomic_helper_shutdown+0x80/0x130
[ 9862.095419]  rockchip_drm_platform_shutdown+0x1c/0x30
[ 9862.101081]  platform_shutdown+0x28/0x40
[ 9862.105477]  device_shutdown+0x15c/0x330
[ 9862.109877]  __do_sys_reboot+0x214/0x294
[ 9862.114273]  __arm64_sys_reboot+0x28/0x3c
[ 9862.118765]  invoke_syscall+0x48/0x114
[ 9862.122969]  el0_svc_common.constprop.0+0x44/0xec
[ 9862.128241]  do_el0_svc+0x28/0x90
[ 9862.131958]  el0_svc+0x20/0x60
[ 9862.135381]  el0t_64_sync_handler+0x1a8/0x1b0
[ 9862.140263]  el0t_64_sync+0x1a0/0x1a4
[ 9862.145769] CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G        W
        5.15.0-rc5 #1
[ 9862.154957] Hardware name: Rockchip PX30 EVB (DT)
[ 9862.160221] Call trace:
[ 9862.162954]  dump_backtrace+0x0/0x19c
[ 9862.167068]  show_stack+0x1c/0x70
[ 9862.170787]  dump_stack_lvl+0x68/0x84
[ 9862.174895]  dump_stack+0x1c/0x38
[ 9862.178611]  ili9881c_unprepare+0x1c/0x4c
[ 9862.183103]  drm_panel_unprepare+0x2c/0x4c
[ 9862.187695]  panel_bridge_post_disable+0x18/0x24
[ 9862.192872]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0
[ 9862.199117]  disable_outputs+0x120/0x31c
[ 9862.203512]  drm_atomic_helper_commit_tail_rpm+0x28/0xa0
[ 9862.209461]  commit_tail+0xa4/0x184
[ 9862.213368]  drm_atomic_helper_commit+0x164/0x37c
[ 9862.218629]  drm_atomic_commit+0x50/0x60
[ 9862.223025]  drm_atomic_helper_disable_all+0x1fc/0x210
[ 9862.228781]  drm_atomic_helper_shutdown+0x80/0x130
[ 9862.234147]  rockchip_drm_platform_shutdown+0x1c/0x30
[ 9862.239810]  platform_shutdown+0x28/0x40
[ 9862.244205]  device_shutdown+0x15c/0x330
[ 9862.248603]  __do_sys_reboot+0x214/0x294
[ 9862.253000]  __arm64_sys_reboot+0x28/0x3c
[ 9862.257492]  invoke_syscall+0x48/0x114
[ 9862.261696]  el0_svc_common.constprop.0+0x44/0xec
[ 9862.266970]  do_el0_svc+0x28/0x90
[ 9862.270687]  el0_svc+0x20/0x60
[ 9862.274111]  el0t_64_sync_handler+0x1a8/0x1b0
[ 9862.278992]  el0t_64_sync+0x1a0/0x1a4
[ 9862.283296] ------------[ cut here ]------------
[ 9862.288490] unbalanced disables for vcc3v3_lcd
[ 9862.293555] WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2851
_regulator_disable+0xd4/0x190

The panel can be disable two times.

 /*
         * TODO Only way found to call panel-bridge post_disable &
         * panel unprepare before the dsi "final" disable...
         * This needs to be fixed in the drm_bridge framework and the API
         * needs to be updated to manage our own call chains...
         */
        if (dsi->panel_bridge->funcs->post_disable)
                dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);

Is this comment relevant?

Michael

On Sat, Oct 16, 2021 at 3:32 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Sam
>
> On Sat, Oct 16, 2021 at 2:25 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Michael,
> >
> > I fail to follow the logic in this patch.
> >
> >
> > On Sat, Oct 16, 2021 at 10:22:32AM +0000, Michael Trimarchi wrote:
> > > The dsi registration is implemented in rockchip platform driver.
> > > The attach can be called before the probe is terminated and therefore
> > > we need to be sure that corresponding entry during attach is valid
> > >
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c   |  8 +++++++-
> > >  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++++++----
> > >  include/drm/bridge/dw_mipi_dsi.h                |  2 +-
> > >  3 files changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > > index e44e18a0112a..44b211be15fc 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > > @@ -362,8 +362,14 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
> > >               dsi->device_found = true;
> > >       }
> > >
> > > +     /*
> > > +      * NOTE: the dsi registration is implemented in
> > > +      * platform driver, that to say dsi would be exist after
> > > +      * probe is terminated. The call is done before the end of probe
> > > +      * so we need to pass the dsi to the platform driver.
> > > +      */
> > >       if (pdata->host_ops && pdata->host_ops->attach) {
> > > -             ret = pdata->host_ops->attach(pdata->priv_data, device);
> > > +             ret = pdata->host_ops->attach(pdata->priv_data, device, dsi);
> > >               if (ret < 0)
> > >                       return ret;
> > >       }
> > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > > index a2262bee5aa4..32ddc8642ec1 100644
> > > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > > @@ -997,7 +997,8 @@ static const struct component_ops dw_mipi_dsi_rockchip_ops = {
> > >  };
> > >
> > >  static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
> > > -                                         struct mipi_dsi_device *device)
> > > +                                         struct mipi_dsi_device *device,
> > > +                                         struct dw_mipi_dsi *dmd)
> > >  {
> > >       struct dw_mipi_dsi_rockchip *dsi = priv_data;
> > >       struct device *second;
> > > @@ -1005,6 +1006,8 @@ static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
> > >
> > >       mutex_lock(&dsi->usage_mutex);
> > >
> > > +     dsi->dmd = dmd;
> > > +
> > >       if (dsi->usage_mode != DW_DSI_USAGE_IDLE) {
> > >               DRM_DEV_ERROR(dsi->dev, "dsi controller already in use\n");
> > >               mutex_unlock(&dsi->usage_mutex);
> > > @@ -1280,6 +1283,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev = &pdev->dev;
> > >       struct device_node *np = dev->of_node;
> > > +     struct dw_mipi_dsi *dmd;
> > >       struct dw_mipi_dsi_rockchip *dsi;
> > >       struct phy_provider *phy_provider;
> > >       struct resource *res;
> > > @@ -1391,9 +1395,9 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> > >       if (IS_ERR(phy_provider))
> > >               return PTR_ERR(phy_provider);
> > >
> > > -     dsi->dmd = dw_mipi_dsi_probe(pdev, &dsi->pdata);
> > > -     if (IS_ERR(dsi->dmd)) {
> > > -             ret = PTR_ERR(dsi->dmd);
> > > +     dmd = dw_mipi_dsi_probe(pdev, &dsi->pdata);
> > > +     if (IS_ERR(dmd)) {
> > > +             ret = PTR_ERR(dmd);
> >
> > The memory pointed to by dmd is allocated in dw_mipi_dsi_probe(), but
> > the pointer is not saved here.
> > We rely on the attach operation to save the dmd pointer.
> >
> >
> > In other words - the attach operation must be called before we call
> > dw_mipi_dsi_rockchip_remove(), which uses the dmd member.
> >
> > This all looks wrong to me - are we papering over some other issue
>
> Ok, it's wrong. I was not expecting that call.Anyway this was my path
> on linux-next
>
> dw_mipi_dsi_rockchip_probe
> dw_mipi_dsi_probe -->start call
>
> dw_mipi_dsi_rockchip_host_attach <-- this was not able to use dmd
>
> dw_mipi_dsi_probe -> exit from the call
>
> Michael
>
> > here?
> >
> >         Sam
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
