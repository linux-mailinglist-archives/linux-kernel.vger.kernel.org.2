Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B127B40DCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhIPOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:30:54 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:37855 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhIPOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:30:52 -0400
Received: by mail-il1-f177.google.com with SMTP id i13so6792114ilm.4;
        Thu, 16 Sep 2021 07:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frRlwJ/10bK38eYStAOqRcdEJX7eQoVjAi5npDQfV+M=;
        b=m3CzB870ix24SFKv5OjiXhrjPuJ+Y3WKL8FPEdusmUPkSiTSq+1Dgw4HLwu8eIvqIk
         QUEdy3vMtrgTykMWFTfpb/nuSR0DF+bO7BdiRTDjYszU19f/mlGqqjldyKKl8mpfOZCp
         YLslTZ//c8sW6zPVl3IYvjb2/lbr5QUaz9M9x3ZfZVgi3CV0wVCF6UVSuZcm2+Vr90i2
         HX50MdBF+IkzeJKP5Fta2FUxSopoNSOjRSfTJBV/jd80FHdEeBdFw7QCzzNZrugcDrTv
         0+SxA9ar3YzORCwJZpYMcz7lvToQjb+RZvR8sxi8ilikJ/3Lj8e8jiOL+xWkPw3jIorh
         te5Q==
X-Gm-Message-State: AOAM530CNbxO/oK6KyjBwVAkRUdXVCaYvrWSVzVfaRqTrrxzs+GH5kir
        JHAaF6GNoE0PuieblnyNxw==
X-Google-Smtp-Source: ABdhPJwNYZd7xpVuZDfxAUPHXc9QXyAk3Crli9jNKY8hibPZMTQIDmY+hfVbpBd8eOJzBJLhoj3V+g==
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr4137495ilu.154.1631802571878;
        Thu, 16 Sep 2021 07:29:31 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id r7sm1826408ilm.5.2021.09.16.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 07:29:31 -0700 (PDT)
Received: (nullmailer pid 1304478 invoked by uid 1000);
        Thu, 16 Sep 2021 14:29:30 -0000
Date:   Thu, 16 Sep 2021 09:29:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Message-ID: <YUNUyolr6ksEoZI3@robh.at.kernel.org>
References: <20210916084714.311048-1-zhang.lyra@gmail.com>
 <20210916084714.311048-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916084714.311048-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:47:12PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible strings.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> new file mode 100644
> index 000000000000..be3c37180279
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2019-2021 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: UMS512 Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - sprd,ums512-apahb-gate
> +      - sprd,ums512-ap-clk
> +      - sprd,ums512-aonapb-clk
> +      - sprd,ums512-pmu-gate
> +      - sprd,ums512-g0-pll
> +      - sprd,ums512-g2-pll
> +      - sprd,ums512-g3-pll
> +      - sprd,ums512-gc-pll
> +      - sprd,ums512-aon-gate
> +      - sprd,ums512-audcpapb-gate
> +      - sprd,ums512-audcpahb-gate
> +      - sprd,ums512-gpu-clk
> +      - sprd,ums512-mm-clk
> +      - sprd,ums512-mm-gate-clk
> +      - sprd,ums512-apapb-gate
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are declared in devicetree.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - sprd,ums512-ap-clk
> +        - sprd,ums512-aonapb-clk
> +        - sprd,ums512-mm-clk
> +then:
> +  required:
> +    - reg
> +
> +else:
> +  description: |
> +    Other UMS512 clock nodes should be the child of a syscon node in
> +    which compatible string should be:
> +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> +
> +    The 'reg' property for the clock node is also required if there is a sub
> +    range of registers for the clocks.

In which cases is this not true?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ap_clk: clock-controller@20200000 {
> +      compatible = "sprd,ums512-ap-clk";
> +      reg = <0x20200000 0x1000>;
> +      clocks = <&ext_26m>;
> +      clock-names = "ext-26m";
> +      #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ap_apb_regs: syscon@71000000 {
> +      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
> +      reg = <0x71000000 0x3000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0x71000000 0x3000>;
> +
> +      apahb_gate: clock-controller@0 {
> +        compatible = "sprd,ums512-apahb-gate";
> +        reg = <0x0 0x2000>;
> +        #clock-cells = <1>;
> +      };

We have this example in the MFD schema, so drop it here.
