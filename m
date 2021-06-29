Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6393B7405
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhF2OOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:14:09 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:34710 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhF2OOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:14:05 -0400
Received: by mail-yb1-f182.google.com with SMTP id c8so24679634ybq.1;
        Tue, 29 Jun 2021 07:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmZ+Lxjw1WXJMeYyugIhhkUfVxchpfwqB5EDg1VAF0I=;
        b=sIymig5z9HvtwsNpqb2gzjITHiwI+5v1Q9px2OG5kBRSkOHk5xeV7PKheOzLnP7k76
         vn+KgFIBVREVvkiIMpi5kvscL2oW4tMswcSuMzp+AHElTSIcXhRRbfcaiTRKwEdzXwmy
         X8u5J9dDITZXXi1pM/aj5z+z6VZBCjVLyFxeOV81O8eXJy6kY4KkNmMadPf4v1uqx1TF
         GTbmbnMB1Ly6JU67QakzsP7umrsaUVrlyKCYWzH8FGtOL6xbw3F7P4SyeJMOwbEjfD+Q
         Ajk46oY+JfmV2Pkb3oJTEDwR2wXo9t7E2aK7Mk7rsXpiWjoqpYWyegUmESlGuWgAsivQ
         ZIUA==
X-Gm-Message-State: AOAM531z1Nd/gyWl1Dl7WAV9IKW0jP1xyUZD3VPxv9rKynWICljJ0GCI
        173nRQgUoOowdKACbOlgMm8tOpjko48+ePG6Sb0=
X-Google-Smtp-Source: ABdhPJxA3llp67yh8BdQ00eJjZ2rVZigIEa78QMhw3Ebb9cCQq7zcq4WpUlVPnM2MJsjQWL55S6bd5gG4JlKHao5tSs=
X-Received: by 2002:a25:c004:: with SMTP id c4mr36715186ybf.39.1624975897205;
 Tue, 29 Jun 2021 07:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-3-harini.katakam@xilinx.com> <YNspC065DnVpzADe@lunn.ch>
In-Reply-To: <YNspC065DnVpzADe@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 29 Jun 2021 19:41:25 +0530
Message-ID: <CAFcVECJNN4-eMK0tN0qJJmCchUJh8cs_EGaTmBehEZx+1oSxhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mscc: Add RGMII RX and TX delay tuning
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>, linux@armlinux.org.uk,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        steen.hegelund@microchip.com, bjarni.jonasson@microchip.com,
        ioana.ciornei@nxp.com, likaige@loongson.cn,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        radhey.shyam.pandey@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Jun 29, 2021 at 7:37 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jun 29, 2021 at 03:10:37PM +0530, Harini Katakam wrote:
> > Add optional properties to tune RGMII RX and TX delay.
> >
> > Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  .../devicetree/bindings/net/mscc-phy-vsc8531.txt         | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 87a27d775d48..e201d24d8e27 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -33,7 +33,14 @@ Optional properties:
> >                         VSC8531_DUPLEX_COLLISION (8).
> >  - load-save-gpios    : GPIO used for the load/save operation of the PTP
> >                         hardware clock (PHC).
> > -
> > +- vsc8531,rx-delay   : RGMII RX delay. Allowed values are defined in
> > +                       "include/dt-bindings/net/mscc-phy-vsc8531.h".
> > +                       Default value, set by the driver is
> > +                       VSC8531_RGMII_CLK_DELAY_2_0_NS.
> > +- vsc8531,tx-delay   : RGMII TX delay. Allowed values are defined in
> > +                       "include/dt-bindings/net/mscc-phy-vsc8531.h".
> > +                       Default value, set by the driver is
> > +                       VSC8531_RGMII_CLK_DELAY_2_0_NS.
>
> The default values need better explanation. So you are saying they are
> only used when 'rgmii' is not used. And they replace the default 2ns
> delay, they don't add to the default 2ns delay.

Thanks for the review. Yes, I'm saying that they replace the default 2ns delay.
But they only come in when rgmii or rgmii-id is used. When that's not used,
the default 0.2ns in the driver is retained. I'll update the DT description here
to be clear.

Regards,
Harini
