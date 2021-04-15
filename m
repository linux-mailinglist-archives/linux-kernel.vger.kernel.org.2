Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE7361049
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhDOQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:39:39 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37421 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:39:38 -0400
Received: by mail-ot1-f46.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso9048668otm.4;
        Thu, 15 Apr 2021 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpKNZqJMtuMERJQ2AbPwF8sZgkJqLPk+S+d3HTR1z9Y=;
        b=K0IiRTYEBWmDwwSF1epcas/AIxV+gFsAgWd3co5eYSxNkZYhV21TiWv9/1UgI+XY5a
         Ud4SqbKckofpWU2H/2dX3tJ38+/n3FgkH/jPzvbguaZVDFeWZLYCMg5tPNBPT6UjrTzC
         VxkcygaabuRYwjxD88D/R6Dq81UJaFyiSz9FCIdnHEumC8yO33ypV66KQvAEQ0eJSDk3
         zdfqsPrqNuQmSPSKF2IwmS+gQ+r55kg+5EeaK11ZYUKzJDd1FNRbfAVCYkB3jxc7AUXU
         fi4PPe7y4uZOw1v5LF7HlFLhvrsywaaoKubJuA5ubvxkidU+KR9Q9trWCclMMHjeOBpU
         B6nA==
X-Gm-Message-State: AOAM533wWySHh3qR3Pb/HWbP14W6XcApXL/CJzwNwT2+vqt3CXtJjB9x
        lpKiNsX1BHLt5Zi9u6mPzQ==
X-Google-Smtp-Source: ABdhPJxfrT1TEsqC3ayPTt5SJKenn6259qEOzXxjhfz6tyEYwEVQfneK+liMC8rKdst2Q11qlP7W+Q==
X-Received: by 2002:a05:6830:2491:: with SMTP id u17mr147988ots.198.1618504753664;
        Thu, 15 Apr 2021 09:39:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm700725oiw.27.2021.04.15.09.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:39:13 -0700 (PDT)
Received: (nullmailer pid 1533253 invoked by uid 1000);
        Thu, 15 Apr 2021 16:39:12 -0000
Date:   Thu, 15 Apr 2021 11:39:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v4 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for
 wcd938x-sdw
Message-ID: <20210415163912.GA1524320@robh.at.kernel.org>
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:48:40PM +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices RX and
> TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x-sdw.yaml      | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> new file mode 100644
> index 000000000000..fff33c65491b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wcd938x-sdw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm SoundWire Slave devices on WCD9380/WCD9385
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
> +  It has RX and TX Soundwire slave devices. This bindings is for the
> +  slave devices.
> +
> +properties:
> +  compatible:
> +    const: sdw20217010d00
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,direction:
> +    description: direction of the SoundWire device instance
> +    enum:
> +      - rx
> +      - tx

Was thinking these were some established bus properties...

This would just be implied by the 'reg' property index. You could define 
'reg-names' too I guess.

> +
> +  qcom,port-mapping:
> +    description: |
> +      Specifies static port mapping between slave and master ports.
> +      In the order of slave port index.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 5

qcom,rx-port-mapping and qcom,tx-port-mapping?

Or keep a single property and the driver knows how many slave ports for 
each direction. IOW, an array of 9 with first 4 entries for tx and last 
5 for rx.

> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,direction
> +  - qcom,port-mapping
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
> +            qcom,direction = "tx";
> +            qcom,port-mapping = <2 3 4 5>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
> 
