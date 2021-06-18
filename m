Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA03AD372
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhFRUSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:18:39 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37529 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:18:36 -0400
Received: by mail-ot1-f41.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10887681otj.4;
        Fri, 18 Jun 2021 13:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lBtHIzlhVk8sJY83HR9VHHtDV8zU8qEhN6lMMc8ccAQ=;
        b=gizWLcVjwlD36k+jLMoURodueIdTD4wcSXUVal0/kA40+BUpWw2hKqvfDJOK/DtAKX
         46JbFeTuAPcTk6oGiH7kAqoJSF56E+SujF9jI9xFW3hD8GhBMX+dRkqk3pykJ3uqFD5j
         +C1xtp07QtFHVH2BdlplrnRvkuer1P7Zxc/1d6NomSjPS/yxpuTgIWBhDW5bPiOT8t9a
         ySGTKSOcAOZX6J8J7z271wjDIV9BGzAUPWWd0KFy0xihIEjqA6co/QngGEa0VZ3U9/0I
         F3a3IhOfygnAF0YKbuqG1PmpslyP3BE58lwYgxwAsacIJktlqAICwpWbowq00K9yBofM
         dSBA==
X-Gm-Message-State: AOAM530H/q94RmPMdtB4FAIN/HJGK+OLbh7JyI7yLzn2g+R+Fx4UJJsy
        QKFW1X7/tbEqNhXLFrsL8A==
X-Google-Smtp-Source: ABdhPJyxP4UQValuX9uYfay5qm8ASFvM1GL7mD27tgWSBBiyyj2DP4FOmSEom/6h9O3OOXV6G3LOZw==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr11111358otf.370.1624047386315;
        Fri, 18 Jun 2021 13:16:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j3sm1981852oii.46.2021.06.18.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:16:25 -0700 (PDT)
Received: (nullmailer pid 2807200 invoked by uid 1000);
        Fri, 18 Jun 2021 20:16:21 -0000
Date:   Fri, 18 Jun 2021 14:16:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org
Subject: Re: [RFC PATCH 03/13] ASoC: qcom: dt-bindings: add bindings Audio
 Processing manager
Message-ID: <20210618201621.GA2801502@robh.at.kernel.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
 <20210607152836.17154-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607152836.17154-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:28:26PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings support for Qualcomm Audio Processing Manager
> service in Audio DSP.
> 
> Audio Process Manager is one of the static service in DSP which is
> responsible for Command/response handling, graph Management
> and Control/Event management between modules.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6apm.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> new file mode 100644
> index 000000000000..9906ef935206
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/qcom,q6apm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Audio Process Manager binding
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes the Qualcomm Audio Process Manager service in DSP
> +
> +properties:
> +  compatible:
> +    const: qcom,q6apm
> +
> +  reg:
> +    maxItems: 1
> +
> +#APM Services
> +patternProperties:
> +  "^.*@[0-9a-f]+$":

You can drop '^.*'.

> +    type: object
> +    description:
> +      APM devices use subnodes for services.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,q6apm-dai
> +          - qcom,q6apm-bedai
> +
> +      iommus:
> +        maxItems: 1
> +
> +      "#sound-dai-cels":

cells?

How is this optional?

> +        const: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

This needs to be false and fix whatever is missing.

> +
> +examples:
> +  - |
> +    gpr {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gprservice@1 {
> +          compatible = "qcom,q6apm";
> +          reg = <1>;
> +
> +          q6apm-dai {

This doesn't match what you have in the schema at all.

> +            compatible = "qcom,q6apm-dai";
> +            #sound-dai-cels = <1>;
> +          };
> +
> +          q6apm-bedai {
> +            compatible = "qcom,q6apm-bedai";
> +            #sound-dai-cels = <1>;
> +          };
> +        };
> +    };
> -- 
> 2.21.0
> 
> 
