Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33136F438
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhD3DGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:06:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74CC06138B;
        Thu, 29 Apr 2021 20:05:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c22so17302849edn.7;
        Thu, 29 Apr 2021 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+teXO3nFNlWI1PW484JBXgFP/en9bwQPRWXtW1e1gls=;
        b=Bm7GWNfj+xfSofAANTYyA6/3xFqCCw/acTZAcQKyU/TbSfCEiL0YpIOan5XLLAZw9C
         OSj6dqrAtXa9nw/ivJmZbff6lJz5GlYJPf5rNy6bqsdLU6YQ5yT2mzthH9nW4RIlUi2N
         KQWff7dC8StwEUhbhDGjuRypXY9GQp1ejVSivUAahVm55HfyGZh319KZrJHi35ooOLFY
         CfGsBGY85Mq83z86LaIgHEDH3khXDSYt3xiAfmd5ad46EhePOlBpByse2/G31Z8z+C0d
         mmleJMSMwK9e7eblsHqpBzxktnPAWrzp4Uwl+y3IZarp4JFDFHmEvMylJuRdA9p3OwXl
         ySwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+teXO3nFNlWI1PW484JBXgFP/en9bwQPRWXtW1e1gls=;
        b=ttDPfCSxDoFQrYyTlwJ0Nh4BOR9mwcbwl3uaornW9jhPOceiw56bJxnCCHr+PtjzdV
         cIGhDF6C4lxaN8YezFAGRGx1Uja9TgxJj/t7arJ01PfkS/sEcW1X/KvJOaw8Cztjcvp6
         FWSgGqVRgszpHB6J807lC00HjMU5q4ll2wsQ4aqcRdo7IDQB0xjpvB55JpZW4YTmC9XY
         +Eosa57M0vbydJYq/lS6ErdQl7EAfbcMoeJawOarcxUXXGrDjL+s25dBYt5CN6DUIUu9
         sKXYlRI+/bFS6sy2jo5tzJBMY9Q8N5AnBCknrdR3u/U3lYnPSzecckSRYIeZLusfH7e9
         XcsQ==
X-Gm-Message-State: AOAM533v6I7PUhnBrJMhL6/PKUpVbCPUmc7Kc9+dRtUQQK11CYVM0eV8
        KJA1ERE3f0ae7BwNYUsdiMhjexwCGG+kMr2FU/M=
X-Google-Smtp-Source: ABdhPJzE3tN+vPT4JoRO1U/cas6Z9ORtvt9xImbsxFf3ps5mnHjGI4/2VgXXD2tTL1/FA7ZVpRua7H634GSjKkudOUw=
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr3164137ede.129.1619751945745;
 Thu, 29 Apr 2021 20:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210429073050.21039-1-peng.fan@oss.nxp.com> <CAHCN7xL11GUSVB3PThsfhxXPtgu1nm1LWSzkJYqj4MHf-aLbVw@mail.gmail.com>
 <DB6PR0402MB276065DF476EBEDABF312CF9885E9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276065DF476EBEDABF312CF9885E9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 29 Apr 2021 22:05:34 -0500
Message-ID: <CAHCN7x+zauc-8knQCGsvFB=YDrBB3T7bEHisdNEvQYgVnFsNGA@mail.gmail.com>
Subject: Re: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 8:34 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
> >
> > On Thu, Apr 29, 2021 at 1:59 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
> > > minor changes from me to make it could work with i.MX BLK-CTL driver.
> > >
> > > Thanks for Lucas's work and suggestion, Frieder Schrempf for
> > > collecting all the patches, Jacky Bai on help debug issues.
> >
> > Thank for you all the work.  I have an i.MX8M Nano that I'll work to add
> > support for gpcv2 unless NXP has started this already.  At one time, I posted
> > some patches for Nano based on Lucas' work, but since that work wasn't
> > accepted, mine wasn't either.
>
> Please continue your work on i.MX8MN, I not work on this. The following
> work from me is i.MX8MP.

No problem.  I thought the focus would be on the 8MP,m so I went ahead
and posted a series [1] for enabling the gpcv2 for the Nano and the
power domains which don't require blk-ctl for now which include the
USB OTG, and the GPU.

If you and/or your colleagues have time to review it, it would be
appreciated.  I was able to suspend and resume with USB attached, and
it continued to operate.  I didn't do extensive testing yet.
I'm starting on the blk-ctl stuff now.  It seems to have changed quite
a bit since the initial submission from Abel, so I'll have to spend a
bit more time porting what I had before.

Thanks again for this series.  It will be nice to have the Mini, Nano
and Plus domains functional.

adam

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210429211625.1835702-2-aford173@gmail.com/

>
> Thanks,
> Peng.
>
> >
> > adam
> > >
> > > Lucas Stach (12):
> > >   soc: imx: gpcv2: move to more ideomatic error handling in probe
> > >   soc: imx: gpcv2: move domain mapping to domain driver probe
> > >   soc: imx: gpcv2: switch to clk_bulk_* API
> > >   soc: imx: gpcv2: split power up and power down sequence control
> > >   soc: imx: gpcv2: wait for ADB400 handshake
> > >   soc: imx: gpcv2: add runtime PM support for power-domains
> > >   soc: imx: gpcv2: allow domains without power-sequence control
> > >   dt-bindings: imx: gpcv2: add support for optional resets
> > >   soc: imx: gpcv2: add support for optional resets
> > >   dt-bindings: power: add defines for i.MX8MM power domains
> > >   soc: imx: gpcv2: add support for i.MX8MM power domains
> > >   soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power
> > >     domains
> > >
> > > Peng Fan (4):
> > >   soc: imx: gpcv2: correct pm_runtime_get_sync usage
> > >   soc: imx: gpcv2: move reset assert after requesting domain power up
> > >   soc: imx: gpcv2: support reset defer probe
> > >   soc: imx: gpcv2: remove waiting handshake in power up
> > >
> > >  .../bindings/power/fsl,imx-gpcv2.yaml         |   9 +
> > >  drivers/soc/imx/gpcv2.c                       | 534
> > ++++++++++++++----
> > >  include/dt-bindings/power/imx8mm-power.h      |  22 +
> > >  3 files changed, 450 insertions(+), 115 deletions(-)  create mode
> > > 100644 include/dt-bindings/power/imx8mm-power.h
> > >
> > > --
> > > 2.30.0
> > >
