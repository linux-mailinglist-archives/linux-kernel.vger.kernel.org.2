Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A191336102D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhDOQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:30:18 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38510 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhDOQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:30:15 -0400
Received: by mail-ot1-f49.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so23093645otk.5;
        Thu, 15 Apr 2021 09:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZffJacP8hHhCx9bduUPtd+KRcz7yQ/sp0czinF9nSzw=;
        b=inJnrcT8cPlIs3DobDKrw2ijHeUBRtdaKF370UlPoLXQ4iFIDpql2sukSA1JS9q2pv
         AjNph93nqV0faE4Y1wXSa57WC2SCb3nw2EskAT4HQ5d0FFhUoAicmqp0fTYIZmQ47jZo
         1XlhCy7vr7QNWXiQd17ETLV2v4tLPJZBPiwLiDRsLeeZvtu8mhzBNs/Xkv6kIAHigbec
         k02J0U4Y1ggQv8UTzhqex2BCygfyMVsXsHXoc6fOJ7o6+DANzE3e1TYyKJw+DLLDuZHk
         oL5Idja7rJCUUKJHxlYTRrggq13RY83QEi9fnNojK+/gh2YBtXyauRPRVeDoJIG7VxdB
         XQGw==
X-Gm-Message-State: AOAM533nk1zM1/a49ZaPsERP/2SFWppNe3I4mnBaj4forepKPuSFlSbL
        YE7dz4ablxS9JS+99nv6/w==
X-Google-Smtp-Source: ABdhPJxdRRvVh2k62PXNOI6ZgMK353R6KtNVTtjIa9dAfMcwtUKR0hjBEZOTnVuKWB9WgmbJiTfjNw==
X-Received: by 2002:a9d:4e05:: with SMTP id p5mr106488otf.264.1618504188589;
        Thu, 15 Apr 2021 09:29:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm678415oic.51.2021.04.15.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:29:48 -0700 (PDT)
Received: (nullmailer pid 1520937 invoked by uid 1000);
        Thu, 15 Apr 2021 16:29:47 -0000
Date:   Thu, 15 Apr 2021 11:29:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v4 1/9] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
Message-ID: <20210415162947.GA1511094@robh.at.kernel.org>
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414154845.21964-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:48:37PM +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> new file mode 100644
> index 000000000000..4c8fa8290af0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> @@ -0,0 +1,176 @@
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
> +    maxItems: 1
> +    description: A reference to Soundwire tx device phandle
> +
> +  qcom,rx-device:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
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
> +  - qcom,mbhc-hphl-switch
> +  - qcom,mbhc-ground-switch
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
> +        qcom,mbhc-hphl-switch;
> +        qcom,mbhc-ground-switch;
> +        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
> +        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
> +        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
> +        qcom,mbhc-button3-vthreshold-microvolt = <500000>;
> +        qcom,mbhc-button5-vthreshold-microvolt = <500000>;
> +        qcom,mbhc-button6-vthreshold-microvolt = <500000>;
> +        qcom,mbhc-button7-vthreshold-microvolt = <500000>;
> +    };
> +
> +    /* ... */
> +
> +    soundwire@3230000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03230000 0x2000>;
> +        wcd938x_tx: codec@0,3 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 3>;
> +            qcom,direction = "tx";
> +            qcom,port-mapping = <2 3 4 5>;
> +        };
> +
> +        wcd938x_rx: codec@0,4 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 4>;
> +            qcom,direction = "rx";
> +            qcom,port-mapping = <1 2 3 4 5>;
> +        };

This is a single device, right? We shouldn't need 3 nodes to describe 
it. I think this should all be a single node like this:

codec@0,3 {
        reg = <0 3>, <0 4>;
	compatible = "sdw20217010d00";

        reset-gpios = <&tlmm 32 0>;
        #sound-dai-cells = <1>;
        qcom,micbias1-microvolt = <1800000>;
        qcom,micbias2-microvolt = <1800000>;
        qcom,micbias3-microvolt = <1800000>;
        qcom,micbias4-microvolt = <1800000>;
        qcom,mbhc-hphl-switch;
        qcom,mbhc-ground-switch;
        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
        qcom,mbhc-button3-vthreshold-microvolt = <500000>;
        qcom,mbhc-button5-vthreshold-microvolt = <500000>;
        qcom,mbhc-button6-vthreshold-microvolt = <500000>;
        qcom,mbhc-button7-vthreshold-microvolt = <500000>;
};

You'll have to figure out the qcom,direction and qcom,port-mapping parts 
though.

Rob
