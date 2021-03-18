Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7A340EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhCRT6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhCRT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:58:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:58:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so8235684edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sxinzDiN1la62MYlJRjehM8ue8AVlNm8Yb/YIglQZ0=;
        b=wNBlcxWA9mQA/cvqLRPAnDgqExhTkYWTTPacOw+r8FKUWUjv65szQJrrLj51woi5Il
         GFyKUOCV0uQwdnlw7ZZs6LbdvixIinRu4xWtZNfIs/4HLjmXV2VHFbBrPlX+J7yA+Kz2
         IEgjXiKKgfO0yWl3fXv+8f2roVRA6kdVf98R2kRzDkSQiY2RV+cVHiM5gyCaoTep+snR
         MZmGmlCX3BXGsq8s1TugCiw7re/1ffgtOXZFAnCifza67rXn1iRcnATPCkcfCwLrcI5t
         9kYRkGdg2V1Cj6T0fOzSWCjoaoQwVmu+H+Wb5Cy3BhL/rLsFkpDxTQeCR/jtE+NEPlI4
         NRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sxinzDiN1la62MYlJRjehM8ue8AVlNm8Yb/YIglQZ0=;
        b=PvEd+AlAQoQgBSXcmjmkdxNhT8YDn+fy5dV2cZ7adTFDBq5MexLewvgpBadfDdsogA
         5XZ/21gkxq3s5Syva6R2h3lC7QwpQ2CNL2zmr83aWZbCm+TpZtYAp6TiR+kfyTz9B/Jk
         36IYdSRBaRTGJZPkS2YUCLblwYCbPpKtF8R6OxjencNZMmrOru7h6TNHiRptBjZPj045
         z/d032859pIZtbjLpZLiNd/NGW1t1hTmFIy2RrvS6wSQZ5sikVa6vhUJV+Kx6NvF4Qr8
         QADHkP+31NXG6tyXfDuMBwG95SiEcteAvxFhYAq8Dag5ebjt4b2dp+O2KVEOfRAZnQP4
         i3Aw==
X-Gm-Message-State: AOAM532PQCEIs7HZ8Gsgplc4KIPzD8fGVdlwdaSjbNePP18lGi2dQgbi
        dTlburvVHmqXGWAY73FRS6skJcF0Lav4pmULHMSmNA==
X-Google-Smtp-Source: ABdhPJxvIpU0efzVUcaO5hMfj1b5ZbFhUJvZKQjAxCnIbCN+8TyQzvbaigH1LcZv1BjFi2UK1tSVXc1mdvdxdSCLORU=
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr5666092edd.134.1616097499821;
 Thu, 18 Mar 2021 12:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <1604402306-5348-11-git-send-email-abel.vesa@nxp.com> <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
 <20201117144828.omlwhu5y7cwsf5ci@fsr-ub1664-175> <6ecf593d-bee6-b0c1-718f-edcee90650ad@kontron.de>
 <DBBPR04MB7930D839D5595BB692CB26DA879E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB7930D839D5595BB692CB26DA879E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 18 Mar 2021 12:58:08 -0700
