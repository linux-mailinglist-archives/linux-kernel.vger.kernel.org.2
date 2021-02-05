Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358BA310870
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBEJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBEJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:46:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05930C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:45:45 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k193so6252183qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0FlvauPxI82lJp8jNkOhgq79rt6yfGv1K5PxDtLBQRg=;
        b=SJjIEqN+fAXUPvWNb4TqBr1kFjSDVRi9dpOpTeX8ViKkCaRS4TeNiraJModQFugQwc
         bD3tizzNKKTCZcLWTuXiQrzdt1SefwVfayL98KiXujC1Q8YEidcbHDMRrZgdw2vTzBKG
         j0uN4QiPMLMaKUuhvbDZKUNE9ny7GjV5AWsQ1GZR5mmuUDAs/RXQa9Zvg7oR4Go2tL5s
         mLqQlnJTjkhgtOqhTbUZN6G+FTQTwafcaGcEHFEqXrj3289UXbsmSWkAMAOw1umnCfoW
         7k9R2VvnDVb2fvnWBdoAL+RypoPIl+0bbQYU6UVZVv4wH/M63KM3l64GVmOCM0ixlEGf
         lU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0FlvauPxI82lJp8jNkOhgq79rt6yfGv1K5PxDtLBQRg=;
        b=KI73ZwYeOblOVZ01M2aEQcOl8m9LA3wEE21UtevWK+wrZ0iizMUnYcQUPTpzRrnY8k
         Jlx/ZB2Jtm4ZoJMCHjPhQ4lJWIB2A/7jrwB7mM1q7CaeIS4wLSP+zJXy2/w5LzqMRDdd
         o/nhA2HJkagDHsiKjOwFG0vWM04NdK9F0RSqZHPZZ/Dc3c1x6OXfnI1rYJETvjN6nbIJ
         95tn5irE0lioXYYTmSf3Q6R0EjyvLWJW5gTVl7L3+ZSbWYQh8Re+T5ljT8Lb/B6TAKrt
         UXEnI96aQ5xKdFH2ECChY8mIaP+hD+YHAS8hAhXdic7stRu4Vk0knH+Nd7fOXqqGnLTQ
         eYpg==
X-Gm-Message-State: AOAM5307ucMfite3cJI/cF7qUYyPR3Ph9ZfeefnhTomKAZkXEkVo62sn
        t65LBeggMO5YMtqza6DgXhavf9nsAMH0wd4tHHzo9g==
X-Google-Smtp-Source: ABdhPJxxmATRZtKOwg48ZhqL0MPxHUwiOYl7cBEJUhrGUaD7tMXIx/qXPPY2uuFsJAamMyhJf8dbADxPcXTfTfRciG8=
X-Received: by 2002:a05:620a:f96:: with SMTP id b22mr3257258qkn.295.1612518344222;
 Fri, 05 Feb 2021 01:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20210203133138.10754-1-kostap@marvell.com> <20210203133138.10754-10-kostap@marvell.com>
In-Reply-To: <20210203133138.10754-10-kostap@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 5 Feb 2021 10:45:32 +0100
Message-ID: <CAPv3WKcuOXdN4zRSaGm1RnaBaXLsCtuT7CRMBAPDFvnBL76oEw@mail.gmail.com>
Subject: Re: [PATCH 09/11] dts: a3700: enable dma coherence for PCIE interface
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com,
        Stefan Chulski <stefanc@marvell.com>,
        =?UTF-8?B?QmVuIFBlbGVkICjXkdefINek15zXkyk=?= <bpeled@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kosta,

=C5=9Br., 3 lut 2021 o 14:32 <kostap@marvell.com> napisa=C5=82(a):
>
> From: Stefan Chulski <stefanc@marvell.com>
>
> Enavble PCIe dma coherence for A3700 platform
>

While at it, can we also add:

--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -71,6 +71,7 @@ soc {
                compatible =3D "simple-bus";
                #address-cells =3D <2>;
                #size-cells =3D <2>;
+               dma-coherent;
                ranges;

                internal-regs@d0000000 {

so that to enable it for all bus-attached interfaces? This safe and
will boost IO performance.

Thanks,
Marcin

> Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index d5b6c0a1c54a..5c0df06bc707 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -486,6 +486,7 @@
>                         #interrupt-cells =3D <1>;
>                         msi-parent =3D <&pcie0>;
>                         msi-controller;
> +                       dma-coherent;
>                         ranges =3D <0x82000000 0 0xe8000000   0 0xe800000=
0 0 0x1000000 /* Port 0 MEM */
>                                   0x81000000 0 0xe9000000   0 0xe9000000 =
0 0x10000>; /* Port 0 IO*/
>                         interrupt-map-mask =3D <0 0 0 7>;
> --
> 2.17.1
>
