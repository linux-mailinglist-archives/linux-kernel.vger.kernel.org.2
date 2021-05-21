Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB238C603
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhEULxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:53:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhEULxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:53:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599081424;
        Fri, 21 May 2021 04:52:14 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7176F3F719;
        Fri, 21 May 2021 04:52:12 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] dt-bindings: iommu: rockchip: Add compatible for
 v2
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
 <20210521083637.3221304-3-benjamin.gaignard@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <40954168-ba5a-d152-2a24-441d5331f4ec@arm.com>
Date:   Fri, 21 May 2021 12:52:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521083637.3221304-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-21 09:36, Benjamin Gaignard wrote:
> Add compatible for the second version of IOMMU hardware block.
> RK356x IOMMU can also be link to a power domain.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 099fc2578b54..d2e28a9e3545 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -19,7 +19,9 @@ description: |+
>   
>   properties:
>     compatible:
> -    const: rockchip,iommu
> +    enum:
> +      - rockchip,iommu
> +      - rockchip,rk3568-iommu
>   
>     reg:
>       items:
> @@ -48,6 +50,9 @@ properties:
>     "#iommu-cells":
>       const: 0
>   
> +  power-domains:
> +    maxItems: 1
> +

Nit: power domains are already present on various IOMMU nodes since 
RK3288 - it feels like strictly this should be in patch #1 to fix the 
existing binding as part of the conversion, but on the other hand I 
can't really imagine anyone caring *that* much about dtscheck bisecting 
cleanly :)

Robin.

>     rockchip,disable-mmu-reset:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description: |
> 
