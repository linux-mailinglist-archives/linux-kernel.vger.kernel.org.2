Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAD3F432B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhHWBps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:45:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33168 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhHWBpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:45:46 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2F112A5;
        Mon, 23 Aug 2021 03:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629683104;
        bh=euWmE3CtpsP81m3SgrIa5KuUsrQe/fdxnN1qsqZYT/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3Xu+rRxHf0qqAY3Q+DKrcVIJ3GqYcvHs+iShYDLqmk9K1FxLOYvl5Xj7Bg6pNM3m
         eO7LDOZAQRqJ9qLmMxOwihC7hYklGcIjrt9lEj0dx9N3xBjnwSchu8ET4sgPUd9CA8
         isMjLz08Pn8LIDHfI6JmNC/24RwYk0OUTW2nZJoE=
Date:   Mon, 23 Aug 2021 04:44:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 6/6] phy: dt-bindings: cdns,dphy: add Rx DPHY
 compatible
Message-ID: <YSL9lkLB0wKk9sem@pendragon.ideasonboard.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-7-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820190346.18550-7-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Sat, Aug 21, 2021 at 12:33:46AM +0530, Pratyush Yadav wrote:
> The DPHY is treated to be in Tx mode by default. Add a new compatible
> for Rx mode DPHYs.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v4:
> - New in v4.
> 
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index d5a5e1f0b671..48b6a841152e 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -11,8 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - const: cdns,dphy
> +      - const: cdns,dphy-rx

It's customary to use an enum instead:

  compatibles:
    enum:
      - cdns,dphy
      - cdns,dphy-tx

I don't know if Rob has a preference for consistency (or for any other
reason). In either case,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>    reg:
>      maxItems: 1

-- 
Regards,

Laurent Pinchart
