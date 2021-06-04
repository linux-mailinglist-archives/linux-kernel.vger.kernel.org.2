Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFE39B10B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFDDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:43:39 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39924 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDDng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:43:36 -0400
Received: by mail-oi1-f181.google.com with SMTP id m137so4606423oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXrwn8O7Z9ra0HSXrktp1Pf6RqZk04u/zgrpbaACAm8=;
        b=nu4CkeZLjtParnluQs2D85/oiP8BC4dC3lLEdgDCmuPqmOoDjtnbi5bZ2kX+cTNrdP
         5vJhubTFFMdk3K3XsKuYpd5XKB9OQ4UOqliuEXAqHBZyenB3qS1qpC19sZUDpCtDyemt
         k2Fzh60Ct3oOhXi1kPsoomYf1tzWiVESNrgSWAAWggyNKEhGOXvUFp8l8U4OvALmiXR9
         l3OpdE5s7u9lg9XVAx/D29OLWmfhnOd7zF8mRJ5BXubvtk+Ryd3xuy5hkvyoXVO5qt/9
         9W/lNpgI5zyjsmhiNS3uor2pqoAQrqYq3qsR0T8lZLk5/FqabuEMTxnl0G+DE5lUflPD
         xfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXrwn8O7Z9ra0HSXrktp1Pf6RqZk04u/zgrpbaACAm8=;
        b=qK3TT03ikWn8/kt/FySZQeGhO5IycIl/SzP0Xx2SaIFoS7RipGapjRc/V1nizON5tk
         +CVqZHaV8fRbd5NhX1QtiGTDQbfYbN51sRYXm6fYVobHrjCjPT9I8QaP/O69q3mMCjLh
         fAsoGU/uDEbuN2PAUcvvHEFd9HBWVRhrMU61kwhFZWrTPeWZ2N7JFKtmApR+hH6U7nUg
         sqTwWj3D4bxF3P4eCjkt6TWNsQ6W6qw8w8BSy+YiUaRs1M4VfohviS1X56ZQOvjKw4Xx
         ie7JpInqDYr72kO3gKS32FETKafTNvhMgoYW0ZfR8ofPSaeZcTlsemAUmZz4WrzT9S2W
         NaaA==
X-Gm-Message-State: AOAM5331jI71baIcLRAZzTchPlgIrZhxPXuGt4LkcxaKueNt9r2WPFiN
        pn64a90QWxm4Z4VyPX5HI4D7gFfbmtn5+YRWt8zXyQ==
X-Google-Smtp-Source: ABdhPJwCHeBEjD6JOd6thCiBXSp5CBpsWnXuTWBq89AVfaa1FU5pUZuP18t0YuywoLXf90lWSCMJTdIGpysTNi5zd+Y=
X-Received: by 2002:a05:6808:f0b:: with SMTP id m11mr9216942oiw.12.1622778038637;
 Thu, 03 Jun 2021 20:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org> <YKdqd6nreHwCV3te@gerhold.net>
In-Reply-To: <YKdqd6nreHwCV3te@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 4 Jun 2021 09:10:27 +0530
Message-ID: <CAH=2NtxxWx4BWhQ5YEkxKaCnD6qBgfbJm2TBdXH0AAzr+_O2EA@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Thanks for the review.

