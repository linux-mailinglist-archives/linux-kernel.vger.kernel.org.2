Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3053B3CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFYHBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhFYHBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:01:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:59:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k6so7267513pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHwJnyu1M1WtC7LQsa6ckFoImjEwhE8dFZ25fvWXS6c=;
        b=dFDJj84Ym7SD6vPMsX2rksoNnPdb73Vbd+kGC60fKgLxEOpDhQRUIo7LkPeEcZ6alJ
         3U2//teY0RQ6H4gvuBbyy+KmC4CdtmoaxBN2l4eTsCavRraN4EbCcoV35vrEmJjvqjjK
         Loqphmf/CJyDoyHOHlMDdXhoHfrm+WZ2kZnOr/sR7wdCLxd0cOJNBO78wAuGdNEtEzv4
         K3sTuqtIkxVnB2GORVLYKDbjaeJAXFaTQn2CoFovwVkKLIfANEfZYQkwMX/x+xk555B9
         EHlAHBo9KPFZSV8QNdKCS7xDcT6XHDgPXYWMTSJh9lP5K9tmHR9zLwrwtFlTz4WpT/5/
         5pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHwJnyu1M1WtC7LQsa6ckFoImjEwhE8dFZ25fvWXS6c=;
        b=ZPjgGGyVCCWgpYl7IcXPeko7uPJNT9Wo8fB51WJJdThtxvYcGi8tPx3doeMbl+uz5H
         S0FLcVb7eKc6ot3O0aW3h8icMkD034WHezBj/O+hb3qhkH1rMALznwtgfOm6+WHAY1Ug
         01mZYWIY4eJXIRq87MQC2kuovE/xX9t4XXwUPjVzoomgrLaCsgkcvzlG3c4Cci1FMx4+
         8xboERftiGLLPOxirNTVa53y3ifQ6UkLZ5DIXQibDjK+4xkXmMpPPyFRFvIVjww4+IGi
         qJWCtAtOM8A6Dp+Hhi63JmGwjXxwjFRWwEAi0Y5EFpND2lR4ICGeNZe65+h7dp3yyX39
         Qx4g==
X-Gm-Message-State: AOAM5332xqQwK1FEj5qvqQSI+bwlKSd2d9E+8peoS/C3bDESE2M5Qgl3
        cW0q6rQTs5Bk5S6C3CzCqZIzyA==
X-Google-Smtp-Source: ABdhPJy00XRwPN8BHfecCuS+WWKxTsrm/686cC2PWlRyOx5C4abvPyhU42EUsvrpfXYu9OIdikuDfg==
X-Received: by 2002:a63:5442:: with SMTP id e2mr8360070pgm.365.1624604371185;
        Thu, 24 Jun 2021 23:59:31 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id z9sm4660768pfa.2.2021.06.24.23.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 23:59:30 -0700 (PDT)
Date:   Thu, 24 Jun 2021 23:59:28 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: riscv: add starfive jh7100 compatibles
Message-ID: <20210625065928.GA567037@x1>
References: <20210616202654.578870-1-drew@beagleboard.org>
 <20210624212018.GA2003868@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624212018.GA2003868@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 03:20:18PM -0600, Rob Herring wrote:
> On Wed, Jun 16, 2021 at 01:27:00PM -0700, Drew Fustini wrote:
> > Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > BeagleV Starlight JH7100 board [2].
> > 
> > [1] https://github.com/starfive-tech/beaglev_doc
> > [2] https://github.com/beagleboard/beaglev-starlight
> > 
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > ---
> > Note: my patch to add 'starfive' to vendor-prefixes.yaml was applied by
> > Rob back on June 2:
> > https://lore.kernel.org/linux-devicetree/20210602163200.GA3513985@robh.at.kernel.org/
> > 
> > I ran dt_binding_check and dtbs_check: 
> > 
> >   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> >   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml 
> >   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >   DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> >   CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > 
> >   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> >   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> >   CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > 
> > The files jh7100.dtsi and jh7100-beaglev-starlight.dts are in the
> > process of being cleaned up for submission. The current downstream is:
> > https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> > 
> >  .../devicetree/bindings/riscv/starfive.yaml   | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > new file mode 100644
> > index 000000000000..4deae9f5c60d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/starfive.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive SoC-based boards
> > +
> > +maintainers:
> > +  - Michael Zhu <michael.zhu@starfivetech.com>
> > +  - Drew Fustini <drew@beagleboard.org>
> > +
> > +description:
> > +  SiFive SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: beagle,beaglev-starlight-jh7100
> > +          - const: starfive,jh7100
> > +
> > +      - items:
> > +          - const: starfive,jh7100
> 
> This alone shouldn't be valid.

Thank you for pointing this out.  I have removed that const item and the
dtbs_check still completes ok.  I will send a v2.

Drew
