Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEDC38BBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhEUBkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:40:32 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38484 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhEUBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:40:31 -0400
Received: by mail-oi1-f182.google.com with SMTP id z3so18237557oib.5;
        Thu, 20 May 2021 18:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHDUWcKLdEreHylbJ6qjwAOsVXEIpsN/MhjQoJ5Ovks=;
        b=VSPNWc4BtH4pvspYZlNeYojSrkMMrh8cGsdkv/2qM+Qr0thxV1BDcIjYSg5vrCWPQT
         AQw6Wz6JIojM42UWvF2BiMhHFwYMxgq4iqzG2uoFnO9v2GS2c5tcD5y2ItpBcFgPZ26y
         mKJR3Mi0nYExuxy2Uoo7K6RwX6rU/Y2PiIg+PxiKsppbfgVYd4guEA4wV28UifbeM3wb
         jS6tfDp6jzgqCYlU/JkE3zNe0Z0DXdOxg9YSfvTIXr/ZgrV7mQatCtoeKb9GoCt+OISK
         mIYIpu+cEnfc4Sl+elbA2m7ycelRmcz4ptqK4D2C7oQX5TVY0TKBWvn6vX3iFIPSQoBj
         1PSQ==
X-Gm-Message-State: AOAM533n8I5gbv1aoonApoUyGFroYNyhifU9OfT+R5TT48pvsrRasUXv
        hjFeutQTa9aZtMJ3x9pl9A==
X-Google-Smtp-Source: ABdhPJy1os/eXheMpifGdqYKraVHyYBNJMLWCtPZfxhLS1bqSNKMrSeUUG53n/h5x7/eyOWVPHzMaw==
X-Received: by 2002:a05:6808:a87:: with SMTP id q7mr281561oij.38.1621561148841;
        Thu, 20 May 2021 18:39:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm1008850otq.35.2021.05.20.18.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:39:08 -0700 (PDT)
Received: (nullmailer pid 2459176 invoked by uid 1000);
        Fri, 21 May 2021 01:39:07 -0000
Date:   Thu, 20 May 2021 20:39:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
Message-ID: <20210521013907.GA2456181@robh.at.kernel.org>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519104152.21119-2-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:41:36AM +0100, Andre Przywara wrote:
> The AXP305 PMIC used in AXP805 seems to be fully compatible to the
> AXP805 PMIC, so add the proper chain of compatible strings.
> 
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Don't you want to convert this to schema? It's one of the last warnings 
for sunxi IIRC.

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 4991a6415796..4fd748101e3c 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -26,10 +26,10 @@ Required properties:
>      * "x-powers,axp803"
>      * "x-powers,axp806"
>      * "x-powers,axp805", "x-powers,axp806"
> +    * "x-powers,axp803", "x-powers,axp805", "x-powers,axp806"
>      * "x-powers,axp809"
>      * "x-powers,axp813"
>  - reg: The I2C slave address or RSB hardware address for the AXP chip
> -- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>  
> @@ -43,6 +43,7 @@ more information:
>  			AXP20x/LDO3: software-based implementation
>  
>  Optional properties:
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
>  		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
>  		      AXP22X/8XX: range: 1800-4050, Default: 3   MHz
> -- 
> 2.17.5
> 
