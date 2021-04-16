Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090623619AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhDPGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbhDPGCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:02:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00CC061574;
        Thu, 15 Apr 2021 23:01:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so24788442otb.7;
        Thu, 15 Apr 2021 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T4qHEDweevzaKk+/Z7BMChCVb0eziZLwAYSXDX8BD/Q=;
        b=gBtm9gxXcMOgIUXbqx9Dano+Ty2CSlmYq4jCAqzvhb1V2WUOeAi2V50ECrk7ENP0Z3
         xoeNLkQH/VzHK4wZrI4yAaNTOOKF29SCeox3B1+9t4oSKKPoOGjsm1ljGPj8qlZt67EZ
         Tty/xNjM/PInqfCa9P//rKTFG6JUCZOsyyfmMMNPVctirKlbX8ob0u2PUcPoMqn+Ydzd
         9Wga1CdYoNE/ROSpb/g6yj32I4nMh4KP4CSXn2pcu9Sj1/C0L4KFb5FbCFpLP/zY5bVX
         FbDUD8iOC/JhlJrIqaqkwbvcK/vZo5m0BByG0QSg6vjdtJ2s/3Or9LGRdtBPQXrhdf58
         ov8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T4qHEDweevzaKk+/Z7BMChCVb0eziZLwAYSXDX8BD/Q=;
        b=A3RG8aE7Nbn/LzFta0obYzhsK6cFVW9KQ1YnK2nLxsNb74/Tca+ioKtMWfyWLaOvVK
         nTkwznXaklc80Z/P+XOF6RLyP2ygZKZqJw/iekZ340R8mpLo8qAKdpS6S0q57BXMBsfA
         cIeHbcTcjQPilAYGmEPJ/EZHYszEyp9/whVjWMLB+67MvDGYN20J79rnQvpF9OT/cpOP
         t7sI3CXKsT41UhxHryj163fa7KnzS9o8jmJIlRryD+bebLwtdgtmypmn4pQey+f/MyKS
         CquG38R7UYCU/VI8NVDulEkmV6CojaAYkFF3q9tnlWH7Kr/0EP5YCZyt0IwJhaXW+jmr
         75eg==
X-Gm-Message-State: AOAM530JR3fL8Yg8ywms2Pz2GSyVXgtNh/aFsOfD7bTfXNYW9DdgQuXb
        hxs+1RrGhf7oP4q2EJ/onZnqQvtxN0fFxiC/Z4A=
X-Google-Smtp-Source: ABdhPJyKhobAkSPrF0bBE94D2OcYfN/PyYnWg2+xNPQ+k2AGgT/bPjH/3M5KcyXX5guT86pQU+koBSKDN7y/XH2ctlQ=
X-Received: by 2002:a05:6830:15d0:: with SMTP id j16mr2509358otr.184.1618552906846;
 Thu, 15 Apr 2021 23:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-8-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-8-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 08:01:38 +0200
Message-ID: <CAFqH_53t4Y-D2tvi7yySc04VeJrYQWBFtVE7ZipHvpwPN-Zy6g@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
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
2021 a les 11:37:
>
> Kenzo is known as Acer Chromebook 311.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/Makefile                |  1 +
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-ken=
zo.dts
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index b33d0bc58021..25770d83059d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-b=
urnet.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-damu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-juniper-sku16.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-kappa.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-kenzo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-willow-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-willow-sku1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kakadu.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts =
b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
> new file mode 100644
> index 000000000000..6f1aa692753a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi-juniper.dtsi"
> +
> +/ {
> +       model =3D "Google kenzo sku17 board";
> +       compatible =3D "google,juniper-sku17", "google,juniper", "mediate=
k,mt8183";
> +};
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
