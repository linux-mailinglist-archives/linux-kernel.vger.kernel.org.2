Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9735E091
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbhDMNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:49:32 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:37467 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbhDMNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:49:29 -0400
Received: by mail-oo1-f54.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so3823829oot.4;
        Tue, 13 Apr 2021 06:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPp8f1sOttmW9qE2ykHdzJcGKB/6rMwTRWEU3ycTH2A=;
        b=qmGN4CkGJZVEa9mPzEnQpIZYreWoPj4lRkcv/P0z3OUHF8sMyOEg/xT2ykcsu66Lw2
         3ER7Tiqn7+MaQA5/EemVijgBM7ypc2JKQBZNB8oP1qb5Lde5lhxVHbDPZfnEqv5QAcP1
         fla1WZkITuuZh3LmgcY5Wkj5Lv2JdlLQHnMmi96PsuXdyHhbkUBIMVRyYdzyNRIKqGaL
         0YHSRNPEPYhh8AAbFPZg/vAR7C3OKel9+db+CYC26N9xBI/N65LzKZqPjSWvbi9bzi40
         pdIMWX7OZCMvbIyywebv/5EUifI4I3VJjz5jW8DJUEiEc71UV6rTgvPQSfZ3kfXSQKgw
         EPZA==
X-Gm-Message-State: AOAM530drNTxbxYhrEpncSQIFf0DObNmu1siQ7hMAZBNDHXDfqNpBmk6
        JhHahnfEiumHCtUVuJpRe7Snjsjbeg==
X-Google-Smtp-Source: ABdhPJw0Vw8Z1kQ1jPM5GwBfySUTY++fjq8ZEMWc4yQCjwQPjrABcVI5iL8Xk2kVddqjw9QIhLswdg==
X-Received: by 2002:a4a:bc92:: with SMTP id m18mr3988186oop.55.1618321748787;
        Tue, 13 Apr 2021 06:49:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f129sm2904769oia.9.2021.04.13.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:49:07 -0700 (PDT)
Received: (nullmailer pid 1550857 invoked by uid 1000);
        Tue, 13 Apr 2021 13:49:06 -0000
Date:   Tue, 13 Apr 2021 08:49:06 -0500
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
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
Message-ID: <20210413134906.GA1538655@robh.at.kernel.org>
References: <20210409031332.21919-1-quan@os.amperecomputing.com>
 <20210409031332.21919-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409031332.21919-2-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:13:29AM +0700, Quan Nguyen wrote:
> Adds device tree bindings for SMPro drivers found on the Mt.Jade hardware
> reference platform with Ampere's Altra Processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
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

Again, not very specific. There's only 1 version of 'smpro' h/w or 
firmware? Are the firmware version and features discoverable? If not, 
you need to be more specific (or better yet, make them discoverable).

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

You don't need these child nodes in DT if there are no resources 
associated with them. The parent driver can instantiate all the 
sub-functions.

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
