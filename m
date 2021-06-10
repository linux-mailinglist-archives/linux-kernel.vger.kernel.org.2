Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62503A2FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhFJP4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:56:03 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38516 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhFJPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:55:59 -0400
Received: by mail-oi1-f177.google.com with SMTP id z3so2608709oib.5;
        Thu, 10 Jun 2021 08:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VRySpPzJlLYhI3h/JIF31rTc1KoHGLh9s0BINnZ+x9M=;
        b=XuMKGROQXfdsi/Ljt6hppjHzrRChQvD3NZykFY93nb+40NcF3/dSRdDWfK2lvUNFPp
         z5obCMAuHUAD1WKOQwLrGM/iInWnnHmNv4GEdRj8jKJxKNRu0jczURQlvCfBinan002x
         WDmhAd8de7+XthiHNR4tReiOH36yisbD2bmd+TcyPHAei+FCkQ1NL98S/tR7JJccqGGx
         t0p4g6Ah4tCyCyvPWCFZRuhJRD3wrtks9pnRKnyHMTuXz9PwAp2jTvoyIM60KBZ8QkXW
         Hlnz4c/0u13p0IdsTJE9zuOjkckCz4+SXe3rrLBtnIBW2DjUtO7KtRYt1xLl94qUt6to
         Krvw==
X-Gm-Message-State: AOAM533LMX9Kpc84CydL48UhLMXQynIBUYZJaLKat4KLppJCQV6S7IVf
        huEsYAX6veD3w6LBWGmERA==
X-Google-Smtp-Source: ABdhPJy1S0NCE5ntUuS+7phY6/iHJ2rMqyiVziT1ZAtosDKXBmthXoUwpRdOtZBBEhZ1W70GFFQXfg==
X-Received: by 2002:a05:6808:8fb:: with SMTP id d27mr6116265oic.115.1623340432085;
        Thu, 10 Jun 2021 08:53:52 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id f25sm677899oto.26.2021.06.10.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:53:51 -0700 (PDT)
Received: (nullmailer pid 1877730 invoked by uid 1000);
        Thu, 10 Jun 2021 15:53:45 -0000
Date:   Thu, 10 Jun 2021 10:53:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: Re: [PATCH v23 08/18] dt-binding: memory: pl353-smc: Enhance the
 description of the reg property
Message-ID: <20210610155345.GA1873816@robh.at.kernel.org>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
 <20210610082040.2075611-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610082040.2075611-9-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:20:30AM +0200, Miquel Raynal wrote:
> The SMC bus controller features several register sets. The one pointed
> by the reg property is for the SMC configuration (impacts the
> sub-controllers configuration), while the others are meant to be used to
> send regular cycles on the memory bus (eg. CMD, ADDR, DATA for a NAND
> device). Detail this a little bit for the sake of clarity.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/memory-controllers/pl353-smc.txt       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> index ecd46856f139..ba6a5426f62b 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> @@ -5,7 +5,8 @@ of memory interfaces: NAND and memory mapped interfaces (such as SRAM or NOR).
>  
>  Required properties:
>  - compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
> -- reg			: Controller registers map and length.
> +- reg			: SMC controller and sub-controllers configuration
> +			  registers.

I think you could just drop this patch. Otherwise, this doesn't match 
what's now in the yaml file.

Rob
