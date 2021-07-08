Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395103BF75B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGHJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhGHJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:18:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD7C061574;
        Thu,  8 Jul 2021 02:16:02 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k6so5955475ilo.3;
        Thu, 08 Jul 2021 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zz9QRz4PH4T9zJcgIW5PVOczaMK/54zPkqBHDjRsL5s=;
        b=Ij6xvXG8Xt7J3wv8u9vDtGmfCm6zljIOtCGnNK4JixS6QDrcLNAW3PVg+FErot3dsx
         ax65rSFG9vA0RrS9irKw7dGYuvRx9F4ZwQf0fKWaAUCaeRPkLLlP2abMugzWPZl6PG8A
         +gkTNWq392F4IE5cGt5WhHfTPfM9hp5wT3VrQaCOPEjnjBm0eQr9etVRZ2Ti3tcjh2B7
         4Ww8hVGVdXSj7aKvvkasjslhv1uTy85nMq1Poghy2r3A8AAxremfFMKZK2T/GkDnpu0N
         Xct3v2XpJwQtUxhmPpSFXs7Icg7/RCOtKA16vL3w5C2dR6gJHtBKBjVCT21ksDun8uIZ
         Pk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz9QRz4PH4T9zJcgIW5PVOczaMK/54zPkqBHDjRsL5s=;
        b=LvAihj7Aom5/ZXaVS6tn/LJjcZbOJ07Ov2TvR+1j/HekF7rSI88xt8gITKv6nqVGXO
         cSuchEOd/YBfd7sQjb32ZWU1CttC365PQXKAOzeDrBa56ogTutHsdK8HeGiKKWSSvwBn
         E8qjhDBBl+d+ADGfC8G+Fv2HCKEt3H3h0ZwJ/3apTx0mYkS/tBgOIBaNeZ7u/i/iJlOE
         yAb20nK9k21M7HVuFq28aw0UglCi9WE+MKnDD8QLZtEVU9zjG8HZQ6NoRN7ntzk1EwwJ
         gG1xWYQedWabigAi4614JdmaaSY1nYtKa0xgKgEW/pDHyh+peHR3sxsHCB2zTPpa49u9
         mwdw==
X-Gm-Message-State: AOAM531v2KRoV44A9udRAAbSlnOZp3p6hSus7k1Yi3HKg8RuicU7vtwK
        7/mEa6/ezm1CFgjXD1bK27aVobgdbaogYpyAcaA=
X-Google-Smtp-Source: ABdhPJwnjLLgT215I++othczjXQqK5SsNLg9xGVRONwRB13y/qL+XQCYNMhFN1tVQ9CyrT+WLd+ehPr86OxabfjGrW8=
X-Received: by 2002:a92:8707:: with SMTP id m7mr7741565ild.177.1625735761721;
 Thu, 08 Jul 2021 02:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210706114028.132-1-alistair@alistair23.me> <CAOMZO5CEeBWEaRWXpfgjR+q0QnpPmoyGN+ShjCHNzoSqk_iW0Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CEeBWEaRWXpfgjR+q0QnpPmoyGN+ShjCHNzoSqk_iW0Q@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 8 Jul 2021 19:16:00 +1000
Message-ID: <CAKmqyKPLWft8kUR9A2V1fjpaD8dmpbT9=Lc-NY76wkgenLE93Q@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imx7d-remarkable2: Add WiFi support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 10:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Alistair,
>
> On Tue, Jul 6, 2021 at 8:40 AM Alistair Francis <alistair@alistair23.me> wrote:
>
> > +       wifi_pwrseq: wifi_pwrseq {
> > +               compatible = "mmc-pwrseq-simple";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_wifi>;
> > +               reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> > +               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
>
> Don't you need to select the osc32 as the parent clock?
>
> This is what we do on arch/arm/boot/dts/imx7d-pico.dtsi and
> arch/arm/boot/dts/imx7d-nitrogen7.dts:
>
> &clks {
> assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>   <&clks IMX7D_CLKO2_ROOT_DIV>;
> assigned-clock-parents = <&clks IMX7D_CKIL>;
> assigned-clock-rates = <0>, <32768>;
> };

I'm not sure I follow, we do the same thing here with:

&clks {
    assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
              <&clks IMX7D_CLKO2_ROOT_DIV>;
    assigned-clock-parents = <&clks IMX7D_CKIL>;
    assigned-clock-rates = <0>, <32768>;
};

Alistair
