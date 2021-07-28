Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD93D9464
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG1Rg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:36:59 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38871 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Rg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:36:57 -0400
Received: by mail-io1-f50.google.com with SMTP id a13so3849607iol.5;
        Wed, 28 Jul 2021 10:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZuWCSGhI9p946I5meiTY9tIujdg9WTVzTMSIiS4wvA=;
        b=rowxeJEt+7OrmigRlYQ3zs+P/C7VbmZCElTDPQy5iCzPggHdHESNG6dyrq8npDdHba
         J4sY55w1qCt+kFd0JKch0eHQUQuFSYwuxC94qeNcNKyE1sEepZhi1RXn6xaxqrkEbhuj
         UK+sWXGDW2sC905LbxWEIp/gW5CzNmwhDDDtETRCRPOEA+mY5XO42OTk75vARY1Atp4/
         U5At/FC+NBDRXRAJvVOU4YORAie1Ix7NZj1JN0PIDLFo6XidpkJUi0lXu7HFJ52kYbxg
         EohXwEOToPpYGQh2LIEAOfoA8TJwlVzfDlCgwNNQDusorvrkc/A0fznckltUcuoBoNZH
         Fphw==
X-Gm-Message-State: AOAM531mAJpkbF9qwIe2cZGdkl5ocnBNg2Ptbsx4thCdblWB+bVLUqp7
        fkCQ7t1iXlWTA+9gIeZaWA==
X-Google-Smtp-Source: ABdhPJxCmh3UPQcqE4Y7EaPT/8ZYwkH97oksdw+d/L95duJC5Jdb6zChMU6kTNaWH9jRrV8yythhsw==
X-Received: by 2002:a05:6638:289:: with SMTP id c9mr876595jaq.14.1627493814569;
        Wed, 28 Jul 2021 10:36:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g4sm335630ilc.11.2021.07.28.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:36:53 -0700 (PDT)
Received: (nullmailer pid 1298058 invoked by uid 1000);
        Wed, 28 Jul 2021 17:36:49 -0000
Date:   Wed, 28 Jul 2021 11:36:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org
Subject: Re: [PATCH v2 04/16] ASoC: qcom: dt-bindings: add bindings Audio
 Processing manager
Message-ID: <20210728173649.GA1290628@robh.at.kernel.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714153039.28373-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 04:30:27PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings support for Qualcomm Audio Processing Manager
> service in Audio DSP.
> 
> Audio Process Manager is one of the static service in DSP which is
> responsible for Command/response handling, graph Management
> and Control/Event management between modules.

This all looks fairly similar to the prior Qcom audio binding(s). It 
would be nice to not see this all re-invented.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6apm.yaml | 87 +++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6apm.h        |  8 ++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>  create mode 100644 include/dt-bindings/sound/qcom,q6apm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> new file mode 100644
> index 000000000000..6f27567523a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> @@ -0,0 +1,87 @@
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
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +#APM Services
> +patternProperties:
> +  'apm@[0-9]+$':

This means '.*apm' for the node name. Did you need a '^'?

> +    type: object
> +    description:
> +      APM devices use subnodes for services.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,q6apm-dais
> +          - qcom,q6apm-bedais
> +
> +      iommus:
> +        maxItems: 1
> +
> +      "#sound-dai-cells":
> +        const: 1
> +
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#sound-dai-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
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
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          apm@1 {
> +            compatible = "qcom,q6apm-dais";
> +            #sound-dai-cells = <1>;
> +            reg = <1>;
> +          };
> +
> +          apm@2 {
> +            compatible = "qcom,q6apm-bedais";
> +            #sound-dai-cells = <1>;
> +            reg = <2>;
> +          };
> +        };
> +    };
> diff --git a/include/dt-bindings/sound/qcom,q6apm.h b/include/dt-bindings/sound/qcom,q6apm.h
> new file mode 100644
> index 000000000000..3c3987eb6e95
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6apm.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_BINDINGS_Q6_APM_H__
> +#define __DT_BINDINGS_Q6_APM_H__
> +
> +/* Audio Process Manager (APM) virtual ports IDs */
> +#include <dt-bindings/sound/qcom,q6afe.h>

Why add this indirection? Rename the file if you need something to cover 
both.

> +
> +#endif /* __DT_BINDINGS_Q6_APM_H__ */
> -- 
> 2.21.0
> 
> 
