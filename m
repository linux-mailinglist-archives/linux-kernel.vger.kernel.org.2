Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA934357831
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDGXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDGXEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:04:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BEDC061760;
        Wed,  7 Apr 2021 16:03:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k8so82049edn.6;
        Wed, 07 Apr 2021 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHXdMVGdWqcnLNYCk5kyrmXPUMHY2HsGiWO2SAAgEiA=;
        b=R0BPXXFqRv//TdoZOB00x29d+8/vUZkJliv4wdexPed9UqN8VwUACs8JyGj1vcpxAo
         tCnM4zXL7lN28Fcb8p74dhie5g2NpzArD/1o0GkrOU89y9HBQbIzH8YN+huWc0RzbSJV
         c4vVUAsI3wJGPS3ol5o+6i9MuWvygI4lAGmYjhTVEZDPdd5dWm89EFPk83Ej+gYkSYLA
         A6Zpsru7gH83jMB0FE3YOlEQR5jC3HQ+NPJlfjzQ+YP//mSUmtwsZh0JC5ori+1GSvgt
         7K8h6TbGpUpq3pOJMVLdoOOLCkiyzPVh2OCClaj/4W+VwkfySB14UcLjGDFmmHf/0509
         RQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHXdMVGdWqcnLNYCk5kyrmXPUMHY2HsGiWO2SAAgEiA=;
        b=XBMKblP5/7qWqB6CQleO55JwLll0wxNnlNWc/MyB/QnPOZ4LQlctcDhSVw9aeI1j0/
         rFjaKpubA8rboCCO2Qm5kLjKS6jvuRer+94MmG2AyoDLfRQe2dW6NBMa2qv0wmmplQPC
         b3GshloqDcPzrm/FYbfArHzA4gynJ5vUWVmACddoHyDKluB0RqKKzseurbfTaM/U2sds
         IGb2O1ayDTk1pIuB9JjamArxu39X7uq7psGQH6QuDVWDS4RcAXFyaJwLQrKPnybPtU5/
         U8zjo62iOyQw6tBpn2KSST8HjuoBHwCNMnIEM+Mj3Icp/MG94YtkRa1j3Pz1U03DgQyp
         CCMA==
X-Gm-Message-State: AOAM530Wbv8CqMVoAV9sER0Hqr659CXU0G0kRWWftJz5B5Ybd+Gydd6W
        Nm+sU6nWNMJsFEWAfpO2g53g1XY22Ktk5ak9AwM=
X-Google-Smtp-Source: ABdhPJzAdO/+HVBAExtuuZXqjZ+R7OwPEvtRVWBrPK3FpIQ/64dOrW9+udqBN/Smaa/LOP0/L8ZL0cJm+25Ewqxjn8c=
X-Received: by 2002:a05:6402:354d:: with SMTP id f13mr7484598edd.228.1617836633029;
 Wed, 07 Apr 2021 16:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210407212122.626137-1-adrien.grassein@gmail.com> <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de>
In-Reply-To: <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 7 Apr 2021 18:03:41 -0500
Message-ID: <CAHCN7xKePMS2F6sR6iRHrfdLET1Z2=zrXB=79K9HFdW+0VYAJg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] imx-gpcv2 improvements
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
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

On Wed, Apr 7, 2021 at 5:13 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Adrien,
>
> I feel like I already mentioned to you some time ago that there is
> already a much more complete patch series to add this functionality on
> the list [1].
>
> If you want this functionality to go upstream, please help test and
> extend this patch series.
>
> Regards,
> Lucas
>
> [1] https://lore.kernel.org/linux-arm-kernel/20201105174434.1817539-1-l.stach@pengutronix.de/

I took Lucas' code and attempted to build upon it to add Nano support.
At some point, someone from NXP thought it would get really hard to
read if we started filling that file with every supported SoC.
To help with that, I created a patch to split the gpcv2 code into a
gcpv2 core functions  with the individual SoC's having separate files
to help keep things a little cleaner, and easier to read:
gpcv2-imx7, gpcv2-imx8mq, gpcv2-imx8mm, and gpcv2-imx8mn, etc.
I was holding off on doing anything with it, because the dt-bindings
appeared to be stalled, and the attempt by Lucas to get the basic
functionality was stalled.

As of right now, it seems like without any changes, I can not get my
Mini or Nano to wake from sleep unless I use a U-Boot and ATF based on
NXP's custom branches.  When using the custom branches, I made some
additional patches to the gpcv2 to add a flag which would prevent
disabling USB OTG on Mini and Nano which appeared to help waking from
sleep, and it matched some of what NXP's custom ATF was doing.

I know there has been some concern about using syscon address the
resets and enables, but I took some work Marek did, and added to it by
adding some flags to the structure which could take the syscon and
write different values to the blk-ctl register depending on whether or
not it was a Mini or Nano (and probably Plus).   Using some of these,
I was able to get the dispmix to come out of reset and enable the
LCDIF on both Mini and Nano, but for some reason, any attempts to
enable the mipi domain were causing failures in other domains, so I
strilpped them out again.  I've withheld posting any of these for the
same reasons I withheld my other patches.

As soon as Lucas' patch [1] above or something similar gets accepted,
can rebase and submit a few of the patches I have.

adam
>
> Am Mittwoch, dem 07.04.2021 um 23:21 +0200 schrieb Adrien Grassein:
> > Hi,
> >
> > This patch set aims is to add the support of the i.MX8 MM power domains
> > on the mainline kernel.
> >
> > To achieve this, I do several patches
> >   - Check errors when reading or writing registers (concerns i.MX8M base
> >     implementation);
> >   - Fix power up/down sequence. Handshake was not checked and it was
> >     not called at the appropriate time (concerns i.MX8M base
> > implementaions);
> >   - Allow domains without power sequence control like the HSIOMIX of the
> >     i.MX8MM.
> >   - Add some i.MX8MM domains (HSIO and OTGS);
> >   - Introduce quirks. For example, i.MX8MM OTG domains should not be
> >     powered off (seen n the source code of th i.MX ATF). Quirks are
> > easily upgrable for other cases.
> >   - Finally I defined power domains into the imx8mm.dtb file.
> >
> > I know that this kind of patch is rejected by NXP ut the other way
> > (callin ATF directly) was also rejected.
> >
> > I also know that NXP is concerned abou adding hundred lines of codes for
> > each new SOC but it' the way it works on Linux. And the "added code"
> > mainly consist of adding structures, defines and generic methods for
> > regmap.
> >
> > If it's a real problem, maybe we can introduc a new "gpcv3" driver for
> > i.MX8MM, i.MX8MN and i.MX8MP.
> >
> > Thanks,
> >
> > Adrien Grassein (7):
> >   soc: imx: gpcv2: check for errors when r/w registers
> >   soc: imx: gpcv2: Fix power up/down sequence
> >   soc: imx: gpcv2: allow domains without power sequence control
> >   dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
> >   soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
> >   soc: imx: gpcv2: add quirks to domains
> >   arm64: dts: imx8mm: add power-domains
> >
> >  .../bindings/power/fsl,imx-gpcv2.yaml         |   7 +-
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  35 ++
> >  drivers/soc/imx/gpcv2.c                       | 336 ++++++++++++++----
> >  include/dt-bindings/power/imx8mm-power.h      |  21 ++
> >  4 files changed, 333 insertions(+), 66 deletions(-)
> >  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> >
>
>
