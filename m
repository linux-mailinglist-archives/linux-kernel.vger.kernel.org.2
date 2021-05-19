Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BE7389A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhESX4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:56:40 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35586 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhESX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:56:35 -0400
Received: by mail-oi1-f182.google.com with SMTP id v22so14768302oic.2;
        Wed, 19 May 2021 16:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzJtZgK1H/5xjeQJaiKS1v1HDO3VL37NAXKpynjn5Xg=;
        b=pNbHMlYfYOxTBdLxjtnsQuk3O9P9yU+ASnqkTkLiQnLGIkWkd5azKZvqxRZ+55xzdC
         rB1qyuNsKM0EFRxHjhrmaaTgdnOooWbhy1WBOCkvmHcWsgmusONsybZWWBOWLdD7Ti1P
         sPFRoXARIMqjjQXQeT+yzgbxceex8+rDKAoY4gUzE9VTj3gXd8V1FnmTEsSox1BwakoY
         J7ZUCKzC3u750v6avVcl5wsSkDFZMdycXYptQ3bZQXsSmB9CFwWVFPv0ViVQcnXheI3b
         4XbzmJHLEeBaXQO8rUy4f7p6m2an7s+aQU83TOdQxCzb2KPCLCJDjtCYgPp0qeVqh6DB
         PGRw==
X-Gm-Message-State: AOAM5302ygu7PFw9veeYs6ZsjbYRG3JLmTb7gztyfvkDpZYPpIt1wrSd
        R/igCG7+oCWpJKsfSNX7QQ==
X-Google-Smtp-Source: ABdhPJwfyiI6bLQxODhV52EzLe6i6OomkP63escY33YOfKsdPEuPMlmDEqQElPoFpt0WnHkiY6ywzw==
X-Received: by 2002:a54:4411:: with SMTP id k17mr1323323oiw.66.1621468514597;
        Wed, 19 May 2021 16:55:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y7sm273535oto.60.2021.05.19.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:55:11 -0700 (PDT)
Received: (nullmailer pid 3909826 invoked by uid 1000);
        Wed, 19 May 2021 23:54:54 -0000
Date:   Wed, 19 May 2021 18:54:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v6 1/9] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
Message-ID: <20210519235454.GA3752127@robh.at.kernel.org>
References: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
 <20210518143759.16837-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518143759.16837-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:37:51PM +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> new file mode 100644
> index 000000000000..b04c5e90e283
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> @@ -0,0 +1,148 @@
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
> +    enum:
> +      - qcom,wcd9380-codec
> +      - qcom,wcd9385-codec
> +
> +  reset-gpios:
> +    description: GPIO spec for reset line to use
> +    maxItems: 1
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
> +  qcom,tx-device:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Only 1 and no args, so just 'phandle'.

> +    maxItems: 1

And drop this.

> +    description: A reference to Soundwire tx device phandle
> +
> +  qcom,rx-device:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1

And here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: A reference to Soundwire rx device phandle
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
> +  qcom,hphl-jack-type-normally-closed:
> +    description: Indicates that HPHL jack switch type is normally closed
> +    type: boolean
> +
> +  qcom,ground-jack-type-normally-closed:
> +    description: Indicates that Headset Ground switch type is normally closed
> +    type: boolean
> +
> +  qcom,mbhc-headset-vthreshold-microvolt:
> +    description: Voltage threshold value for headset detection
> +    minimum: 0
> +    maximum: 2850000
> +
> +  qcom,mbhc-headphone-vthreshold-microvolt:
> +    description: Voltage threshold value for headphone detection
> +    minimum: 0
> +    maximum: 2850000
> +
> +  qcom,mbhc-buttons-vthreshold-microvolt:
> +    description:
> +      Array of 8 Voltage threshold values corresponding to headset
> +      button0 - button7
> +    minItems: 8
> +    maxItems: 8
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - qcom,tx-device
> +  - qcom,rx-device
> +  - qcom,micbias1-microvolt
> +  - qcom,micbias2-microvolt
> +  - qcom,micbias3-microvolt
> +  - qcom,micbias4-microvolt
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    codec {
> +        compatible = "qcom,wcd9380-codec";
> +        reset-gpios = <&tlmm 32 0>;
> +        #sound-dai-cells = <1>;
> +        qcom,tx-device = <&wcd938x_tx>;
> +        qcom,rx-device = <&wcd938x_rx>;
> +        qcom,micbias1-microvolt = <1800000>;
> +        qcom,micbias2-microvolt = <1800000>;
> +        qcom,micbias3-microvolt = <1800000>;
> +        qcom,micbias4-microvolt = <1800000>;
> +        qcom,hphl-jack-type-normally-closed;
> +        qcom,ground-jack-type-normally-closed;
> +        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +    };
> +
> +    /* ... */
> +
> +    soundwire@3210000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03210000 0x2000>;
> +        wcd938x_rx: codec@0,4 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 4>;
> +            qcom,rx-port-mapping = <1 2 3 4 5>;
> +        };
> +    };
> +
> +    soundwire@3230000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03230000 0x2000>;
> +        wcd938x_tx: codec@0,3 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 3>;
> +            qcom,tx-port-mapping = <2 3 4 5>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
> 
