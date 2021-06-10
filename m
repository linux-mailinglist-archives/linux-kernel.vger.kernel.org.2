Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE73A224A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFJCfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:35:04 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38524 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJCfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:35:02 -0400
Received: by mail-ot1-f42.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so12426451otk.5;
        Wed, 09 Jun 2021 19:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w3Qk3mDaHVdG6iOni8nUWBguXf5d+3DBDCqBEu56Bpg=;
        b=EvUU8JUDu+cwvwqgpTG3UBYx8z2Aze7o8eEQG2NdyEmEENMw5xedudejDTQoCW7wbJ
         2sRUVlVrbaBfbXIar6lr07oQ939gQ25rPSfgcWW3dPTbyHHAKlTvmx64weXcjFYE3xMS
         gDm38vnUK4AtGhsDfL+SQ4sqQMWbtTME22p5Q7iL7CGSWOzSakUYnj6qy6oawY8Rm+f5
         jxXHcD9NqPQ/nXE5uw0loDs+pPSxgRBw1CTbwazeZZ5sEw5ft+FFcO3YeEtBV/GuZCGu
         yrySts2/k4B9z4nd9Z9izYkYELxO63JwXse6vLMVh6g1pAuySRElSyc7/W/8tsRosvcE
         tf5Q==
X-Gm-Message-State: AOAM533o/aaISBH7NjLICW82lRquBV0Hjb20lOJl6l/jjlNLiy3cbInL
        9G/MOHGV9D7y5SaxXk1XHg==
X-Google-Smtp-Source: ABdhPJz5Fm5SOTjq59+89tCBY1vEuqORfUL+b3CCToeDK1+/IClyQhAK5cM1UmY8xOZaiA5MX01xGQ==
X-Received: by 2002:a05:6830:22ec:: with SMTP id t12mr540593otc.243.1623292373914;
        Wed, 09 Jun 2021 19:32:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w186sm319636oib.58.2021.06.09.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 19:32:53 -0700 (PDT)
Received: (nullmailer pid 672655 invoked by uid 1000);
        Thu, 10 Jun 2021 02:32:51 -0000
Date:   Wed, 9 Jun 2021 21:32:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
Message-ID: <20210610023251.GA648931@robh.at.kernel.org>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-18-miquel.raynal@bootlin.com>
 <57ef16cd-33e7-6c16-3a24-9634f47831b3@canonical.com>
 <20210609153621.1303bc4d@xps13>
 <6fb9c0e4-43cb-d224-0ebe-568f62ac35b1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb9c0e4-43cb-d224-0ebe-568f62ac35b1@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 03:57:05PM +0200, Krzysztof Kozlowski wrote:
> On 09/06/2021 15:36, Miquel Raynal wrote:
> > Hi Krzysztof,
> > 
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> > Jun 2021 14:01:10 +0200:
> > 
> >> On 09/06/2021 10:01, Miquel Raynal wrote:
> >>> Add a yaml description of this NAND controller which is described as a
> >>> subnode of the SMC bus.
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> ---
> >>>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
> >>>  1 file changed, 57 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> >>> new file mode 100644
> >>> index 000000000000..e72fa14b4385
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> >>> @@ -0,0 +1,57 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: PL353 NAND Controller device tree bindings
> >>> +
> >>> +allOf:
> >>> +  - $ref: "nand-controller.yaml"
> >>> +
> >>> +maintainers:
> >>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> >>> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:  
> >>
> >> That's not an enum, but simple const without items.
> > 
> > Ok.
> > 
> >>
> >>> +          - arm,pl353-nand-r2p1
> >>> +
> >>> +  reg:
> >>> +    items:
> >>> +      - items:
> >>> +          - description: CS with regard to the parent ranges property
> >>> +          - description: Offset of the memory region requested by the device
> >>> +          - description: Length of the memory region requested by the device  
> >>
> >> Doesn't it depend on parent's address/size cells?
> > 
> > Yes, but as the child nodes are not defined in the parent's binding
> > (ie. the SMC) I think it's interesting to have them defined here, no?
> 
> The trouble is if parent decides to have different address/size cells.
> The schema will stop matching. I am actually not that sure if such case
> is real since the pl353 NAND part will usually be connected to pl353
> SMC. However the schema now hard-codes specific dependency against
> parent schema/node.
> 
> Rob,
> Maybe you have here some thoughts?

I think it is fine given the parent child coupling.

Rob
