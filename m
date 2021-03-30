Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24A334E37D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhC3It0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:49:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36989 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhC3Is4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:48:56 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lRA3T-0004lL-E2
        for linux-kernel@vger.kernel.org; Tue, 30 Mar 2021 08:48:55 +0000
Received: by mail-wr1-f72.google.com with SMTP id m13so8819696wri.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=klQmGv60Fj1L8SIUk4QGLeKpz6t2wilREmbvV+IHG9o=;
        b=Sd/vu8jJuMv6vDTWckS3+aFbOhgZpTBVwoozA81KgHFczhfIvUEpv1krgtGxezj9Hi
         AZYqaLE+XnUgEznAD36iGiQVtD3kcby3tA6SBrPgeMuq970zHh4pmZYk6IPZiJi99Apl
         e0C4Suy3fGHvXhL3gFU1aIla/DykqSco2MM5pMsQq9rfDyXNZkEbvnsiqOibN0wu7E8R
         HG5UhRX54me9xTtY/G3tABEmP3/4urfv4J5ytN/nvh/yOEmcqTIlfsUgtTEjmYrl8LrP
         E+tS5KWPqJiUTeWOKZhvLbybBGITYcf0FMohffKMIbkjeGeRREmJ2HQ77fR1ShRmnKv1
         EcjA==
X-Gm-Message-State: AOAM532P3iAAcznge4DfH0PkF7W5xfT4iuZaESuVTiKmhcUJTf6TBD0K
        CIuIZIcNTNPjCkkDimJAckm0K4Q9Kb65d8cR1Ss5EMaNn9xjqDYkWrl+ljpflPuHN3ARu1Awc87
        wrkG+KWiklNENAudJk5xFvmF8muu3zosVMSzkF6339g==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2905275wmc.51.1617094135042;
        Tue, 30 Mar 2021 01:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVTs+PddCKPalHGYjD7MxlC/SymLJ4ZLrIrpB8wLKJGNPHy98StbpBdHD6uSLIVZn8s4g2tw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2905264wmc.51.1617094134832;
        Tue, 30 Mar 2021 01:48:54 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id u3sm33760826wrt.82.2021.03.30.01.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:48:54 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] dt-bindings: memory: tegra20: emc: Convert to
 schema
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210329194602.17049-1-digetx@gmail.com>
 <20210329194602.17049-6-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7e45375c-3e24-4fc1-5776-190db32681e5@canonical.com>
