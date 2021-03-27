Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672634B825
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhC0Qah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:30:37 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41868 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhC0QaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:30:11 -0400
Received: by mail-ot1-f54.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so8187548otq.8;
        Sat, 27 Mar 2021 09:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Rp5YRMAuX+nFksmAgBJTg7ZHDI2BYdNvFQYEt8ALSo=;
        b=tTAYy8PDNKyCgefQiP4UBQV20f78Ffo/LO1RywSLorUjP/jFG4x6yCfg3+p2WMJzql
         mPGuKx36RVeDssUIAqP+ihp45zA00PuniqF3s6+6NnNqYZoKjAQz5PZLyV4iTfaORo6h
         8rgRjwOgZkqFHyNaYonsHjuU5Ne9kkgqytSpAv6FejjdnKdtvT4re8+/xaqUc5AeqHg/
         tObhmn7OFVRVqX5rZl44vZwRuQd5retsb2OKeJ1mTgOjfamI38qyw0IcN39FZOU/16f4
         cOdHHHKlbDInv+8yKf+9DWs7uFfRB/hvtEANwVfXXjGbPwCCkCBVw88HbomiouWyhQh2
         ISDA==
X-Gm-Message-State: AOAM5321UNRrf9qI0V7+icbsuy6lSP+dS8hckPHL5hO2FLRVE8jGa1WB
        jYJSdTfVBXUTBWPtDPL+RA==
X-Google-Smtp-Source: ABdhPJxUWXW6EjXIzgfB/hlFp/ntAvacXisLN585V8F7oaTeQISeOrUptrzfqbveJrvCbvFRXL2CKA==
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr9761664otr.209.1616862611114;
        Sat, 27 Mar 2021 09:30:11 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id w199sm2474969oif.41.2021.03.27.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:30:10 -0700 (PDT)
Received: (nullmailer pid 202941 invoked by uid 1000);
        Sat, 27 Mar 2021 16:30:06 -0000
Date:   Sat, 27 Mar 2021 10:30:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210327163006.GA185779@robh.at.kernel.org>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
 <95105518f61408743d17783099ed9c373a3dfe18.1616178258.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95105518f61408743d17783099ed9c373a3dfe18.1616178258.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 08:27:59PM +0200, Cristian Ciocaltea wrote:
> Add devicetree binding for the Actions Semi Owl SoCs info module.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  .../bindings/soc/actions/owl-socinfo.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> new file mode 100644
> index 000000000000..3fcb1f584fdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoC info module
> +
> +maintainers:
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  Actions Semi Owl SoC info module provides access to various information
> +  about the S500, S700 and S900 SoC variants, such as serial number or id.
> +
> +patternProperties:
> +  "^soc(@[0-9a-f]+)?$":

Make this a $nodename property.

> +    type: object
> +    properties:

And move this up to top-level.

You need a custom 'select' entry to exclude 'simple-bus'.

> +      compatible:
> +        items:
> +          - enum:
> +              - actions,s500-soc
> +              - actions,s700-soc
> +              - actions,s900-soc
> +          - const: simple-bus
> +
> +      "#address-cells":
> +        enum: [1, 2]
> +
> +      "#size-cells":
> +        enum: [1, 2]
> +
> +      ranges: true
> +
> +      actions,serial-number-addrs:
> +        description: |
> +          Contains the physical addresses in DDR memory where the two parts
> +          of the serial number (low & high) can be read from.
> +          This is currently supported only on the S500 SoC variant.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        maxItems: 2

Humm, it doesn't really seem you have an actual device or bus here, but 
are abusing DT to create your socinfo device.

As the only property is data in main memory, you should do a compatible 
for that memory region and put it under reserved-memory. You need that 
anyway to prevent the kernel from using the memory, right?

Rob
