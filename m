Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F064359FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhDINg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDINg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:36:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E10C061760;
        Fri,  9 Apr 2021 06:36:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so8725308ejr.5;
        Fri, 09 Apr 2021 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORK7Ni7rBYd2U9kNMSKdG31gNJoCS6P/+dcBmLvcUlw=;
        b=I7PJzHdH08eGiCDK/m2dCKnNY1v6aBL/CnZw/3Y9DVcpdR2OSfhk/S3obkssrGppSB
         SqRUC9f9ycTnDC0OmPUMtbQoKvDbt53k1z9v28KbD7dX6hOdDyOOT7X2QkZXm4cXYWjJ
         uRPuAH6hoAdkQDHGzNwtzw19CmptPfWiHsVw3AVWwBRcPjE8PO49hQqhYHcHfhpijTru
         H8AINAVDP8J1E4hSndmMApVgYD6gkD/AUJp3ud6NWqR203s+yLPtzuL/ctIgiBLBIPNC
         m4caMD76ZSxfHqxgXHPz7y/GwjZTGgY++drXNGGGHp79ganJm4tMHqwtVdfKo61Gx5Y0
         NSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORK7Ni7rBYd2U9kNMSKdG31gNJoCS6P/+dcBmLvcUlw=;
        b=PUTvwkJsHVS9jBxbmufv31nOf7Iri3ro6InJR8mXIURqLCz0eHp4LfahaijaM1yBJ0
         hUsqnR8ucb+n1Ew1LcyU985NoPmSNT39GJMEquHgnPXdDCTfe2UryQ+1xZUyU6Wpg12B
         rUL4y4oqZqJK/GJYjdFLkxOtO9t5jacaxjTpFHCgBMWxMl4FEwXt3bot/8OGmS4g8Nsp
         aBwcd4VDNEsqOGoyzeljaL2Md4xK2V+cIuEMcDAEwvxCgAi4jXsTEOMVwDCjijKaoD6K
         VLocXLmG6lM0WobDkCE4l1lGB+OQRHHC+q7by0NC0URLi25NBhBUCs+RkreS6p6Zsx9D
         G2Sg==
X-Gm-Message-State: AOAM533WmTXAH9kCxdBYg/PQjqc0Xht72Q0vzA6xZSY8Cd5mhcdziD3+
        DF4gzmNw9pFric30yiNBFkNdzTmb2XBhQJLbzYI=
X-Google-Smtp-Source: ABdhPJwDt9k6K9SczK6O9QC1MnEEHxtcFSysDpQdAm6P8xxjcFFvuf43OpBKd+HlUTOo6uqDbTdWqz6Y8AmHb4/b4jw=
X-Received: by 2002:a17:906:44b:: with SMTP id e11mr8419543eja.551.1617975402441;
 Fri, 09 Apr 2021 06:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
 <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de> <bc59b75b-d5b7-fe0f-6cba-d184cab204d3@oss.nxp.com>
In-Reply-To: <bc59b75b-d5b7-fe0f-6cba-d184cab204d3@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 9 Apr 2021 08:36:29 -0500
Message-ID: <CAHCN7xK=mjvgrMGXfFwN6520rhtdZu9YRiSn6mi6-+9sVA-LWg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] imx-gpcv2 improvements
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, qiangqing.zhang@nxp.com,
        Alice Guo <alice.guo@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 8:27 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> Hi Lucas,
>
> On 2021/4/8 6:13, Lucas Stach wrote:
> > Hi Adrien,
> >
> > I feel like I already mentioned to you some time ago that there is
> > already a much more complete patch series to add this functionality on
> > the list [1].
> >
> > If you want this functionality to go upstream, please help test and
> > extend this patch series.
> >
> > Regards,
> > Lucas
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20201105174434.1817539-1-l.stach@pengutronix.de/
>
> Would you share what's the issue that block this going forward?

Peng,

I know of a few.  One of them is mentioned in [1] above.  From what I
can tell, the dt-bindings have halted being able to enable the GPU and
USB power domains.  See [2] for some of that dialog.

The second part that I am aware is the blk-ctl being dependent on the
power domain and the power domain being dependent on the blk-ctl [3]
There was some discussion of using syscon to let the power-domain
finish coming up and then referencing the the power-domain from the
blk-ctl, but there was some disagreement [4] on that approach

I think Abel tried to create an IRC, but by the time I was able to
join the IRC, there was no activity.

[2] - https://lore.kernel.org/linux-arm-kernel/CAHCN7xLdkEd0G3fa9gAp-xvKZ-bYmvcyn-8OEbgNjBJyCCOs9g@mail.gmail.com/
[3] - https://lkml.org/lkml/2020/11/9/17
[4] - https://www.spinics.net/lists/arm-kernel/msg849032.html

>
> Thanks,
> Peng.
>
> >
> > Am Mittwoch, dem 07.04.2021 um 23:21 +0200 schrieb Adrien Grassein:
> >> Hi,
> >>
> >> This patch set aims is to add the support of the i.MX8 MM power domains
> >> on the mainline kernel.
> >>
> >> To achieve this, I do several patches
> >>    - Check errors when reading or writing registers (concerns i.MX8M base
> >>      implementation);
> >>    - Fix power up/down sequence. Handshake was not checked and it was
> >>      not called at the appropriate time (concerns i.MX8M base
> >> implementaions);
> >>    - Allow domains without power sequence control like the HSIOMIX of the
> >>      i.MX8MM.
> >>    - Add some i.MX8MM domains (HSIO and OTGS);
> >>    - Introduce quirks. For example, i.MX8MM OTG domains should not be
> >>      powered off (seen n the source code of th i.MX ATF). Quirks are
> >> easily upgrable for other cases.
> >>    - Finally I defined power domains into the imx8mm.dtb file.
> >>
> >> I know that this kind of patch is rejected by NXP ut the other way
> >> (callin ATF directly) was also rejected.
> >>
> >> I also know that NXP is concerned abou adding hundred lines of codes for
> >> each new SOC but it' the way it works on Linux. And the "added code"
> >> mainly consist of adding structures, defines and generic methods for
> >> regmap.
> >>
> >> If it's a real problem, maybe we can introduc a new "gpcv3" driver for
> >> i.MX8MM, i.MX8MN and i.MX8MP.
> >>
> >> Thanks,
> >>
> >> Adrien Grassein (7):
> >>    soc: imx: gpcv2: check for errors when r/w registers
> >>    soc: imx: gpcv2: Fix power up/down sequence
> >>    soc: imx: gpcv2: allow domains without power sequence control
> >>    dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
> >>    soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
> >>    soc: imx: gpcv2: add quirks to domains
> >>    arm64: dts: imx8mm: add power-domains
> >>
> >>   .../bindings/power/fsl,imx-gpcv2.yaml         |   7 +-
> >>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  35 ++
> >>   drivers/soc/imx/gpcv2.c                       | 336 ++++++++++++++----
> >>   include/dt-bindings/power/imx8mm-power.h      |  21 ++
> >>   4 files changed, 333 insertions(+), 66 deletions(-)
> >>   create mode 100644 include/dt-bindings/power/imx8mm-power.h
> >>
> >
> >