Date:   Tue, 30 Mar 2021 10:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329194602.17049-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2021 21:46, Dmitry Osipenko wrote:
> Convert Tegra20 External Memory Controller binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt | 130 --------
>  .../nvidia,tegra20-emc.yaml                   | 294 ++++++++++++++++++
>  2 files changed, 294 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> deleted file mode 100644
> index d2250498c36d..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -Embedded Memory Controller
> -
> -Properties:
> -- name : Should be emc
> -- #address-cells : Should be 1
> -- #size-cells : Should be 0
> -- compatible : Should contain "nvidia,tegra20-emc".
> -- reg : Offset and length of the register set for the device
> -- nvidia,use-ram-code : If present, the sub-nodes will be addressed
> -  and chosen using the ramcode board selector. If omitted, only one
> -  set of tables can be present and said tables will be used
> -  irrespective of ram-code configuration.
> -- interrupts : Should contain EMC General interrupt.
> -- clocks : Should contain EMC clock.
> -- nvidia,memory-controller : Phandle of the Memory Controller node.
> -- #interconnect-cells : Should be 0.
> -- operating-points-v2: See ../bindings/opp/opp.txt for details.
> -
> -For each opp entry in 'operating-points-v2' table:
> -- opp-supported-hw: One bitfield indicating SoC process ID mask
> -
> -	A bitwise AND is performed against this value and if any bit
> -	matches, the OPP gets enabled.
> -
> -Optional properties:
> -- power-domains: Phandle of the SoC "core" power domain.
> -
> -Child device nodes describe the memory settings for different configurations and clock rates.
> -
> -Example:
> -
> -	opp_table: opp-table {
> -		compatible = "operating-points-v2";
> -
> -		opp@36000000 {
> -			opp-microvolt = <950000 950000 1300000>;
> -			opp-hz = /bits/ 64 <36000000>;
> -		};
> -		...
> -	};
> -
> -	memory-controller@7000f400 {
> -		#address-cells = < 1 >;
> -		#size-cells = < 0 >;
> -		#interconnect-cells = <0>;
> -		compatible = "nvidia,tegra20-emc";
> -		reg = <0x7000f400 0x400>;
> -		interrupts = <0 78 0x04>;
> -		clocks = <&tegra_car TEGRA20_CLK_EMC>;
> -		nvidia,memory-controller = <&mc>;
> -		power-domains = <&domain>;
> -		operating-points-v2 = <&opp_table>;
> -	}
> -
> -
> -Embedded Memory Controller ram-code table
> -
> -If the emc node has the nvidia,use-ram-code property present, then the
> -next level of nodes below the emc table are used to specify which settings
> -apply for which ram-code settings.
> -
> -If the emc node lacks the nvidia,use-ram-code property, this level is omitted
> -and the tables are stored directly under the emc node (see below).
> -
> -Properties:
> -
> -- name : Should be emc-tables
> -- nvidia,ram-code : the binary representation of the ram-code board strappings
> -  for which this node (and children) are valid.
> -
> -
> -
> -Embedded Memory Controller configuration table
> -
> -This is a table containing the EMC register settings for the various
> -operating speeds of the memory controller. They are always located as
> -subnodes of the emc controller node.
> -
> -There are two ways of specifying which tables to use:
> -
> -* The simplest is if there is just one set of tables in the device tree,
> -  and they will always be used (based on which frequency is used).
> -  This is the preferred method, especially when firmware can fill in
> -  this information based on the specific system information and just
> -  pass it on to the kernel.
> -
> -* The slightly more complex one is when more than one memory configuration
> -  might exist on the system.  The Tegra20 platform handles this during
> -  early boot by selecting one out of possible 4 memory settings based
> -  on a 2-pin "ram code" bootstrap setting on the board. The values of
> -  these strappings can be read through a register in the SoC, and thus
> -  used to select which tables to use.
> -
> -Properties:
> -- name : Should be emc-table
> -- compatible : Should contain "nvidia,tegra20-emc-table".
> -- reg : either an opaque enumerator to tell different tables apart, or
> -  the valid frequency for which the table should be used (in kHz).
> -- clock-frequency : the clock frequency for the EMC at which this
> -  table should be used (in kHz).
> -- nvidia,emc-registers : a 46 word array of EMC registers to be programmed
> -  for operation at the 'clock-frequency' setting.
> -  The order and contents of the registers are:
> -    RC, RFC, RAS, RP, R2W, W2R, R2P, W2P, RD_RCD, WR_RCD, RRD, REXT,
> -    WDV, QUSE, QRST, QSAFE, RDV, REFRESH, BURST_REFRESH_NUM, PDEX2WR,
> -    PDEX2RD, PCHG2PDEN, ACT2PDEN, AR2PDEN, RW2PDEN, TXSR, TCKE, TFAW,
> -    TRPAB, TCLKSTABLE, TCLKSTOP, TREFBW, QUSE_EXTRA, FBIO_CFG6, ODT_WRITE,
> -    ODT_READ, FBIO_CFG5, CFG_DIG_DLL, DLL_XFORM_DQS, DLL_XFORM_QUSE,
> -    ZCAL_REF_CNT, ZCAL_WAIT_CNT, AUTO_CAL_INTERVAL, CFG_CLKTRIM_0,
> -    CFG_CLKTRIM_1, CFG_CLKTRIM_2
> -
> -		emc-table@166000 {
> -			reg = <166000>;
> -			compatible = "nvidia,tegra20-emc-table";
> -			clock-frequency = < 166000 >;
> -			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 >;
> -		};
> -
> -		emc-table@333000 {
> -			reg = <333000>;
> -			compatible = "nvidia,tegra20-emc-table";
> -			clock-frequency = < 333000 >;
> -			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> -						 0 0 0 0 >;
> -		};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> new file mode 100644
> index 000000000000..9665fdd80b22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> @@ -0,0 +1,294 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra20-emc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra20 SoC External Memory Controller
> +
> +maintainers:
> +  - Dmitry Osipenko <digetx@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  The External Memory Controller (EMC) interfaces with the off-chip SDRAM to
> +  service the request stream sent from Memory Controller. The EMC also has
> +  various performance-affecting settings beyond the obvious SDRAM configuration
> +  parameters and initialization settings. Tegra20 EMC supports multiple JEDEC
> +  standard protocols: DDR1, LPDDR2 and DDR2.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra20-emc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

