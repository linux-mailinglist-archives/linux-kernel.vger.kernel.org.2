Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83FA4169B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhIXB5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:57:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96861C061574;
        Thu, 23 Sep 2021 18:55:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w206so12468996oiw.4;
        Thu, 23 Sep 2021 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ezYXT7lx1DMyi79smc8gAocvesXupY5YdDbkThvPxwk=;
        b=cU+q0OgS9IsiqCudoJA3jJ/wdrokQxQ7kp27a3JpWvB7U/IS+jFoAxCF0GaP7k4eHN
         jaZIVh3WhkJAbF/Sn6XXhCQODpmTOy28YkNxV34Aog9rs8ya7DrJpiVgWHS2PihG7tfm
         KdKG7gBRi+b9aBL25Pg58fwfUxdPAoh9/7ILNb70iLpUacathyQx5+1qZMxKlF1YzZ1P
         oRUJGo/oP8Q17nCtj+G0jftEBV8kEXil7jV904095olIufZJWruuDg+xnXkVZMw19GCs
         M7MpmL0ojCeLP+Kn2/huUcZDIbuJgTUKDU7rAS/fR//bWk6/3onRFXjhrlBAx95bfCEu
         5fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ezYXT7lx1DMyi79smc8gAocvesXupY5YdDbkThvPxwk=;
        b=CYG7mLQo/9fW55oUoHG7P4cOuk7wCAqLF1ETEewV3hP/VV16L+EMZNJcmKSVufISpV
         0/buEz78ofUSIAFs46V1SkyTOzX4Iw1W8Y3Nk0SE/lnT+IMi55OsZrAyVtSAjM3ZcUE+
         MEZoq63BUgWcx4uLOvRtOG3YvxQO+d4j1pVOp1SNL/5Uo6ec4t3YOzYbbdE6F0VTuNXS
         NdRfS3Ttrbgvg/kT1GA+AT0me6pYAAJjNsbP8Z05D8Gh/jttojDchQAp7a2M7LUo2DfP
         KQ/54M+MpqI1n9ASk0wepbUPD2/052QuTQA/9b56hfOWQqAN2U5kVLwqZLIBR7lQUAJX
         NwEA==
X-Gm-Message-State: AOAM530kMxxCzaVBi89G+u3xXgPHHKQygYZpHDVpeCXHScL2/aEwizin
        IbNnXEj9GoSa6TnQXdfqo60=
X-Google-Smtp-Source: ABdhPJxWSaBr3t9NH99NeTcym/RaIawHPoiEdLvjg445e3gWhqOI5FRMRSFAaxqzPofNrjXSdHBXsQ==
X-Received: by 2002:a05:6808:13c9:: with SMTP id d9mr6371338oiw.165.1632448547043;
        Thu, 23 Sep 2021 18:55:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t80sm1833990oie.9.2021.09.23.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:55:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:55:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: hwmon: lltc,ltc4151: convert to dtschema
Message-ID: <20210924015545.GA3031064@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:30PM +0200, Krzysztof Kozlowski wrote:
> Convert the LTC4151 current and voltage sensor bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/lltc,ltc4151.yaml          | 41 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/ltc4151.txt     | 18 --------
>  2 files changed, 41 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc4151.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
> new file mode 100644
> index 000000000000..4b5851c326f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/lltc,ltc4151.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTC4151 High Voltage I2C Current and Voltage Monitor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    const: lltc,ltc4151
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt resistor value in micro-Ohms
> +    default: 1000
> +
> +required:
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
> +        sensor@6e {
> +            compatible = "lltc,ltc4151";
> +            reg = <0x6e>;
> +            shunt-resistor-micro-ohms = <1500>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/ltc4151.txt b/Documentation/devicetree/bindings/hwmon/ltc4151.txt
> deleted file mode 100644
> index d008a5ef525a..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ltc4151.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -LTC4151 High Voltage I2C Current and Voltage Monitor
> -
> -Required properties:
> -- compatible: Must be "lltc,ltc4151"
> -- reg: I2C address
> -
> -Optional properties:
> -- shunt-resistor-micro-ohms
> -	Shunt resistor value in micro-Ohms
> -	Defaults to <1000> if unset.
> -
> -Example:
> -
> -ltc4151@6e {
> -	compatible = "lltc,ltc4151";
> -	reg = <0x6e>;
> -	shunt-resistor-micro-ohms = <1500>;
> -};
