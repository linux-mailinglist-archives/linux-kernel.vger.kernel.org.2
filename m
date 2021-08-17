Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E313EF321
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhHQUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:12:43 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:34597 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhHQUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:12:42 -0400
Received: by mail-oo1-f48.google.com with SMTP id w2-20020a4a9e420000b02902859adadf0fso19594ook.1;
        Tue, 17 Aug 2021 13:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Y8O/ugVUGd/pj+YpwBoilPPzVox4p1gBlgEBXz9RZM=;
        b=bXELBVzvCmhHbk7kR+ucuj94SMpL6ZOgWO4jptH/EMr1JRuh17woH1yQKItto1pe3o
         iyddKeOUdhv54vQTcQmV6mw/CaVpw+lTHbEzARunZgUfbmPG1XQvnY02HA4HiXa62kaa
         vs6aPOyiK1jNV77XZj6AQqO3AsSAhVDuASLHBjwOV8ZWG/yxZKu1J1ujCFPm6dBb9Ffb
         xxa8K11Eto1hBKGH0/8mpZ/zBQCs9YanoJzJVQmPljToz/1+wKjP4ptUGmEUT/OejkNB
         vg+XXHRX2olAzv92t05VBHwykENODxJj6STl5Yuhz/kZpZa+WVYCdvoXVXKbJuCH+sfz
         GgvA==
X-Gm-Message-State: AOAM531NcAuKcWg2WR98IVKQ0kkAfi/J+BU7Xqvj7WzYQ7vWeipGEMpE
        eDbJZ1ZK7ma/JGNGRG2wUw==
X-Google-Smtp-Source: ABdhPJzXi2Qb6T0n6M6hziTxPBlA6ZUr+4xKRXs2HwFfG0DIibNMEo5wtI0feqdM1bdl918jWY2pRQ==
X-Received: by 2002:a4a:d5d0:: with SMTP id a16mr3910689oot.18.1629231128239;
        Tue, 17 Aug 2021 13:12:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i188sm708832oih.7.2021.08.17.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:12:07 -0700 (PDT)
Received: (nullmailer pid 762404 invoked by uid 1000);
        Tue, 17 Aug 2021 20:12:06 -0000
Date:   Tue, 17 Aug 2021 15:12:06 -0500
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
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH v3 02/13] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <YRwYFtVlNjxyRwX+@robh.at.kernel.org>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
 <20210810080859.29511-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810080859.29511-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 04:08:48PM +0800, Yong Wu wrote:
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
> its smi-common. meanwhile the sub-common only has one gals clock.
> 
> Additionally, add a new property "mediatek,smi_sub_common" for this
> sub-common, this is needed in the IOMMU driver in which we create a device
> link between smi-common and the IOMMU device. If we add the smi-sub-common
> here, the IOMMU driver still need to find the smi-common device. thus,
> add this bool property to indicate if it is sub-common.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note:
> a. change mediatek, smi type from phandle-array to phandle from Rob.
> b. Add a new bool property (mediatek,smi_sub_common) to indicate this is
>    smi-sub-common. the reason is as above.
> ---
>  .../mediatek,smi-common.yaml                  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 602592b6c3f5..26bb9903864b 100644
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
> @@ -67,6 +68,14 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the smi-common node above. Only for sub-common.
> +
> +  mediatek,smi_sub_common:

s/_/-/

> +    type: boolean
> +    description: Indicate if this is smi-sub-common.
> +
>  required:
>    - compatible
>    - reg
> @@ -93,6 +102,27 @@ allOf:
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
> +        - mediatek,smi_sub_common
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

If not allowed for other compatibles, you need:

else:
  properties:
    mediatek,sni: false
    mediatek,smi_sub_common: false


> +
>    - if:  # for gen2 HW that have gals
>        properties:
>          compatible:
> -- 
> 2.18.0
> 
> 