Message-ID: <CAJ+vNU27TUQC4Dt=RHKDkOZFzCV2kWEoxOy-RYyv0+O=fLE+LQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:28 AM Jacky Bai <ping.bai@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Frieder Schrempf [mailto:frieder.schrempf@kontron.de]
> > Sent: Thursday, February 25, 2021 4:23 PM
> > To: Abel Vesa <abel.vesa@nxp.com>; Dong Aisheng <dongas86@gmail.com>
> > Cc: Aisheng Dong <aisheng.dong@nxp.com>; Rob Herring <robh@kernel.org>;
> > Peng Fan <peng.fan@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Anson Huang
> > <anson.huang@nxp.com>; devicetree <devicetree@vger.kernel.org>;
> > Stephen Boyd <sboyd@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > Mike Turquette <mturquette@baylibre.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Marek Vasut <marek.vasut@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> > Fabio Estevam <fabio.estevam@nxp.com>; Philipp Zabel
> > <p.zabel@pengutronix.de>; Adam Ford <aford173@gmail.com>; linux-clk
> > <linux-clk@vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC
> > ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; Lucas Stach
> > <l.stach@pengutronix.de>
> > Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
> >
> > Hi Abel,
> >
> > On 17.11.20 15:48, Abel Vesa wrote:
> > > On 20-11-11 17:13:25, Dong Aisheng wrote:
> > >> On Tue, Nov 3, 2020 at 7:22 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >> ...
> > >>> +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
> > >>> +                                 unsigned long id, bool assert) {
> > >>> +       struct imx_blk_ctl_drvdata *drvdata = container_of(rcdev,
> > >>> +                       struct imx_blk_ctl_drvdata, rcdev);
> > >>> +       unsigned int offset = drvdata->rst_hws[id].offset;
> > >>> +       unsigned int shift = drvdata->rst_hws[id].shift;
> > >>> +       unsigned int mask = drvdata->rst_hws[id].mask;
> > >>> +       void __iomem *reg_addr = drvdata->base + offset;
> > >>> +       unsigned long flags;
> > >>> +       u32 reg;
> > >>> +
> > >>> +       if (!assert && !test_bit(1, &drvdata->rst_hws[id].asserted))
> > >>> +               return -ENODEV;
> > >>
> > >> What if consumers call deassert first in probe which seems common in
> > kernel?
> > >> It seems will fail.
> > >> e.g.
> > >> probe() {
> > >>      reset_control_get()
> > >>      reset_control_deassert()
> > >> }
> > >>
> > >> Regards
> > >> Aisheng
> > >>
> > >
> > > OK, I'm trying to explain here how I know the resets are supposed to
> > > be working and how the BLK_CTL IP is working.
> > >
> > >
> > > First of, the BLK_CTL bits (resets and clocks) all have the HW init
> > > (default) values as 0. Basically, after the blk_ctl PD is powered on,
> > > the resets are deasserted and clocks are gated by default. Since the
> > > blk_ctl is not the parent of any of the consumers in devicetree (the
> > > reg maps are entirely different anyway), there is no way of ordering
> > > the runtime callbacks between the consumer and the blk_ctl. So we
> > > might end up having the runtime resume callback after the one from
> > > EARC (consumer), for example, which will basically overwrite the value
> > written by EARC driver with whatever was saved on suspend.
> > >
> > > Now, about the usage of the reset bits. AFAICT, it would make more
> > > sense to assert the reset, then enable the clock, then deassert. This
> > > way, you're keeping the EARC (consumer) in reset (with the clocks on)
> > > until you eventually release it out of reset by deasserting. This is
> > > how the runtime resume should deal with the reset and the clock. As
> > > for the runtime suspend, the reset can be entirely ignored as long as you're
> > disabling the clock.
> > >
> > > This last part will allow the blk_ctl to make the following assumption:
> > > if all the clocks are disabled and none of the reset bits are asserted, I can
> > power off.
> > >
> > > Now, I know there are drivers outthere that do assert on suspend, but
> > > as long as the clocks are disabled, the assert will have no impact.
> > > But maybe in their case the reset controller cannot power down itself.
> > >
> > > As for the safekeeping of the register, I'll just drop it due to the following
> > arguments:
> > > 1. all the clocks are gated by default 2. all resets are deasserted by
> > > default 3. when blk_ctl goes down, all the consumers go down. (all
> > > have the same PD)
> > >
> > >  From 1 and 2 results the IP will not be running and from 3 results
> > > the HW state of every IP becomes HW init state.
> >
> > Are there any plans to continue this work? As BLK-CTL it is not only relevant
> > for the i.MX8MP, but also for i.MX8MM and i.MX8MN, it would be nice to get
> > this ready in order to prepare for proper graphics/display support.
> >
>
> Before continuing this work, we need to find out a way to resolve the cycling dependency issue between power domain and blk-ctrl.
> it is indeed introduced some troubles in NXP latest internal release when the blk-ctrl driver is added.
>

Jacky,

Any update on this? This is still blocking several drivers and major
functionality of the i.MX8 SoC's in mainline and I would hope this
would be a top priority for NXP.

Best regards,

Tim
