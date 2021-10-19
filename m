Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4524340A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJSVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:37:35 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41710 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:37:34 -0400
Received: by mail-ot1-f48.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so3678661ote.8;
        Tue, 19 Oct 2021 14:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xbQGFzivhpvVw2AMdu/JQq7yxujXnqSJPyy32VIDIa4=;
        b=FJH6GOfCj/XXZJP9NIiPEF01RYMNlV0C413qus9ADUyM+2qaoY5h44e/Ei5QnM51LX
         7LvKdR43R4/XHUItHi6i98pT0R2JdeyYNMG2ji57w9bNbxKoNfTelyvRXwcssnCtLeGi
         n3XXbtCBdmvW0lufwJFIyWwJNs2RiIKmno5tPNesRHvTgsbegUQoN68CrSj9gFzpFvbM
         jrapu3+MxRiC2fjp0LnwGVGP+fMp4NI4vt870YV3BjC7hObxYuRqYJvKILULqqApy4LV
         WzaNPEEOffEWa8a6lPEiiPc3CmvoCjtlxzsQdxGwq0xeEexqw4wngGvwMYjwH1uiGxRn
         nK3w==
X-Gm-Message-State: AOAM533S9p1yS7ujogsz5VQcBqFFTXEUadQol98oeAFgsQ7+CQBLbMMl
        wNjyj0YMR/p7IqG+cQbI7Q==
X-Google-Smtp-Source: ABdhPJxSgDWR+Ryh7YMTDSSXIL/rS/rBi87TDKPfqO64NwUKIjrQjgMURUgGELXKqNJto4I2tpJ2xQ==
X-Received: by 2002:a9d:2a8:: with SMTP id 37mr7507545otl.58.1634679321127;
        Tue, 19 Oct 2021 14:35:21 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-67-78-118-34.sw.biz.rr.com. [67.78.118.34])
        by smtp.gmail.com with ESMTPSA id f1sm56616oos.46.2021.10.19.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:35:19 -0700 (PDT)
Received: (nullmailer pid 879931 invoked by uid 1000);
        Tue, 19 Oct 2021 21:35:17 -0000
Date:   Tue, 19 Oct 2021 16:35:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
Message-ID: <YW86Ffa+zoIZpixu@robh.at.kernel.org>
References: <20211009104309.45117-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009104309.45117-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 12:43:09PM +0200, David Heidelberg wrote:
> Convert fan devices connected to GPIOs to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> deleted file mode 100644
> index f4cfa350f6a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for fan connected to GPIO lines
> -
> -Required properties:
> -- compatible : "gpio-fan"
> -
> -Optional properties:
> -- gpios: Specifies the pins that map to bits in the control value,
> -  ordered MSB-->LSB.
> -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> -  control value that should be set to achieve them. This array
> -  must have the RPM values in ascending order.
> -- alarm-gpios: This pin going active indicates something is wrong with
> -  the fan, and a udev event will be fired.
> -- #cooling-cells: If used as a cooling device, must be <2>
> -  Also see:
> -  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> -  min and max states are derived from the speed-map of the fan.
> -
> -Note: At least one the "gpios" or "alarm-gpios" properties must be set.
> -
> -Examples:
> -
> -	gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio1 14 1
> -			 &gpio1 13 1>;
> -		gpio-fan,speed-map = <0    0
> -				      3000 1
> -				      6000 2>;
> -		alarm-gpios = <&gpio1 15 1>;
> -	};
> -	gpio_fan_cool: gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio2 14 1
> -			 &gpio2 13 1>;
> -		gpio-fan,speed-map =	<0    0>,
> -					<3000 1>,
> -					<6000 2>;
> -		alarm-gpios = <&gpio2 15 1>;
> -		#cooling-cells = <2>; /* min followed by max */
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> new file mode 100644
> index 000000000000..e2db65d58a92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/hwmon/gpio-fan.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Bindings for fan connected to GPIO lines
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>

Just robh@kernel.org

> +
> +properties:
> +  compatible:
> +    const: gpio-fan
> +
> +  gpios:
> +    description: |
> +      Specifies the pins that map to bits in the control value,
> +      ordered MSB-->LSB.

minItems: 1
maxItems: 7 ?

> +
> +  gpio-fan,speed-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 254
> +    description: |
> +      A mapping of possible fan RPM speeds and the
> +      control value that should be set to achieve them. This array
> +      must have the RPM values in ascending order.

Really this should be a uint32-matrix with this schema:

items:
  minItems: 2
  maxItems: 127
  items:
    - description: fan speed in RPMs
    - description: control value

> +
> +  alarm-gpios:
> +    description: |
> +      This pin going active indicates something is wrong with
> +      the fan, and a udev event will be fired.

maxItems: 1

udev is a linuxism and shouldn't be in the binding.

> +
> +  '#cooling-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - gpio-fan,speed-map
> +
> +anyOf:
> +  - required: [gpios]

How is 'gpios' not always required?

> +  - required: [alarm-gpios]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio_fan {
> +      compatible = "gpio-fan";
> +      gpios = <&gpio1 14 1
> +               &gpio1 13 1>;
> +      gpio-fan,speed-map = <0    0
> +                            3000 1
> +                            6000 2>;

Brackets needed around each pair.

> +      alarm-gpios = <&gpio1 15 1>;
> +    };
> +  - |
> +    gpio_fan_cool: gpio_fan {
> +      compatible = "gpio-fan";
> +      gpios = <&gpio2 14 1
> +               &gpio2 13 1>;
> +      gpio-fan,speed-map = <0    0
> +                            3000 1
> +                            6000 2>;
> +      alarm-gpios = <&gpio2 15 1>;
> +      #cooling-cells = <2>; /* min followed by max */
> +    };
> -- 
> 2.33.0
> 
> 
