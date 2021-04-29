Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43B36F21B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhD2Vb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhD2Vb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:31:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB55C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:31:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id zg3so20452306ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVMl1qnVSF03rfGgdYkMBHAAAqe4Ku/OnaBY2U59O2s=;
        b=Zf4acKs32A29H762/G5LkAPIL+Q3bdfTEdtGk/fYQOU1SrXKCu1N2KGhE/O9hZAR8m
         XK0xyoHOfBHj4RkF23kP7wj3fRTOkgt5u1Dq7qxGpklWYp4mH61RhjEUQiaWUeSfLE8L
         xNLSINLOfkVEF9AE6dqRIqf/PyCX4DAAajVZCNZJNPu0TChO+jRwreba2jVDNB6CbRiR
         2PCEPa0cnOksoqsJxIuwGSHuT3+qaKRDjHusl39Bpi1gjIjQqa9bcE97VlIlv7km3o2u
         OPZosYhoteIcxKdL2OM9upHe5maTv1WsfKeb5FDGWQTtRBE/6fxp++P5m2JZ3TnlhHD/
         vDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVMl1qnVSF03rfGgdYkMBHAAAqe4Ku/OnaBY2U59O2s=;
        b=sTaoNGZLyjiVOzg40HqdFT4jZpBYExmakPMA03jqJ5wNyyxg+pY9eI2b/AHGiQro3b
         pmIM6ACqqW3ze3a8ZqrEHNQAQ0BAqBFQohMRH63MMjDH9tAWbP94GO1PbRXNK2v+3p0o
         X6JtjaNkG+gf5TBzKw4NW2nKEDyAXQCvJBA7GCxgwUjiDVzDFyFboj+Hd+F+6/2Hfza4
         cADXNbPXBKjGOnyMq7u6zJsBtPAF0vngqH7qMyVa5Xkfr1dClBzZTdD4wok4okNe69HK
         VSzGq//Jke1L2i31Ip+cc0FR4P+WVyFUzbC5owAU/iV1M+XxZHj5fzlXdb7iHNCLXP3O
         khXA==
X-Gm-Message-State: AOAM533+ZYvisE7McD35WJywrtAU6NKltMAd4Em/zJEMA27KLViFBWkG
        vq1qEHnv46BD+f8wM0vslyYAVgY3sZS4ulq2n+BgzjRw4wU=
X-Google-Smtp-Source: ABdhPJwq1uyPLkWHfyPVREWPc7ZTJSfwQblAtTnULW2OPkFED5s8OL9ENgWZOb0EQRn+PTVaXvM/rd4GiBxndYSWEEE=
X-Received: by 2002:a17:906:ecb8:: with SMTP id qh24mr623023ejb.162.1619731869841;
 Thu, 29 Apr 2021 14:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210429170404.3616111-1-narmstrong@baylibre.com> <20210429170404.3616111-4-narmstrong@baylibre.com>
In-Reply-To: <20210429170404.3616111-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 23:30:58 +0200
Message-ID: <CAFBinCDQeTU0ss=oNmjX78MPyNZmmCt-haojNNcQqkjJUmJYKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

thanks for adding support for the BPI-M5!
I had this on my TODO-list for a long time but didn't have enough time
so far. so it's great to see this patch now :-)

On Thu, Apr 29, 2021 at 7:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +       adc_keys {
> +               compatible = "adc-keys";
> +               io-channels = <&saradc 2>;
> +               io-channel-names = "buttons";
> +               keyup-threshold-microvolt = <1800000>;
> +
> +               button-onoff {
maybe just "key" (as you used below for SW1)?

> +                       label = "SW3";
> +                       linux,code = <BTN_3>;
> +                       press-threshold-microvolt = <1700000>;
> +               };
> +       };

> +       /* TOFIX: handle CVBS_DET on SARADC channel 0 */
it's great to see that after many years at least some boards finally
can detect whether the CVBS connector is plugged it

> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x40000000>;
> +       };
note to self: u-boot will update this from 1GiB to 4GiB

> +       flash_1v8: regulator-flash_1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "FLASH_1V8";
BPI-M5-SCH-V10-Release.pdf schematics are calling this EMMC_1V8. I
suggest to use that name so it's easier to compare this with the
schematics in the future

> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               vin-supply = <&vddao_3v3>;
> +               regulator-always-on;
> +       };
> +
> +       dc_in: regulator-dc_in {
> +               compatible = "regulator-fixed";
> +               regulator-name = "5V";
maybe use "DC_IN" here as well so the node-name matches what we see in
userspace/kernel logs?

> +       vddcpu: regulator-vddcpu {
> +               /*
> +                * SY8120B1ABC DC/DC Regulator.
> +                */
> +               compatible = "pwm-regulator";
> +
> +               regulator-name = "VDDCPU";
> +               regulator-min-microvolt = <721000>;
> +               regulator-max-microvolt = <1022000>;
the vendor .dts has:
  regulator-min-microvolt = <690000>;
  regulator-max-microvolt = <1050000>;
which also matches meson-sm1-sei610.dts (which uses the same regulator IC)

[...]
> +&ethmac {
> +       pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-handle = <&external_phy>;
> +       amlogic,tx-delay-ns = <2>;
I haven't checked their u-boot code but some of the newer Amlogic BSPs
seem to let the PHY add the TX delay (which is also what the netdev
maintainers recommend)
that can be achieved by setting:
  phy-mode = "rgmii-txid";
and deleting the "amlogic,tx-delay-ns" property

> +&gpio {
> +       gpio-line-names =
> +               /* GPIOZ */
> +               "", "", "", "", "", "", "", "",
GPIOZ_0 to GPIOZ_15:
- ETH_MDIO
- ETH_MDC
- ETH_RXCLK
- ETH_RX_DV
- ETH_RXD0
- ETH_RXD1
- ETH_RXD2
- ETH_RXD3
- ETH_TXCLK
- ETH_TXEN
- ETH_TXD0
- ETH_TXD1
- ETH_TXD2
- ETH_TXD3
- ETH_INTR
- ETH_NRST

> +               /* GPIOH */
> +               "", "", "", "", "",
GPIOH_0 to GPIOH_4:
- HDMI_SDA
- HDMI_SCL
- HDMI_HPD
- HDMI_CEC
- VL-RST_N

> +               "CON1-P36", /* GPIOH_5 */
GPIOH_6 to GPIOH_8:
- VL-PWREN
- WiFi_3V3_1V8
- TFLASH_VDD_EN

> +               /* BOOT */
> +               "", "", "", "", "", "", "", "",
> +               "", "", "", "", "", "", "", "",
BOOT_0 to BOOT_13:
- eMMC_D0
- eMMC_D1
- eMMC_D2
- eMMC_D3
- eMMC_D4
- eMMC_D5
- eMMC_D6
- eMMC_D7
- eMMC_CLK
- (BOOT_9 is unused)
- eMMC_CMD
- (BOOT_11 is unused)
- eMMC_RST#
- eMMC_DS

> +               /* GPIOC */
> +               "", "", "", "", "", "", "", "",
GPIOC_0 to GPIOC_7:
- SD_D0_B
- SD_D1_B
- SD_D2_B
- SD_D3_B
- SD_CLK_B
- SD_CMD_B
- CARD_EN_DET
- (GPIOC_7 is unused)


> +&gpio_ao {
> +       gpio-line-names =
> +               /* GPIOAO */
> +               "DEBUG TX", /* GPIOAO_0 */
> +               "DEBUG RX", /* GPIOAO_1 */
> +               "SYS_LED2", /* GPIOAO_2 */
> +               "UPDATE_KEY", /* GPIOAO_3 */
> +               "CON1-P40", /* GPIOAO_4 */
> +               "",
GPIOAO_5 is IR_IN

> +               "TF_3V3N_1V8_EN", /* GPIOAO_6 */
> +               "CON1-P35", /* GPIOAO_7 */
> +               "CON1-P12", /* GPIOAO_8 */
> +               "CON1-P37", /* GPIOAO_9 */
> +               "CON1-P38", /* GPIOAO_10 */
> +               "SYS_LED", /* GPIOAO_11 */
> +               /* GPIOE */
> +               "", "", "";
GPIOE_0 to GPIOOE_2:
- VDDEE_PWM
- VDDCPU_PWM
- TF_PWR_EN

> +&usb2_phy0 {
> +       phy-supply = <&dc_in>;
> +};
> +
> +&usb2_phy1 {
> +       /* Enable the hub which is connected to this port */
> +       phy-supply = <&vl_pwr_en>;
> +};
I think technically we'd need to use AVDD18_USB here (that said, I
chose the same approach as you are using here before..)
USB bus devices (AFAIK) still need to be detected before any
device-tree properties can be applied and there's (again AFAIK) still
no pwrseq concept.
so I guess for now this is the way to go as there's enough comments
about it in your patch


Best regards,
Martin
