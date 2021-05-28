Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809F6393ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhE1BC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235283AbhE1BC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909E1613AF;
        Fri, 28 May 2021 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622163652;
        bh=q6WFQmiFbMs1OoXAM5Qb8EKAKUW2m0FTtJcYgqBXtHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWH5eJfV4Cf0Te7+90JMu7h4sUmafVEhTnW1vzqRoeR3tyoA7JjMY2VDZLaJHkwcL
         2i/52fPntFp5WNTTuqWZDOCX8MRHRJ1DxgydQVG2VAbhVDLfna8WOtetuFkYWFB7ah
         y1lznkJWt/3CYO9dAnoMaSVy9NynKo0lG3+DVIDUlODjjr26cRMdXGuQ9iKOdCXtvm
         iEH6BaBeRRMXwLvsdMEggVHiLUYG0Tb9JsTc4IQBrp7ArjAzHeEleOBplVkDBRkTZ/
         IuKp3g1kHNEHhRNWxZHj3xqTBd/Uh3PPVLZkfUc02NEgO6WaoHtlME2D0NQ6Q4a/Nh
         o3NoAP0cuS4sw==
Date:   Fri, 28 May 2021 09:00:47 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: cdns,usb3: Fix interrupts order
Message-ID: <20210528010047.GB10856@nchen>
References: <20210527193952.1705127-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527193952.1705127-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-27 21:39:52, Geert Uytterhoeven wrote:
> Correct the order of the descriptions for the "interrupts" property to
> match the order of the "interrupt-names" property.
> 
> Fixes: 68989fe1c39d9b32 ("dt-bindings: usb: Convert cdns-usb3.txt to YAML schema")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> index a407e1143cf4251b..8dedfa16c9929d77 100644
> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> @@ -28,9 +28,9 @@ properties:
>    interrupts:
>      minItems: 3
>      items:
> -      - description: OTG/DRD controller interrupt
>        - description: XHCI host controller interrupt
>        - description: Device controller interrupt
> +      - description: OTG/DRD controller interrupt
>        - description: interrupt used to wake up core, e.g when usbcmd.rs is
>                       cleared by xhci core, this interrupt is optional
>  
> -- 
> 2.25.1
> 

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen

