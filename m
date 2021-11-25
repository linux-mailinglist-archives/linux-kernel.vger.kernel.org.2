Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3B45D9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhKYMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbhKYL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:58:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7FC0613F4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 03:53:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b1so15598563lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6lxqjduOQsYJ4wgkh2NWvC8MrkYVQVCzgFR0CAGA8Ww=;
        b=sUGZIk9K0mM1wk5DOXHNsUlYXDpofTH1LP1GKIheRdkDgaVf83g6av3Ac84p0o4ujT
         rRrvUUt44GLZX3qs8T1eeLJuI0R1J70X5XJxf3PdEDmEtvRBhjmUkz1Ke5/Uv+hd5mBD
         waYXhJ2+R+JIHyamskFUcUU/nHujaEtAzHo2fc3uIufdiI4vjvKlkvfxal7dTlzDdza2
         E8jL16sJksSHNw+hE2nDNIFwZmScZgX5f+QOkrkI5Ib2k0BnXospPoLiJYazM0pnPpKw
         ossadcE0kNb9JmWjoze4+bOH9MnOAR1wFiAmAWvNQ7j05u5/Y6u/HZly9PVz97NVgQa6
         gLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6lxqjduOQsYJ4wgkh2NWvC8MrkYVQVCzgFR0CAGA8Ww=;
        b=UIKVfi867TZGE7YGO7w7/DZpwTQHxY7lfknBmMRfQB+onWC6xAU8qNhWFjgk34k3tu
         rgoo6mKkjYWwAhwUWvXRQ+Ztc/qAcWki844Ks61SND66olDRDM41yeA3XCKrzWhzcCIX
         iiXmvZindBsUGFOcxS/NkXTe9j+E4Jd5SB3c6DnpXCUOjEJXZMGuhcs9H8KIBgc8W2k7
         5CMJJP9u/IT4a4xoZBbZcvXJmObd5XznB90njEznbeZ7XFBFK8kSyUsz6zHUl5LmZ8H0
         ewd8DYOZZZ0S7iEWu9LjMPwniiy7QxYaDUyz3bRojxgSSCUdthHIv2eLTF+3FAJ2sBom
         TTnQ==
X-Gm-Message-State: AOAM533Hq7cRqBa+ljRwApIhuReDttBr7Aymb7NF1UCM32eOVGpN+0Rr
        2knEpWY34tGtnZwltuNW6OwmsQ==
X-Google-Smtp-Source: ABdhPJzymMghDkNOoD4FkGfhSdZUue3ZBbWuy26eOuzMCx56yiodyEaYBxQMs6t3+CqcVM8TjEaC0Q==
X-Received: by 2002:a05:6512:3a8d:: with SMTP id q13mr21969447lfu.73.1637841224624;
        Thu, 25 Nov 2021 03:53:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u23sm219901lji.56.2021.11.25.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 03:53:44 -0800 (PST)
Subject: Re: [PATCH 3/3] dt-bindings: display: msm: Add binding for msm8998
 dpu
To:     Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, abhinavk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        devicetree@vger.kernel.org
References: <20210901181138.1052653-1-angelogioacchino.delregno@somainline.org>
 <20210901181138.1052653-3-angelogioacchino.delregno@somainline.org>
 <YTexaJuQSNazh9sn@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <d9ad36f5-1913-2cb3-d4be-125ed2d29041@linaro.org>
