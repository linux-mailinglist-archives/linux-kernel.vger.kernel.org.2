Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9271B424ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhJFX7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:59:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54278 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhJFX7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:59:31 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AF2A9DC;
        Thu,  7 Oct 2021 01:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633564657;
        bh=JW1ZJmQaw12URJOf2jTrvvNj1ozcaCCwcpFlp8P5Qes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=veQCSLUacOalC5NvdCl05zLj6hzWsF4TTUOy3ceevPrOtLfDLP7XBVi3UayoDq2ON
         IdZSRQrFK7YHqQwf5kUpsAL687eW2OHtksp1L9Q5+gI3GvJEX+7S8Wz1tqWepJQGD7
         YDGoPeowEqryObzBxfMHzZ2avP7zxsqvMM9yWdgw=
Date:   Thu, 7 Oct 2021 02:57:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 4/6] phy: dt-bindings: cdns,dphy: make clocks optional
 for Rx mode
Message-ID: <YV436f5G7U/ZSCx8@pendragon.ideasonboard.com>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210902185543.18875-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Fri, Sep 03, 2021 at 12:25:41AM +0530, Pratyush Yadav wrote:
> The clocks are not used by the DPHY when used in Rx mode so make them
> optional for it by using a conditional based on compatible.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v5:
> - Make clocks a required property based on the compatible.
> 
> Changes in v3:
> - Add Rob's Ack.
> 
> Changes in v2:
> - Re-order subject prefixes.
> 
>  .../devicetree/bindings/phy/cdns,dphy.yaml          | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index b90a58773bf2..558f110fda9e 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -33,10 +33,19 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names
>    - "#phy-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: cdns,dphy
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +
>  additionalProperties: false
>  
>  examples:

-- 
Regards,

Laurent Pinchart
