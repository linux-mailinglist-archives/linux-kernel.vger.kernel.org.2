Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B030337B74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhCKR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCKR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:56:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F12C061574;
        Thu, 11 Mar 2021 09:56:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j18so43558wra.2;
        Thu, 11 Mar 2021 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Zk3zgGqTX1e9ZGhYNvo16p2qHC5ENH2WzO7ak0uUDo=;
        b=V6m1Xq1O2QNWYiFlp+5jGaiC0fFnE+i9xD9PtKvExrnwD87oX1OJn/i1JTp9CZReAV
         IvL7rh1GKdl8eeS621o1OomOGXBeKtXZJfk/nraxPcGLrQ4Ses8hr1Kn48RUzQ14GyQ6
         SpEQbAJgTOekgl8FkiG3axkwtncDCDdqVyNKVrf8OjSc7tgCSH8XhcFv0XPOcv2nuhsF
         NDfeE/whtlQ7Mmoe6vDE14aatS3/CZkle2aKsbT84uUvlI7VNY00rLR30/LV1SrIB3ns
         Ilo65Jd8Nx0qVWLcx5CVkkiopDFg7mZIt7QohIEmVEA4uOua11nAJrcwguADdfzt7OGf
         DufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Zk3zgGqTX1e9ZGhYNvo16p2qHC5ENH2WzO7ak0uUDo=;
        b=LlEiioutB/RfyJniWmgjRAGKx6bPZZeaOa2tyRxYkXp9tuYo6IZjY+dZhsxq9oXa8p
         cduOFvurRN/Zq1Cua7xH99OjVphzfOnGO/X7T1eGNaZFOe7AyafU1LND65Eth4CFhT5v
         ydR0w/mAGfA5VnJnZOzc35hEfRZVn1GiYaR7hzIykXjTQiNIA8tSIJkr0Yh+8wTjA/9J
         5cxjBZn2+zRCAsKYgQsw/J4tCWAsMZe1qU0b58LHhMtWTtQvB2bWtRC9u0iv/su3Hw1H
         8SRMP1K6plV1EKAwXelkvh021/ZTIJDWOWba5y/XjOnRS0+cBWbgy5exXiWtfwNXJHNv
         P4FA==
X-Gm-Message-State: AOAM530MHtMBAnoMaWXRYWo20UNcVT8EJm4vIO+pl/5MM93htWWyM8eI
        z5A5sECo+Px1n9ZgfmepaKc=
X-Google-Smtp-Source: ABdhPJxzDDlgHSqQ446a5JHiZM0Gr3mIEa+SY6AlUpvbpESKEjmOaPIFAW5hF02zGLDL40wcGacWIA==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr10004926wrg.362.1615485408720;
        Thu, 11 Mar 2021 09:56:48 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id v18sm5676827wrf.41.2021.03.11.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:56:48 -0800 (PST)
Date:   Thu, 11 Mar 2021 11:50:25 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <YEn18b9m5mHX8eO7@Ansuel-xps.localdomain>
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
 <20210311051309.16789-2-ansuelsmth@gmail.com>
 <20210311173221.GB866234@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311173221.GB866234@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:32:21AM -0700, Rob Herring wrote:
> On Thu, Mar 11, 2021 at 06:12:48AM +0100, Ansuel Smith wrote:
> > Document nvmem-cells compatible used to treat mtd partitions as a
> > nvmem provider.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > new file mode 100644
> > index 000000000000..b53faf87d4e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > @@ -0,0 +1,99 @@
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
> > +
> > +allOf:
> > +  - $ref: "../../nvmem/nvmem.yaml#"
> 
> I'd rather have the 'absolute' path:
> 
> /schemas/nvmem/nvmem.yaml
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
>

Should I send a v7?

> > +
> > +properties:
> > +  compatible:
> > +    const: nvmem-cells
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +      compatible = "fixed-partitions";
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +
> > +      /* ... */
> > +
> > +      };
> > +      art: art@1200000 {
> > +        compatible = "nvmem-cells";
> > +        reg = <0x1200000 0x0140000>;
> > +        label = "art";
> > +        read-only;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        macaddr_gmac1: macaddr_gmac1@0 {
> > +          reg = <0x0 0x6>;
> > +        };
> > +
> > +        macaddr_gmac2: macaddr_gmac2@6 {
> > +          reg = <0x6 0x6>;
> > +        };
> > +
> > +        pre_cal_24g: pre_cal_24g@1000 {
> > +          reg = <0x1000 0x2f20>;
> > +        };
> > +
> > +        pre_cal_5g: pre_cal_5g@5000{
> > +          reg = <0x5000 0x2f20>;
> > +        };
> > +      };
> > +  - |
> > +    partitions {
> > +        compatible = "fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@0 {
> > +            label = "bootloader";
> > +            reg = <0x000000 0x100000>;
> > +            read-only;
> > +        };
> > +
> > +        firmware@100000 {
> > +            compatible = "brcm,trx";
> > +            label = "firmware";
> > +            reg = <0x100000 0xe00000>;
> > +        };
> > +
> > +        calibration@f00000 {
> > +            compatible = "nvmem-cells";
> > +            label = "calibration";
> > +            reg = <0xf00000 0x100000>;
> > +            ranges = <0 0xf00000 0x100000>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +
> > +            wifi0@0 {
> > +                reg = <0x000000 0x080000>;
> > +            };
> > +
> > +            wifi1@80000 {
> > +                reg = <0x080000 0x080000>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.30.0
> > 
