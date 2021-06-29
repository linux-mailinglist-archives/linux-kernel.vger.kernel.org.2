Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B533B742B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhF2OWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:22:08 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:37599 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhF2OWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:22:05 -0400
Received: by mail-yb1-f174.google.com with SMTP id b13so24667484ybk.4;
        Tue, 29 Jun 2021 07:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmfYFeRirvP4cQ2N39rXkFHGm2EQASVxATkQTIKgSb4=;
        b=p1Yg1sCoeZts6v96syM3u830pDn49hdKzddMJ4dri3dEVRGsZ319Gzcz/mlN6GWN8R
         Ej7GLyQGLUPX8+QKiUpJ9QdsYxzMVQ6YgU180u4TfayivsCdimKaT+fT+CyjcuNllsYw
         vx3bHvY9FLVJiKtc7kX+w5nIVMyPZ/mu6k3CvqfKYaJewZAIfvXCOHK61EucG596fHa/
         3P2j4RaHbPL8XOd5kJe53LmWuRhN0B4ILUPtv5HwJ4wfBLWOTWavEe/psE/6BQ9c4aPb
         HIAgVxMXhFfjfavM8Sl7y1eK6Srq8zlS22TZvCsWPu8gEZfhKez2a7diPV89meciGhgA
         I2ig==
X-Gm-Message-State: AOAM532moDX0tXSw0eV15UYDfWgvVR3myIOoJO6Ba/dhevK/FEZIO7q/
        CH3g2FLTleepI/VJOHv0xq2f77HUVciyrWNNY/U=
X-Google-Smtp-Source: ABdhPJwh3NmBzgb+TQrqpLSgcfdIjjGTuKDw+AGtuQtl7YCn115+ZlQx/qWC8M0/eHSaDCghBvh18xfww9vTvoW8gZE=
X-Received: by 2002:a25:6dc5:: with SMTP id i188mr39982005ybc.420.1624976377812;
 Tue, 29 Jun 2021 07:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-4-harini.katakam@xilinx.com> <453afad0-4e4b-f1bf-6ec5-5675d2c9c1b6@gmail.com>
In-Reply-To: <453afad0-4e4b-f1bf-6ec5-5675d2c9c1b6@gmail.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 29 Jun 2021 19:49:26 +0530
Message-ID: <CAFcVECK2COLnkr+7+4FKKn6anDPERsmxcVWsfwpBWnEXdD8KzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] phy: mscc: Add support for VSC8531_02 with RGMII tuning
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux@armlinux.org.uk, David Miller <davem@davemloft.net>,
        kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        radhey.shyam.pandey@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Tue, Jun 29, 2021 at 4:11 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 29.06.2021 11:40, Harini Katakam wrote:
> > Add support for VSC8531_02 (Rev 2) device.
> > Add support for optional RGMII RX and TX delay tuning via devicetree.
> > The hierarchy is:
> > - Retain the defaul 0.2ns delay when RGMII tuning is not set.
> > - Retain the default 2ns delay when RGMII tuning is set and DT delay
> > property is NOT specified.
> > - Use the DT delay value when RGMII tuning is set and a DT delay
> > property is specified.
> >
> > Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/net/phy/mscc/mscc.h      |  3 +++
> >  drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++++++++++++++++++++++--
> >  2 files changed, 42 insertions(+), 2 deletions(-)
> >
<snip>
>  {
> >       .phy_id         = PHY_ID_VSC8540,
> >       .name           = "Microsemi FE VSC8540 SyncE",
> > @@ -2668,6 +2704,7 @@ static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
> >       { PHY_ID_VSC8514, 0xfffffff0, },
> >       { PHY_ID_VSC8530, 0xfffffff0, },
> >       { PHY_ID_VSC8531, 0xfffffff0, },
> > +     { PHY_ID_VSC8531_02, 0xfffffff0, },
>
> Effectively this is the same as the line before. Maybe it would make sense
> to change this table in a follow-up patch to just one entry covering all
> PHY ID's with the vendor part being Microsemi, e.g. using macro
> PHY_ID_MATCH_VENDOR().

Thanks for the review. Let me check and test - I have a couple of these parts.
Will try to include the patch in this series.

Regards,
Harini
