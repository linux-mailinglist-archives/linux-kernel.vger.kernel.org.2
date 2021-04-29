Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE02036F21F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhD2VfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhD2VfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:35:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B1BC06138B;
        Thu, 29 Apr 2021 14:34:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y26so666719eds.4;
        Thu, 29 Apr 2021 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lK7Nlie8/CSVsi6nATHCgI80+6/hcW39NKGz6rfjDvg=;
        b=lGwWY4B0mzo9H/D8qY6EwB2aDhMdLWxmvdzG7QLtNvUZqht09Awps1zmgiFdYHjVn9
         YBmxabI/Uo7fBYfTRUhE25B01vtzhy19V1fT3/einCKwtU2aozJUX2NKI0zcLlmvZehy
         eqbTtbucreVWSCMR46rtS0tNpBEMhOJY58bLsEhvB6oZ4GU/O4yjKjbYuiVqS961AcR+
         vdpPbO2jOILHStO7xjyH6Yl40TgfEnD/TcUZmeoRMKyfDHdhDzVxp+kh2s2CIbgVM77e
         FpSsPBfjVKqa8EVuMUzPH+utOXLxZb7ahm8STgE4pv2BRH4hoSHYhc5dvRIMztk1b3h3
         kRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lK7Nlie8/CSVsi6nATHCgI80+6/hcW39NKGz6rfjDvg=;
        b=erKuwIxkBuI2soMKe4iD1ZqWjQ0loHYkKHk+krsahvWVuFbka3LLZMV3A52PI+XoYR
         LFtJolrVFFugHwT+i9TwRmI1TW0yQtmqDgT8pHDkxggdwm9Zc6MdJvn7P7meHnpRFlCo
         elb8m9/gdsWfXJqB0nDet/5AFWACNtu8ZO8ojK2kSUC2uEcE9rYIIX9clIRbApCf+Nky
         7vZS+LkM+5P3l7ob794XLeeswMHqxpfphArWeyKwik/rF3pwL23bdKcaPgNUKm4xViuO
         SH036XTGKnbDe/tRjwougd3QjjgcfokKSy4J8zRYX3uL2wF/48nJuvmKTe7VUh1ARLEK
         OU8g==
X-Gm-Message-State: AOAM531qhlDNVmB/OToaSZP3bt0SC1W9X3dnBfhOGZuMGI67aiNZQJJV
        6twMXeE7OoQ+lKe/IbrYmy+TkE7CSKoWkF8ZYON3aIYncl0=
X-Google-Smtp-Source: ABdhPJyJlMTpZCe3fhbuYHhGYiJ2pCRraOG67uxsWh2kgU9qtljHfumpwrJxvOsleWMNFwrjL2V0tDuom6jURPpkn14=
X-Received: by 2002:a50:9e4f:: with SMTP id z73mr1972841ede.338.1619732051559;
 Thu, 29 Apr 2021 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210429060830.6266-1-wens@kernel.org>
In-Reply-To: <20210429060830.6266-1-wens@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 23:34:00 +0200
Message-ID: <CAFBinCBrx8tCiWMf+p1k7Mn91yQ5JFGFgSw5fYvGtn6zjwxPJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 8:08 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The NanoPi K2 has a AP6212 WiFi+BT combo module. The WiFi portion is
> already enabled. The BT part is connected via UART and I2S.
>
> Enable the UART and add a device node describing the Bluetooth portion
> of the module.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
one nit-pick below - with that you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 7273eed5292c..10f48fb1af61 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -385,9 +385,19 @@ &uart_AO {
>
>  /* Bluetooth on AP6212 */
>  &uart_A {
> -       status = "disabled";
> +       status = "okay";
>         pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>         pinctrl-names = "default";
based on Documentation/devicetree/bindings/serial/serial.yaml please add:
  uart-has-rtscts;


Thank you!
Martin
