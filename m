Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4829B44FE86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhKOGDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhKOGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:03:45 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6FFC0613B9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:00:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so25566556otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0hjuIitrFb02fXcc+qwu0/Ao0P1TR8wWUugB4S5eBU=;
        b=EPYAkJSYsA8WdUmfCLmL+m364i7HEJTfI84eVqPuEmyhu8fQFa4trzbIRKLnh3I+O+
         1yI5rSDAJcF08/ZC1qms0z+OXm9HynWJ1Hjy0gE5ERSkW7up0sFoiyqBc6vASFWIX7ys
         dJgtJoWn5R01rWfdWmdG9WGXX3rMoGqVCRQxn5cs/WZY53TUBHJJVwZpvlk/5ZkJx03i
         2g/TdcIYIjl0JR3VZQ8PwaMDn2DcHM9yZqtTkfmkWadjKw1tXP23XlPDREdwtkthONYA
         e9ATGJimtIYN1SvS2i/As6uyhusLbtC50ejafJA0y4Kfz2cWinuqdxBMdlfRNeHGcF97
         4Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0hjuIitrFb02fXcc+qwu0/Ao0P1TR8wWUugB4S5eBU=;
        b=oNEThs3HCVfGxmGcbwYbSljyqslFvH/U65Kxuzj26Wvuhjv8TVFP7WmMNxTdu4V19J
         /eNO5DLJKpu0jJXhd844hXc3f2RAWwXCJDgb+VLz6zEDB0pMO5E5cGD0dxgqEfGcrvUM
         9ZUPUkePeacc9J/PgO4pUeZSFxKvPxkgdG8PwtImjvhek7LXhMZkGebTNlK13ZijR3h9
         9OCYf/oaG8O0gJSHxiswm5EAhUOp6mNQIzMT9gsr1/X5wkkkctd3Yd/Y5t3+z9mwCNEr
         cS6rE+f4t6PuQPAoBrerGxIj/icVRHGgAENnY1eyZzTpLwu2H4HfR3EnmXtNyRqBEW+M
         seyQ==
X-Gm-Message-State: AOAM533qj4OOkfY5MXurDDtQOJq19rDYBezyCXLNoQ0B9irAW0qNNe8U
        V0D7E6Ji6ppOmUIft734y+0VukLVMexFUvGuI0Pjqg==
X-Google-Smtp-Source: ABdhPJyUbpj16P4csxyRQ9MSohPpXCQmDqHM5JN8smKtj7SiicwjKN9ibLjXA6Pg7pY8eci39b32XWXEeV1kkXjBHfc=
X-Received: by 2002:a05:6830:44a1:: with SMTP id r33mr23418807otv.162.1636956049231;
 Sun, 14 Nov 2021 22:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-4-bhupesh.sharma@linaro.org> <dd8cfa0d-0128-84a9-b2e5-b994a2bbd4cf@linaro.org>
In-Reply-To: <dd8cfa0d-0128-84a9-b2e5-b994a2bbd4cf@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 15 Nov 2021 11:30:38 +0530
Message-ID: <CAH=2Ntw6N6kgMv125ALZ1J3F-Cd6jUaT_OEJJ=92+78=xhWbzA@mail.gmail.com>
Subject: Re: [PATCH v5 03/22] dt-bindings: qcom-bam: Convert binding to YAML
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, 12 Nov 2021 at 14:11, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> > Convert Qualcomm BAM DMA devicetree binding to YAML.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
> >   .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
> >   2 files changed, 91 insertions(+), 50 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> >   create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
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
> > index 000000000000..3ca222bd10bd
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
> > +      - qcom,bam-v1.3.0 # for APQ8064, IPQ8064 and MSM8960
> > +      - qcom,bam-v1.4.0 # for MSM8974, APQ8074 and APQ8084
> > +      - qcom,bam-v1.7.0 # for MSM8916
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: bam_clk
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 31
> > +
> > +  num-channels:
> > +    maximum: 31
> > +    description:
> > +      Indicates supported number of DMA channels in a remotely controlled bam.
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +    description: The single cell represents the channel index.
> > +
> > +  qcom,ee:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 7
> > +    description:
> > +      Indicates the active Execution Environment identifier (0-7)
> > +      used in the secure world.
> > +
> > +  qcom,controlled-remotely:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the bam is controlled by remote proccessor i.e.
> > +      execution environment.
> > +
> > +  qcom,num-ees:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 31
> > +    default: 2
> > +    description:
> > +      Indicates supported number of Execution Environments in a
> > +      remotely controlled bam.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +  - qcom,ee
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> > +    dma-controller@f9984000 {
> > +        compatible = "qcom,bam-v1.4.0";
> > +        reg = <0xf9984000 0x15000>;
> > +        interrupts = <0 94 0>;
> > +        clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > +        clock-names = "bam_clk";
> > +        #dma-cells = <1>;
> > +        qcom,ee = <0>;
> > +    };
> >
>
> this change should be rebased on top of the upstream commit 37aef53f5cc ("dt-bindings:
> dmaengine: bam_dma: Add "powered remotely" mode"), which adds 'qcom,powered-remotely'
> property description.

Indeed. Seems there was some confusion, as we had earlier agreed that
Stephan's change would be part of my v5 series (see [1]), but I see
that the change has anyway being picked up for Linus's tree (in the
.txt version of the bindings).

No problem, I will fix the same in v6.

[1]. https://www.spinics.net/lists/linux-arm-msm/msg97143.html

Regards,
Bhupesh
