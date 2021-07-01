Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620243B8C93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 05:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhGADOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGADOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:14:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F9C061756;
        Wed, 30 Jun 2021 20:12:21 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id n9so3150623qtk.7;
        Wed, 30 Jun 2021 20:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqTfUx+1bpJ+GEZ1JasFELVQC7fHMfJcaiqyDCFPIuw=;
        b=alBMPcQgQ4sDn+WFk4di7zdZI+/oW/JiE9BmC+6+i/eynxs5Q0F3qzXMd7jvbJKdcs
         al/BWmsBczUkNgGX5+H5/V+IfzFfTZPVMZE1W6Noo41j/BuxZ885p4LEtUOIqJ4dG6lJ
         XC9l//ve4l7B0pZnQSDiMWuxyfXb0dEdbjCBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqTfUx+1bpJ+GEZ1JasFELVQC7fHMfJcaiqyDCFPIuw=;
        b=RkLFvN+NpaaRn1o+D03SPea5yaaFjN6h3rIMkCZlIanYKF+qyyydQsXIi/G+vWxX0H
         ZsSoTaS7Z/0VKgewgeHRm3Cwzj+90BPeR5Cfe2si2C5BVn9VQ/1akfdscm1WH3OPCIcA
         LdgxZjcIXwhNDGXbxguLSuCS1aomIOe+g97EWH31RcJptcI6LRBNGkODoc6OhF2LHAbO
         Lg2Gtbkv1zHMZ8s5JMNf/RdPEmf2XqgIcKS8eLOWjOtKIkJj8SAbcB/9ZYhX5BmZlTJ+
         VTGue79YqanBmVUyo2/oIRk/UiLhxC2Env/hCNDB3lDize5rzWQitnu2YDb2yArMEI59
         S9VA==
X-Gm-Message-State: AOAM5305AkUaCML9937HoruE9A1Awvp/O3B819J6e17I3eOtN90sKRM0
        3Tpovxoq6TJQWJwPH5md4W2Jkr9AUd4ikodnkGr3xVeD6V8=
X-Google-Smtp-Source: ABdhPJy2kf91B2vTqHlagKoi/6aakbeQj8UnEv2eAc/5e2Sz//Sa79thJYLh7yTsO1ikEDcd9FDWPoHzHnB45g8OURo=
X-Received: by 2002:a05:622a:50f:: with SMTP id l15mr14036901qtx.263.1625109140085;
 Wed, 30 Jun 2021 20:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210416075113.18047-1-zev@bewilderbeest.net>
In-Reply-To: <20210416075113.18047-1-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 1 Jul 2021 03:12:07 +0000
Message-ID: <CACPK8XeRg5P8+W8kyxSNyOa7JBhua5QdP_oCVJALGPJQio0dhA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: update e3c246d4i vuart properties
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 at 07:52, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This device-tree was merged with a provisional vuart IRQ-polarity
> property that was still under review and ended up taking a somewhat
> different form.  This patch updates it to match the final form of the
> new vuart properties, which additionally allow specifying the SIRQ
> number and LPC address.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>


Fixes: ca03042f0f12 ("serial: 8250_aspeed_vuart: add aspeed,
lpc-io-reg and aspeed, lpc-interrupts DT properties")
Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>
> The relevant aspeed-vuart patches [0] have been merged into Greg KH's
> tty-next tree, so I figure it's probably okay to proceed with the
> corresponding dts adjustments now.
>
> [0] https://lore.kernel.org/openbmc/20210412034712.16778-1-zev@bewilderbeest.net/
>
>  arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> index dcab6e78dfa4..8be40c8283af 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -4,6 +4,7 @@
>  #include "aspeed-g5.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  #include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  /{
>         model = "ASRock E3C246D4I BMC";
> @@ -73,7 +74,8 @@ &uart5 {
>
>  &vuart {
>         status = "okay";
> -       aspeed,sirq-active-high;
> +       aspeed,lpc-io-reg = <0x2f8>;
> +       aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
>  &mac0 {
> --
> 2.31.1
>
