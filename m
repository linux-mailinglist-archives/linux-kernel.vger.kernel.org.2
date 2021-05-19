Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA50388448
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhESBTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:19:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhESBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:19:30 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F13A45E;
        Wed, 19 May 2021 03:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621387090;
        bh=w3br3R9b5YuogXvJ+4Md07rNPhvvQST+awL6ZItkg4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lb07uRx60fMPu5ms9sIytoW0ORUUV5fheREpobjjSIJe0OrFKSgOQBhEd17nudWhe
         QuwvuALY/bQxeEXjeSC/xnfH3Lt+w9VGRcoEUXp8MHdkm2iMtCwlPcTRomOrpgI6J2
         bjyifFCmqde8Uyf/vENl5mUahqgtnjlT41e0Wio4=
Date:   Wed, 19 May 2021 04:18:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: i2c: maxim,max9286: Use the
 i2c-mux.yaml schema
Message-ID: <YKRnUSASlUrmqvYV@pendragon.ideasonboard.com>
References: <20210518232858.1535403-1-robh@kernel.org>
 <20210518232858.1535403-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518232858.1535403-7-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Tue, May 18, 2021 at 06:28:58PM -0500, Rob Herring wrote:
> Use the i2c-mux.yaml schema in the maxim,max9286 binding schema. With this,
> several properties can be dropped as they are defined in i2c-mux.yaml
> already.
> 
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/media/i2c/maxim,max9286.yaml     | 23 +++----------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> index ee16102fdfe7..02f656e78700 100644
> --- a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> @@ -111,17 +111,10 @@ properties:
>  
>    i2c-mux:
>      type: object
> +    $ref: /schemas/i2c/i2c-mux.yaml#
> +    unevaluatedProperties: false
>      description: |
> -      Each GMSL link is modelled as a child bus of an i2c bus
> -      multiplexer/switch, in accordance with bindings described in
> -      Documentation/devicetree/bindings/i2c/i2c-mux.txt.
> -
> -    properties:
> -      '#address-cells':
> -        const: 1
> -
> -      '#size-cells':
> -        const: 0
> +      Each GMSL link is modelled as a child bus of an i2c bus multiplexer/switch.
>  
>      patternProperties:
>        "^i2c@[0-3]$":
> @@ -133,12 +126,6 @@ properties:
>            channels.
>  
>          properties:
> -          '#address-cells':
> -            const: 1
> -
> -          '#size-cells':
> -            const: 0
> -
>            reg:
>              description: The index of the GMSL channel.
>              maxItems: 1
> @@ -173,10 +160,6 @@ properties:
>  
>              additionalProperties: false
>  
> -        additionalProperties: false
> -
> -    additionalProperties: false
> -
>  required:
>    - compatible
>    - reg

-- 
Regards,

Laurent Pinchart
