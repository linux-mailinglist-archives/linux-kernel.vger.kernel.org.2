Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0507242A4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhJLMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:54:23 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43935 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhJLMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:54:21 -0400
Received: by mail-oi1-f178.google.com with SMTP id o4so28904852oia.10;
        Tue, 12 Oct 2021 05:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GH/rUNldGDrQWZbHGHNnv3z7yGjMSKDvdbkj2ZpIpc4=;
        b=hWQcpbafOqEfhkzZUi+fyaX7CYCmIdeQdqEUayhs6BC7hdkzeTsR/hhzqkio0rpEoU
         tgdUQSjKI4hwtOMG77C6HoEU4sQBSgMoeKEHe4OrrQO6g5Ms/SDQMrZnPGd1cBKTU8vJ
         e4dglGMrolzLoTxC/enzyqJ0BS6QxwU86H+sKOaeQfmnng6t+nK3E1SMj7YQHi4Uhhck
         hj2yQHVHiPAKDkLHB3tSFqbdv1Wv/VgZgmHsYqJ2HCp/T6L3ESNQ2YxeT50j0G1DFduk
         VLoGXYc/9fkWYakp39Oa+VS7VTlZGH0yHWnvjgt7/1k8m948RPl66A/5Z6oAK82Q2i7h
         kV2w==
X-Gm-Message-State: AOAM531ujTCIGfAbG/2K0TEj0CjdydsOcvr516pP5q+3Ud5swqHq7Y/M
        NPMOmJ8XKE54/8hwkXWaEQ==
X-Google-Smtp-Source: ABdhPJz8As3l+5i35LUl/3j8/RYdO3uMxHOhk3l3WiuYe0C4KBDwdJpcQI1vNwr1VfPoZj4l4G6kSA==
X-Received: by 2002:aca:6747:: with SMTP id b7mr3524949oiy.46.1634043139688;
        Tue, 12 Oct 2021 05:52:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l45sm2090151ooi.30.2021.10.12.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:52:18 -0700 (PDT)
Received: (nullmailer pid 2551195 invoked by uid 1000);
        Tue, 12 Oct 2021 12:52:17 -0000
Date:   Tue, 12 Oct 2021 07:52:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <Alexander.Stein@tq-systems.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add
 output-driver-strength property
Message-ID: <YWWFAXeekLS80bOR@robh.at.kernel.org>
References: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:15:28PM +0200, Alexander Stein wrote:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> This property is for optimizing output voltage impedance and is
> specific to each board.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> I checked Micron and Macronix datasheets. Both have similar but not
> identical supported values. Also the register locations are different.
> For those reasons I decided to specify the Ohms value directly and let
> the device specfic driver figure out if it is supported where to write
> it to.
> BTW: Are the Ohm values and the corresponding register bits standardized
> somewhere?
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index ed590d7c6e37..7d7f20a741b5 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -72,6 +72,12 @@ properties:
>        be used on such systems, to denote the absence of a reliable reset
>        mechanism.
>  
> +  output-driver-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Output driver strength in Ohms which optimizes the impedance at Vcc/2
> +      output voltage.

Use a standard unit suffix.

Though, specifying 'drive strength' in ohms rather than amps is a bit 
strange.
