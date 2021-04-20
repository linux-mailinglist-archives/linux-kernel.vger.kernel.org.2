Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5173F36518B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 06:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhDTEep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 00:34:45 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34790 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTEem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 00:34:42 -0400
Received: by mail-oi1-f178.google.com with SMTP id k18so32829797oik.1;
        Mon, 19 Apr 2021 21:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qq8dgtGJwrS7fKasipW8Urc+VaRmsOcPysIaaEEznk=;
        b=C37uCDsGjwa7puQ7LloX15GHytqOKEYLsuUETj9DwGmUvxVQwZb6mEt2jRtwwSUJmE
         ier9FoILlIY+zsNZL4NlpnNs6Nvq/iueX5R5muBNbXeUT27mFoDqFrCUSPvMok6Ly1ER
         dSSCzjVloX23rZZAs/+Vm+H+bm2W67uxX6B4BQhyYLkhgANpRFATK3AapM7RIsNMaBPU
         7/TpRPhhwJhPaLq0g7z8ntP86q3D/LhnAHUpYvAgy+9caPL4Czj4jG4lN1ZVTscSsaZm
         9CRxiG9ga8s6z1LWw87PGiDyWsiASCVLyxk7ICAKucMEXVaeJ2j+IDMEUTYm/H2HN4Ey
         RtVw==
X-Gm-Message-State: AOAM533wdgSlaXFMUOyia5aOquTzLj59Kwh2O14ENB5rMWzdqsBfJpv2
        iX0hDW0k96UgsoJbP7swyHaqMjfH85A=
X-Google-Smtp-Source: ABdhPJwxBQ/0nWO04t3JGQp5NWR6VdNPU11Xmuj2p7yK4kjZI5Fm4cVDPzNYb5IKEFNuqDF6I4BPoA==
X-Received: by 2002:a54:470e:: with SMTP id k14mr1665713oik.151.1618893251487;
        Mon, 19 Apr 2021 21:34:11 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id s7sm1342142oij.15.2021.04.19.21.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 21:34:10 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so34723299otn.1;
        Mon, 19 Apr 2021 21:34:10 -0700 (PDT)
X-Received: by 2002:a9d:19c7:: with SMTP id k65mr17387755otk.221.1618893250401;
 Mon, 19 Apr 2021 21:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
In-Reply-To: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 19 Apr 2021 23:33:58 -0500
X-Gmail-Original-Message-ID: <CADRPPNSdDU-G-sLe8j27Rmd923jSWKirRdYS9qzZMHotsMuKCQ@mail.gmail.com>
Message-ID: <CADRPPNSdDU-G-sLe8j27Rmd923jSWKirRdYS9qzZMHotsMuKCQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1028a-rdb: enable optee node
To:     Sahil Malhotra <sahil.malhotra@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 9:53 AM Sahil Malhotra
<sahil.malhotra@oss.nxp.com> wrote:
>
> From: Sahil Malhotra <sahil.malhotra@nxp.com>
>
> optee node was disabled by default, enabling it for ls1028a-rdb.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 41ae6e7675ba..1bdf0104d492 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -274,6 +274,10 @@
>         status = "okay";
>  };
>
> +&optee {
> +       status = "okay";
> +};
> +
>  &sai4 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 262fbad8f0ec..fb155ac192b1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -92,7 +92,7 @@
>         };
>
>         firmware {
> -               optee {
> +               optee: optee  {
>                         compatible = "linaro,optee-tz";
>                         method = "smc";
>                         status = "disabled";
> --
> 2.17.1
>
