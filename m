Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5D44EA1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhKLPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:36:44 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35638 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:36:42 -0500
Received: by mail-oi1-f173.google.com with SMTP id m6so18589397oim.2;
        Fri, 12 Nov 2021 07:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDrhavM5gNU8fiGV4yXPS+mEDIrEI/q0tvC/VqQatCU=;
        b=tEtl9yUWXgTCyFvTk87ouGLoOAKzU7ZL5st8+iENO20/OTbxh80kW6wPip7fQWC/43
         MJfiS7IWIua5/BBvn1yKPhWeIcWDjNeKL7czWKuRvkCcSf/Kfwwksm7Ffs/TJTwNMb4E
         nQlISI0YejCSCziYyBeRNlMMXIUhRkMTdG4u3JXkgGGyxpV3WwWAW3GFbHn0ur7Mvmr5
         2+pMjsfHyTQnwaQUfC64CULlzEjnnHmqjDt8EMtI737WG58I2PevsHpK6O7qr70qbwwj
         TnGXkdpGROwuWjI24uM5iKiw2VvApuNVB7G5E0jZgoZXyizmZw0qUpuRP1igHcQKAt22
         dovA==
X-Gm-Message-State: AOAM530gUIOA1aWRtQ5B4L/PGOjj/1zNMjXaNZpaImpCFxnnyWtvTO24
        WPoRYATc7j4PeC63/1p5Bw==
X-Google-Smtp-Source: ABdhPJwPo1ebTBXtx7cRT1OZMYNSVXyxKOypZR2MNKgmDSUgIkvz6F8xujE4mZrawvQvxLffd2sM7A==
X-Received: by 2002:a54:480a:: with SMTP id j10mr6961708oij.34.1636731231381;
        Fri, 12 Nov 2021 07:33:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm1144053oom.32.2021.11.12.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:33:50 -0800 (PST)
Received: (nullmailer pid 2890267 invoked by uid 1000);
        Fri, 12 Nov 2021 15:33:49 -0000
Date:   Fri, 12 Nov 2021 09:33:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vincent Shih <vincent.shih@sunplus.com>
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: Convert Sunplus OCOTP to
 json-schema
Message-ID: <YY6JXT2UK+tyXfdY@robh.at.kernel.org>
References: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
 <1635743712-25358-3-git-send-email-vincent.shih@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635743712-25358-3-git-send-email-vincent.shih@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:15:12PM +0800, Vincent Shih wrote:
> Convert Sunplus OCOTP to json-schema
> 
> Signed-off-by: Vincent Shih <vincent.shih@sunplus.com>

Author and Sob emails don't match.

> ---
>  .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 116 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> new file mode 100644
> index 0000000..2d18f38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/sunplus,sp7021-ocotp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: On-Chip OTP Memory for Sunplus sp7021
> +
> +maintainers:
> +  - Vincent Shih <vincent.shih@sunplus.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-ocotp
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: hb_gpio
> +      - const: otprx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  therm_calib:

s/_/-/ in node names.

> +    type: object
> +    description: thermal calibration values

> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg

You can drop 'reg' as nvmem.yaml should cover that.

> +
> +  mac_addr0:
> +    type: object
> +    description: MAC address of ethernet port 0
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +  mac_addr1:
> +    type: object
> +    description: MAC address of ethernet port 1
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +  disc_vol:
> +    type: object
> +    description: disconnect voltages of usb2 port 0 and port 1
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +
> +    otp: otp@9C00AF00 {

Lowercase hex for unit-address

> +        compatible = "sunplus,sp7021-ocotp";
> +        reg = <0x9C00AF00 0x34>, <0x9C00AF80 0x58>;
> +        reg-names = "hb_gpio", "otprx";
> +        clocks = <&clks OTPRX>;
> +        resets = <&rstc RST_OTPRX>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        therm_calib: therm_calib@14 {
> +          reg = <0x14 0x3>;
> +        };
> +        mac_addr0: mac_addr0@34 {
> +          reg = <0x34 0x6>;
> +        };
> +        mac_addr1: mac_addr1@3A {

Here too. If nvmem.yaml is not checking this, it should be.

> +          reg = <0x3A 0x6>;
> +        };
> +        disc_vol: disc_vol@18 {

Sort nodes in order of unit-address.

> +          reg = <0x18 0x2>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7df2f1..c0ccc95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17950,6 +17950,7 @@ F:	drivers/net/ethernet/dlink/sundance.c
>  SUNPLUS OCOTP DRIVER
>  M:	Vincent Shih <vincent.shih@sunplus.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
>  F:	drivers/nvmem/sunplus-ocotp.c
>  F:	drivers/nvmem/sunplus-ocotp.h
>  F:	drivers/nvmem/sunplus-ocotp0.c
> -- 
> 2.7.4
> 
> 
