Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE0349F17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCZBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:52:07 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:37859 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCZBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:52:03 -0400
Received: by mail-il1-f173.google.com with SMTP id z9so3816335ilb.4;
        Thu, 25 Mar 2021 18:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBBDzJB1veA3jjgPUkxR07NhQKbPrftIzj05sWg545E=;
        b=kCDmF6/jxoEnftHz4XegklLOB4a3lf2JVwcx7Nj4WYnOCEcEM8pR7hS8Cfg8nw8UPO
         HWEpIXii0dY7OCV7CQP67RiLVc4qO3HdMnh/ezM1Jz88vSbM3YDSf1C/B91FMtxvr5wV
         uEScZrACE1NAfMYYYBex2L0gGMNtAe2X9SSn4CprLW5W1hm6nXxMHmsUga/74wYOVVFD
         nT6aKXej+QbPhpD/q8LS1PixdwqwaPB4Wnw37YW8LMztDLSpef2H/2bzXiYQxb2UKE/O
         tUkfgXLS7yuXnHVnQywQruNxjcZ0TqB/Lp0cQTR6GH9hZBqEhKw0aLbxkn2roOnfCx8E
         GY9A==
X-Gm-Message-State: AOAM5314layJ3fcmn06H15woxZFlor27x+LejrBGR+POyHXyAmLu1z8M
        dmoLdmsTzWkXjPgVyq0L+A==
X-Google-Smtp-Source: ABdhPJxctmv3VzCtMljs/sOClUGWY+n4cUYEn+fqKf7+K54xR7A1xQD9Vwe/TfNRfu8FQqh19ZmNzA==
X-Received: by 2002:a92:ce4a:: with SMTP id a10mr7654040ilr.102.1616723522437;
        Thu, 25 Mar 2021 18:52:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q207sm3696255iod.6.2021.03.25.18.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:52:01 -0700 (PDT)
Received: (nullmailer pid 2163620 invoked by uid 1000);
        Fri, 26 Mar 2021 01:52:00 -0000
Date:   Thu, 25 Mar 2021 19:52:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
Message-ID: <20210326015200.GA2160488@robh.at.kernel.org>
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319092919.21218-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 09:29:13AM +0000, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> new file mode 100644
> index 000000000000..fe47e483d4b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wcd938x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm WCD9380/WCD9385 Audio Codec
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
> +  It has RX and TX Soundwire slave devices.
> +
> +properties:
> +  compatible:
> +    const: sdw20217010d00
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO spec for reset line to use
> +    maxItems: 1
> +
> +  direction:

Needs a description and vendor prefix.

> +    oneOf:
> +      - const: rx
> +      - const: tx

Better expressed as an 'enum'

> +
> +  vdd-buck-supply:
> +    description: A reference to the 1.8V buck supply
> +
> +  vdd-rxtx-supply:
> +    description: A reference to the 1.8V rx supply
> +
> +  vdd-io-supply:
> +    description: A reference to the 1.8V I/O supply
> +
> +  qcom,micbias1-microvolt:
> +    description: micbias1 voltage
> +    minimum: 1800000
> +    maximum: 2850000
> +
> +  qcom,micbias2-microvolt:
> +    description: micbias2 voltage
> +    minimum: 1800000
> +    maximum: 2850000
> +
> +  qcom,micbias3-microvolt:
> +    description: micbias3 voltage
> +    minimum: 1800000
> +    maximum: 2850000
> +
> +  qcom,micbias4-microvolt:
> +    description: micbias4 voltage
> +    minimum: 1800000
> +    maximum: 2850000
> +
> +  qcom,mbhc-hphl-switch:
> +    description: Indicates that HPHL switch type is normally closed
> +    type: boolean
> +
> +  qcom,mbhc-ground-switch:
> +    description: Indicates that Headset Ground switch type is normally closed
> +    type: boolean
> +
> +  qcom,mbhc-button0-vthreshold-microvolt:
> +    description: Voltage threshold value headset button0
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button1-vthreshold-microvolt:
> +    description: Voltage threshold value headset button1
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button2-vthreshold-microvolt:
> +    description: Voltage threshold value headset button2
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button3-vthreshold-microvolt:
> +    description: Voltage threshold value headset button3
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button4-vthreshold-microvolt:
> +    description: Voltage threshold value headset button4
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button5-vthreshold-microvolt:
> +    description: Voltage threshold value headset button5
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button6-vthreshold-microvolt:
> +    description: Voltage threshold value headset button6
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button7-vthreshold-microvolt:
> +    description: Voltage threshold value headset button7
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,port-mapping:
> +    description: |
> +      Specifies static port mapping between slave and master ports.
> +      In the order of slave port index.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 5
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - qcom,micbias1-microvolt
> +  - qcom,micbias2-microvolt
> +  - qcom,micbias3-microvolt
> +  - qcom,micbias4-microvolt
> +  - qcom,port-mapping
> +  - qcom,mbhc-hphl-switch
> +  - qcom,mbhc-ground-switch
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soundwire@3230000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03230000 0x2000>;
> +
> +        codec@0,3 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 3>;
> +            reset-gpios = <&tlmm 32 0>;
> +            direction = "tx";
> +            #sound-dai-cells = <1>;
> +            qcom,micbias1-microvolt = <1800000>;
> +            qcom,micbias2-microvolt = <1800000>;
> +            qcom,micbias3-microvolt = <1800000>;
> +            qcom,micbias4-microvolt = <1800000>;
> +            qcom,mbhc-hphl-switch;
> +            qcom,mbhc-ground-switch;
> +            qcom,mbhc-button0-vthreshold-microvolt = <75000>;
> +            qcom,mbhc-button1-vthreshold-microvolt = <150000>;
> +            qcom,mbhc-button2-vthreshold-microvolt = <237000>;
> +            qcom,mbhc-button3-vthreshold-microvolt = <500000>;
> +            qcom,mbhc-button5-vthreshold-microvolt = <500000>;
> +            qcom,mbhc-button6-vthreshold-microvolt = <500000>;
> +            qcom,mbhc-button7-vthreshold-microvolt = <500000>;
> +            qcom,port-mapping = <2 3 4 5>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
> 
