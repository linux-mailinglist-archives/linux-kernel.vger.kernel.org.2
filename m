Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7A3D1C20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhGVCMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:12:30 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:42698 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGVCM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:12:29 -0400
Received: by mail-il1-f177.google.com with SMTP id m20so4098685ili.9;
        Wed, 21 Jul 2021 19:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82O9pxHs2phuaInzl9cox8me6UL28Nm2JehOPgfRTdU=;
        b=hyAfNkrA5cirR5zSaTOB5LifoeXSldbsmJqUEsAjuGF7FAZkRZv3/fpCIpuY8Ihe6+
         o/FNdoxJR68UtQc6tJI9BFeF+rkLCLWH33gJ/tW1BC6bvtQ36lbz3dPLWQdzsQrPHO7Z
         QWGXCIecBVMf8SW87GJ2k97pskdb3yIMPKfOeoFbUV2QMZWoX0SGdbuJDyDK3I9jRqWV
         hku1Ri3xcBShajAHttO22v9SM/oZi/5YETIAu7GvMtbJqUbhnIexD4DJKPw3e6L8V1jY
         QcNnksYeiTlv4rzKDm0w620XgYtfg66H7K+hxF40DQiKpM1w+iyYregsOjYjfvygMARh
         FIlA==
X-Gm-Message-State: AOAM53245cTA1A6r0pRYzEZirX3BQQ2fkkRn2bCdXpG7g3IEZWKDw/6W
        dYhtz7xvUuhxOl9x5XD06Q==
X-Google-Smtp-Source: ABdhPJyn11/pSzoHtQk9aFg6OthLDc/3e1S3UHr3amy1RP5ecpQGjtAMSWqcQHWLLIfasZwcFAYIZQ==
X-Received: by 2002:a92:c805:: with SMTP id v5mr24196570iln.293.1626922384270;
        Wed, 21 Jul 2021 19:53:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i5sm14559011ilc.16.2021.07.21.19.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:53:03 -0700 (PDT)
Received: (nullmailer pid 3205958 invoked by uid 1000);
        Thu, 22 Jul 2021 02:53:01 -0000
Date:   Wed, 21 Jul 2021 20:53:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
Subject: Re: [PATCH v2 02/11] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <20210722025301.GA3204448@robh.at.kernel.org>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715121209.31024-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 08:12:00PM +0800, Yong Wu wrote:
> Add the binding for smi-sub-common. The SMI block diagram like this:
> 
>         IOMMU
>          |  |
>       smi-common
>   ------------------
>   |      ....      |
>  larb0           larb7   <-max is 8
> 
> The smi-common connects with smi-larb and IOMMU. The maximum larbs number
> that connects with a smi-common is 8. If the engines number is over 8,
> sometimes we use a smi-sub-common which is nearly same with smi-common.
> It supports up to 8 input and 1 output(smi-common has 2 output)
> 
> Something like:
> 
>         IOMMU
>          |  |
>       smi-common
>   ---------------------
>   |      |          ...
> larb0  sub-common   ...   <-max is 8
>       -----------
>        |    |    ...   <-max is 8 too.
>      larb2 larb5
> 
> We don't need extra SW setting for smi-sub-common, only the sub-common has
> special clocks need to enable when the engines access dram.
> 
> If it is sub-common, it should have a "mediatek,smi" phandle to point to
> its smi-common. meanwhile, the sub-common only has one gals clock.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 602592b6c3f5..f79d99ebc440 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -38,6 +38,7 @@ properties:
>            - mediatek,mt8192-smi-common
>            - mediatek,mt8195-smi-common-vdo
>            - mediatek,mt8195-smi-common-vpp
> +          - mediatek,mt8195-smi-sub-common
>  
>        - description: for mt7623
>          items:
> @@ -67,6 +68,10 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

If only a phandle, then s/phandle-array/phandle/

> +    description: a phandle to the smi-common node above. Only for sub-common.
> +
>  required:
>    - compatible
>    - reg
> @@ -93,6 +98,26 @@ allOf:
>              - const: smi
>              - const: async
>  
> +  - if:  # only for sub common
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-smi-sub-common
> +    then:
> +      required:
> +        - mediatek,smi
> +      properties:
> +        clock:
> +          items:
> +            minItems: 3
> +            maxItems: 3
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals0
> +
>    - if:  # for gen2 HW that have gals
>        properties:
>          compatible:
> -- 
> 2.18.0
> 
> 
