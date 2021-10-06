Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01138423DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhJFMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhJFMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:32:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48D0C061749;
        Wed,  6 Oct 2021 05:30:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p11so9198922edy.10;
        Wed, 06 Oct 2021 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKN7bbXPKujDL93bouVpvZmMTNQ8NG449X3nPqVNjAc=;
        b=aNM7UlRdGILOk3gqQ8tOQ9Q6vYb2pl9JxpDFS5cRxnJQCSaYwuomlFPE7sOCAlMSak
         FkkKTgY1NS90EReRQi3+pwr3mTGZnw5u/y24iCMAYtMq8Jc3f640rIDtI7/2LQey50do
         z4mXbwXQSGJVu+A3qDH4A9BPKOPy5rt0xnaykO54lMfkizvzhpwOoWGYu+GVZyBQAIkr
         +LKzJFNprLfvpVz0Y8gw3VfuZrNX4L1spcYYinE2R9Kg+P4V8dJ9r8t9tbFYZWVnveap
         38GCNoNJRgR6oWJbOK8GTua2wCOiAzYb/SEeEoHLELEH03NOEYt4ICfWhZEKe32BWzd4
         krZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKN7bbXPKujDL93bouVpvZmMTNQ8NG449X3nPqVNjAc=;
        b=cwXHHypfNoUhR+rDa/rIpEURv27ZvuzVHA4yFVPGqY1Dy6szO8PfIbuc4/JAEoV4kH
         zhAwn6LXP5HvHOR2NS9pUurFCOTnYLgCH50KHt6QTx4IkXfI9oP6qta4SqTAOTd3L8vH
         5ThzKFXchOHZ4Otyv+4AUOFlOoa88jyx2Z7neYBrij6AcVuAsVSkRPHF2ZatRMWIIZbF
         LH01YI8XxFMwN7ZsQWNBu78vUm8kP73FLhmwExta8Y5fYCKC9bblb3Fo0jtLWTHKJDCd
         ysYurrs2YfV+x9HbyFU+vdCGae4/AvoUUPn94sp+3IOv6ek7ct+J3bUlRvW8RllmbGpN
         /LXw==
X-Gm-Message-State: AOAM533lmKSnF8OpzLTzhRpNIIu0ChChpoiDzDxzXumFciVkombY8heN
        Qkm4ukmVQErzuDPhkqRj0dbqg8s65pNnaE3ze1U=
X-Google-Smtp-Source: ABdhPJypPTN6oU8oGXhT/nOluV0DBhXexY/Yge12etQz4Quy84NrZhsw5/GFzgAoXQdv7WqiTwHMSe3tMRI0biuzTps=
X-Received: by 2002:a50:be81:: with SMTP id b1mr34813176edk.59.1633523427259;
 Wed, 06 Oct 2021 05:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211006000505.627334-1-aford173@gmail.com> <20211006000505.627334-2-aford173@gmail.com>
 <b5b80a0fafe6b774fe9d8bb9e1431960cf2e7330.camel@pengutronix.de>
In-Reply-To: <b5b80a0fafe6b774fe9d8bb9e1431960cf2e7330.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Oct 2021 07:30:15 -0500
Message-ID: <CAHCN7xJw6m4ArGXfnk67dBmqbAnEd6pRD+NsP701UMv0mWBZhA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 2:39 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Dienstag, dem 05.10.2021 um 19:04 -0500 schrieb Adam Ford:
> > This adds the DT binding for the i.MX8MN DISP blk-ctrl.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> > new file mode 100644
> > index 000000000000..92d30aff446e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mm-disp-blk-ctrl.yaml#
>
> mm -> mn in the file name.

Oops, I missed one.  Thanks for catching.
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX8MN DISP blk-ctrl
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
>
> I'm not opposed to being maintainer for this file, just making sure
> that this is what you intended.

Because this yaml file points to the driver you wrote, I thought it
made sense to have you be the maintainer.  In hindsight, I should have
asked first.  Sorry about that.

>
> Other than that I think this looks okay.

Thanks for reviewing the series.  I'll try to get a V2 prepared
tomorrow, and I'll wait a little bit to send it, just in case NXP
wants to give some feedback as well.

adam

>
> Regards,
> Lucas
>
> > +
> > +description:
> > +  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
> > +  the NoC and ensuring proper power sequencing of the display and MIPI CSI
> > +  peripherals located in the DISP domain of the SoC.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: fsl,imx8mn-disp-blk-ctrl
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  power-domains:
> > +    minItems: 5
> > +    maxItems: 5
> > +
> > +  power-domain-names:
> > +    items:
> > +      - const: bus
> > +      - const: isi
> > +      - const: lcdif
> > +      - const: mipi-dsi
> > +      - const: mipi-csi
> > +
> > +  clocks:
> > +    minItems: 11
> > +    maxItems: 11
> > +
> > +  clock-names:
> > +    items:
> > +      - const: disp_axi
> > +      - const: disp_apb
> > +      - const: disp_axi_root
> > +      - const: disp_apb_root
> > +      - const: lcdif-axi
> > +      - const: lcdif-apb
> > +      - const: lcdif-pix
> > +      - const: dsi-pclk
> > +      - const: dsi-ref
> > +      - const: csi-aclk
> > +      - const: csi-pclk
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-domains
> > +  - power-domain-names
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mn-clock.h>
> > +    #include <dt-bindings/power/imx8mn-power.h>
> > +
> > +    disp_blk_ctl: blk_ctrl@32e28000 {
> > +      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> > +      reg = <0x32e28000 0x100>;
> > +      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
> > +                    <&pgc_dispmix>, <&pgc_mipi>,
> > +                     <&pgc_mipi>;
> > +      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
> > +                         "mipi-csi";
> > +      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
> > +            <&clk IMX8MN_CLK_DISP_APB>,
> > +            <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > +            <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > +            <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > +            <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > +            <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> > +            <&clk IMX8MN_CLK_DSI_CORE>,
> > +            <&clk IMX8MN_CLK_DSI_PHY_REF>,
> > +            <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > +            <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
> > +       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
> > +                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
> > +                     "dsi-ref", "csi-aclk", "csi-pclk";
> > +       #power-domain-cells = <1>;
> > +    };
>
>
