Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470534B115
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCZVL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:11:27 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:42721 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:11:20 -0400
Received: by mail-il1-f173.google.com with SMTP id l5so6145327ilv.9;
        Fri, 26 Mar 2021 14:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkBaBBFDeht7SNCFuW/9Y03CUQmfjoZwU61Yl9kHu38=;
        b=sVlUJjJUR5xwTVl7gvcL2FaA+q3ONOp6JZw7j4uXuh/i3tqI6+9aO4bgrsRg8QMTjr
         LBPyMppNpIlWggVwbqcJCaXyQ+BU3AMCrJET4iezMr3lB6syKiZwYZ7XIktwrF91YSgM
         qexMmwbOK1Be9QE4L+wF3xdOlYSnj57XMr6y0pKCav4Dj95KIvw9lbw+lHYTLkYGY+AV
         oysUFhg7THay6G1vx1s2/Ipu7VcoQHqsRFXLPmBLlfDKMQv++/K5n8C5Uj9UvclNZ/Vq
         mlNEsCd8BFiythGUFenDn/X8hunmiwqkBLe0V3qnLaaYNrYZoDvJ3Hqh4ZJsdnFv+YIE
         4p3Q==
X-Gm-Message-State: AOAM5314ZtDTKGoq/S12zBiFzJ+zlNicoAwShJcLTu9hOc+zZs+ykOsU
        eHtGHjJoE2COaZAYDy+BuA==
X-Google-Smtp-Source: ABdhPJyzxh6B5HL61Cx6KQl31O7AADpeoiH2Q7TPj2sdXOcMG9TavfGkT5IOjMJSftGn1xJE9EDCPQ==
X-Received: by 2002:a92:730a:: with SMTP id o10mr11910426ilc.160.1616793079008;
        Fri, 26 Mar 2021 14:11:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y3sm4842556iot.15.2021.03.26.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:11:18 -0700 (PDT)
Received: (nullmailer pid 3867570 invoked by uid 1000);
        Fri, 26 Mar 2021 21:11:17 -0000
Date:   Fri, 26 Mar 2021 15:11:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 (RESEND) 3/7] spmi: hisi-spmi-controller: move driver
 from staging
Message-ID: <20210326211117.GA3862036@robh.at.kernel.org>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
 <697f26c380dc2c22c07bedc63a0eab8c9325fccc.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697f26c380dc2c22c07bedc63a0eab8c9325fccc.1616695231.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 07:05:35PM +0100, Mauro Carvalho Chehab wrote:
> The Hisilicon 6421v600 SPMI driver is ready for mainstream.
> 
> So, move it from staging.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../spmi/hisilicon,hisi-spmi-controller.yaml  |  71 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/spmi/Kconfig                          |   9 +
>  drivers/spmi/Makefile                         |   1 +
>  drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ------------------
>  .../hisilicon,hisi-spmi-controller.yaml       |  71 ----
>  9 files changed, 455 insertions(+), 450 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
>  create mode 100644 drivers/spmi/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> new file mode 100644
> index 000000000000..6b755039a74c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/hisilicon,hisi-spmi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon SPMI controller
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |
> +  The HiSilicon SPMI BUS controller is found on some Kirin-based designs.
> +  It is a MIPI System Power Management (SPMI) controller.
> +
> +  The PMIC part is provided by
> +  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
> +
> +allOf:
> +  - $ref: spmi.yaml#
> +
> +properties:
> +
> +  $nodename:
> +    pattern: "spmi@[0-9a-f]"
> +
> +  compatible:
> +    const: hisilicon,kirin970-spmi-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +  spmi-channel:

Generic to SPMI or HiSilicon specific? Needs to be documented in the 
appropriate place and named appropriately.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spmi-channel
> +
> +patternProperties:
> +  "@[0-9a-f]$":

       type: object

> +    description: |
> +      PMIC properties, which are specific to the used SPMI PMIC device(s).
> +      When used in combination with HiSilicon 6421v600, the properties
> +      are documented at
> +      drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      spmi: spmi@fff24000 {
> +        compatible = "hisilicon,kirin970-spmi-controller";
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x0 0xfff24000 0x0 0x1000>;
> +        spmi-channel = <2>;
> +
> +        pmic@0 {
> +          reg = <0 0>;
> +          /* pmic properties */
> +        };
> +      };
> +    };