Date:   Thu, 25 Nov 2021 14:53:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTexaJuQSNazh9sn@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 21:37, Rob Herring wrote:
> On Wed, Sep 01, 2021 at 08:11:38PM +0200, AngeloGioacchino Del Regno wrote:
>> Add yaml binding for msm8998 dpu1 support.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/display/msm/dpu-msm8998.yaml     | 220 ++++++++++++++++++
>>   1 file changed, 220 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
>> new file mode 100644
>> index 000000000000..db435342ecbf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
>> @@ -0,0 +1,220 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/dpu-msm8998.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Display DPU dt properties for MSM8998 target
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> +
>> +description: |
>> +  Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
>> +  sub-blocks like DPU display controller, DSI and DP interfaces etc. Device tree
>> +  bindings of MDSS and DPU are mentioned for MSM8998 target.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,msm8998-mdss
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reg-names:
>> +    const: mdss
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Display AHB clock
>> +      - description: Display AXI clock
>> +      - description: Display core clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: bus
>> +      - const: core
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#address-cells": true
>> +
>> +  "#size-cells": true
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +
>> +  iommus:
>> +    items:
>> +      - description: Phandle to apps_smmu node with SID mask for Hard-Fail port0
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^display-controller@[0-9a-f]+$":
>> +    type: object
>> +    description: Node containing the properties of DPU.
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: qcom,msm8998-dpu
>> +
>> +      reg:
>> +        items:
>> +          - description: Address offset and size for mdp register set
>> +          - description: Address offset and size for regdma register set
>> +          - description: Address offset and size for vbif register set
>> +          - description: Address offset and size for non-realtime vbif register set
>> +
>> +      reg-names:
>> +        items:
>> +          - const: mdp
>> +          - const: regdma
>> +          - const: vbif
>> +          - const: vbif_nrt
>> +
>> +      clocks:
>> +        items:
>> +          - description: Display ahb clock
>> +          - description: Display axi clock
>> +          - description: Display mem-noc clock
>> +          - description: Display core clock
>> +          - description: Display vsync clock
>> +
>> +      clock-names:
>> +        items:
>> +          - const: iface
>> +          - const: bus
>> +          - const: mnoc
>> +          - const: core
>> +          - const: vsync
>> +
>> +      interrupts:
>> +        maxItems: 1
>> +
>> +      power-domains:
>> +        maxItems: 1
>> +
>> +      operating-points-v2: true
>> +      ports:
>> +        $ref: /schemas/graph.yaml#/properties/ports
>> +        description: |
>> +          Contains the list of output ports from DPU device. These ports
>> +          connect to interfaces that are external to the DPU hardware,
>> +          such as DSI, DP etc. Each output port contains an endpoint that
>> +          describes how it is connected to an external interface.
>> +
>> +        properties:
>> +          port@0:
>> +            $ref: /schemas/graph.yaml#/properties/port
>> +            description: DPU_INTF1 (DSI1)
>> +
>> +          port@1:
>> +            $ref: /schemas/graph.yaml#/properties/port
>> +            description: DPU_INTF2 (DSI2)
>> +
>> +        required:
>> +          - port@0
>> +          - port@1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - reg-names
>> +      - clocks
>> +      - interrupts
>> +      - power-domains
>> +      - operating-points-v2
>> +      - ports
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - power-domains
>> +  - clocks
>> +  - interrupts
>> +  - interrupt-controller
>> +  - iommus
>> +  - ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    display-subsystem@c900000 {
>> +        compatible = "qcom,msm8998-mdss";
>> +        reg = <0x0c900000 0x1000>;
>> +        reg-names = "mdss";
>> +
>> +        clocks = <&mmcc MDSS_AHB_CLK>,
>> +                 <&mmcc MDSS_AXI_CLK>,
>> +                 <&mmcc MDSS_MDP_CLK>;
>> +        clock-names = "iface", "bus", "core";
>> +
>> +        #address-cells = <1>;
>> +        #interrupt-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        iommus = <&mmss_smmu 0>;
>> +
>> +        power-domains = <&mmcc MDSS_GDSC>;
>> +        ranges;
>> +        status = "disabled";
> 
> Drop. Why disable an example?

AngeloGioacchino, could you please update and repost this patch series? 
I'd like to get it merged.

> 
>> +
>> +        display-controller@c901000 {
>> +            compatible = "qcom,msm8998-dpu";
>> +            reg = <0x0c901000 0x8f000>,
>> +                  <0x0c9a8e00 0xf0>,
>> +                  <0x0c9b0000 0x2008>,
>> +                  <0x0c9b8000 0x1040>;
>> +            reg-names = "mdp", "regdma", "vbif", "vbif_nrt";
>> +
>> +            clocks = <&mmcc MDSS_AHB_CLK>,
>> +                     <&mmcc MDSS_AXI_CLK>,
>> +                     <&mmcc MNOC_AHB_CLK>,
>> +                     <&mmcc MDSS_MDP_CLK>,
>> +                     <&mmcc MDSS_VSYNC_CLK>;
>> +            clock-names = "iface", "bus", "mnoc", "core", "vsync";
>> +
>> +            interrupt-parent = <&mdss>;
>> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>> +            operating-points-v2 = <&mdp_opp_table>;
>> +            power-domains = <&rpmpd MSM8998_VDDMX>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    dpu_intf1_out: endpoint {
>> +                        remote-endpoint = <&dsi0_in>;
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    dpu_intf2_out: endpoint {
>> +                        remote-endpoint = <&dsi1_in>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
>> -- 
>> 2.32.0
>>
>>


-- 
With best wishes
Dmitry
