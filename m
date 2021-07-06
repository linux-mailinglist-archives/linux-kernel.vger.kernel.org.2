Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBE3BD6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhGFMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbhGFMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:47:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81247C0A8887;
        Tue,  6 Jul 2021 05:29:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r26so20486846lfp.2;
        Tue, 06 Jul 2021 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5Qtd3fuR7kMLaMb3nhIpOHtCY+/u+6q3WDsXYoZ2b4=;
        b=pjf0hNOGG6UM0WfHp6uBP4xQtp6m3wjS3+XEiteAXm78Zyisok6ONiWWhMsX4xPHxi
         xfUW5MfTmSTfpjLcJBaOMu/9cBGdSO0Cv4Fzhnv4boQ9kBxVQx1cKgR6aq9ATokyS7hi
         /XeZ+ThGyFCJVmcYHKBNL0EfR1qj5yCgNZreE3LqN/cUT2JwvXbKII664V7XlUBlbaFq
         psHji5XzpZmmO2T7mbr6nKRd8iwrT/N8xK68uY1nBbwPmV3CVW4zb7TxTC3BVyn2mZhe
         4+eg32KLEsgwaxl9BFmznWqoXYsmZlT45OGHQg6aeJOvpVTawDES9iTsUBkSkFxL/J2k
         H04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5Qtd3fuR7kMLaMb3nhIpOHtCY+/u+6q3WDsXYoZ2b4=;
        b=QrbiyZRAHg5kTjfFCysl6s8/s6Ymjc7TzyD/XxO44XqnfRq56BiWlLSI2NLGvfxhWM
         VJkMOXDpyepU72IJ9i6GkIa7wLeW2k3O/npnIbCWOWsb47CqpBC/TYcvr8AbHmL/yOl7
         YkaVbJ9PERCJuHvzZS4/As3RAsc6+y/EA+EWNr9igb1yKDfkepFRHl4PRwapA7w+mNQ1
         9zBIYpwOczKAkGIbX2eUujaaoKF5xmJrhyb8b574OpMOaEtFmaj8f07n5CnDXe7C1tuG
         FuVjx+ZkHJHjELo8+gDjHfppjBTI/q9eVjMny8//eVoW8T2PgKA1YHHitD9xti0nXwt9
         V1fQ==
X-Gm-Message-State: AOAM531fjWWWBAoJxJFD0KfhJzz9kbfxiVR/tnq2nlK5f7D95sABlieu
        uNqbV4Yj1UrIuuJ8tKv9ex7yHl050I9q9OH0RgE=
X-Google-Smtp-Source: ABdhPJzPPY1f+Jc0yJPnPF3OoWS8rSMKFE7ihL9VNpXMJTOvEK41TxqiwlHIBiniW0a7tG/oumOwHZEl/rysJD3cTDA=
X-Received: by 2002:a05:6512:1583:: with SMTP id bp3mr10083480lfb.500.1625574570856;
 Tue, 06 Jul 2021 05:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210706114028.132-1-alistair@alistair23.me>
In-Reply-To: <20210706114028.132-1-alistair@alistair23.me>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 6 Jul 2021 09:29:19 -0300
Message-ID: <CAOMZO5CEeBWEaRWXpfgjR+q0QnpPmoyGN+ShjCHNzoSqk_iW0Q@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imx7d-remarkable2: Add WiFi support
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, alistair23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On Tue, Jul 6, 2021 at 8:40 AM Alistair Francis <alistair@alistair23.me> wrote:

> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_wifi>;
> +               reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;

Don't you need to select the osc32 as the parent clock?

This is what we do on arch/arm/boot/dts/imx7d-pico.dtsi and
arch/arm/boot/dts/imx7d-nitrogen7.dts:

&clks {
assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
  <&clks IMX7D_CLKO2_ROOT_DIV>;
assigned-clock-parents = <&clks IMX7D_CKIL>;
assigned-clock-rates = <0>, <32768>;
};
