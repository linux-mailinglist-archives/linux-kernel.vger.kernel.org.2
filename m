Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1E4169A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbhIXByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbhIXByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:54:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43572C061760;
        Thu, 23 Sep 2021 18:52:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r26so12459402oij.2;
        Thu, 23 Sep 2021 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNrerwDTZGxLcdkOBcTUO8N76tKvz+gTytgsfxC8kqo=;
        b=M9lFXCUnequUjUG92o/gTm4XPT5JAAjyJkNrKAPehw3EiuweUlAuNnMfYbD2Y5giOm
         brNC3rLGgNU0UnMfKYtYqGJH9PKiHMFgmyr7lcsdJYVeClgM9diBK/3DKFrAEzgzIX3e
         Ih0zRAEeGb/ufbLWcpXnbFKrIX109Y8z8hdM2CaBxSoQHO1wNd86axbSDvEtT1okJXH3
         pYHSJQGTLuXAZqE1AaTyYmZNEnW/gvbmKx/SqBhXUWfT77m5HUSvv32c0RaGdyb2Bk3a
         TJl52Ft6gB2MbRzw9WCJJVsDWgsGQgsg0I9mn8JqQ/TbAYei3qTjBfnOcKsUXIXxc6zN
         l9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zNrerwDTZGxLcdkOBcTUO8N76tKvz+gTytgsfxC8kqo=;
        b=dzHZo124zJRsT059iLg+WV86AnD5XYEiUkk91xiLLulPxM0ewvhXSo8CvQwpk/uDua
         +g6BAyUSQo0oIz6QBNnq1oLETzie4pl+BY0cCDCUxkKuMWBhD6dx8Gz8p0a8z8frsKF7
         nFBd2IicVr0qZQmevO4KHicuD9VM+QZt4nyVBdADeaQf3ZjChgQ/aaNO35nkTf/MKiCi
         6q2SDtkQVGt8Sx8JqxSbD03xccywyzK5YgpPJh7FCtl5xKeLWcORVhl+If+r6dduoQNH
         7UbzzR3demjsDBVdgHM+UH796IBRFM9s3h3r5+QmcliWorUBQlOaP7fhoiKucCPuowoY
         XTZw==
X-Gm-Message-State: AOAM5316BftQkUSa41VAVMU9BXMpEEzLVr5p9lECpwlpofTz/y9CHd3e
        Il7x1G1Q35G+NrDdYC56cMs=
X-Google-Smtp-Source: ABdhPJxJMakJkTYYDZ/9gg3XmJaqOuPAwDPMmxQjzyLf+9E7t2vuZRT0OPjQQe+7eoM1KV9q0JaaIA==
X-Received: by 2002:aca:5887:: with SMTP id m129mr10769874oib.123.1632448350626;
        Thu, 23 Sep 2021 18:52:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7sm1808051ooa.36.2021.09.23.18.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:52:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:52:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: hwmon: ti,tmp108: convert to dtschema
Message-ID: <20210924015228.GA3030756@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:27PM +0200, Krzysztof Kozlowski wrote:
> Convert the TI TMP108 temperature sensor bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ti,tmp108.yaml  | 50 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/tmp108.txt      | 18 -------
>  2 files changed, 50 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/tmp108.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
> new file mode 100644
> index 000000000000..eda55bbc172d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMP108 temperature sensor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmp108
> +
> +  interrupts:
> +    items:
> +      - description: alert interrupt
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@48 {
> +            compatible = "ti,tmp108";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&tmp_alrt>;
> +            #thermal-sensor-cells = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt b/Documentation/devicetree/bindings/hwmon/tmp108.txt
> deleted file mode 100644
> index 54d4beed4ee5..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -TMP108 temperature sensor
> --------------------------
> -
> -This device supports I2C only.
> -
> -Requires node properties:
> -- compatible : "ti,tmp108"
> -- reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
> -
> -Optional properties:
> -- interrupts: Reference to the TMP108 alert interrupt.
> -- #thermal-sensor-cells: should be set to 0.
> -
> -Example:
> -	tmp108@48 {
> -		compatible = "ti,tmp108";
> -		reg = <0x48>;
> -	};