On Fri, 21 May 2021 at 13:41, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi,
>
> On Wed, May 19, 2021 at 08:06:44PM +0530, Bhupesh Sharma wrote:
> > Convert Qualcomm BAM DMA devicetree binding to YAML.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
> >  .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
> >  2 files changed, 91 insertions(+), 50 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > deleted file mode 100644
> > index cf5b9e44432c..000000000000
> > --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > +++ /dev/null
> > @@ -1,50 +0,0 @@
> > -QCOM BAM DMA controller
> > -
> > -Required properties:
> > -- compatible: must be one of the following:
> > - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> > - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> > - * "qcom,bam-v1.7.0" for MSM8916
> > -- reg: Address range for DMA registers
> > -- interrupts: Should contain the one interrupt shared by all channels
> > -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> > -  represents the channel number
> > -- clocks: required clock
> > -- clock-names: must contain "bam_clk" entry
> > -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> > -  the secure world.
> > -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> > -  remote proccessor i.e. execution environment.
> > -- num-channels : optional, indicates supported number of DMA channels in a
> > -  remotely controlled bam.
> > -- qcom,num-ees : optional, indicates supported number of Execution Environments
> > -  in a remotely controlled bam.
> > -
> > -Example:
> > -
> > -     uart-bam: dma@f9984000 = {
> > -             compatible = "qcom,bam-v1.4.0";
> > -             reg = <0xf9984000 0x15000>;
> > -             interrupts = <0 94 0>;
> > -             clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > -             clock-names = "bam_clk";
> > -             #dma-cells = <1>;
> > -             qcom,ee = <0>;
> > -     };
> > -
> > -DMA clients must use the format described in the dma.txt file, using a two cell
> > -specifier for each channel.
> > -
> > -Example:
> > -     serial@f991e000 {
> > -             compatible = "qcom,msm-uart";
> > -             reg = <0xf991e000 0x1000>
> > -                     <0xf9944000 0x19000>;
> > -             interrupts = <0 108 0>;
> > -             clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> > -                     <&gcc GCC_BLSP1_AHB_CLK>;
> > -             clock-names = "core", "iface";
> > -
> > -             dmas = <&uart-bam 0>, <&uart-bam 1>;
> > -             dma-names = "rx", "tx";
> > -     };
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > new file mode 100644
> > index 000000000000..173e4d7508a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QCOM BAM DMA controller binding
> > +
> > +maintainers:
> > +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > +
> > +description: |
> > +  This document defines the binding for the BAM DMA controller
> > +  found on Qualcomm parts.
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,bam-v1.4.0
> > +      - qcom,bam-v1.3.0
> > +      - qcom,bam-v1.7.0
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Address range of the DMA registers.
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  clock-names:
> > +    const: bam_clk
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Single interrupt line shared by all channels.
> > +
> > +  num-channels:
> > +    maxItems: 31
>
> maxItems doesn't seem right here, since num-channels isn't an array.
> Perhaps you meant maximum: 31?
>
> Can you check your bindings on the existing device trees with
> "make dtbs_check" and make sure that only reasonable errors remain?
>
> This fails on pretty much every device tree:
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: num-channels: [[31]] is too short
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

I did run "make dtbs_check" and I don't remember seeing the issues you reported.
Hmm.. maybe I missed something. Let me recheck and fix issues in v4.

> > +    description: |
> > +      Indicates supported number of DMA channels in a remotely controlled bam.
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +    description: The single cell represents the channel index.
> > +
> > +  qcom,ee:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Indicates the active Execution Environment identifier (0-7)
> > +      used in the secure world.
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
>
> bam_dma.c reads this as uint32 and all existing device tree specify it
> as uint32. I don't think adding the /bits/ 8 to all existing device
> trees is really worth it.
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: qcom,ee: missing size tag in [[1]]
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

Ok.

> > +  qcom,controlled-remotely:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the bam is controlled by remote proccessor i.e.
> > +      execution environment.
> > +
> > +  qcom,num-ees:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Indicates supported number of Execution Environments in a
> > +      remotely controlled bam.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
>
> clocks is often missing if qcom,controlled-remotely is set, e.g.
>
>                 slimbam: dma-controller@9184000 {
>                         compatible = "qcom,bam-v1.7.0";
>                         qcom,controlled-remotely;
>                         reg = <0x09184000 0x32000>;
>                         num-channels  = <31>;
>                         interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
>                         #dma-cells = <1>;
>                         qcom,ee = <1>;
>                         qcom,num-ees = <2>;
>                 };
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clocks' is a required property
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clock-names' is a required property
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
>
> You might be able to encode this with an if: statement (clocks required
> if qcom,controlled-remotely not specified), not sure.

Ok.

Thanks,
Bhupesh
