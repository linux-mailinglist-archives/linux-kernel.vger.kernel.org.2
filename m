Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D5326FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 01:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhB1Auo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 19:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB1Aul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 19:50:41 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A6C06178B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 16:49:21 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id f33so12889453otf.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XWqnUl1mdnB3JAAYw5d6L5y9S7s05e4ZLh5O99+5nfM=;
        b=qNy44be0yKLCic21OcqvK9OW7l6hT9Ki+KTr5ZBg0y9aKe8VeN1cqTlDFrB1ELKFbG
         lBA/CvWWzuYMDDUDgHjOcA60wHwSjk0/NJVdL/QfxbGfp3P1okAuOAdYy3gULUMVayua
         dT20Qx5T8hVVyuXXfxwdayYp3/OcNqEFXYcMM9iHaqCuZDOdkpLdhRTWu/FxBUsY6c+8
         vKr9HKIIQ7W9rU36hjZTNr05EZMrhLtLUhz+/j/727Lcdo7E+fl+KZyh5Cd8DB5+5V2r
         1a8lBCVYJ6StHdG2WIUoQYJg9T4PZADff86lUWkF1QG7Fgdw8EuRXy2FjKgvi2CHF3EQ
         xcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XWqnUl1mdnB3JAAYw5d6L5y9S7s05e4ZLh5O99+5nfM=;
        b=EkQ/LWqyP6h7JP4l/eBeTbWWePfQfEWzhwMiwni+CFKUpFkTPMu7KpmPdi0ONH0Yan
         2fMZ+5GAwj6h+KgPClpyDP0iqABklldwlzd2XU9CvCb41f/y4H8a7fUcWDgIHOLxQNzv
         E6lW7w6GNFtSjfsieFsuDsO0YzrgqlGYRVMf81u+Ro0ZguXSd3DV1j7tcMEDUsEuX9UW
         9r7B8/oxVRwdmb6wmKmSQG5kf0pmRCEk34DA10p32dxzwqyhvEc/4tOHKg86hiHe9hil
         vCJOssp5rS4l/9aS0/Bo83PVVLtudGkrY02hcMukyive9UxfbHSWhQLvIzY7sTziFE5F
         Bx1Q==
X-Gm-Message-State: AOAM532teWD0c5Aafxs599Z7Fg0dXHiMgSGKnocvoFL1gSoRY4tIfMs6
        W6uchp8bzdpL8VkGMrLx0BvXdkuhbzrH7cCIntcJ
X-Google-Smtp-Source: ABdhPJx/4Rh+uoGUFPnDSvFa/s9+VS8Sow/JnLOwCCLeCOSCdn3QdZ/8CRIckq3ruX995B9BCJRTPPPCd+b/gthgVHE=
X-Received: by 2002:a9d:63ce:: with SMTP id e14mr7682977otl.347.1614473360895;
 Sat, 27 Feb 2021 16:49:20 -0800 (PST)
MIME-Version: 1.0
References: <1613131643-60062-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1613131643-60062-4-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1613131643-60062-4-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Sun, 28 Feb 2021 09:48:54 +0900
Message-ID: <CABMQnVKXDj-e2+YkBsGUdj58nAK2edFXDyaXmT94SJya4W80ww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: Add Xilinx ZynqMP pinctrl driver support
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        git@xilinx.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2021=E5=B9=B42=E6=9C=8812=E6=97=A5(=E9=87=91) 21:10 Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com>:
>
> Adding pinctrl driver for Xilinx ZynqMP platform.
> This driver queries pin information from firmware and registers
> pin control accordingly.
>
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.=
com>
> ---
>  drivers/pinctrl/Kconfig          |   13 +
>  drivers/pinctrl/Makefile         |    1 +
>  drivers/pinctrl/pinctrl-zynqmp.c | 1031 ++++++++++++++++++++++++++++++
>  3 files changed, 1045 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-zynqmp.c
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 815095326e2d..25d3c7208975 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -341,6 +341,19 @@ config PINCTRL_ZYNQ
>         help
>           This selects the pinctrl driver for Xilinx Zynq.
>
> +config PINCTRL_ZYNQMP
> +       bool "Pinctrl driver for Xilinx ZynqMP"
> +       depends on ARCH_ZYNQMP
> +       select PINMUX
> +       select GENERIC_PINCONF
> +       help
> +         This selects the pinctrl driver for Xilinx ZynqMP platform.
> +         This driver will query the pin information from the firmware
> +         and allow configuring the pins.
> +         Configuration can include the mux function to select on those
> +         pin(s)/group(s), and various pin configuration parameters
> +         such as pull-up, slew rate, etc.
> +
>  config PINCTRL_INGENIC
>         bool "Pinctrl driver for the Ingenic JZ47xx SoCs"
>         default MACH_INGENIC
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index f53933b2ff02..7e058739f0d5 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PINCTRL_TB10X)   +=3D pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_ST)       +=3D pinctrl-st.o
>  obj-$(CONFIG_PINCTRL_STMFX)    +=3D pinctrl-stmfx.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)     +=3D pinctrl-zynq.o
> +obj-$(CONFIG_PINCTRL_ZYNQMP)    +=3D pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_INGENIC)  +=3D pinctrl-ingenic.o
>  obj-$(CONFIG_PINCTRL_RK805)    +=3D pinctrl-rk805.o
>  obj-$(CONFIG_PINCTRL_OCELOT)   +=3D pinctrl-ocelot.o
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-z=
ynqmp.c
> new file mode 100644
> index 000000000000..ec0a5d0e22d5
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -0,0 +1,1031 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ZynqMP pin controller
> + *
> + *  Copyright (C) 2020 Xilinx, Inc.
> + *
> + *  Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + */

<snip>

> +/**
> + * zynqmp_pinctrl_get_function_name() - get function name
> + * @fid:       Function ID.
> + * @name:      Function name
> + *
> + * Call firmware API to get name of given function.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int zynqmp_pinctrl_get_function_name(u32 fid, char *name)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +       qdata.qid =3D PM_QID_PINCTRL_GET_FUNCTION_NAME;
> +       qdata.arg1 =3D fid;
> +
> +       zynqmp_pm_query_data(qdata, ret_payload);

Please check the return value here as well as other functions.

I know that when we used zynqmp_pm_query_data with
PM_QID_PINCTRL_GET_FUNCTION_NAME,
it returns -22 error code.
How about adding processing with zynqmp_pm_query_data like
PM_QID_CLOCK_GET_NAME or
writing a comment here?

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
