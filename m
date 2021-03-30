Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3534F2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhC3VP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:15:58 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44008 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhC3VPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:15:48 -0400
Received: by mail-ot1-f48.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so16886379otn.10;
        Tue, 30 Mar 2021 14:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4vChBJJ6EYanz1jBGjgMMr+PeNDASuUg2ns+WfjA4bE=;
        b=Y4NdCJdErHKaL02ZuUGc2ZE1hE7jk4HCNXXd+PI46gRdVXlKemjcOUEWnIvNlnYIyK
         Ct4YyshrTRPqXUayqy4KSqw37z5kPYGrQ93YN9F89gbIyEXdyhA96v1PgXpFb2d8QtiH
         6Xgtjq8SKtcQrONkPcswltGHJ1/k043SPK84fDFhdkaYpqiZvtqidiigsPP6SSILnYGP
         wb16v8OXdzs3kxZTb3cX5FAFSTX4h0zEANlkTGqttLX9Zl1Hi+6EWwrjRBi/Tj//2s3V
         armZ7WbxKk0yxjASiBBhcR/VnWw4XDRmIQAk8J95i/r7xsaGcHe4Lx+ygCx6I0ajCitn
         zCrg==
X-Gm-Message-State: AOAM531fWlprwUXDfjRIx3fqm/ABvC3VjjLTMMut3oC7blWBZ46n01dS
        GCAf9r1uD7Ehl8dmZhwqZw==
X-Google-Smtp-Source: ABdhPJz0LTLMITQ7Y8/X5B6FbMkC38+yfV0Tx1qBMnvJjdAy8X4mInt+GzTPko2+l4MglZX/rGRzRA==
X-Received: by 2002:a9d:171d:: with SMTP id i29mr28517424ota.294.1617138948168;
        Tue, 30 Mar 2021 14:15:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j4sm15914oom.11.2021.03.30.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:14:51 -0700 (PDT)
Received: (nullmailer pid 729378 invoked by uid 1000);
        Tue, 30 Mar 2021 21:14:44 -0000
Date:   Tue, 30 Mar 2021 16:14:44 -0500
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
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
Message-ID: <20210330211443.GA326528@robh.at.kernel.org>
References: <20210329015238.19474-1-quan@os.amperecomputing.com>
 <20210329015238.19474-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015238.19474-2-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 08:52:35AM +0700, Quan Nguyen wrote:
> Adds device tree bindings for SMPro drivers found on the Mt.Jade hardware
> reference platform with Ampere's Altra Processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  .../bindings/hwmon/ampere,ac01-hwmon.yaml     | 27 ++++++
>  .../devicetree/bindings/mfd/ampere,smpro.yaml | 82 +++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
> new file mode 100644
> index 000000000000..015130a281f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
> @@ -0,0 +1,27 @@
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
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> new file mode 100644
> index 000000000000..bf789c8a3d7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> @@ -0,0 +1,82 @@
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
> +    const: ampere,smpro

Only 1 version of SMPro? Needs to be more specific or provide details on 
how the exact version of firmware/hardware is discovered.

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
> +    description: Ampere Altra SMPro Misc driver

Bindings describe h/w, not drivers.

> +    properties:
> +      compatible:
> +        const: "ampere,ac01-misc"
> +
> +  "^errmon(@[0-9a-f]+)?$":
> +    type: object
> +    description: Ampere Altra SMPro Error Monitor driver
> +    properties:
> +      compatible:
> +        const: "ampere,ac01-errmon"
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
> +            hwmon {
> +                compatible = "ampere,ac01-hwmon";
> +            };
> +
> +            misc {
> +                compatible = "ampere,ac01-misc";
> +            };
> +
> +            errmon {
> +                compatible = "ampere,ac01-errmon";
> +            };

None of the child nodes have any resources in DT, so you don't need 
them in DT.

Rob
