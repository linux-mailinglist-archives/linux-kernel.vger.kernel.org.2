Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442784169D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbhIXCJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbhIXCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:09:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC732C061574;
        Thu, 23 Sep 2021 19:08:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so4299325otv.4;
        Thu, 23 Sep 2021 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AMAmYVrWAHvl2rx0+S+khopG5lyTmrN8QbDyPOk2GQY=;
        b=gkZdengo36l8eJRckb6gDuaWN2pIXS72aLAZZlYVSS/hqgC3Wzu6zcEmyrHPpyhZBe
         SXtjAv1t2xf3Hu3fCglr9IAddOfgY7tUuiyuzmFTxQgj1lfz1RfOFSEaL/UskzCgbo5G
         FYG7MHSI7cJQLQ91RfyD7qV5nUlHJRz5nZINp38Fj08kGcAy/Y7EdLQxQnF8owCttR0+
         l6ls3/Z8g7KPfv2AOAUrv8qmtNZMdRcUlyI3N9sNQLXOOjWKGlx+ncVUJ0t4V7o6Ujf3
         Un+zQwckqN9Tsj6I4XoRq6I6k5SjjEVjsmrymWp+c+6lJ/9jxhljLpso2OLla7eMkPjY
         b54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AMAmYVrWAHvl2rx0+S+khopG5lyTmrN8QbDyPOk2GQY=;
        b=VcY8lOEQi2/ghkBCktgcNYJjt8s1GQAhNjmE0ZgLmw5lVgUD7/Fs1NORBejzmpaMbX
         KkWQMk3kPZw8LpvTq7HWjOo9rmVd/8JwWfjiRpOv89wM2MWaEY4D9y/ECNNbkIdmYh9y
         YWNkToRJ1LEyJ637nDapfJZgfBDkv1pw75lQjGS4EK9LjzES/EnfnOx1GI4+jEsIFRBW
         hoiLYbcLUuWhukl6AzrFVshan6bhaERTJByG59sQ6YIslK7hdHKx860CMc4tH54DlTO8
         81O3d/tCtCleaYaBeqcqd8YWKPvvNkDwqec/9QQUE12zIbdMRLoMXTHX5qFDP6K5prko
         oFxw==
X-Gm-Message-State: AOAM532PVu+/nXEYbLvjrnrjuVQvpjySC1sXQpJhqsT1trlUsiUuOuv0
        /YkF/MY6ybp7nMqfkm8obiA=
X-Google-Smtp-Source: ABdhPJwftgmQ8LKyKB0exPdsgV+qXsaDjNZdLIQAsZMPC7vkr6c0XKApHtBsZMZi8Io1rfM3TGmyeQ==
X-Received: by 2002:a9d:332:: with SMTP id 47mr1716789otv.333.1632449296386;
        Thu, 23 Sep 2021 19:08:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26sm355609otn.67.2021.09.23.19.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:08:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:08:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: hwmon: jedec,jc42: convert to dtschema
Message-ID: <20210924020814.GA3032194@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:13PM +0200, Krzysztof Kozlowski wrote:
> Convert the Jedec JC-42.4 temperature sensor bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/jc42.txt        | 46 -------------
>  .../devicetree/bindings/hwmon/jedec,jc42.yaml | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 70 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/jc42.txt b/Documentation/devicetree/bindings/hwmon/jc42.txt
> deleted file mode 100644
> index f569db58f64a..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/jc42.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -Properties for Jedec JC-42.4 compatible temperature sensors
> -
> -Required properties:
> -- compatible: May include a device-specific string consisting of the
> -	      manufacturer and the name of the chip. A list of supported
> -	      chip names follows.
> -	      Must include "jedec,jc-42.4-temp" for any Jedec JC-42.4
> -	      compatible temperature sensor.
> -
> -	      Supported chip names:
> -		adi,adt7408
> -		atmel,at30ts00
> -		atmel,at30tse004
> -		onnn,cat6095
> -		onnn,cat34ts02
> -		maxim,max6604
> -		microchip,mcp9804
> -		microchip,mcp9805
> -		microchip,mcp9808
> -		microchip,mcp98243
> -		microchip,mcp98244
> -		microchip,mcp9843
> -		nxp,se97
> -		nxp,se98
> -		st,stts2002
> -		st,stts2004
> -		st,stts3000
> -		st,stts424
> -		st,stts424e
> -		idt,tse2002
> -		idt,tse2004
> -		idt,ts3000
> -		idt,ts3001
> -
> -- reg: I2C address
> -
> -Optional properties:
> -- smbus-timeout-disable: When set, the smbus timeout function will be disabled.
> -			 This is not supported on all chips.
> -
> -Example:
> -
> -temp-sensor@1a {
> -	compatible = "jedec,jc-42.4-temp";
> -	reg = <0x1a>;
> -};
> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> new file mode 100644
> index 000000000000..a7bb4e3a1c46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/jedec,jc42.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Jedec JC-42.4 compatible temperature sensors
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: jedec,jc-42.4-temp
> +      - items:
> +          - enum:
> +              - adi,adt7408
> +              - atmel,at30ts00
> +              - atmel,at30tse004
> +              - idt,tse2002
> +              - idt,tse2004
> +              - idt,ts3000
> +              - idt,ts3001
> +              - maxim,max6604
> +              - microchip,mcp9804
> +              - microchip,mcp9805
> +              - microchip,mcp9808
> +              - microchip,mcp98243
> +              - microchip,mcp98244
> +              - microchip,mcp9843
> +              - nxp,se97
> +              - nxp,se98
> +              - onnn,cat6095
> +              - onnn,cat34ts02
> +              - st,stts2002
> +              - st,stts2004
> +              - st,stts3000
> +              - st,stts424
> +              - st,stts424e
> +          - const: jedec,jc-42.4-temp
> +
> +  reg:
> +    maxItems: 1
> +
> +  smbus-timeout-disable:
> +    description: |
> +      When set, the smbus timeout function will be disabled. This is not
> +      supported on all chips.
> +    type: boolean
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
> +        temp-sensor@1a {
> +            compatible = "jedec,jc-42.4-temp";
> +            reg = <0x1a>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b07679009af2..15c4d3c809e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10033,6 +10033,7 @@ JC42.4 TEMPERATURE SENSOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>  F:	Documentation/hwmon/jc42.rst
>  F:	drivers/hwmon/jc42.c
>  
