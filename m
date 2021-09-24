Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3054169B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbhIXB6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbhIXB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:58:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A9C061574;
        Thu, 23 Sep 2021 18:56:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso11137220ota.8;
        Thu, 23 Sep 2021 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h06XWVZMzx/fClrR33x5U7yyMWwgEljfMFyGArSZ5RY=;
        b=C13j7yoeoeHcocbbWfOM/peDMgPbquqH75fqgvuXuI1Ojmc/FlUGc/4F8EuzKNZDrP
         pn93K85jIf9kDN7NdGPQAKFIQU3O4F6zY6/QsRnWYWI4rt2nl23Xgb9c31SkU6EILGRh
         shcK0GgbjPD2njFuf08rNJm66FpNLFG0UeuaflQSuvGzsPPYrw9QWrMTpDGaCPbWXHfa
         D30biWnvOLWVRn3kBiEW9PBc+sfav3O76RpEUy3TgjaSL0SdEfj8MwO+UpGC6+QGDKdy
         zHeW8LBie63LcrSG24IOYUVYKKeNC8bx9K9WyKoDmo0CpLiYkkm3hnXLBWjQHnQSqxdN
         mTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h06XWVZMzx/fClrR33x5U7yyMWwgEljfMFyGArSZ5RY=;
        b=PU++mqo9rMl7f+labQ8cs3nptjJ7wxDB4MpYc1w4Bcjy+N33q3lEVKoX2y3Z5Wz6+o
         WVbxP3JCVXCSVVFuySnfIe/J1ERwwKaVByWZnZBEGfP9xaPYG9/mOygko4AGIRiw72Ud
         ZSc+cRi4nc7u6YNgC1NGM2AirQLewYLfWl3R2RwSrOrOewY7FWOkpzfoEwTHhFECXhze
         e4TZhRM/e4S12z3qfax2xofPR4ikv4cvlBZWmqF5vkBXW0EWpDXzS/J0NWNldzL66A3s
         2BYnw+NQkdYBqAFPIaDBEghyHN8KtPHUGOmsk468WfGY+zrb9XNEem0PFzzEBedAV3qf
         Qegg==
X-Gm-Message-State: AOAM531bkThLfP8VZle70jQATKq1TE2RPwx9Zlwr1UK8oximGWeV3pXr
        C1gAGTbF2zyX/wNLTZSEH+k=
X-Google-Smtp-Source: ABdhPJyxOisF016AIW8BiS5hkwIRomwx5crXPAmv2+nVNuJhBj22Fb4dN6+V6EvJKt1egXcrIepj7Q==
X-Received: by 2002:a9d:7019:: with SMTP id k25mr1656080otj.350.1632448592803;
        Thu, 23 Sep 2021 18:56:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d26sm1734683oij.49.2021.09.23.18.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:56:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:56:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: hwmon: microchip,mcp3021: convert to
 dtschema
Message-ID: <20210924015630.GA3031174@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:31PM +0200, Krzysztof Kozlowski wrote:
> Convert the Microchip MCP3021 ADC bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/mcp3021.txt     | 21 ---------
>  .../bindings/hwmon/microchip,mcp3021.yaml     | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/mcp3021.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/mcp3021.txt b/Documentation/devicetree/bindings/hwmon/mcp3021.txt
> deleted file mode 100644
> index 294318ba6914..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/mcp3021.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -mcp3021 properties
> -
> -Required properties:
> -- compatible: Must be one of the following:
> -	- "microchip,mcp3021" for mcp3021
> -	- "microchip,mcp3221" for mcp3221
> -- reg: I2C address
> -
> -Optional properties:
> -
> -- reference-voltage-microvolt
> -	Reference voltage in microvolt (uV)
> -
> -Example:
> -
> -mcp3021@4d {
> -	compatible = "microchip,mcp3021";
> -	reg = <0x4d>;
> -
> -	reference-voltage-microvolt = <4500000>; /* 4.5 V */
> -};
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
> new file mode 100644
> index 000000000000..c42051f8a191
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,mcp3021.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP3021 A/D converter
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp3021
> +      - microchip,mcp3221
> +
> +  reg:
> +    maxItems: 1
> +
> +  reference-voltage-microvolt:
> +    description:
> +      VDD supply power and reference voltage
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
> +        adc@4d {
> +            compatible = "microchip,mcp3021";
> +            reg = <0x4d>;
> +
> +            reference-voltage-microvolt = <4500000>; /* 4.5 V */
> +        };
> +    };
