Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F343B4438AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhKBWqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhKBWqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:46:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDCC061714;
        Tue,  2 Nov 2021 15:44:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee33so2628069edb.8;
        Tue, 02 Nov 2021 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LDnLbQUA7eyK1FrDO7VrlZC4VQ3RUSvHLnAoAvoZuOc=;
        b=LmY8iRfTTKzcFKxpKJUZaG1G77If5TNT9NJ8reyrdO8Kw8HmqSMogK8+FRYVT7Ak4q
         pg+n01qQ+ks8LcRf/ms8jIV+K5jnryBcMwehAnyZhSzDVTyqsXwTyXRblGHcXOxPiKzo
         bR1z2eLwiXxiMjqh49/LxQ2Rr82fw//4jxjlR7ZdJ2alozrXSxrB9bepMUfAzwnOMFdb
         h3l7w1QHs+f7gayW0aRaukyMm6YcvDP/SI/bFD6bEjfEvLBT9JB1i752YXcw6xVCnqDy
         3wsUlllmsFsFSCa8IrNLHcj7qkK+7gaAja6Yw+3rP4N1t551EZOUkcwP+cEDMpj1UMLZ
         OdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDnLbQUA7eyK1FrDO7VrlZC4VQ3RUSvHLnAoAvoZuOc=;
        b=xqjZ/BHvYAncVol2+QO3MdN0c0Om5DHBNTU2JhkI1SxKcKWlhBBltl150uA8h+kXZ5
         6ypC0VrLsYIDekpuKAO9OPvnp56M8RM7qqcjja76IoKROziR/MjhRCS5GOtv+C315JqF
         H3OiwAWpUJRRbKpHkZou0TlrvjUIM8liCf5dTfRnhm9+GUHlVf/B6n12oTyso0X64BG8
         /uTiccri+sNGVXW6HZsHBh1ikn4AzSQunO0c20p5QQaDKduXQd2cz5E98b/4eYcCpQ+f
         DZYXZ9P8e6YLyJVXPO/F4g2VawxlTd9z3Do3XlShx1gARZ++LLixYWjlhYoLdb4LDi25
         4pFw==
X-Gm-Message-State: AOAM532q5eMWn37tq6/HmwcOgmHqkJKcAeux21jXLd7CznYsO1beMJpD
        AFiQeLAx9lvxf/z4QgdcEGk=
X-Google-Smtp-Source: ABdhPJyfX+Es3nzz+CM8s/jrO5166B1Fk/2V22GKG3Qj9qhStAoxFdqbv0reUmd4k6YAJd4OkyWdzA==
X-Received: by 2002:a17:907:3eaa:: with SMTP id hs42mr48695778ejc.429.1635893043028;
        Tue, 02 Nov 2021 15:44:03 -0700 (PDT)
Received: from tom-ThinkPad-T470p (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id z22sm163651edc.83.2021.11.02.15.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 15:44:02 -0700 (PDT)
Date:   Tue, 2 Nov 2021 23:43:58 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
Message-ID: <20211102224358.GA4637@tom-ThinkPad-T470p>
References: <20211101222857.6940-1-tomm.merciai@gmail.com>
 <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop>
 <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
 <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE>
 <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
 <20211102154742.GA86474@tom-ThinkBook-14-G2-ARE>
 <CAHCN7xJtDtBNJ-rFcveya8TGr8+jA-HrDBxPYfZx=fiv7w5UPA@mail.gmail.com>
 <CAJ+vNU0DRMuVMgibc1Ag3HdPXFq1Mzs-q0Znb0aLukYVvKc1gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0DRMuVMgibc1Ag3HdPXFq1Mzs-q0Znb0aLukYVvKc1gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 11:18:53AM -0700, Tim Harvey wrote:
> On Tue, Nov 2, 2021 at 9:08 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Tue, Nov 2, 2021 at 10:47 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > >
> > > On Tue, Nov 02, 2021 at 07:23:06AM -0500, Adam Ford wrote:
> > > > The upcoming 5.16 kernel will have a new blk-ctrl driver which will
> > > > work in conjunction with the GPC.  You can see it in linux-next [1],
> > > > and I would expect it to be present in 5.16-rc1 once the merge is
> > > > done.
> > > >
> > > > In [1], Look for :
> > > >
> > > > disp_blk_ctrl: blk-ctrl@32e28000 {
> > > >     compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> > > >
> > > > It creates a bunch of virtual power domains which are effectively the
> > > > resets for the VPU, CSI, DSI, and LCDIF [2].
> > > >
> > > > Basically, to pull the respective device out of reset, you'd reference
> > > > them using power-domains.  I have an RFC patch for the CSI located [3]
> > > > which should bring the GPC power domain up, then take the CSI bridge
> > > > and MIPI_CSI out of reset using the blk-ctrl.  A few of us are still
> > > > investigating the CSI bridge and mipi_csi drivers to determine what's
> > > > going wrong, but  inside that patch, you'll see that we reference
> > > > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;" and
> > > > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;" which
> > > > are part of the new blk-ctrl driver @32e2800.  Other peripherals like
> > > > LCD, DSI, and the VPU's should be able to reference their respective
> > > > power domains to activate the corresponding resets after enabling the
> > > > proper GPC power domain.
> > >
> > >   Hi Adam,
> > >   Then is all done right. Using this this new driver/dts node eLCDIF/mipi_dsi
> > >   module are out of reset. Thanks for the tips. I'm trying to get eLCDIF/mipi_dsi
> > >   work on mainline. I try to get work
> > >
> > >   - eLCDIF using: mxsfb_drv.c
> > >   - mipi_dsi using: nwl-dsi.c
> > >
> > >   What do you think about? You think that can be a good way ( taking
> > >   imx8mq as reference )?
> >
> > The DSI controller for the 8MM and 8MN is not the same as the DSI
> > controller on the 8MQ, but the LCDIF controller should be compatible.
> >
> > There have been several attempts to support the 8MM DSI, but none of
> > them have been accepted for various reasons.
> >
> > The latest was found here [1], but others [2]  and [3] , when used
> > together, do something similar.
> >
> > If memory serves, the main issue has to do with the fact that the DSIM
> > controller in the 8MM and 8MN is also present in one of the Samsung
> > processors, and the goal is to rework those drivers so we'll have one
> > driver that supports both Samsung progressors and NXP instead of
> > having two duplicate drivers doing the same thing. When whatever
> > driver is chosen is ready, it'll be likely that the LCDIF will use
> > power-domains = <&disp_blk_ctrl MX8MM_DISPBLK_PD_LCDIF> and the DSI
> > node will use power-domains = <&disp_blk_ctrl
> > IMX8MM_DISPBLK_PD_MIPI_DSI> to pull their respective devices out of
> > reset and enable the gpc.
> >
> >
> > [1] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=510489&archive=both&state=*
> > [2] - https://patchwork.kernel.org/project/dri-devel/list/?series=347439&archive=both&state=*
> > [3] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=359775&archive=both&state=*
> 
> Adam,
> 
> Thanks for the good summary... I was just putting this info together
> as well. I'm also interested to see if anyone has made progress on
> IMX8MM MIPI DSI display. Now that blk-ctl and most of the dt bindings
> have been merged for 5.16 I think we are just down to the drm/exynos
> driver issue.
> 
> Added Frieder, Jagan, and Michael to the thread.
> 
> Best Regards,
> 
> Tim

  Hi Adam,
  Thanks again for your explanation. Then, now the main goal is refactoring
  exynos dsim driver as bridge driver in order to support both imx8mm and exynos
  SOC. I'll investigate on it.

  Regards,
  Thanks
