Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A609445D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKEBm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhKEBm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:42:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A243C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:40:18 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id s9so6482267qvk.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuiu0Wf4u9BEGXBoIO9WIUY1RtGLPv3KstdNH+skVn4=;
        b=OlHZHpMMlHlA2mvNmNLMVYTBkYoOu+wuDTNv26+y/aJr0eHbC+oJ3i8677sqJTiFUB
         kZAqRUaI8Q6V6+kY6V4NK/At2bdGiTfcJOC9WS5kJ1FLTQiZNgKrHm0bU7MQi+LOFOTK
         UScPeAhF0wmBZeDCZ4h5BYhKBppp4cAGLcT3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuiu0Wf4u9BEGXBoIO9WIUY1RtGLPv3KstdNH+skVn4=;
        b=W7tjR7WI0cNiKmxgI+QlQr7NIcn/5/ry+y3FY+nZMp+Tl2xCZUq0PCLePR9JL5cxDQ
         eqaVxJZ9p/ZHnh3vTDulEPJaJncQtNmDkwkC2TpxWgAistLGadXAIwE+ODIDX4SacKlI
         VXF7Jwq2CMJkNBT9tsVQpdTI1oAxP5ddf2KJFx/ntuOGdpjUcMHnCWxH4IlqkWmIx4Tx
         wr+H3kx4Q0NmOXmrRTZ1lc8cEt/4sU42v9qCHQnLWEyHc6A7goSEGAsAHMSEgNepICbv
         zOjh7jQgwEPkuaGNrjDwDKfVMLkjW2EiypRYgSdi4hrYXFds0mJgtGhR/y0wtpv9RRHF
         l/Sg==
X-Gm-Message-State: AOAM530HBG9RFiAVcokHl5A1Uf0QNG2A7rUqRVkyKnG6snYcEXdHry+M
        PwllhnOSkdTWQksylv8TcgqBGIX6n+6D+7l2sxI=
X-Google-Smtp-Source: ABdhPJwn7ltINiaTnafuAfwJf+9xnaLsMQM755UKrybz+o6veGW29/K/cs79Ln231Xya3DTp+gpEIBBL8k1kZK/4deQ=
X-Received: by 2002:a0c:c784:: with SMTP id k4mr53964077qvj.43.1636076417159;
 Thu, 04 Nov 2021 18:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com>
In-Reply-To: <20211105005955.107419-1-osk@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 5 Nov 2021 01:40:05 +0000
Message-ID: <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Oskar Senft <osk@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 at 01:00, Oskar Senft <osk@google.com> wrote:
>
> This change updates the configuration for the nct7802 hardware
> monitor to correctly configure its temperature sensors.
>
> Signed-off-by: Oskar Senft <osk@google.com>

I applied this and tried comple testing, and got this warning:

  DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
(reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:220.4-14: Warning
(reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@1:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:226.4-14: Warning
(reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@2:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:232.4-14: Warning
(reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@3:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (pci_device_reg):
Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (i2c_bus_reg):
Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (spi_bus_reg):
Failed prerequisite 'reg_format'
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:216.13-218.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:216.13-218.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:219.13-223.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@1: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:219.13-223.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@1: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:225.13-229.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@2: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:225.13-229.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@2: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:231.13-234.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@3: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:231.13-234.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@3: Relying on
default #size-cells value

You need to add this to the nct node:

#address-cells = <1>;
#size-cells = <0>;

Did you see this with your testing? I'm building on top of v5.15 and
my distro's dtc is 1.6.0.

> ---
> Changes from PATCH v1:
> - Removed superfluous "status" from channels.
> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> index 68f332ee1886..66734e4e2ea1 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> @@ -213,6 +213,25 @@ &i2c0 {
>         nct7802@28 {
>                 compatible = "nuvoton,nct7802";
>                 reg = <0x28>;
> +               channel@0 { /* LTD */
> +                       reg = <0>;
> +               };
> +               channel@1 { /* RTD1 */
> +                       reg = <1>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@2 { /* RTD2 */
> +                       reg = <2>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@3 { /* RTD3 */
> +                       reg = <3>;
> +                       sensor-type = "temperature";
> +               };
>         };
>
>         /* Also connected to:
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
