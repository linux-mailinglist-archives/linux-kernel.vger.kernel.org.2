Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4F34AC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCZQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhCZQTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:19:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C7E61960;
        Fri, 26 Mar 2021 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616775552;
        bh=y5D7LKMF6UcIhdpmaKfS0zgbiEVj4Y3JfqsnPyf/1Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bC7tP8fqqvJksjeOZA/bvpau2ORDnVm6T+Ghgnq/d+84oyv9q7UzVbjFzjKDv31Hp
         nFRoxI4Hs+A1N9qOsRmKFAk2tEZRRNsubvtEEykhlNjjldI4ZN+sbWm1a4JVefBr5S
         RxsTUtIl37qdealoEl1QpqL8ABEgPqzDODqgFEShgxyzo7ccWdyeTOyU9tJFVRCqJO
         wEW8gvx1j4Dran84g591ebOpuyz+hVoJ2rO2RMHEyH+sKNr2IkQueFEr7iKnAxJiQt
         YUD0h5Zl1VOkR2A1BQL2Q5TgYM07DgQEjOYOgWktesZO/v7spNDmISNDmL//k9H7Q5
         ER3D62ZqWbSfQ==
Received: by mail-ed1-f46.google.com with SMTP id dm8so6976854edb.2;
        Fri, 26 Mar 2021 09:19:11 -0700 (PDT)
X-Gm-Message-State: AOAM531MFvKcTQQEel0TYikH4AX5HPFy/a3NaVfB3Nwk7JIZ75iLuWMg
        tAW61SOAnp4bWh6gFdRmaGOXV12YX3x/lAD7qQ==
X-Google-Smtp-Source: ABdhPJyRlcrMf7ezc1JD8+sAHdHx3wKfXOkh3fjCTx6BHGW8HdVAalI+CmlcwqgEDX3fwzOq2Y1wHWP2P1V7HPPThH0=
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr16022265eds.166.1616775550443;
 Fri, 26 Mar 2021 09:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
In-Reply-To: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 27 Mar 2021 00:18:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-8W57Pid9N9kJO0iBNkmRh_sSf_E3hzewxojZ3GAnG2w@mail.gmail.com>
Message-ID: <CAAOTY_-8W57Pid9N9kJO0iBNkmRh_sSf_E3hzewxojZ3GAnG2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
To:     Nina Wu <nina-cm.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Jackson-kt.Chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nina:

Nina Wu <nina-cm.wu@mediatek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
>
> To support newer hardware architecture of devapc,
> update device tree bindings.
>
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/devapc.yaml   | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b=
/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> index 31e4d3c..489f6a9 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -20,9 +20,27 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-devapc
> +      - mediatek,mt8192-devapc
> +
> +  version:
> +    description: The version of the hardware architecture
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    maxItems: 1
> +
> +  slave_type_num:
> +    description: The number of the devapc set
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 4]
> +    maxItems: 1
>
>    reg:
>      description: The base address of devapc register bank
> +    maxItems: 4
> +
> +  vio_idx_num:
> +    description: The number of the devices controlled by devapc
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      maxItems: 1
>
>    interrupts:
> @@ -39,7 +57,10 @@ properties:
>
>  required:
>    - compatible
> +  - version
> +  - slave_type_num
>    - reg
> +  - vio_idx_num
>    - interrupts
>    - clocks
>    - clock-names
> @@ -53,8 +74,28 @@ examples:
>
>      devapc: devapc@10207000 {
>        compatible =3D "mediatek,mt6779-devapc";
> +      version =3D <1>;

I think version is redundant. For example, if mt0001-devapc is
identical to mt6779-devapc, its compatible should be

compatible =3D "mediatek,mt0001-devapc", "mediatek,mt6779-devapc";

In driver, only keep compatible for mt6779 and no mt0001 because
mt0001 is identical to mt6779.
In probe sequence, try first compatible string
"mediatek,mt0001-devapc", but it does not exist in driver, so try next
compatible string "mediatek,mt6779-devapc" and match.
So mt0001-devapc would work as mt6779-devapc.

> +      slave_type_num =3D <1>;
>        reg =3D <0x10207000 0x1000>;
> +      vio_idx_num =3D <511>;
>        interrupts =3D <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
>        clocks =3D <&infracfg_ao CLK_INFRA_DEVICE_APC>;
>        clock-names =3D "devapc-infra-clock";
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +
> +    devapc: devapc@10207000 {
> +        compatible =3D "mediatek,mt8192-devapc";
> +        version =3D <2>;
> +        slave_type_num =3D <4>;
> +        reg =3D <0 0x10207000 0 0x1000>,
> +            <0 0x10274000 0 0x1000>,
> +            <0 0x10275000 0 0x1000>,
> +            <0 0x11020000 0 0x1000>;
> +        vio_idx_num =3D <367 292 242 58>;
> +        interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&infracfg_ao CLK_INFRA_DEVICE_APC>;
> +        clock-names =3D "devapc-infra-clock";
> +    };

It looks like that there are 4 devapc device in mt8192.
These 4 device work independently, so I would like to decouple them
rather than couple them.

devapc0: devapc@10207000 {
    compatible =3D "mediatek,mt8192-devapc";
    reg =3D <0 0x10207000 0 0x1000>;
    vio_idx_num =3D <367>;
    ...
};

devapc1: devapc@10274000 {
    compatible =3D "mediatek,mt8192-devapc";
    reg =3D <0 0x10274000 0 0x1000>;
    vio_idx_num =3D <292>;
    ...
};

devapc2: devapc@10275000 {
    compatible =3D "mediatek,mt8192-devapc";
    reg =3D <0 0x10275000 0 0x1000>;
    vio_idx_num =3D <242>;
    ...
};

devapc3: devapc@11020000 {
    compatible =3D "mediatek,mt8192-devapc";
    reg =3D <0 0x11020000 0 0x1000>;
    vio_idx_num =3D <58>;
    ...
};

Regards,
Chun-Kuang.

> --
> 2.6.4
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
