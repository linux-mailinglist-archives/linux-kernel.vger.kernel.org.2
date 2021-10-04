Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46E4213D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhJDQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:18:55 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:47007 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhJDQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:18:54 -0400
Received: by mail-oi1-f172.google.com with SMTP id s69so22173361oie.13;
        Mon, 04 Oct 2021 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pf88udj5nt/KT7d9jbHcC+owlbZc/CpSFgdstchHks=;
        b=w0DrMmPlMa+vBzCvSufX+Gn1Ua7EppZfzVGQhMF9E1MqUS8UFu2n5xnQvH4PmeqMp6
         MDdD3tqEFiEzrTyErA0OgRwJ0bAxIRv6+pwFd9rjHEUKfr6JmXo9xrySTrWJBFVU+j7D
         Idd7NWmWnLTMn0J4SP9gq4hVrblsgyu3vsrUDPAxguaFpTslC0Dd1vhs0siBEZISerE4
         qrlfCBcNHPCBw3vPSzfZfGKODwejGQfZVQrwHaaE0rSA4Lo3od/0Bwdo7TNQ7sbjchAu
         HFtj7mupniknNBdx2LZuHJUJoUAai/xEjQ9FOKxhC6f+oqAyMGauPAaUerLzPngtlQPp
         OBDQ==
X-Gm-Message-State: AOAM5339w5TDkKImkf36IL/ZdnvcbCB/abHdIyZI0KI8o70CtK0K4xWP
        xy/dauXnrrci3CH87ROHsQ==
X-Google-Smtp-Source: ABdhPJym1rFnpsm9XdZgKcx9KlcF6AVxIlmd+pYVYVMs3KyDbDQ0xTBW7PiCsJaITTql5bjQamQ+WA==
X-Received: by 2002:a05:6808:a9c:: with SMTP id q28mr14059367oij.148.1633364224977;
        Mon, 04 Oct 2021 09:17:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm2989928otf.12.2021.10.04.09.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:17:04 -0700 (PDT)
Received: (nullmailer pid 1402925 invoked by uid 1000);
        Mon, 04 Oct 2021 16:17:03 -0000
Date:   Mon, 4 Oct 2021 11:17:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8973: convert to
 dtschema
Message-ID: <YVso//wfOMVUUZmv@robh.at.kernel.org>
References: <20211001074654.41196-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001074654.41196-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 09:46:54AM +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX8973 regulator to DT schema format.  Extend the
> examples with more advanced one for MAX77621 copied from kernel's
> nvidia/tegra210-smaug.dts, licensed under GPL-2.0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/max8973-regulator.txt  |  52 -------
>  .../bindings/regulator/maxim,max8973.yaml     | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max8973-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> deleted file mode 100644
> index c2c68fcc1b41..000000000000
> --- a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* Maxim MAX8973 Voltage Regulator
> -
> -Required properties:
> -
> -- compatible:	must be one of following:
> -			"maxim,max8973"
> -			"maxim,max77621".
> -- reg:		the i2c slave address of the regulator. It should be 0x1b.
> -
> -Any standard regulator properties can be used to configure the single max8973
> -DCDC.
> -
> -Optional properties:
> -
> --maxim,externally-enable: boolean, externally control the regulator output
> -		enable/disable.
> --maxim,enable-gpio: GPIO for enable control. If the valid GPIO is provided
> -		then externally enable control will be considered.
> --maxim,dvs-gpio: GPIO which is connected to DVS pin of device.
> --maxim,dvs-default-state: Default state of GPIO during initialisation.
> -		1 for HIGH and 0 for LOW.
> --maxim,enable-remote-sense: boolean, enable reote sense.
> --maxim,enable-falling-slew-rate: boolean, enable falling slew rate.
> --maxim,enable-active-discharge: boolean: enable active discharge.
> --maxim,enable-frequency-shift: boolean, enable 9% frequency shift.
> --maxim,enable-bias-control: boolean, enable bias control. By enabling this
> -		startup delay can be reduce to 20us from 220us.
> --maxim,enable-etr: boolean, enable Enhanced Transient Response.
> --maxim,enable-high-etr-sensitivity: boolean, Enhanced transient response
> -		circuit is enabled and set for high sensitivity. If this
> -		property is available then etr will be enable default.
> -
> -Enhanced transient response (ETR) will affect the configuration of CKADV.
> -
> --junction-warn-millicelsius: u32, junction warning temperature threshold
> -		in millicelsius. If die temperature crosses this level then
> -		device generates the warning interrupts.
> -
> -Please note that thermal functionality is only supported on MAX77621. The
> -supported threshold warning temperature for MAX77621 are 120 degC and 140 degC.
> -
> -Example:
> -
> -	max8973@1b {
> -		compatible = "maxim,max8973";
> -		reg = <0x1b>;
> -
> -		regulator-min-microvolt = <935000>;
> -		regulator-max-microvolt = <1200000>;
> -		regulator-boot-on;
> -		regulator-always-on;
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
> new file mode 100644
> index 000000000000..8947d1fa989a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max8973.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX8973/MAX77621 voltage regulator
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max8973
> +      - maxim,max77621
> +
> +  junction-warn-millicelsius:
> +    #$ref: /schemas/types.yaml#/definitions/uint32

Drop. 

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: |
> +      Junction warning temperature threshold in millicelsius. If die
> +      temperature crosses this level then device generates the warning
> +      interrupts.
> +      Please note that thermal functionality is only supported on MAX77621. The
> +      supported threshold warning temperature for MAX77621 are 120 degC and 140
> +      degC.
