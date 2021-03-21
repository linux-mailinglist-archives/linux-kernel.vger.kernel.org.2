Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1043432B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCUNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:15:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB7C061574;
        Sun, 21 Mar 2021 06:15:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m12so17093144lfq.10;
        Sun, 21 Mar 2021 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF4nBf0FXKZ92uHqAvVz6fGcspBzCf7DW5ZZmy9EuKA=;
        b=NRXFh9ZnzPaVqz3EbrLTAM4pqET072BBMFwBkoYqTGKM0rKh4X+hAWwgkNXQ4o/Agu
         X8gvQi6y8devEWtpWCKEwMlRCBQZ5JUzIkl3lJFrrK+S9XClEZV7zj0a74lIFZRU5SZf
         owphliZeNLMpWGKx8WgRaOsuny3x4rhDBTP1DKVXcT2pe50mkti+NLkWgXpH012KkbXu
         qLPZafyxiNMUjMwExXlVWqIecFeIN7z0unLjcx4uvK4tvxODRZsCDn6WMptRAmUYje4o
         CC0ubxA2xZCTXNE9INvkmiKfzwq1QTH8m9J9gJdTpJZzjLWsfAt2AvTF0Ui45eDcNX5H
         wT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF4nBf0FXKZ92uHqAvVz6fGcspBzCf7DW5ZZmy9EuKA=;
        b=Ux8PrW7pZSJi6kx9BPgPNIgLw8IIc/Kw0TcWjdZjWkfmu7UKFBqzUWT9TybOoAEmli
         D44tak3w6r2E1wmMVJV+l1ZBBvTyB1ARb1W0JeeVtDJHnn9O/ZbWHzXYxqbsjYwM4QjA
         kgbIQiNiM8F1okWYGwTrhuMUNzLwLKZnVW7udDd3c15+lm7sQmzSTOLdfynrfjTucsJG
         kz3B+EmGP4UK9Qx2yKrClbOTGH5rvpvGHo5bCY2402vB1ZHqdYg6XZCvjRW+bUctzWW1
         xJgkO3ccJtorzeB162+3iAcGQH0v9wgStqgbGUmDXzXPwtUTVcWfzssmnkE2fv+ps6EC
         epxA==
X-Gm-Message-State: AOAM532wOQW06tGse9+Ok+W7ULkjGgmbeY4p+DMSaz6UPM4l6A1rp/FB
        5fFR8ySf1wje1e7BLgEd0cEr0ylAUm9E3MoZTQ4=
X-Google-Smtp-Source: ABdhPJzLGqUvY4SEVe4x1CHLzWm1exmAM3i6Yy15y31EUMm849ysNvBoR7ym8B2SDAdDruwhhoI612jJLnSyZze/iq4=
X-Received: by 2002:a19:f614:: with SMTP id x20mr6238513lfe.229.1616332526594;
 Sun, 21 Mar 2021 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210316022740.132-1-alistair@alistair23.me> <20210316022740.132-3-alistair@alistair23.me>
In-Reply-To: <20210316022740.132-3-alistair@alistair23.me>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 21 Mar 2021 10:15:14 -0300
Message-ID: <CAOMZO5AnmhjzARZwT0LfRwoCH-pmygket+H2Qes7Q6MUrYk_MA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ARM: imx7d-remarkable2.dts: Initial device tree
 for reMarkable2
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
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

On Mon, Mar 15, 2021 at 11:27 PM Alistair Francis
<alistair@alistair23.me> wrote:
>
> The reMarkable2 (https://remarkable.com) is an e-ink tablet based on
> the imx7d SoC.
>
> This commit is based on the DTS provide by reMarkable but ported to the
> latest kernel (instead of 4.14). I have removed references to
> non-upstream devices and have changed the UART so that the console can
> be accessed without having to open up the device via the OTG pogo pins.
>
> Currently the kernel boots, but there is no support for the display.
>
> WiFi is untested (no dispaly or UART RX makes it hard to test), but

"display"

> +       memory {
> +               reg = <0x80000000 0x40000000>;
> +       };

This should be:

memory@80000000 {
         device_type = "memory";
         reg = <0x80000000 0x40000000>;
};

> +&crypto {
> +       status = "disabled";
> +};

Why do you need to disable this node?

> +&dma_apbh {
> +       status = "disabled";
> +};

Same here.

> +&sdma {
> +       status = "okay";
> +};

No need to enable it in the board file.

> +&iomuxc_lpsr {
> +       pinctrl_digitizer_reg: digitizerreggrp {

This is not referenced from anywhere.