An idea for a follow-up patch (not needed here) - add the clock-names
and get the clock by name in the driver.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#interconnect-cells":
> +    const: 0
> +
> +  nvidia,memory-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle of the Memory Controller node.
> +
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle of the SoC "core" power domain.

I think the core checks the type, so you only need to limit max items.

> +
> +  operating-points-v2:
> +    description:
> +      Should contain freqs and voltages and opp-supported-hw property, which
> +      is a bitfield indicating SoC process ID mask.
> +
> +  nvidia,use-ram-code:
> +    type: boolean
> +    description:
> +      If present, the emc-tables@ sub-nodes will be addressed.
> +
> +patternProperties:
> +  "^emc-table@[0-9]+$":

This might not be easy but you should add constraints when emc-table and
emc-tables are expected. The schema should check if proper node is used
depending on "nvidia,use-ram-code".

> +    type: object
> +    properties:
> +      compatible:
> +        const: nvidia,tegra20-emc-table
> +
> +      clock-frequency:
> +        description:
> +          Memory clock rate in kHz.
> +        minimum: 1000
> +        maximum: 900000
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Either an opaque enumerator to tell different tables apart, or
> +          the valid frequency for which the table should be used (in kHz).
> +
> +      nvidia,emc-registers:
> +        description:
> +          EMC timing characterization data. These are the registers
> +          (see section "15.4.1 EMC Registers" in the TRM) whose values
> +          need to be specified, according to the board documentation.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - description: EMC_RC
> +          - description: EMC_RFC
> +          - description: EMC_RAS
> +          - description: EMC_RP
> +          - description: EMC_R2W
> +          - description: EMC_W2R
> +          - description: EMC_R2P
> +          - description: EMC_W2P
> +          - description: EMC_RD_RCD
> +          - description: EMC_WR_RCD
> +          - description: EMC_RRD
> +          - description: EMC_REXT
> +          - description: EMC_WDV
> +          - description: EMC_QUSE
> +          - description: EMC_QRST
> +          - description: EMC_QSAFE
> +          - description: EMC_RDV
> +          - description: EMC_REFRESH
> +          - description: EMC_BURST_REFRESH_NUM
> +          - description: EMC_PDEX2WR
> +          - description: EMC_PDEX2RD
> +          - description: EMC_PCHG2PDEN
> +          - description: EMC_ACT2PDEN
> +          - description: EMC_AR2PDEN
> +          - description: EMC_RW2PDEN
> +          - description: EMC_TXSR
> +          - description: EMC_TCKE
> +          - description: EMC_TFAW
> +          - description: EMC_TRPAB
> +          - description: EMC_TCLKSTABLE
> +          - description: EMC_TCLKSTOP
> +          - description: EMC_TREFBW
> +          - description: EMC_QUSE_EXTRA
> +          - description: EMC_FBIO_CFG6
> +          - description: EMC_ODT_WRITE
> +          - description: EMC_ODT_READ
> +          - description: EMC_FBIO_CFG5
> +          - description: EMC_CFG_DIG_DLL
> +          - description: EMC_DLL_XFORM_DQS
> +          - description: EMC_DLL_XFORM_QUSE
> +          - description: EMC_ZCAL_REF_CNT
> +          - description: EMC_ZCAL_WAIT_CNT
> +          - description: EMC_AUTO_CAL_INTERVAL
> +          - description: EMC_CFG_CLKTRIM_0
> +          - description: EMC_CFG_CLKTRIM_1
> +          - description: EMC_CFG_CLKTRIM_2
> +
> +    required:
> +      - clock-frequency
> +      - compatible
> +      - reg
> +      - nvidia,emc-registers
> +
> +    additionalProperties: false
> +
> +  "^emc-tables@[a-z0-9\\-]+$":

Why \ and - in the pattern?

Best regards,
Krzysztof
