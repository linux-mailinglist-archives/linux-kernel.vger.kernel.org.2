Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD723701F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhD3UUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:20:16 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38740 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhD3UUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:20:10 -0400
Received: by mail-ot1-f41.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so10739993otj.5;
        Fri, 30 Apr 2021 13:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05YajdrOgDhUy0VSmK12HSI6pp+IeJDTyJyysQF3p7o=;
        b=nM9kSLAqN8CtFxCogI9Gc2rb223cOvNH/+rwMxhWHdiIsDKFfEXybEUTODR5CkJvqT
         9zPHR9iJFvF2qB8rX6EgXm6SW/F9VfGVcOlX29xpEATOP3FuMyMV4XgxSPbMyO6OEvEs
         eLAPENgMIfjYmTeZSjBGO/ZN5X+phffm0RUDRKtDItNz+tX+dyE7+ZiG9SqtZkVcZIzQ
         jSP2yjcPP76E9BsLSDFUbQwY3n7vegHW/IBnUw/rP3T7nTuQ78wk/txPZg9RMOwpLbNS
         KE/yAcncLda9nU4jmcAixTaaE9KzOpLaV/9o0UxQJfMMAciAxNt7CnwCSLmkJicQudyg
         YVwA==
X-Gm-Message-State: AOAM533X/6z+3XBp231oVrmAE5p4aqW6GeN3QCdwyfHWXMTJ6ZdpoKsP
        SzX5JV0qTYCt5yksqdz1E8cGpg85/Q==
X-Google-Smtp-Source: ABdhPJyhpwkye5/a50dVpExQW5qA9sdb/0cba2fjbZX1NCBrx5NgquzmypopNGw2rU4zxKfPMbFpAw==
X-Received: by 2002:a9d:61c7:: with SMTP id h7mr5030835otk.360.1619813960116;
        Fri, 30 Apr 2021 13:19:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm985926oia.22.2021.04.30.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:19:19 -0700 (PDT)
Received: (nullmailer pid 3818585 invoked by uid 1000);
        Fri, 30 Apr 2021 20:19:18 -0000
Date:   Fri, 30 Apr 2021 15:19:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
Message-ID: <20210430201918.GA3806853@robh.at.kernel.org>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
 <20210422090843.4614-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422090843.4614-2-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:08:40PM +0700, Quan Nguyen wrote:
> Adds device tree bindings for SMPro driver found on the Mt.Jade hardware
> reference platform with Ampere's Altra Processor family.
> 
> The SMpro co-processor on Ampere Altra processor family is to monitor
> and report various data included hwmon-related info, RAS errors, and
> other miscellaneous information. This parent SMPro MFD driver creates
> a single simple register map to be shared by all sub-devices and leave
> all the specific to be handled by the child drivers.

Again, just because you have multiple functions aka MFD, that doesn't 
mean you need child nodes for each function. The only thing you have 
in DT is a register address. Does this vary? If so, how often? How many 
different versions of a DT do you currently or expect to have? 

> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Changes in v4:
>   + Revised the commit message to clarify how the specific info will
>     be handled commented by Rob.
> 
> Changes in v3:
>   + Supported list of compatible string [Rob]
>   + Introduced reg property in DT to specify reg offset [Rob]
>   + Updated description and other minor changes in yaml file [Rob]
> 
> Changes in v2:
>   + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
> 
>  .../bindings/hwmon/ampere,ac01-hwmon.yaml     |  28 +++++
>  .../devicetree/bindings/mfd/ampere,smpro.yaml | 105 ++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
> new file mode 100644
> index 000000000000..fbf7ec754160
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ampere,ac01-hwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hardware monitoring driver for the Ampere Altra SMPro
> +
> +maintainers:
> +  - Quan Nguyen <quan@os.amperecomputing.com>
> +
> +description: |
> +  This module is part of the Ampere Altra SMPro multi-function device. For more
> +  details see ../mfd/ampere,smpro.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ampere,ac01-hwmon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> new file mode 100644
> index 000000000000..5613c420869e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ampere,smpro.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ampere Altra SMPro firmware driver
> +
> +maintainers:
> +  - Quan Nguyen <quan@os.amperecomputing.com>
> +
> +description: |
> +  Ampere Altra SMPro firmware may contain different blocks like hardware
> +  monitoring, error monitoring and other miscellaneous features.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ampere,smpro
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^hwmon(@[0-9a-f]+)?$":
> +    $ref: ../hwmon/ampere,ac01-hwmon.yaml
> +
> +  "^misc(@[0-9a-f]+)?$":
> +    type: object
> +    description: |
> +      This module is part of the Ampere Altra SMPro multi-function device
> +      to support miscellaneous features
> +    properties:
> +      compatible:
> +        enum:
> +          - ampere,ac01-misc
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +  "^errmon(@[0-9a-f]+)?$":
> +    type: object
> +    description: |
> +      This module is part of the Ampere Altra SMPro multi-function device
> +      that supports error monitoring feature.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ampere,ac01-errmon
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        smpro@4f {
> +            compatible = "ampere,smpro";
> +            reg = <0x4f>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            hwmon@10 {
> +                compatible = "ampere,ac01-hwmon";
> +                reg = <0x10>;
> +            };
> +
> +            misc@b0 {
> +                compatible = "ampere,ac01-misc";
> +                reg = <0xb0>;
> +            };
> +
> +            errmon@80 {
> +                compatible = "ampere,ac01-errmon";
> +                reg = <0x80>;
> +            };
> +
> +        };
> +    };
> -- 
> 2.28.0
> 
