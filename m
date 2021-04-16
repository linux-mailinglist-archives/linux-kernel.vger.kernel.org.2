Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB03619A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhDPF7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDPF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:59:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D2C061574;
        Thu, 15 Apr 2021 22:59:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so18892763oti.9;
        Thu, 15 Apr 2021 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PGyYzRPEy6FhxfIB5cecNtkEGo2GJLisHFpfnEIgv9s=;
        b=jVXRN5SAfb3UbbYemk4rVpT24rI8CKDfizfHjfn5MKCNinyhm7Jj6ckJ3/phcJajgo
         C9C60lt/WJRtIk9rbesObsMdWQO2N8Adj27ZIkAJy5m7APNVIcLF7Ow1YHwDnoOsqZf5
         AUmzNO1nqjxHGqmMkSRd7utRabQlEXvEGIdDYsI39afpoq3vFaK+u5rGJyFkDZ8U8Ahp
         ULxns0mlgQOQZ9exk23tehJ4z4+kJrTsh6TPRc2et0ev2mtsVZmfgiBXOuDjeYK18aSp
         +pADTpTOgFpkb7/tjfNESid9h/7AtsnSUYV9VI7WvND3XF+eIwCRlO2rQt+QzSkFdDsv
         vpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PGyYzRPEy6FhxfIB5cecNtkEGo2GJLisHFpfnEIgv9s=;
        b=MWQrLg6aFPLGYSildBOrTNyT/KQBrY7tGskbRtsdnhPDhzPygQY7/roIG1PhYEOX6/
         zN2Koz/QR71e/tVLHMSHxmdA0eSOhJN216wlERnq/ww2gB9dW1stkfSSzBzUVmsdN3f+
         UjFZQvm21SFgBOxarw5rmCAHYTr1+D5qXP03zYSuqQ5CCGQE9OOqciq30iTKDC+r7FGL
         WU0Wo8xjAycI0loFcrDECwNsc+iSbzdzUkTft+cM2uaXjpPTjcs9BiuBsDmXKgaA4w68
         qY4LAoPoRF6AmxyxtR4H1ylcBFM5voowWrdX1LskBdMv8aEACVb3RmQtUDNvLHxaPVdZ
         qlVg==
X-Gm-Message-State: AOAM530IeFZOjkd0rsLAkQb7KxcyGRtH95DDAkeYQaKkUlOt0ibG/2YO
        LkQY9cTm6F3c1DBeIwLDWfooEDknvusUHssT/w4/mUItURY/PeWq
X-Google-Smtp-Source: ABdhPJzw8TH8HspG/Ib3hNDSuxhA1MFn02ncYre9feD3BsyVC+KHsWN7g55VIGatiTpvjHk2gaoLkqDfjQlGAzAGzDY=
X-Received: by 2002:a05:6830:15d0:: with SMTP id j16mr2502749otr.184.1618552766131;
 Thu, 15 Apr 2021 22:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-5-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-5-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:59:17 +0200
Message-ID: <CAFqH_515cZrto3wHuUsiMtoQMHjDv-isH3LMRkkgJ+KMZFd6oQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 15 d=E2=80=99ab=
r.
2021 a les 11:36:
>
> Kappa is known as HP Chromebook 11a
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/Makefile            |  1 +
>  .../dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kap=
pa.dts
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index a1c50adc98fa..df70674949ce 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-damu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-juniper-sku16.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-kappa.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kakadu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sku16.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sku272.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts =
b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
> new file mode 100644
> index 000000000000..b3f46c16e5d7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi.dtsi"
> +
> +/ {
> +       model =3D "Google kappa board";
> +       compatible =3D "google,kappa", "mediatek,mt8183";
> +};
> +
> +&mt6358codec {
> +       mediatek,dmic-mode =3D <1>; /* one-wire */
> +};
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
