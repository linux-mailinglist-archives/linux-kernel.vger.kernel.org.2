Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33A94169B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbhIXB70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbhIXB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:59:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3236C061574;
        Thu, 23 Sep 2021 18:57:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 24so12520706oix.0;
        Thu, 23 Sep 2021 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XwMUpHWHdZN4NHuO4gz678VcNaVlC+0PuUEAOf6ntyQ=;
        b=HKddQJESF9tmClboBpprQhaL4MrI9rbNqACbBFYvnMnuvxMtqZPKDV8iqS/DgF06q1
         eaQRFOTbUa4oztDFcdDszY3tKQce/vZfIbacPicPy8T751a9AKNVMu8WzS8WW9B+TIaP
         tI2BnRgWT+B3FcwgftMfjbsCFw35ZtJZeeJ6BWpF6gnzWzw0dlJWdUO3px2C3eEl4rNU
         IC+mqtBT9rEZpJai9vEUAzb1NKqZcgx2Igds8g63aTpnJMZuGrRQO3wvOenD8KPGXaZI
         gG+eqrg6G8N1wzC06/ZIvhazbrrBvgbp8UObMU+G1nXc1vUNbI1ixEwIJ0ykhtdR9r34
         m6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XwMUpHWHdZN4NHuO4gz678VcNaVlC+0PuUEAOf6ntyQ=;
        b=D4A05fT5xOnc6BbzVZO8FVhv1zoHhYuNmLkcZ2n1k26KTpkYx2HbRcQCz8J/FHBkf8
         gVktsKMQX3Mk/KSLCmexgLKwLerJkB8l0Z7L0HNiAIXVF4Ptv8PSSypYIaMwV5MUn6pC
         lh94VwG8I8WxbVwjnTESFyHIE5idl91GlfGmw7bAabnLm87YFMEjjMF8RxnNrzaRWc0g
         XdrV//+PyI7mrWT/aMwqMzrR59E9+IoHb6Tn77gbjBx+PRSwAB2mao9OeuxOAxhCx2F5
         jSXEKFsbEpLsEytGtJSWNnlJoxNhZ0dLb2Ay591MittvG/KOJNpAH1mMTiFaNTlFenkS
         YIOA==
X-Gm-Message-State: AOAM530bC+sCGqbz0f5grIjcQfkmzoKCIata2VH6nqQP1FxREYAnCoDy
        TgSs2Syhh3hag+FAgog71s8=
X-Google-Smtp-Source: ABdhPJzGldP3OT159DfdHm+3h6zYt8n1O4u4DEsjSxhdCZ83/TGBUIQcbY1O4zCdP5G4n03jQA1FZg==
X-Received: by 2002:aca:3bc2:: with SMTP id i185mr5996011oia.67.1632448672393;
        Thu, 23 Sep 2021 18:57:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10sm1875970ooj.24.2021.09.23.18.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:57:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:57:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: sensirion,sht15: convert to
 dtschema
Message-ID: <20210924015750.GA3031369@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:32PM +0200, Krzysztof Kozlowski wrote:
> Convert the Sensirion SHT15 humidity sensor to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/sensirion,sht15.yaml       | 43 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/sht15.txt       | 19 --------
>  2 files changed, 43 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/sht15.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
> new file mode 100644
> index 000000000000..4669217d01e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,sht15.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHT15 humidity and temperature sensor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    const: sensirion,sht15
> +
> +  clk-gpios:
> +    maxItems: 1
> +
> +  data-gpios:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: regulator that drives the VCC pin
> +
> +required:
> +  - compatible
> +  - clk-gpios
> +  - data-gpios
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sensor {
> +        compatible = "sensirion,sht15";
> +        clk-gpios = <&gpio4 12 0>;
> +        data-gpios = <&gpio4 13 0>;
> +        vcc-supply = <&reg_sht15>;
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_sensor>;
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/sht15.txt b/Documentation/devicetree/bindings/hwmon/sht15.txt
> deleted file mode 100644
> index 6a80277cc426..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/sht15.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Sensirion SHT15 Humidity and Temperature Sensor
> -
> -Required properties:
> -
> - - "compatible": must be "sensirion,sht15".
> - - "data-gpios": GPIO connected to the data line.
> - - "clk-gpios": GPIO connected to the clock line.
> - - "vcc-supply": regulator that drives the VCC pin.
> -
> -Example:
> -
> -	sensor {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_sensor>;
> -		compatible = "sensirion,sht15";
> -		clk-gpios = <&gpio4 12 0>;
> -		data-gpios = <&gpio4 13 0>;
> -		vcc-supply = <&reg_sht15>;
> -	};
