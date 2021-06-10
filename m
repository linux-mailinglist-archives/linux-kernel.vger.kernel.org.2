Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184343A2FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhFJPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:51:18 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38725 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:51:16 -0400
Received: by mail-ot1-f47.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so142893otk.5;
        Thu, 10 Jun 2021 08:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHLGIt6RLM2t7ULN/gWoY1/X6PighK4+59mVA8vx+r8=;
        b=Df2gtLxwCY2GEbLE5t4bA8/nqxDbSseE+x2Frv/AEI/zjOSXYa/Ol4xIOlwbdCYUcW
         W3UjoENl/3oEhsZF+yqja98msfwXk8tIUP5pByG8Dj8z23D+dn6O2d70zNTPhgJv7zBp
         fYbQSxFY2COcWtlq0mj+Z6l4r7hbCIBwCIwv1rpsSe53NpbSE+PUxdLjRP8EKZ//d0EO
         zwoF7dqqIHOIfJDc6d5BFRCc6eTTQ6DWdTlBquxubR/1FRU7YMbgaqOFDngYEr0/5HIg
         dSttBPA/ZYVyOX6pf9CL4CprTcsduIVDRGEugyhdNGEWiq64gOB6ay8Fm2IxHc8/mXtD
         B1Dw==
X-Gm-Message-State: AOAM530SCxMuxVfBDGGGsT6T0zeTSkCDeyrWVjsPsO/U/rSNmzQKGg8h
        SseCxLDy5YDueovnSCMU2g==
X-Google-Smtp-Source: ABdhPJwZnH/HEVQP9MZceozaTD8X/CkVHBbgq+n0s6TSv58Q9zBYFCo/F+Ma9llLukA882/0GaAySg==
X-Received: by 2002:a9d:4817:: with SMTP id c23mr3105218otf.352.1623340147764;
        Thu, 10 Jun 2021 08:49:07 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id g25sm680396otn.81.2021.06.10.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:49:07 -0700 (PDT)
Received: (nullmailer pid 1868515 invoked by uid 1000);
        Thu, 10 Jun 2021 15:49:04 -0000
Date:   Thu, 10 Jun 2021 10:49:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        helmut.grohne@intenta.de,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Goud <sgoud@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Michal Simek <monstr@monstr.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
Message-ID: <20210610154904.GA1868448@robh.at.kernel.org>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
 <20210610082040.2075611-18-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610082040.2075611-18-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:20:39 +0200, Miquel Raynal wrote:
> Add a yaml description of this NAND controller which is described as a
> subnode of the SMC bus.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
