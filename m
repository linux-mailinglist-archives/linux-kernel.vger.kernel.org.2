Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44B34FA91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhCaHmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhCaHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:41:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCBCC061574;
        Wed, 31 Mar 2021 00:41:30 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q9so9491248qvm.6;
        Wed, 31 Mar 2021 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QR9n7jMBXuR7AUyYsxvNVDLdp7MMQ0XLcqNzq6Oedts=;
        b=ItuOamKAmyL1iqPklk3GBvrSvM/SNq/FVZC+5ryPmXu7jROc6lUwTxNrOOD/xcWp2+
         ymD4C6KALI+zjZuiS6LHcbLErQINHJmoTrnJ0Et+89desnpQaTEXUXoHYd8wMF75LlUu
         C2weFnwQ8w1CEc06TsKIZ5QAORrxw7Ox6zFWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR9n7jMBXuR7AUyYsxvNVDLdp7MMQ0XLcqNzq6Oedts=;
        b=l0OWGcyZdMj82/nx6xZlVEBQQzNq7c3D7qFO+XsXf9o7KkPpE/arYnLZg9JOm72apq
         IHAwXNTnpNnZoMu9K1H5nhQiLZOv9z1WiR4ZAn5g3udiQ5d0Y2Z3A/wYQMjLbQ1CyDT+
         h54OsBCwviYYnQjHYD2AHQWYP595JF/LSgjJhP7AvkioDIiqAs8MiV/rb2vhvictpXuC
         6s1oHjOXhyN3uOHxX5IcVDHRrpSB8lDBuQhMo1RQQ4Q5ddHOXM+86uF0CQ3297DaIuRs
         e9Yq4l0Z6PhRXjxa0mpav/2FR3xQ/mMHX5wY6IREn81Zw5lOODDLNbTxQwJuIkwZIh0J
         DwBA==
X-Gm-Message-State: AOAM533su9wcoz0siXNKAc6oXpk2rsK8Wy7EFOGv30J+5pJ8VxkK4t1R
        sbMWwM2M5oVZNMar6eBBs1sJcC5u0bpcI00GeOTMAM+ctQO7wYwv
X-Google-Smtp-Source: ABdhPJyRzi3fzNlKv54UZ4uRGyUMLMYtEitqX6uumolAz+qxX3eAEqUXtMwhLc+MEgT21jRm5FxrI/X79kntIIb+PhI=
X-Received: by 2002:ad4:58e3:: with SMTP id di3mr1756404qvb.43.1617176490132;
 Wed, 31 Mar 2021 00:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210330002338.335-1-zev@bewilderbeest.net> <20210330002338.335-4-zev@bewilderbeest.net>
In-Reply-To: <20210330002338.335-4-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 07:41:18 +0000
Message-ID: <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 00:25, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> mini-ITX board that we hope can provide a decent platform for OpenBMC
> development.
>
> This initial device-tree provides the necessary configuration for
> basic BMC functionality such as host power control, serial console and
> KVM support, and POST code snooping.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> new file mode 100644
> index 000000000000..27b34c3cf67a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/{
> +       model = "ASRock E3C246D4I BMC";
> +       compatible = "aspeed,ast2500";

Convention is to add a compatible for the board. I'll add
asrock,e3c246d4Ii-bmc when I apply the patch.

> +&vuart {
> +       status = "okay";
> +       aspeed,sirq-active-high;

We don't have support for this yet, but I'll leave it in and you will
need to send a follow up if the property changes.

Cheers,

Joel
