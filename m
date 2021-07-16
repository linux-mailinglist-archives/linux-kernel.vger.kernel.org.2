Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8303CB37E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhGPHtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhGPHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:49:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC20C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:46:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v26so9599640iom.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwWxgkdAW3/KS/WFR7/3/xY5+SDGRuBv+QXp7L0Q0Jc=;
        b=b7VPouuaVZFV2I1xQmpob+1Hqg/StYVfW/pz9NWF/a3+T8/4J00vw2h9Arl+gk2dCq
         xUip6K9pfwy8/MQrvna8y8c4qldGM8QzomehwA9mLnNyGug2Mbbsb6jTkzcjk8RCS1AG
         P1VZZQRFKy2sqSjuW29XAXCC4iGIMvstLDaODMMf5apFzwby8A7oBlKVbuP/Qi3L1J5i
         x/bPX4p9mbYNBBeaTQOortsHa6Zd0Qp7RKI/nVVl+Lpl6rc9eh1QChtqem/ch9pylCYJ
         ICCxDTrSEa5cG3EcUEDbzeVi4NvTB7YIkRCGG+i5xVjxhZ0LL/FJZEP3aUgnaoV9LSn6
         MpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwWxgkdAW3/KS/WFR7/3/xY5+SDGRuBv+QXp7L0Q0Jc=;
        b=Padvp2HOe4xPLGDa0ZVFfahoEp9VK4w8n/76VQ/9E8B7JaLOBf4wuwhNA915PYRcPN
         LEhAmwYF5wCS8Fmthc+WZDKNKn9s2TQuf8/7T7t4ly5BHMyzqHPCe2zmwmHwqc/1i27F
         7QYxJSAb7p6pOfTzQ/RzCi9wVQ2eVM55sY7wF4y+6soXkmo4iCq0cuoOEQF3xg9kOqZo
         8+O3OJOzJ+560mbWr2KJF7bEOa/3ULKwJAqhRpX9Y6ZSNq262h8XsHR8uGw+5+W4o+WR
         b4c3aoIsWlze3BX6GmZx4nrmivE59zvq7GdiKjR9pCO0WcphJjPskEaqu/axxlGQ6atA
         iVcg==
X-Gm-Message-State: AOAM532hcqIe1eBOG2eUbRptms01IyGjr13BRm5iMYiYGVZIHETxkMkU
        DT7p71lFgTYjPOi8wj6KNAWkHaT2aduT1hnZAjIB9g==
X-Google-Smtp-Source: ABdhPJyzb04RlDtz8fruYXzmz4HTB1lgHoj+8WfjSm3y3QNBifOue2sUTRlKMFFyIt9KMpKVPlh9U4/0apYosBfVDDM=
X-Received: by 2002:a6b:6217:: with SMTP id f23mr6614522iog.173.1626421615310;
 Fri, 16 Jul 2021 00:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210715173750.10852-1-jason-jh.lin@mediatek.com> <20210715173750.10852-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20210715173750.10852-6-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@google.com>
Date:   Fri, 16 Jul 2021 15:46:19 +0800
Message-ID: <CAC=S1nhi0rLpQznvUP1FVNtEDzdffFG_aMO7j-w4fHBY8ceJnw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] dt-bindings: arm: mediatek: change mmsys txt to
 yaml file
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     chunkuang.hu@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nancy.lin@mediatek.com, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 1:48 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> Change mediatek,mmsys.txt to mediatek,mmsys.yaml
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  32 ------
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> deleted file mode 100644
> index 9712a6831fab..000000000000
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Mediatek mmsys controller
> -============================
> -
> -The Mediatek mmsys system controller provides clock control, routing control,
> -and miscellaneous control in mmsys partition.
> -
> -Required Properties:
> -
> -- compatible: Should be one of:
> -       - "mediatek,mt2701-mmsys", "syscon"
> -       - "mediatek,mt2712-mmsys", "syscon"
> -       - "mediatek,mt6765-mmsys", "syscon"
> -       - "mediatek,mt6779-mmsys", "syscon"
> -       - "mediatek,mt6797-mmsys", "syscon"
> -       - "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
> -       - "mediatek,mt8167-mmsys", "syscon"
> -       - "mediatek,mt8173-mmsys", "syscon"
> -       - "mediatek,mt8183-mmsys", "syscon"
> -       - "mediatek,mt8192-mmsys", "syscon"
> -- #clock-cells: Must be 1
> -
> -For the clock control, the mmsys controller uses the common clk binding from
> -Documentation/devicetree/bindings/clock/clock-bindings.txt
> -The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> -
> -Example:
> -
> -mmsys: syscon@14000000 {
> -       compatible = "mediatek,mt8173-mmsys", "syscon";
> -       reg = <0 0x14000000 0 0x1000>;
> -       #clock-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> new file mode 100644
> index 000000000000..ea31c7c2792c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mmsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek mmsys Controller Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jason-JH Lin <jason-jh.lin@mediatek.com>
> +
> +description: |
> +  The Mediatek mmsys system controller provides clock control, routing control,
> +  and miscellaneous control in mmsys partition.
> +
> +properties:
> +  compatible:
> +    description: |
> +      If the mmsys controller of different soc have the same function,
> +      you can use the same compatible name after it.
> +      For example, if the function of mt2701 mmsys controller is the same as syscon,
> +      then the compatible property could be set as:
> +      compatible = "mediatek,mt2701-mmsys", "syscon";
> +    oneOf:
> +      - items:
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-mmsys
> +              - mediatek,mt7623-mmsys
> +          - enum:
> +              - syscon

Not a yaml expert but I think it's:
  - items:
    - enum:
      - mediatek,mt7623-mmsys
    - enum:
      - mediatek,mt2701-mmsys
    - enum:
      - syscon

> +      - items:
> +          - enum:
> +              - mediatek,mt2712-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt6779-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt6797-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8167-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8173-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8183-mmsys
> +          - enum:
> +              - syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8192-mmsys
> +          - enum:
> +              - syscon

Just
  - enum:
    - mediatek,mt2712-mmsys
    ...
    - mediatek,mt8192-mmsys
  - enum:
    - syscon

Fei

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    description: |
> +      For the clock control, the mmsys controller uses the common clk binding from
> +      Documentation/devicetree/bindings/clock/clock-bindings.txt
> +      The available clocks are defined in dt-bindings/clock/mt*-clk.h
> +    const: 1
> +
> +  mboxes:
> +    description: |
> +      Client use mailbox to communicate with GCE, it should have this
> +      property and list of phandle with mailbox specifiers as defined in
> +      Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clocks-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    mmsys: syscon@14000000 {
> +        compatible = "mediatek,mt8173-mmsys", "syscon";
> +        reg = <0 0x14000000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +...
> --
> 2.18.0
