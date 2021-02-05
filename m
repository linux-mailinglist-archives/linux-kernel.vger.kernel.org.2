Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE9311A1F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhBFDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:31:38 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39655 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhBFCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:44:15 -0500
Received: by mail-ot1-f41.google.com with SMTP id d7so6605412otq.6;
        Fri, 05 Feb 2021 18:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVxSD1rRrWRAJtG5RDpbzugHIfcqDTvX+OpzCsWnge0=;
        b=Et2QRdcvhCJGsfrCOtdRnnE7b2kywqKLe3l8qA51K105+qyJto5YsQ/h4g0nAh8ZjY
         NoCrgDBjnr4O3dC0zW8bb+xkIBPHVVEfAPOXZ+zkv2g5ml1G0LCZ5CWWhBF6qmY6tihQ
         HuDF1fCBkNpBQt5dNUNtFsr0j+L6j7Qopf7NXSnbOrXLO9XU4ewYHZsvVpT/VSgSGdvl
         v6G1KWthwvSVLeZvXsAYT2NFo3Oc8YhXrgenJP9kR6TJFk1CoNbCHOZd3IEiyiuznfo/
         sgXKxAFxKBPlDrLh1Wf0fj5YEstWLOFkeMcTwBclSuLwg8iPn0nZhoUeB9hJF58MCCQO
         KTaQ==
X-Gm-Message-State: AOAM530uchXvMvAd6x8KzjMAI0wSinBcckM+W7jItws7I/d5kZXAQd/n
        kfPi2g3EwSZhtULqx5Kb2inRvXNv/Q==
X-Google-Smtp-Source: ABdhPJyu7gJrKzV2CHIDzrZf0xO2fwFgHLWzzUYn1r2rXC/7SPUKdVPADz9GDBP6ItA1Y6wElUidrQ==
X-Received: by 2002:a4a:ce90:: with SMTP id f16mr4998594oos.61.1612562215585;
        Fri, 05 Feb 2021 13:56:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x187sm2091742oig.3.2021.02.05.13.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:56:54 -0800 (PST)
Received: (nullmailer pid 3821562 invoked by uid 1000);
        Fri, 05 Feb 2021 21:56:53 -0000
Date:   Fri, 5 Feb 2021 15:56:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/20] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
Message-ID: <20210205215653.GA3813445@robh.at.kernel.org>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-5-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:24:44PM +0000, Andre Przywara wrote:
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

I don't normally (yet) ask for schema conversions on compatible 
additions, but this is one of the few remaining compatibles with no 
schema for allwinner. So a conversion here would be nice. BTW, dtschema 
now has a better check for this (-m option) without the false positives. 
I plan to turn on the option soon (doesn't matter for dtbs as they all 
have lots of warnings, but bindings also get warnings).

Either way,

Acked-by: Rob Herring <robh@kernel.org>


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
