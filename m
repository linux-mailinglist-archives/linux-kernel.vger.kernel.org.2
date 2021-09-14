Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF440AB04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhINJif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhINJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:38:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA0C061574;
        Tue, 14 Sep 2021 02:37:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r3so22640761ljc.4;
        Tue, 14 Sep 2021 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoMeS7omBMSW+Lz5A4NCxAQDi0imsFqBXh/CcY2n+Xs=;
        b=fuv6V+WCpwidH86QPauqqKVy3eVIHVbY5mWHPZEIqhHR4bXn7csGuFh8ADALvI1dfD
         3DO7s99Fnh/aC/LeKW7bfHpIDEx33dO/h9sjNOBnctIHPUM+pMMivXJK5XTo5j8D4qjQ
         894sxkDw1eBVw5TnQ2jZom5EGw8M+KpnULoK4eWpKf18vj0iPQWYlu8ff9GFTBg2DpiI
         usRqy5T5q0qelbRnfnpzu0GS73FvPCcJmSBH806jdvY6ALYTGysHarWMn1e9ch2kfkNQ
         8uuEDrHuQRgiGBkCetaoW/IrkC/aH8P1pMveTGsX4CxYsdU8qd36Kv5ZcX8a4WKZ6/35
         aQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoMeS7omBMSW+Lz5A4NCxAQDi0imsFqBXh/CcY2n+Xs=;
        b=jDgMlIEzGotl+CJ986uwqAXw70AZSq+HFJ7oyRCFEpgIrc0yVDwoczkVBnSQ/4a6cO
         Uitr1dOi3N4+U8PI+t46++qPgaH6SAEbuVLQZX6oOsfa+hIJxz6qcfYdkaFcawPWKr7Z
         4diSF2R7xlwsrIBH4pitymIxV/eIH/kPc4S4Bkpghi7JbGAB6dVcTWUX2uyzzeiPZ4yj
         knzx/gX+kigCOZYSPWX9YWMFW2Dx88lxo5iP/0WZUi3u8pSYdBlMxKED2FO4GADD12MI
         BtbEEfV+w5aQR3RElqeDlm/xDLVqpXyXDEBY9tTlR6392HS0MsghlzJRMkl4eecFem8K
         Gphg==
X-Gm-Message-State: AOAM532jQaf4Kjy0ZeS0b4EkyJsUO62Nc9HDulRG08sYmzw+1QpNKkvX
        jdxN1JSb/4JdsCM/2Nj3zDJ+6OTVH46r7MBg45g=
X-Google-Smtp-Source: ABdhPJw/96v5BXAIp/uLlEW+meuvGyr0qkyZAocHEMv6ABV2PQJPf6XlqNJqiI7hkCBlo8K7TTwNqf/L3BS5qKsHO3o=
X-Received: by 2002:a2e:2201:: with SMTP id i1mr14779109lji.441.1631612235017;
 Tue, 14 Sep 2021 02:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
 <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
 <79fb60ea9a002ea553a92ea08b28b866@walle.cc> <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
 <9e3d52c297ed024594a1e610a5cf61b2@walle.cc>
In-Reply-To: <9e3d52c297ed024594a1e610a5cf61b2@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 14 Sep 2021 11:37:04 +0200
Message-ID: <CAEyMn7aYYkGZ1Eawd=yazdKeBuHVQc=3F7PnHSCSRyYCu=CJ9A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
To:     Michael Walle <michael@walle.cc>
Cc:     Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Di., 14. Sept. 2021 um 11:12 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Am 2021-09-14 10:52, schrieb Lucas Stach:
> > Am Dienstag, dem 14.09.2021 um 10:32 +0200 schrieb Michael Walle:
> >> Hi Lucas,
> >>
> >> Am 2021-09-14 10:20, schrieb Lucas Stach:
> >> > Am Dienstag, dem 14.09.2021 um 09:26 +0200 schrieb Heiko Thiery:
> >> > > The sw4 output (V_1V8_S0 voltage) from the PMIC is the main supply for
> >> > > the 1V8 power domain. It is not only used as supply for the eMMC.
> >> > > So this voltage can not be changed and is not allowed to switched off.
> >> > > Therefore we do not want to provide this regulator to the SDHC driver
> >> > > to
> >> > > control this voltage.
> >> > >
> >> > This specific requirement should not be solved by removing the
> >> > regulator connection from the SDHCI node, but instead by constraining
> >> > the regulator voltage range to a fixed 3.3V and marking the regulator
> >> > as always-on to reflect the hardware requirements in the DT.
> >> >
> >> > Also if your eMMC vqmmc is a fixed 3.3V, I don't think you need the
> >> > faster pinctrl states, as you can't use the faster pin states anyways,
> >> > as they require a 1.8V signaling voltage.
> >>
> >> Are you speaking of the 1.8V signalling modes? As far as I know the
> >> IMX SDHC controller will switch the voltage by its own function pin.
> >> That is, its not a GPIO.
> >
> > Ah, I mixed things up here. This is a fixed 1.8V supply, which is valid
> > for eMMC, so the high-speed modes are available. My comment still
> > applies that this should be fixed by constraining the regulator, not by
> > removing the DT connection.
> >
> > vqmmc is the MMC IO voltage, which can be switched either by the
> > function pin, which gets toggled automatically when software does the
> > voltage switch, or by explicitly switching the regulator voltage. eMMCs
> > are a bit special as they can work with a fixed 1.8V IO supply and
> > don't need to start with 3.3V.
>
> I tend to agree. There might be some useful information, like the driver
> could fetch the voltage although it is not able to change it.
>
> NB. the regulator is already fixed at 1.8V and is marked as always on.
>
> from arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts:
>
> sw4_reg: sw4 {
>          regulator-name = "V_1V8_S0";
>          regulator-min-microvolt = <1800000>;
>          regulator-max-microvolt = <1800000>;
>          regulator-always-on;
> };

To be honest, the intention was that I wanted to separate the
dependency between emmc and PMIC. Debian 11 unfortunately does not
have a driver enabled for the PMIC used and therefore cannot
initialize the emmc driver.

So I should reconsider how to fix this.

-- 
Heiko
