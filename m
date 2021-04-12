Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8E35CAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbhDLQCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:02:39 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41789 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbhDLQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:02:38 -0400
Received: by mail-ot1-f42.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso4651243ott.8;
        Mon, 12 Apr 2021 09:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ngce6ec7f1c0lKTqeUe7A7Xm2r+o9qe2C4pUnKmBkEc=;
        b=GbxSvq0j8LQanuvwTi2BLXwlOQ84zwVVHFp2Pul+6ErigKaIbsv6yDQLPbu1AJnw1+
         v3s/srwOBKiq1GxyWE65Jg09KffvwAYongDoZxVs/fye/viT24pe55/MiqUckS+d4kYc
         gOLalJCXSUcMUj+6MxJtvYPP5/wtJecvrPeg6/I4PG0VBArAJq8tYrhJnzbElwxeiVIR
         d51I1Q3/PL1wMiWX8DFxoH8BQuko72WQG0xvbCiaGpehXdGoGEb4GeTy6yiGisz4Gdx+
         SWQ796ZeuKsQw1wZPf9ObgxcqRCKJ8iMdI4owhG6wgD4tP4Y/dPo4SenHcXffAZvXcI6
         f7zw==
X-Gm-Message-State: AOAM533frYdG2ogYfaPkSfCqyA0QZY9s+ul3JOEOzZus64etx6nIlvL/
        KwJk3MZtSKvwnJxUNGCIqYMvgqm9Og==
X-Google-Smtp-Source: ABdhPJyphvrAAQqhZzq/xJoYqxJ9sKV8YW9PiHjAV9kYDD7MKFG4FnH+SHoCHCPLgsB18Sdm2QM8lw==
X-Received: by 2002:a9d:6054:: with SMTP id v20mr24517464otj.81.1618243338556;
        Mon, 12 Apr 2021 09:02:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm651808oou.0.2021.04.12.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:02:17 -0700 (PDT)
Received: (nullmailer pid 3971650 invoked by uid 1000);
        Mon, 12 Apr 2021 16:02:16 -0000
Date:   Mon, 12 Apr 2021 11:02:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/24] dt-bindings: atmel-sysreg: add bindings for
 sama7g5
Message-ID: <20210412160216.GA3970458@robh.at.kernel.org>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
 <20210409111345.294472-17-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409111345.294472-17-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:13:37PM +0300, Claudiu Beznea wrote:
> Add RAM controller and RAM PHY controller DT bindings.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt     | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 807264a78edc..7cd55a760d41 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -45,7 +45,8 @@ RAMC SDRAM/DDR Controller required properties:
>  			"atmel,at91sam9260-sdramc",
>  			"atmel,at91sam9g45-ddramc",
>  			"atmel,sama5d3-ddramc",
> -			"microchip,sam9x60-ddramc"
> +			"microchip,sam9x60-ddramc",
> +			"microchip,sama7g5-uddrc"
>  - reg: Should contain registers location and length
>  
>  Examples:
> @@ -55,6 +56,18 @@ Examples:
>  		reg = <0xffffe800 0x200>;
>  	};
>  
> +RAMC PHY Controller required properties:
> +- compatible: Should be "microchip,sama7g5-ddr3phy", "syscon"
> +- reg: Should contain registers location and length
> +
> +Example:
> +
> +	ddr3phy: ddr3phy@e3804000 {
> +		compatible = "microchip,sama7g5-ddr3phy", "syscon";
> +		reg = <0xe3804000 0x1000>;
> +		status = "okay";

Really need an example for this? If so, drop 'status'.

> +};
> +
>  SHDWC Shutdown Controller
>  
>  required properties:
> -- 
> 2.25.1
> 
