Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06D132BE34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385298AbhCCRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbhCCMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:54:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E87C061788;
        Wed,  3 Mar 2021 04:54:12 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u20so25531357iot.9;
        Wed, 03 Mar 2021 04:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CBvkFEvqxR6pJ8RNOiBgWpkdUJaqTzxbWWfGxZhteMs=;
        b=nN7p0M48f/tcetJyHBbjLEHxhzaLbYFZ6xXf7pJw91utDAhSWOwJjpn//gKsz0OS09
         2j05ZatL0qlnau5YxMei0k8xaO3bVAv0gqM6GWc8KvOA8ghSXaGHiA+R0BJXlHUcuHCu
         8scwg8GsiDkFOUjGkioYrySmYN5tL0eT6Jurw1MM5/eHD4eisguQvXwCxxI1HeMR36L1
         Q5UikKq3B3VLXyhNU9T9vWmZrnSd72qwTLYKu3eNfnrfDY8rvW43/UwagL5Lg+AqFqOP
         gqtMJsmTJQwVS+HR0mYmkrbGmHDzKNp5cfR7rd+JyPwVHMj6PRSS3TzXgDv8h62FqjTy
         gV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CBvkFEvqxR6pJ8RNOiBgWpkdUJaqTzxbWWfGxZhteMs=;
        b=mHgeylLmxzlUpbwcRM1LjLe17yjP6cIV1snYHq2JMvRQ2ag+MK/fIouqqYFF4ZvbeX
         ZkWU3hZAV2tTr6vvqzd+8VQkqGAfzbI11gipSGDO4a78lezjhD80bDYDMFr/XIEb5l0a
         ick3982Tt9GHTp5IpPHAB7tQs4IGIBrJRLTxNFeWsSeGHMvL1HwgzjOrWtqbFUI7trVP
         z92nRHbvJpIMxvB+MevlsE6e9HqI7ln4gV7ml3wQwazO6MYynUWWbmuydILbOAWfJtoq
         FkMdga9Ov43FFNbhPehpY4zpASsAmws2PIUFsv4DL0c2WGbALQoGiOcu0y0/F6JFGY3x
         uI0g==
X-Gm-Message-State: AOAM532hdDzIn41EXeD48SNLIBU/ksSyJEprAjgOvq8A3Y5nbyHatzKO
        kWGmOhg/hDDyIKXLM1eyK6oPCACPUpK4pu1URzI=
X-Google-Smtp-Source: ABdhPJyV/xGvvi3YmN3DtKAi73iEQpcmeHQCMH5AslZ5uDEigz35WsiBhVAzD8/j5c1mw18Z6kAeFWiJwvtK+3dCmGg=
X-Received: by 2002:a6b:db15:: with SMTP id t21mr16665316ioc.133.1614776051339;
 Wed, 03 Mar 2021 04:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20210222140756.713-1-heiko.thiery@gmail.com> <20210222140756.713-3-heiko.thiery@gmail.com>
 <CAOMZO5C4bL72mksHG4GfikgLOxib-A659rac7VkpjGsm150O_A@mail.gmail.com>
In-Reply-To: <CAOMZO5C4bL72mksHG4GfikgLOxib-A659rac7VkpjGsm150O_A@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Wed, 3 Mar 2021 13:54:00 +0100
Message-ID: <CAEyMn7akV6G4PkS266pMwi+nro6-Tffc0Zt6LN9sV7Kgi2dKcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,


Am Di., 2. M=C3=A4rz 2021 um 15:43 Uhr schrieb Fabio Estevam <festevam@gmai=
l.com>:
>
> Hi Heiko,
>
> On Mon, Feb 22, 2021 at 11:08 AM Heiko Thiery <heiko.thiery@gmail.com> wr=
ote:
>
> > +       reg_usdhc2_vmmc: regulator-v-3v3-sd {
>
> reg_usdhc2_vmmc: regulator-usdhc2-vmmc {

I used the same name as used on imx8mq-evk. Do you think a better name
is the one you proposed?

> > +       tpm_reset: tpm-reset {
> > +               compatible =3D "gpio-reset";
>
> I don't see this compatible string documented.

This comes from the linux-imx tree [1].  Nethertheless the reset seems
not to be used by the tpm driver for the infineon chip.

[1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/reset=
/gpio-reset.c?h=3Dimx_5.4.70_2.3.0

So I think I can remove it here.

>
> > +               reset-gpios =3D <&gpio3 2 GPIO_ACTIVE_LOW>;
> > +               reset-delay-us =3D <2>;
> > +               reset-post-delay-ms =3D <60>;
> > +               #reset-cells =3D <0>;
> > +       };
> > +
> > +       usb_hub_reset: usb-hub-reset {
> > +               compatible =3D "gpio-reset";
>
> Same here.

Also the usb-hub-reset can be removed.

>
> > +&fec1 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_fec1>;
> > +       phy-mode =3D "rgmii-id";
> > +       phy-handle =3D <&ethphy0>;
> > +       phy-reset-gpios =3D <&gpio1 11 GPIO_ACTIVE_LOW>;
>
> This property is deprecated. Please consider using reset-gpios inside
> ethernet-phy instead.

Done

> > +       /* TODO: configure audio, as of now just put a placeholder */
> > +       wm8904: audio-codec@1a {
> > +               compatible =3D "wlf,wm8904";
> > +               reg =3D <0x1a>;
> > +               clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
> > +               clock-names =3D "mclk";
> > +               clock-frequency =3D <24000000>;
>
> Not a valid property.

The whole node is removed since v3.

> > +/* M.2 B-key slot */
> > +&pcie0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_pcie0>;
> > +       disable-gpio =3D <&gpio5 29 GPIO_ACTIVE_LOW>;
>
> Not a valid property.

This comes from the linux-imx tree [2]. but in mainline it is not
valid. So I will remove it.

[2] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/c=
ontroller/dwc/pci-imx6.c?h=3Dimx_5.4.70_2.3.0#n2436

> > +       reset-gpio =3D <&gpio1 9 GPIO_ACTIVE_LOW>;
> > +       clocks =3D <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> > +                <&clk IMX8MQ_CLK_PCIE1_AUX>,
> > +                <&clk IMX8MQ_CLK_PCIE1_PHY>,
> > +                <&pcie0_refclk>;
> > +       clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > +       ext_osc =3D <1>;
>
> Not a valid property.

This comes from the linux-imx tree [3]. but in mainline it is not
valid. So I will remove it.

[3] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/c=
ontroller/dwc/pci-imx6.c?h=3Dimx_5.4.70_2.3.0#n2422

> > +/* Intel Ethernet Controller I210/I211 */
> > +&pcie1 {
> > +       clocks =3D <&clk IMX8MQ_CLK_PCIE2_ROOT>,
> > +                <&clk IMX8MQ_CLK_PCIE2_AUX>,
> > +                <&clk IMX8MQ_CLK_PCIE2_PHY>,
> > +                <&pcie1_refclk>;
> > +       clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > +       ext_osc =3D <1>;
>
> Not a valid property.

same as commented before.

Thank you for the review. I will prepare v4.


--
Heiko
