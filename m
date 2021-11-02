Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2323A443573
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhKBSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhKBSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:21:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:19:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x64so1905207pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP+SOvXKKTym5+tOquh3VRoJ2z+8mVjx/1jy4x7GBuM=;
        b=QpYjJPEGXaDBAMsL7DRgDsbEDzjWoby3ITLWUyDnK+X+FWY7TF9W9yYCuaHUc0MooQ
         bBhP7zcis8OW4dbhPTSeeGxcm8Su7IE0JaIZCPf3w751nmyoXCS3VmPHASEL4bX6+DBy
         Mju1usWsOgVBSnPBIL0/m8+4PUpWv3/naNxol2EIabNG/p77wXNN2Zsz05UQD0JKiTX1
         mWSDCm8u/6Vq1Tre2ojl1/RSIzrxVEPKiyKdidl3xgivou5XIWE8UQZyOcusskHTGsVJ
         JP0CAa2j6L+W3RdQMANNAYhd4pHDBLut1+YPb8tw7/c0C6BbIufvxe4vxBxEJX0cqFo3
         Zbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP+SOvXKKTym5+tOquh3VRoJ2z+8mVjx/1jy4x7GBuM=;
        b=Fm8K9SLVDXBqGjTpczA/OtFTwJ4Z6I9WYebaTPaDRpiaEW3xwEAhWnk7cCg+RD06XF
         CxT11GuO+EA4uJE88JiHKnZlzHFncWteE/DIYI+Q3s8ZNNginqxQWEVMGGlqDHTi2UHM
         DAh6bA00p/ABKPlrrYYXfEe9zkejT+NhXq0HmVDyjmWwnrXL8Mq3oJsOnnFFvAKJfoNc
         RiggTXcC3JMuWK8Bku6mbslds7IMx4y70XGuJHCel/QQYVjtWendZU4kXWJVgsPL9HYA
         AmBuGfMiOJmBSia3jcHIQ/xjJwB4jU/vESvFvr9Po/hVrRooifYm3yxNfoQ2GGNQTLYo
         53yA==
X-Gm-Message-State: AOAM530pPFL86Pp2L0xxgozhHEWg8k+1HLof/5zCjTARo3rKCbgAGKRW
        +txHgAYfqM6eN7WNe1zR3lGYrMdwrUbXWPrhILSSjA==
X-Google-Smtp-Source: ABdhPJwautOfIgZT/6sZ2ajleWEWXgj3K5Dy3PyDU3iemRjTkJp5p2V6Qs618GfcfkBlnVNLG3UhsJgVt6VGxJ6+wr0=
X-Received: by 2002:a63:788e:: with SMTP id t136mr29193671pgc.432.1635877145381;
 Tue, 02 Nov 2021 11:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211101222857.6940-1-tomm.merciai@gmail.com> <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop> <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
 <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE> <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
 <20211102154742.GA86474@tom-ThinkBook-14-G2-ARE> <CAHCN7xJtDtBNJ-rFcveya8TGr8+jA-HrDBxPYfZx=fiv7w5UPA@mail.gmail.com>
In-Reply-To: <CAHCN7xJtDtBNJ-rFcveya8TGr8+jA-HrDBxPYfZx=fiv7w5UPA@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 2 Nov 2021 11:18:53 -0700
Message-ID: <CAJ+vNU0DRMuVMgibc1Ag3HdPXFq1Mzs-q0Znb0aLukYVvKc1gA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
To:     Adam Ford <aford173@gmail.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 9:08 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Nov 2, 2021 at 10:47 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > On Tue, Nov 02, 2021 at 07:23:06AM -0500, Adam Ford wrote:
> > > The upcoming 5.16 kernel will have a new blk-ctrl driver which will
> > > work in conjunction with the GPC.  You can see it in linux-next [1],
> > > and I would expect it to be present in 5.16-rc1 once the merge is
> > > done.
> > >
> > > In [1], Look for :
> > >
> > > disp_blk_ctrl: blk-ctrl@32e28000 {
> > >     compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> > >
> > > It creates a bunch of virtual power domains which are effectively the
> > > resets for the VPU, CSI, DSI, and LCDIF [2].
> > >
> > > Basically, to pull the respective device out of reset, you'd reference
> > > them using power-domains.  I have an RFC patch for the CSI located [3]
> > > which should bring the GPC power domain up, then take the CSI bridge
> > > and MIPI_CSI out of reset using the blk-ctrl.  A few of us are still
> > > investigating the CSI bridge and mipi_csi drivers to determine what's
> > > going wrong, but  inside that patch, you'll see that we reference
> > > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;" and
> > > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;" which
> > > are part of the new blk-ctrl driver @32e2800.  Other peripherals like
> > > LCD, DSI, and the VPU's should be able to reference their respective
> > > power domains to activate the corresponding resets after enabling the
> > > proper GPC power domain.
> >
> >   Hi Adam,
> >   Then is all done right. Using this this new driver/dts node eLCDIF/mipi_dsi
> >   module are out of reset. Thanks for the tips. I'm trying to get eLCDIF/mipi_dsi
> >   work on mainline. I try to get work
> >
> >   - eLCDIF using: mxsfb_drv.c
> >   - mipi_dsi using: nwl-dsi.c
> >
> >   What do you think about? You think that can be a good way ( taking
> >   imx8mq as reference )?
>
> The DSI controller for the 8MM and 8MN is not the same as the DSI
> controller on the 8MQ, but the LCDIF controller should be compatible.
>
> There have been several attempts to support the 8MM DSI, but none of
> them have been accepted for various reasons.
>
> The latest was found here [1], but others [2]  and [3] , when used
> together, do something similar.
>
> If memory serves, the main issue has to do with the fact that the DSIM
> controller in the 8MM and 8MN is also present in one of the Samsung
> processors, and the goal is to rework those drivers so we'll have one
> driver that supports both Samsung progressors and NXP instead of
> having two duplicate drivers doing the same thing. When whatever
> driver is chosen is ready, it'll be likely that the LCDIF will use
> power-domains = <&disp_blk_ctrl MX8MM_DISPBLK_PD_LCDIF> and the DSI
> node will use power-domains = <&disp_blk_ctrl
> IMX8MM_DISPBLK_PD_MIPI_DSI> to pull their respective devices out of
> reset and enable the gpc.
>
>
> [1] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=510489&archive=both&state=*
> [2] - https://patchwork.kernel.org/project/dri-devel/list/?series=347439&archive=both&state=*
> [3] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=359775&archive=both&state=*

Adam,

Thanks for the good summary... I was just putting this info together
as well. I'm also interested to see if anyone has made progress on
IMX8MM MIPI DSI display. Now that blk-ctl and most of the dt bindings
have been merged for 5.16 I think we are just down to the drm/exynos
driver issue.

Added Frieder, Jagan, and Michael to the thread.

Best Regards,

Tim
