Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B817C3CB247
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhGPGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhGPGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:18:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B96C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:15:25 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b14so7300571ilf.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5Nw9v5MsWaDurLBbY+BcDcL+BDdTyOKPRaT2ACYHvE=;
        b=NxJniVE/k/2wgZOeb9DWJ3Q0FQoJ3J2ABv8rVvc1ZmO9aAcbXoK9jx27ceGGQiumbv
         cdSp/TQ1f7VFlAWyC45NUiqmLnGXhRQ1MU4rjy2TKuUt49UbbTzRTF6ay7NLOjMktCxB
         +uew8FvbsmEzy2Yru8+aCbIgqdydQ4B3tKUO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5Nw9v5MsWaDurLBbY+BcDcL+BDdTyOKPRaT2ACYHvE=;
        b=URKJ15isJp9Bs/Efm6wDSLTHAhTYvvQPHQDjl7Wdi/p+KSv4KzECvP0xJM7ttqc9wd
         hsFGOaNX8VZfJe5/1KQdVqAr/18mbQGTqxsaavltA1Ja5WDIdf4z5EViejz6bTg8l+jw
         1VtBShjeECSWLcNTIeNRLt+b2Roz6gAGo504+/qpLTi/wJhhju6xEj0M0vwEttpwJVf3
         Q7+EFg3vu8VfJoRM3hBCfOQ3ChthZB5Z7Bwv/b0CTiVCVeqT8A9yMo0+n9a4YfC/z+qY
         V/KGU4QKdapjqH+hDMrA3opavLES9bMxQ9tq50XOOQJPFHun//btUUOkbJbcxewjDBro
         AeGg==
X-Gm-Message-State: AOAM531BjK5mSAL4F23Kr9pGu7pHPQ/LdZWpV3QJjmSwhffN9N0us4ym
        tibsD4R3QKRIT1N4bWSHsob9zxg9LuWDXg==
X-Google-Smtp-Source: ABdhPJzE7taZbNSPzMGJS3aCFUIreamEkAIAf6CVa3d+QsG7lJE2dBJoPJxdA3Uj2U6on7GS9+52eg==
X-Received: by 2002:a05:6e02:1208:: with SMTP id a8mr5284877ilq.257.1626416124534;
        Thu, 15 Jul 2021 23:15:24 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id a10sm4872461ioo.9.2021.07.15.23.15.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 23:15:23 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id b14so7300474ilf.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:15:22 -0700 (PDT)
X-Received: by 2002:a92:6902:: with SMTP id e2mr5481520ilc.275.1626416122431;
 Thu, 15 Jul 2021 23:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210715173750.10852-1-jason-jh.lin@mediatek.com> <20210715173750.10852-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20210715173750.10852-3-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 16 Jul 2021 14:14:46 +0800
X-Gmail-Original-Message-ID: <CAC=S1niC1WKQwJ44Y1hqOyRm4FrwRWbCUB+Z-eHoObP3hTFRtg@mail.gmail.com>
Message-ID: <CAC=S1niC1WKQwJ44Y1hqOyRm4FrwRWbCUB+Z-eHoObP3hTFRtg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] dt-bindings: mediatek: display: add definition
 for mt8195
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

On Fri, Jul 16, 2021 at 1:38 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> Add definition for mt8195 display.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.yaml   | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.yaml
> index 63a6bc975b29..910bb9ce61d6 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.yaml
> @@ -54,6 +54,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-ovl
> +              - mediatek,mt8195-disp-ovl
>            - enum:
>                - mediatek,mt8183-disp-ovl
>
> @@ -82,6 +83,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-rdma
> +              - mediatek,mt8195-disp-rdma

Make mediatek,mt8195-disp-rdma an individual item to align with the dts change.

>            - enum:
>                - mediatek,mt8183-disp-rdma
>
> @@ -95,6 +97,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-ccorr
> +              - mediatek,mt8195-disp-ccorr
>            - enum:
>                - mediatek,mt8183-disp-ccorr
>
> @@ -115,6 +118,7 @@ properties:
>            - enum:
>                - mediatek,mt8183-disp-color
>                - mediatek,mt8192-disp-color
> +              - mediatek,mt8195-disp-color
>            - enum:
>                - mediatek,mt8173-disp-color
>
> @@ -124,6 +128,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-dither
> +              - mediatek,mt8195-disp-dither
>            - enum:
>                - mediatek,mt8183-disp-dither
>
> @@ -135,6 +140,7 @@ properties:
>                - mediatek,mt2712-disp-aal
>                - mediatek,mt8183-disp-aal
>                - mediatek,mt8192-disp-aal
> +              - mediatek,mt8195-disp-aal
>            - enum:
>                - mediatek,mt8173-disp-aal
>
> @@ -146,10 +152,13 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-gamma
> +              - mediatek,mt8195-disp-gamma
>            - enum:
>                - mediatek,mt8183-disp-gamma
>
>        # MERGE: merge streams from two RDMA sources
> +      - items:
> +          - const: mediatek,mt8195-disp-merge
>
>        # POSTMASK: control round corner for display frame
>        - items:
> @@ -209,6 +218,7 @@ properties:
>            - const: mediatek,mt8183-disp-mutex
>        - items:
>            - const: mediatek,mt8192-disp-mutex
> +          - const: mediatek,mt8195-disp-mutex
>
>        # OD: overdrive
>        - items:
> @@ -234,7 +244,7 @@ properties:
>    mediatek,larb:
>      description: The compatible property should be one of DMA function blocks,
>        such as "mediatek,<chip>-disp-ovl", "mediatek,<chip>-disp-rdma" or
> -      "mediatek,<chip>-disp-wdma". The supported chips are mt2701, mt8167 and mt8173.
> +      "mediatek,<chip>-disp-wdma". The supported chips are mt2701, mt8167, mt8173 and mt8195.
>        Should contain a phandle pointing to the local arbiter device as defined in
>        Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml.
>        It must sort according to the local arbiter index, like larb0, larb1, larb2...
> @@ -245,7 +255,7 @@ properties:
>    iommus:
>      description: The compatible property should be one of DMA function blocks,
>        such as "mediatek,<chip>-disp-ovl", "mediatek,<chip>-disp-rdma" or
> -      "mediatek,<chip>-disp-wdma". The supported chips are mt2701, mt8167 and mt8173.
> +      "mediatek,<chip>-disp-wdma". The supported chips are mt2701, mt8167, mt8173 and mt8195.
>        Should point to the respective IOMMU block with master port as argument, see
>        Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
>
> --
> 2.18.0
