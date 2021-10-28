Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1843E2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJ1Nz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:55:26 -0400
Received: from ixit.cz ([94.230.151.217]:35258 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJ1NzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:55:12 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5D70A20064;
        Thu, 28 Oct 2021 15:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635429161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhbhJtURt+WnE9ECLdh1gqMi5nXfjMcR+LTiEWo/+2s=;
        b=fcB6XX4004At1KY3+sfv99iJcibCHwuuu1xRny9RTu2cLvXDlLeMYiamkB25qVGjJHAka4
        T0q6GYJuGrskIG7yQWiSp6cvF7MuEE9BeAN/CUIJNVe7DBtCp/1s94vHGaDgwaUqd+Odtt
        RWeqqQcx0NNlwN2ePm2BD2H6aUo6rBs=
Date:   Thu, 28 Oct 2021 15:52:35 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht
Message-Id: <N7XO1R.T7ICL6D5U4CF3@ixit.cz>
In-Reply-To: <YW86Ffa+zoIZpixu@robh.at.kernel.org>
References: <20211009104309.45117-1-david@ixit.cz>
        <YW86Ffa+zoIZpixu@robh.at.kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, Oct 19 2021 at 16:35:17 -0500, Rob Herring <robh@kernel.org> 
wrote:
> On Sat, Oct 09, 2021 at 12:43:09PM +0200, David Heidelberg wrote:
>>  Convert fan devices connected to GPIOs to the YAML syntax.
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>   .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
>>   .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69 
>> +++++++++++++++++++
>>   2 files changed, 69 insertions(+), 41 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
>> 
>>  diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt 
>> b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>>  deleted file mode 100644
>>  index f4cfa350f6a1..000000000000
>>  --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>>  +++ /dev/null
>>  @@ -1,41 +0,0 @@
>>  -Bindings for fan connected to GPIO lines
>>  -
>>  -Required properties:
>>  -- compatible : "gpio-fan"
>>  -
>>  -Optional properties:
>>  -- gpios: Specifies the pins that map to bits in the control value,
>>  -  ordered MSB-->LSB.
>>  -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
>>  -  control value that should be set to achieve them. This array
>>  -  must have the RPM values in ascending order.
>>  -- alarm-gpios: This pin going active indicates something is wrong 
>> with
>>  -  the fan, and a udev event will be fired.
>>  -- #cooling-cells: If used as a cooling device, must be <2>
>>  -  Also see:
>>  -  
>> Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
>>  -  min and max states are derived from the speed-map of the fan.
>>  -
>>  -Note: At least one the "gpios" or "alarm-gpios" properties must be 
>> set.
>>  -
>>  -Examples:
>>  -
>>  -	gpio_fan {
>>  -		compatible = "gpio-fan";
>>  -		gpios = <&gpio1 14 1
>>  -			 &gpio1 13 1>;
>>  -		gpio-fan,speed-map = <0    0
>>  -				      3000 1
>>  -				      6000 2>;
>>  -		alarm-gpios = <&gpio1 15 1>;
>>  -	};
>>  -	gpio_fan_cool: gpio_fan {
>>  -		compatible = "gpio-fan";
>>  -		gpios = <&gpio2 14 1
>>  -			 &gpio2 13 1>;
>>  -		gpio-fan,speed-map =	<0    0>,
>>  -					<3000 1>,
>>  -					<6000 2>;
>>  -		alarm-gpios = <&gpio2 15 1>;
>>  -		#cooling-cells = <2>; /* min followed by max */
>>  -	};
>>  diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml 
>> b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
>>  new file mode 100644
>>  index 000000000000..e2db65d58a92
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
>>  @@ -0,0 +1,69 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: "http://devicetree.org/schemas/hwmon/gpio-fan.yaml#"
>>  +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>  +
>>  +title: Bindings for fan connected to GPIO lines
>>  +
>>  +maintainers:
>>  +  - Rob Herring <robh+dt@kernel.org>
> 
> Just robh@kernel.org
> 
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: gpio-fan
>>  +
>>  +  gpios:
>>  +    description: |
>>  +      Specifies the pins that map to bits in the control value,
>>  +      ordered MSB-->LSB.
> 
> minItems: 1
> maxItems: 7 ?
> 
>>  +
>>  +  gpio-fan,speed-map:
>>  +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>  +    minItems: 4
>>  +    maxItems: 254
>>  +    description: |
>>  +      A mapping of possible fan RPM speeds and the
>>  +      control value that should be set to achieve them. This array
>>  +      must have the RPM values in ascending order.
> 
> Really this should be a uint32-matrix with this schema:
> 
> items:
>   minItems: 2
>   maxItems: 127
>   items:
>     - description: fan speed in RPMs
>     - description: control value
> 
>>  +
>>  +  alarm-gpios:
>>  +    description: |
>>  +      This pin going active indicates something is wrong with
>>  +      the fan, and a udev event will be fired.
> 
> maxItems: 1
> 
> udev is a linuxism and shouldn't be in the binding.
> 
>>  +
>>  +  '#cooling-cells':
>>  +    const: 2
>>  +
>>  +required:
>>  +  - compatible
>>  +  - gpio-fan,speed-map
>>  +
>>  +anyOf:
>>  +  - required: [gpios]
> 
> How is 'gpios' not always required?
> 
>>  +  - required: [alarm-gpios]
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    gpio_fan {
>>  +      compatible = "gpio-fan";
>>  +      gpios = <&gpio1 14 1
>>  +               &gpio1 13 1>;
>>  +      gpio-fan,speed-map = <0    0
>>  +                            3000 1
>>  +                            6000 2>;
> 
> Brackets needed around each pair.

Well, that's the issue. I would love to use u32-matrix, but all the 
drivers use < x1 x2 y1 x2 ... z1 z2 > syntax and driver suggests it's 
the right solution.
         * Speed map is in the form <RPM ctrl_val RPM ctrl_val ...>

Someone had to rewrite the driver and the DTS files to fix it. We could 
mark old format as deprecated and use u32-matrix, but for now with 
current drivers it's not a solution.

What you think? Should I document it as it is (so u32-array)?

David

> 
>>  +      alarm-gpios = <&gpio1 15 1>;
>>  +    };
>>  +  - |
>>  +    gpio_fan_cool: gpio_fan {
>>  +      compatible = "gpio-fan";
>>  +      gpios = <&gpio2 14 1
>>  +               &gpio2 13 1>;
>>  +      gpio-fan,speed-map = <0    0
>>  +                            3000 1
>>  +                            6000 2>;
>>  +      alarm-gpios = <&gpio2 15 1>;
>>  +      #cooling-cells = <2>; /* min followed by max */
>>  +    };
>>  --
>>  2.33.0
>> 
>> 


