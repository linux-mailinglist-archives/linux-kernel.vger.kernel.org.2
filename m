Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946DD3704B4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhEABfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:35:43 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:38678 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:35:41 -0400
Received: by mail-oo1-f42.google.com with SMTP id h9-20020a4a94090000b02901f9d4f64172so42190ooi.5;
        Fri, 30 Apr 2021 18:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUXpAoI/KzwgrARmWw+voeZ0INm/PtgvJecf6NLxWtI=;
        b=qRIsp7MuvqB7GdD9Svr4HhtBzg7AN2ecUDA+ATVmUqiqLwAuLXWZGolGElKOrxb4uu
         PaR8M925tqZu2tv/9rfcwldf83g/r4Ptk/zfcVgVKOokANg6aO1MnGtfZJ5lXZlBDN2P
         RqUeJwl9/B+1/jYxdWuwMqQDQ9/7tWIEElu4dVj6gpG4199Tqy48SOYZ7d94MCQCE7tm
         ao7hQmcN8fEYw5XM2kNad22k1YKtQ3JEGZnYaQNFOVV/C+3RMEkNLP5tUffhVyJqUln9
         vH9ZHQT83kimL7RpUKK8qlIMice9usaCetTlu7IfIuZSDoBtrVGp0Glut4xnBAdgvhYM
         YpPA==
X-Gm-Message-State: AOAM530YPEbResxXyc2HBzzFmn5orbtX0bMlxlKKr758i4FiUbDR4iCc
        IiqReLqIjMd7Yie0xDUp4bSTpfM2vg==
X-Google-Smtp-Source: ABdhPJxUbLnwv8w2KIA2KErjdTKoBtPoNxqe9/Doqh2tks/IILgB7WLqP++X9JxZZnzRy/SkywjjVw==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr6861569oou.44.1619832891658;
        Fri, 30 Apr 2021 18:34:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a23sm56732otf.47.2021.04.30.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 18:34:50 -0700 (PDT)
Received: (nullmailer pid 121538 invoked by uid 1000);
        Sat, 01 May 2021 01:34:48 -0000
Date:   Fri, 30 Apr 2021 20:34:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     joro@8bytes.org, will@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 2/4] dt-bindings: iommu: rockchip: Add compatible for
 v2
Message-ID: <20210501013448.GA4001859@robh.at.kernel.org>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
 <20210422141602.350746-3-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422141602.350746-3-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:16:00PM +0200, Benjamin Gaignard wrote:
> Add compatible for the second version of IOMMU hardware block.
> RK356x IOMMU can also be link to a power domain.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
>  - Add power-domains property
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 0db208cf724a..e54353ccd1ec 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -19,7 +19,9 @@ description: |+
>  
>  properties:
>    compatible:
> -    const: rockchip,iommu
> +    enum:
> +      - rockchip,iommu
> +      - rockchip,iommu-v2

This should be SoC specific.

>  
>    reg:
>      minItems: 1
> @@ -46,6 +48,9 @@ properties:
>    "#iommu-cells":
>      const: 0
>  
> +  power-domains:
> +    maxItems: 1
> +
>    rockchip,disable-mmu-reset:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: |
> -- 
> 2.25.1
> 
