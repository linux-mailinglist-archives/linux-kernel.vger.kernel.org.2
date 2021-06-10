Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE333A2FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhFJPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:51:00 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:43648 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFJPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:50:58 -0400
Received: by mail-oi1-f169.google.com with SMTP id x196so2583569oif.10;
        Thu, 10 Jun 2021 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oofmloNBtAXODqa/Pc2gss4iGaD3a0Bn3YImB8xl1VI=;
        b=ZGVF5ArYC48nmKd4jHfJltrj7ZUNmkY+RWsEvRnn3AkyDLJT9d3dCE4iDZ4ZU3v/SQ
         O2paYaZ5YYJM2p8ciuvOGj2UE/RIicZ61RdqkCvsxSjuFXc1LfuGDG+1gGMJXoeiqg+E
         o1PYgUefzPNEYeYQWchIwna3ZcYfYBjDxmBPI0pTZEJxrTZFHxxFmhXDr5gITfdKua81
         FKOpWLWbAjA6PbkU5fIFEp1H6A/sG9ofbVQYXhyjX9Uovmk/slxcS9oNSTShCZ23n2d5
         AfwnWbG1GAfD7MSm9uoTs98UC60m7a0C7RbVW4FaT+J0WsZ/ZU80DACWb+KMbmirAgI6
         YOPQ==
X-Gm-Message-State: AOAM5322S08SvMM6oIufwJPGCeH7mPu9WmhUN/Vak+m1Dxmrl5kFRTiY
        qpA0UY7dTfvPNgCdyJ5PvQ==
X-Google-Smtp-Source: ABdhPJz1F49FcH57RVkPlhaAmm0oEjXoNQULmfhglMJ/ZNiGqGbcDOhQuSqpmYS0f+E0ltHncTz6IQ==
X-Received: by 2002:a54:448d:: with SMTP id v13mr3885281oiv.41.1623340141910;
        Thu, 10 Jun 2021 08:49:01 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id s6sm653663otk.71.2021.06.10.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:49:01 -0700 (PDT)
Received: (nullmailer pid 1868332 invoked by uid 1000);
        Thu, 10 Jun 2021 15:48:58 -0000
Date:   Thu, 10 Jun 2021 10:48:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Subject: Re: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
Message-ID: <20210610154858.GA1864637@robh.at.kernel.org>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
 <20210610082040.2075611-18-miquel.raynal@bootlin.com>
 <ce97c460-14eb-a758-31f6-124585e733f1@canonical.com>
 <20210610105653.2d732c4b@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610105653.2d732c4b@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:56:53AM +0200, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Thu,
> 10 Jun 2021 10:48:16 +0200:
> 
> > On 10/06/2021 10:20, Miquel Raynal wrote:
> > > Add a yaml description of this NAND controller which is described as a
> > > subnode of the SMC bus.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 53 +++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > > new file mode 100644
> > > index 000000000000..5f126bb9b202
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: PL353 NAND Controller device tree bindings
> > > +
> > > +allOf:
> > > +  - $ref: "nand-controller.yaml"
> > > +
> > > +maintainers:
> > > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > > +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:  
> > 
> > I think you can skip the "items" here and leave only "const: foo".
> 
> Crap, I missed that one, you're right. I'll wait a bit for Rob's
> feedback and eventually fix it when applying or resend (hopefully) only
> the NAND bits.

Either way is fine.
