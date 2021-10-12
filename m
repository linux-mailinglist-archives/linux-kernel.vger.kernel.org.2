Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1345142A5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhJLNh7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Oct 2021 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhJLNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:37:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3DC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:35:55 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1maHwV-00025C-Sk; Tue, 12 Oct 2021 15:35:43 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1maHwV-0001ab-Ct; Tue, 12 Oct 2021 15:35:43 +0200
Message-ID: <91ae922d66b4b8c521142c8030bdd1a9f6d2fad1.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add lan966x support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, robh+dt@kernel.org,
        andrew@lunn.ch, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 12 Oct 2021 15:35:43 +0200
In-Reply-To: <20211012114238.2060101-2-horatiu.vultur@microchip.com>
References: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
         <20211012114238.2060101-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Tue, 2021-10-12 at 13:42 +0200, Horatiu Vultur wrote:
> This adds support for lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> index 370579aeeca1..622cf3d0455d 100644
> --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -20,7 +20,11 @@ properties:
>      pattern: "^reset-controller@[0-9a-f]+$"
>  
>    compatible:
> -    const: microchip,sparx5-switch-reset
> +    oneOf:
> +      - items:
> +          - const: microchip,sparx5-switch-reset
> +      - items:
> +          - const: microchip,lan966x-switch-reset
>  
>    reg:
>      items:
> @@ -37,6 +41,14 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description: syscon used to access CPU reset
>  
> +  cuphy-syscon:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: syscon used to access CuPHY
> +
> +  gpios:

From the description I'd expect this to be called phy-reset-gpios.

> +    description: used for release of reset of the external PHY
> +    maxItems: 1
> +

Shouldn't an external PHY be described as a separate DT node, with its
own reset gpio?

regards
Philipp
