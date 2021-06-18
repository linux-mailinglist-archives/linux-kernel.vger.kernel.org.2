Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609013ACBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhFRNVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFRNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:21:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:19:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ji1so9783436ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8V4PPjDC1gz6JriGuuoHP1QKqxpavt/zsBJP5m9gcE=;
        b=e2Cic6CbgHhdrBDz14ZdYtzulhyV+7dKvI09WXaTR0dOvZ5PLsNABW3otQIIncHt1J
         gO1LWIfD2zc2qKiF/HubchlTc6kC2PEV7FHsWhO+5zL0y/0c8EOsIUtZTfE/4wReDKZf
         t6czmTxN9sU1EgNvlESX6xVb/wGfM4VDXD8KMkTOnIiXJGqPaGetbyWordY1KAkyhbj6
         pC+7CGaUmLEeS/bnJFapglFMEoG+xTPbcKz0PaZBGQEiItiXF2wtUmPlfV6jCSNx3D/j
         LQ4ZNDBIzH1ojYb7mNzFMlGjU4sEADW7/IDd1oZ/Y2AeX8YclE0ZZjhbCcYmsDG7xFbz
         cc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8V4PPjDC1gz6JriGuuoHP1QKqxpavt/zsBJP5m9gcE=;
        b=fbG0XhcWA/MzCPibyJkUNPDXyoqvb3fUqUZn5LmiPNTTOPcGlHKuhAjw660PlWCgEt
         d3dqSNhU5jdfbIQfsqMB1h60iP6y6pY/IulHEOOMRSlCpVTItpxhk/x5yEj5MQs8cCGZ
         S1zPZX/dcnQa7HVIauFk1ZX/4A3j7BM2btMSfiZ9u8SOmG0R5lHoFXok/yKRaR7fAC/s
         HTV+S5BpFKi2mlFGYM9dld8mohR3+yte1DKPrzInpFLhGhZGLVAlYGFvq66JSlTYVwmo
         PUwNojCnTlq7ZolPu9xKkkp5FbjDPyVQv642cIuC8XbMZgdTSZJn/PPBRmlS7Na2ptuj
         moJg==
X-Gm-Message-State: AOAM533e0rm0Ry5V/0XQqu1MnqEmDJEWKSwLj0kQGnxZZ7LYKTJ98Dth
        F+Qh/0yA4c2ic7bTuY3UGGeVXQIct1jJIvnSJQM=
X-Google-Smtp-Source: ABdhPJwWJL6HHS3kXwwEJ2gM8GNLYhNhomtQGKiImb6LnNLsv+4EMk98BFu7/G2bgbQrIGlpl2DkoSY82MVmAMI4VVc=
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr11322909ejc.494.1624022357121;
 Fri, 18 Jun 2021 06:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-5-linux.amoon@gmail.com>
 <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com>
In-Reply-To: <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 18:49:05 +0530
Message-ID: <CANAwSgQVgKUoTpfaJyfxdphqc6M=Oq6jj5zZ7An9St7PdzQHYA@mail.gmail.com>
Subject: Re: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Martin.

Thanks for your review comments.

On Fri, 18 Jun 2021 at 03:46, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:43 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Reorder the code for phy set_mode in .set_mode callback function.
> > For now configure the phy in host mode.
> as mentioned in the cover-letter: to my knowledge these register bits
> are "static"
> The settings for dr_mode == USB_DR_MODE_HOST mainly apply to the
> second PHY (usb1_phy)
>
> [...]
> > +static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
> > +                                   int submode)
> >  {
> >         struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
> >         u32 reg;
> >
> > +       switch (mode) {
> > +       case PHY_MODE_USB_HOST:
> > +               if (priv->match->host_enable_aca) {
> > +                       regmap_update_bits(priv->regmap, REG_ADP_BC,
> > +                                          REG_ADP_BC_ACA_ENABLE,
> > +                                          REG_ADP_BC_ACA_ENABLE);
> > +
> > +                       udelay(ACA_ENABLE_COMPLETE_TIME);
> > +
> > +                       regmap_read(priv->regmap, REG_ADP_BC, &reg);
> > +                       if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> > +                               dev_warn(&phy->dev, "USB ID detect failed!\n");
> > +                               return -EINVAL;
> > +                       }
> > +               }
> > +               break;
> > +       default:
> > +               dev_warn(&phy->dev, "USB ID detect failed to setnode! %d\n", mode);
> > +               return -EINVAL;
> I have tested this driver already with PHY_MODE_USB_DEVICE (on my
> Odroid-C1) so I don't see why we should drop support for this
> Also if we want runtime mode switching in this driver then we would
> need to undo the changes from "case PHY_MODE_USB_HOST" above
>
> I suggest dropping this patch until we know for sure if and which
> registers need to be updated based on the DR mode.

Yes, I have observed this, Can you give these small changes a try?
With the below changes, I got the  PHY_MODE_USB_DEVICE support working.

Here is the boot log of odroid c1+
[0] https://pastebin.com/pCXLS5Vu

$ lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 3: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 1: Dev 2, If 1, Class=Human Interface Device, Driver=usbhid, 12M

 git diff drivers/phy/amlogic/phy-meson8b-usb2.c
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c
b/drivers/phy/amlogic/phy-meson8b-usb2.c
index bd624781d914..9b79e86d7a0d 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -204,6 +204,22 @@ static int phy_meson8b_usb2_setmode(struct phy
*phy, enum phy_mode mode,
                        }
                }
                break;
+       case PHY_MODE_USB_DEVICE:
+       case PHY_MODE_USB_OTG:
+               regmap_update_bits(priv->regmap, REG_ADP_BC,
+                                  REG_ADP_BC_DCD_ENABLE,
+                                  REG_ADP_BC_DCD_ENABLE);
+
+               udelay(ACA_ENABLE_COMPLETE_TIME);
+
+               regmap_read(priv->regmap, REG_ADP_BC, &reg);
+               if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
+                       dev_warn(&phy->dev, "USB ID detect failed!\n");
+                       return -EINVAL;
+               }
+               regmap_update_bits(priv->regmap, REG_ADP_BC,
+                                  REG_ADP_BC_ID_PULLUP, REG_ADP_BC_ID_PULLUP);
+               break;
        default:
                dev_warn(&phy->dev, "USB ID detect failed to setnode!
%d\n", mode);
                return -EINVAL;
>
>
> Best regards,
> Martin

Thanks


-Anand
