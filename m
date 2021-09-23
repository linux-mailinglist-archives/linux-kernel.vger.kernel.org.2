Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1593416155
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhIWOph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241737AbhIWOpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:45:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D59C610D1;
        Thu, 23 Sep 2021 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632408244;
        bh=oURGTTytXYO9QjY9AXVDK9+v2UgnhEYRmFXbtjUBCPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xzo/e378Ju2nJ27DH1T7d/DnPdaXvBuRRJTSxXgu4zMsvgniVyuCpwaZC5PjShQ86
         vHH5Axo7oqPynqsBFqLmqXsXco43tT0RjKUbv3VU95vG0SSQ7pDbaEwu0GCYb9apTV
         E9CvdqjU3mgQ59h1p3PAF6PfwfLNZbNTLsQmR6yxUyCCLJ/Q8hZPxw1Mi7IEDH4FWC
         bKy6n9kYYSx93cpcdQq2Cux4ZyiP0fVTlxoH5ssO8V178SVpFTn6LKaAv0v2dqyrgd
         YrZwpLQrUte/hsE/Mwr32aFGLOPtHR4UGTCkrN/o6zLYrI+eo+E7HhDexlZnLo25/y
         Eh32esnEC3oVg==
Received: by mail-ed1-f47.google.com with SMTP id x7so10215721edd.6;
        Thu, 23 Sep 2021 07:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM530aThPQHLsFXMT88thPh8pkQX0drWoCKi38BEWku66BM5zWbctv
        HpDHZkWmiVHY55A4MHMyZjB+OaKMWtL8DDMCFQ==
X-Google-Smtp-Source: ABdhPJyeC+hTvMr/QmcLda9a4Xl1Ej0dWEJuusrQlBBef8Ak7tpatznMOhMs/se7nVqhINdPZeyF7Lamk7xM0n5f+zY=
X-Received: by 2002:a05:6402:b23:: with SMTP id bo3mr6082099edb.145.1632408230595;
 Thu, 23 Sep 2021 07:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
 <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com> <YUuDMjBGWfNsMf2n@robh.at.kernel.org>
 <AS8PR04MB86766122EB2D851844FC7D7C8CA39@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86766122EB2D851844FC7D7C8CA39@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Sep 2021 09:43:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJhSB1ZYUU_nB+U+1yr0kbWQLeO1CUs5PCQ85MEOb=Og@mail.gmail.com>
Message-ID: <CAL_JsqJJhSB1ZYUU_nB+U+1yr0kbWQLeO1CUs5PCQ85MEOb=Og@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:56 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, September 23, 2021 3:26 AM
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; kishon@ti.com; vkoul@kernel.org;
> > galak@kernel.crashing.org; shawnguo@kernel.org;
> > linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > pad modes of imx8 pcie phy
> >
> > On Fri, Sep 17, 2021 at 10:31:00AM +0800, Richard Zhu wrote:
> > > Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
> > >
> > > diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h
> > b/include/dt-bindings/phy/phy-imx8-pcie.h
> > > new file mode 100644
> > > index 000000000000..fe198a0cc12c
> > > --- /dev/null
> > > +++ b/include/dt-bindings/phy/phy-imx8-pcie.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> >
> > Perhaps this should match the dts files license...
> >
> Hi Rob:
> What's the means of the "dts files license"?

You include this into .dts files and those are dual licensed. The
licenses should match (or be compatible).

> I'm not clear understand that.
> I found that there are almost similar "/* SPDX-License-Identifier: GPL-2.0 */" license contained in the files of the /include/dt-bindings/phy folder.

Yes, licenses are a mess. But what other files in
include/dt-bindings/phy have don't matter. Where you use this file is
what matters.

Rob
