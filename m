Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089C8334BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhCJWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhCJWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:47:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079BC061574;
        Wed, 10 Mar 2021 14:47:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g25so149563wmh.0;
        Wed, 10 Mar 2021 14:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dp9DInsVMxgWeAboBahDiDPT111NcMpaXY2ilDA9Zo4=;
        b=b31D9MRU1bFKXcV8L7Yf+L1dnbD+tOUfbPMCHx5mO+dPzZE8N7105P4EYquurdH3r/
         nuz5XqMTFB27T9BnsxahsmlmlKLGXpT8ObuVunhx1Za/DguZuVMsp+4UZgCCqdBiUBjh
         OaDbfrHTvCFHKPfRaKmUN/QKkHHCholELtncvq4nWpZnutVNKoCLMb91of7x3ofW2j4e
         IwcJOcQa3buL7iXofPZSFkeYVWeJF9Gz+m+01GWVvQnOZTGkLUmu7+InS4raQglPSOgb
         Wvq/5dbpNgWRkUbK6YlJiRl6RLd8MUp6CCefw+3mYTATjtsrWF1cyK+qQYNAHaxAvJV6
         USPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dp9DInsVMxgWeAboBahDiDPT111NcMpaXY2ilDA9Zo4=;
        b=k7oncUkua6z9Io3GQpyrbePAkOI5Evjc9AJV3Q3iVteyuDvZjkUdJmDUum8Yir2JOE
         9T0x+LBziLVbNA7hDU9Q0K3srLWqm5edgA3eRBr/WVXcVWNw3uzCxAvpA8ZEluLBHzhi
         zTKx+3yC4smsHZ3fKRAN1DRHCxXYRPFjTVkZdeKxj7KCSCwIYoz8gmloMH4jbR9PLWqM
         w92j3SogFwfwN1P4VFp1ba8gBgsMrAcDhRnGJ86TwLjnVRvQBg4Dw1zJkyAactsin/Gw
         GSSxviB/+HZ9+0QmIy/HKE43itqShvvO5RlZOx/hCXkaQ6vU58Xi+5Xj6uu2Z5hfeOSg
         Ux0Q==
X-Gm-Message-State: AOAM531qXZed2+BslAb6iIRrn2QhWsaQXp+x0xIRPpzZs+ZEL4kUPjBz
        APRaXF3Gwcy45VhmjkDSBeE=
X-Google-Smtp-Source: ABdhPJyR/gLtCOZzQajU4mg+PApLftgolVO8nNF6Z7DmFi3vssrDLEZaY/scs1tGzbr93bGS/VhZtA==
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr5317774wmc.88.1615416464250;
        Wed, 10 Mar 2021 14:47:44 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id z25sm909099wmi.23.2021.03.10.14.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:47:43 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:47:42 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <YElMjg/AspNSRe0A@Ansuel-xps.localdomain>
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
 <20210310210812.8880-2-ansuelsmth@gmail.com>
 <5d798266-3a18-d50d-9c3e-f91bc2460fe5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d798266-3a18-d50d-9c3e-f91bc2460fe5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:41:24PM +0100, Rafał Miłecki wrote:
> See inline
> 
> On 10.03.2021 22:08, Ansuel Smith wrote:
> > Document nvmem-cells compatible used to treat mtd partitions as a
> > nvmem provider.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   .../bindings/mtd/partitions/nvmem-cells.yaml  | 96 +++++++++++++++++++
> >   1 file changed, 96 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > new file mode 100644
> > index 000000000000..f70d7597a6b0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nvmem cells
> > +
> > +description: |
> > +  Any partition containing the compatible "nvmem-cells" will register as a
> > +  nvmem provider.
> > +  Each direct subnodes represents a nvmem cell following the nvmem binding.
> > +  Nvmem binding to declare nvmem-cells can be found in:
> > +  Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> 
> I think that when Rob wrote:
> 
> On 10.03.2021 03:58, Rob Herring wrote:
> > I think this should reference nvmem.yaml.
> 
> he meant you using:
> 
> allOf:
>   - $ref: "nvmem.yaml#"
> 
> (you'll need to adjust binding path).
> 
> Please check how it's done in Documentation/devicetree/bindings/nvmem/*.yaml files
> 
>

Aside from that, should I readd the old properties or I can keep the
compatible as the only one required?

Thanks for the suggestion.

> > +properties:
> > +  compatible:
> > +    const: nvmem-cells
