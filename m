Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5941345DE94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356408AbhKYQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhKYQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:22:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF5C0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:08:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l16so12676206wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BBIjRQcQTe/p8MPuV8+84d+JQi/ynOVnTogY5pdUch4=;
        b=U5U0b+/ziFIlFc/ux3ZoOEDrb8zzXm42loeB46lAIDLcsnt8g6LWZdNab9N8LgYlBs
         L2mRETMzguDlzF40i7NiRt7NjZuiBifM2pDWQRDEHu/u6BhpIYjfFvSPeGIPTvoe6JBC
         MksqgkSQoO3GHgQTEW4TYyslTwW6c2ieEypd6eiUTfOaAJsQotX2Ec6VSsM0qH9g0sDq
         dA2AbPP3uBCQRuL5gelcz6ZFqlqJgVbKAnIeQZX2KkK7uqcclGI6+bPHg7ItfYie/Gf9
         3yq6kV28i+vJ4C8D1fR+x82AGaUYttYQOL1pBf19OiLJE6pGTrtxUY61ixIQIfnZI8bU
         BoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BBIjRQcQTe/p8MPuV8+84d+JQi/ynOVnTogY5pdUch4=;
        b=8DEFw90mGViNELPeixyIRVrKvuBtmEyguH1iHMmxIb3D1lejGx3FI9bzG+Wl8Cf9jL
         yENVFm+2DuLoUbk7T6q4DL+G9M7zHvF17ACDib1yJEg5M3DJkX25eFmPztamDJpUk+WR
         4OiODvgTiPnVrDihUcTTdCXor1GuQRqCF2IjcqzVE+TwRpEVhyadSUeOXBZYK5QIxWPV
         ZyJWdDw2Qbv0ebQc1USjhOZsvybfMuNirAO/d3yklodBX9sql4dDFOagGjUlzZLyHU+F
         7wqXMBU3rxdSlMo5goy3abMkP0agZikGMNXXWUn8vwRKXBY+AHtb1Re8adwNsiF6wxT+
         L6Kg==
X-Gm-Message-State: AOAM532joroM4H+0hjNZEsbihokwAHk50HU9YzpHtkc/WnD8bRjtIdl1
        BwsglJ4mWKWUmB6nBej3VysG6w==
X-Google-Smtp-Source: ABdhPJxkfPB4Sn6d4awiD0RuzY3zDfpzeOlG0sL9DlrmFmkTSBbPNNh9f/BRCMQorDtbL8Bv6xl9lA==
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr7622120wrm.535.1637856484276;
        Thu, 25 Nov 2021 08:08:04 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id l15sm3313235wme.47.2021.11.25.08.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:08:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive, plic: Fix
 number of interrupts
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20211125152233.162868-1-geert@linux-m68k.org>
Date:   Thu, 25 Nov 2021 16:08:03 +0000
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <161F972E-7972-4001-BE19-C88F81EF8047@jrtc27.com>
References: <20211125152233.162868-1-geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2021, at 15:22, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> To improve human readability and enable automatic validation, the =
tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.  As the DT bindings lack an upper bound on the number of
> interrupts, thus assuming one, proper grouping is currently flagged as
> an error.
>=20
> Fix this by adding the missing "maxItems", limiting it to 9 interrupts
> (one interrupt for a system management core, and two interrupts per =
core
> for other cores), which should be sufficient for now.

This is SiFive=E2=80=99s IP, so is this actually true? I would imagine =
it=E2=80=99s
just parameterised and could be generated with as many targets as fit
in the MMIO space, and that this is thus inaccurate. Besides, such a
function change should be made separately from the grouping change.

The same goes for your equivalent sifive,clint0 patch.

Jess

> Group the tuples in the example.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git =
a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0=
.yaml =
b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0=
.yaml
> index 08d5a57ce00ff446..198b373f984f3438 100644
> --- =
a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0=
.yaml
> +++ =
b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0=
.yaml
> @@ -61,6 +61,7 @@ properties:
>=20
>   interrupts-extended:
>     minItems: 1
> +    maxItems: 9
>     description:
>       Specifies which contexts are connected to the PLIC, with "-1" =
specifying
>       that a context is not present. Each node pointed to should be a
> @@ -89,12 +90,11 @@ examples:
>       #interrupt-cells =3D <1>;
>       compatible =3D "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
>       interrupt-controller;
> -      interrupts-extended =3D <
> -        &cpu0_intc 11
> -        &cpu1_intc 11 &cpu1_intc 9
> -        &cpu2_intc 11 &cpu2_intc 9
> -        &cpu3_intc 11 &cpu3_intc 9
> -        &cpu4_intc 11 &cpu4_intc 9>;
> +      interrupts-extended =3D <&cpu0_intc 11>,
> +                            <&cpu1_intc 11>, <&cpu1_intc 9>,
> +                            <&cpu2_intc 11>, <&cpu2_intc 9>,
> +                            <&cpu3_intc 11>, <&cpu3_intc 9>,
> +                            <&cpu4_intc 11>, <&cpu4_intc 9>;
>       reg =3D <0xc000000 0x4000000>;
>       riscv,ndev =3D <10>;
>     };
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

