Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A53A8C15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFOWxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:53:03 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:40892 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhFOWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:53:00 -0400
Received: by mail-il1-f182.google.com with SMTP id b14so600760ilq.7;
        Tue, 15 Jun 2021 15:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opap8Pc211PDfiYK0lAjeotI8dphuxVUIi8AzzAvhVg=;
        b=Pis6efOK04Fk3lN9Z3FshmMNP5yG79jD8KxotVzt2tvanvXIlijtl5+2+1en1t6JSP
         Ss8FWEQZ41Ns+dbB4J3HSk4jZ3RZOnq/8Xn2IhqV76VJn4DWoCBfzMr6PuputIRT9ByV
         DsedfVprRNu3o4bDHaf11pW0YgznAx0fOj7AHRSKdkXxu5UR3tdLeR95VjAPjM1GoF1J
         cXJOohxAifS1iH5VnLA9nzCh0kDRdtvBRk9p3913FPUm3rZ44dhX+x5QEO7QOPNOQgpc
         H3xMcqXVAOWII7kzt8u9EoMR9g5A775/nTJbRkqN6ujh/RTNhYJl+WWwjjIkglkOwlsr
         5eUw==
X-Gm-Message-State: AOAM530zbfH0hNlMqKGQttEqJuicVGlQu+fXKxFOOln6Dv1IZbUyuT5t
        lMVLI5+4OQAEMttZiB89fZqOXl35zw==
X-Google-Smtp-Source: ABdhPJw5T2orqmGqjguMKb3Ij75uI4pTV8gKU/COi92gDoYGKMVJLarE7tiYTs1W5FGt8oQJJG0Rew==
X-Received: by 2002:a05:6e02:1a45:: with SMTP id u5mr1247054ilv.242.1623797453581;
        Tue, 15 Jun 2021 15:50:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e14sm226984ilc.47.2021.06.15.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:50:52 -0700 (PDT)
Received: (nullmailer pid 1433414 invoked by uid 1000);
        Tue, 15 Jun 2021 22:50:50 -0000
Date:   Tue, 15 Jun 2021 16:50:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, petre.minciunescu@analog.com
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: ad9545: Add documentation
Message-ID: <20210615225050.GA1417742@robh.at.kernel.org>
References: <20210614070718.78041-1-alexandru.tachici@analog.com>
 <20210614070718.78041-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614070718.78041-3-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:07:18AM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add dt bindings for ad9545.

Kind of a lot of properties, not really sure what to do about that...

> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../devicetree/bindings/clock/clk-ad9545.yaml | 556 ++++++++++++++++++
>  include/dt-bindings/clock/ad9545.h            |  69 +++
>  2 files changed, 625 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
>  create mode 100644 include/dt-bindings/clock/ad9545.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/clk-ad9545.yaml b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> new file mode 100644
> index 000000000000..50553a88ab44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> @@ -0,0 +1,556 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/clk-ad9545.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
> +  1 pps Synchronizer and Jitter Cleaner
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9545
> +
> +  "#clock-cells":
> +    const: 2
> +
> +  reg:
> +    description: |

Don't need '|' if there's no formatting or anything that has to be 
escaped.

Same applies elsewhere.

> +      I2C address of the secondary device.
> +    minimum: 0
> +    maximum: 0xFF
> +
> +  avcc-supply:
> +    description: |
> +      Phandle to the Avcc power supply.
> +
> +  adi,freq-doubler:
> +    description: |
> +      The system clock PLL provides the user with the option of doubling the reference frequency.
> +    type: boolean
> +
> +  adi,ref-crystal:
> +    description: |
> +      At XOA,XOB there is a crystal connected that needs maintaining.
> +      Otherwise it is assumed that there is a TCXO or OCXO connected.
> +    type: boolean
> +
> +  adi,ref-frequency-hz:
> +    description: |
> +      Reference input frequency at XOA,XOB. This is used for the system clock.
> +
> +  clocks:
> +    items:
> +      - description: Ref A clock input
> +      - description: Ref AA clock input
> +      - description: Ref B clock input
> +      - description: Ref BB clock input
> +      - description: Ref M0 clock input
> +      - description: Ref M1 clock input
> +      - description: Ref M2 clock input
> +    maxItems: 4

Looks like 7 is the max...

> +
> +  assigned-clocks:
> +    description:
> +      Clocks are identified using two cells <&ad9545 clock_type clock_address>.
> +    minItems: 1
> +    maxItems: 14
> +
> +  assigned-clock-rates:
> +    minItems: 1
> +    maxItems: 14
> +
> +  assigned-clock-phases:
> +    minItems: 1
> +    maxItems: 14
> +
> +  clock-output-names:
> +    maxItems: 10
> +
> +  aux-dpll:
> +    description: |
> +      Auxiliary DPLL used for Closed-Loop method of system clock compensation.
> +    type: object
> +
> +    properties:
> +      adi,compensation-source:
> +        description: |
> +          System clock closed loop compensation source.
> +          Choose from Ref-A to Ref-BB [0-3] or aux TDCs [4-5].
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5]
> +
> +      adi,aux-dpll-bw-mhz:
> +        description: |
> +          Auxiliary DPLL bandwidth.
> +        minimum: 100
> +        maximum: 2000000
> +
> +      adi,rate-change-limit:
> +        description: |
> +          Error compensation rate change limiting expressed in ppb/s. Disabled if property is
> +          missing.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [715, 1430, 2860, 5720, 11440, 22880, 45760]
> +
> +    required:
> +      - adi,compensation-source
> +      - adi,aux-dpll-bw-mhz
> +
> +  aux-tdc-clks:
> +    description: |
> +      Child nodes represent Mx pin reference clock inputs.
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +         const: 1
> +
> +      '#size-cells':
> +         const: 0
> +
> +    patternProperties:
> +      "^aux-tdc-clk@[0-3]$":
> +
> +        description: |
> +          Represents a Mx pin reference clock input.
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: |
> +              Address of the Auxiliary TDC.
> +            maximum: 1

0-3 as the unit-address says or only 1? 

> +
> +          adi,pin-nr:
> +            description: |
> +              Pin number to be the source of this TDC.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 6
> +
> +        required:
> +          - reg
> +          - adi,pin-nr
> +
> +    additionalProperties: false
> +
> +  ref-input-clks:
> +    description: |
> +      Child nodes represent reference clock inputs.
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +         const: 1
> +
> +      '#size-cells':
> +         const: 0
> +
> +    patternProperties:
> +      "^ref-input-clk@[0-3]$":
> +        description: |
> +          Represents a reference clock input.
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: |
> +              The reference input number. It can have up to 4 input clocks numbered from 0 to 3.
> +              (mapped: [refa, refaa, refb, refbb] -> [0, 1, 2, 3])
> +            maxItems: 1
> +
> +          adi,single-ended-mode:
> +            description: |
> +              Single-ended configuration mode.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +
> +          adi,differential-mode:
> +            description: |
> +              Differential configuration mode.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2]
> +
> +          adi,r-divider-ratio:
> +            description: |
> +              Each reference input has a dedicated divider.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 1073741824
> +
> +          adi,ref-dtol-pbb:
> +            description: |
> +              REFx offset limit. Constitutes a fractional portion of the corresponding nominal period.
> +              The 24-bit number represents fractional units of parts per billion (ppb) up to a
> +              maximum of approximately 17 million ppb (1.7%).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 16777215
> +            default: 100000
> +
> +          adi,ref-monitor-hysteresis-pbb:
> +            description: |
> +              Basis points of the offset limit representing per ten thousand of REFx offset limit.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 3125, 6250, 12500, 25000, 50000, 75000, 87500]
> +            default: 12500
> +
> +          adi,ref-validation-timer-ms:
> +            description: |
> +              Time required for a reference to remain in tolerance condition before being
> +              available to be used.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 1048574
> +            default: 10
> +
> +          adi,freq-lock-threshold-ps:
> +            description: |
> +              Phase lock detector threshold (in picoseconds).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 16777215
> +
> +          adi,phase-lock-threshold-ps:
> +            description: |
> +              Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 16777215
> +
> +          adi,phase-lock-fill-rate:
> +            description: |
> +              Parameter used by the DPLL Phase Lock Detector.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 255
> +            default: 10
> +
> +          adi,phase-lock-drain-rate:
> +            description: |
> +              Parameter used by the DPLL Phase Lock Detector.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 255
> +            default: 10
> +
> +          adi,freq-lock-fill-rate:
> +            description: |
> +              Parameter used by the DPLL Frequency Lock Detector.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 255
> +            default: 10
> +
> +          adi,freq-lock-drain-rate:
> +            description: |
> +              Parameter used by the DPLL Frequency Lock Detector.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 255
> +            default: 10
> +
> +        required:
> +          - reg
> +          - adi,r-divider-ratio
> +          - adi,ref-dtol-pbb
> +          - adi,ref-monitor-hysteresis-pbb
> +          - adi,ref-validation-timer-ms
> +          - adi,freq-lock-threshold-ps
> +          - adi,phase-lock-threshold-ps
> +
> +    additionalProperties: false
> +
> +  pll-clks:
> +    description: |
> +      Child nodes represent PLLs.
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +         const: 1
> +
> +      '#size-cells':
> +         const: 0
> +
> +    patternProperties:
> +      "^pll-clk@[0-1]$":
> +        description: |
> +          Represents a PLL.
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: |
> +              PLL number. AD9545 has two PLLs.
> +            maxItems: 1
> +
> +          '#address-cells':
> +             const: 1
> +
> +          '#size-cells':
> +             const: 0
> +
> +          adi,fast-acq-trigger-mode:
> +            description: |
> +              If this is not specified Fast Acquisition will be used every time. See reg 0x2106
> +              for constraints on Fast Acquisition trigger.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 15
> +            default: 0
> +
> +        patternProperties:
> +          "^profile@[0-5]$":
> +            description: |
> +              Represents a DPLL profile. Each DPLL can have up to 6 specified sources
> +              wih priorities assigned.
> +            type: object
> +
> +            properties:
> +              reg:
> +                description: |
> +                  Profile number. A DPLL can have up to 6 translation profiles.
> +                maxItems: 1

Blank line

> +              adi,profile-priority:
> +                description: |
> +                  Profile selection priority. 0 is the highest, 31 is the lowest. For revertive
> +                  reference switching, ensure that priority difference is > 7.
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                minimum: 0
> +                maximum: 31
> +
> +              adi,pll-source:
> +                description: |
> +                  Each PLL can have 1 signal source. Choose from Ref-A to Ref-BB [0-3] or aux NCOs [4-5].
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [0, 1, 2, 3, 4, 5]
> +
> +              adi,pll-loop-bandwidth-uhz:
> +                description: |
> +                  PLL loop bandwidth in microhertz.
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                minimum: 1
> +                maximum: 1850000000
> +                default: 200000000
> +
> +              adi,fast-acq-excess-bw:
> +                description: |
> +                  Controls the DPLL loop bandwidth scaling factor while in fast acquisition mode.
> +                  0 means this feature is disabled.
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
> +                default: 0
> +
> +              adi,fast-acq-timeout-ms:
> +                description: |
> +                  Fast acquisition timeout controls the maximum amount of time that DPLL waits to
> +                  achieve phase lock before reducing the loop bandwidth by a factor of two.
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [1, 10, 50, 100, 500, 1000, 10000, 50000]
> +                default: 1
> +
> +              adi,fast-acq-lock-settle-ms:
> +                description: |
> +                  Controls how long DPLL must wait after achieving phase lock before reducing
> +                  the loop bandwidth by a factor of 2.
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [1, 10, 50, 100, 500, 1000, 10000, 50000]
> +                default: 1
> +
> +            required:
> +              - reg
> +              - adi,pll-source
> +              - adi,pll-loop-bandwidth-uhz
> +
> +        additionalProperties: false
> +
> +        required:
> +          - reg
> +
> +    additionalProperties: false
> +
> +  aux-ncos:
> +    description: |
> +      Child nodes represent auxiliary Numerical Controlled Oscilators.
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +         const: 1
> +
> +      '#size-cells':
> +         const: 0
> +
> +    patternProperties:
> +      "^aux-nco-clk@[0-1]$":
> +        description: |
> +          Represents an auxiliary Numerical Controlled Oscilator. Generates timestamps that
> +          can be sent to the DPLL0 or DPLL1.
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: |
> +              Auxiliary NCO address mapped: [NCO0, NCO1] -> [0, 1].
> +            maxItems: 1
> +
> +          adi,freq-lock-threshold-ps:
> +            description: |
> +              Phase lock detector threshold (in picoseconds).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 16777215
> +
> +          adi,phase-lock-threshold-ps:
> +            description: |
> +              Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 16777215
> +
> +        required:
> +          - reg
> +          - adi,freq-lock-threshold-ps
> +          - adi,phase-lock-threshold-ps
> +
> +    additionalProperties: false
> +
> +  output-clks:
> +    description: |
> +      Child nodes represent clock outputs.
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +         const: 1
> +
> +      '#size-cells':
> +         const: 0
> +
> +    patternProperties:
> +      "^output-clk@([0-9]|1[0-3])$":
> +        description: |
> +          Represents a clock output.
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: |
> +              The reference input number. It can have up to 10 output clocks mapped:
> +              (OUT0AP OUT0AN OUT0BP OUT0BN OUT0CP OUT0CN OUT1AP OUT1AN OUT1BP OUT1BN) ->
> +              (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

Looks like constraints (maximum: 9).

> +            maxItems: 1
> +
> +          adi,current-source:
> +            description: |
> +              If specified output is set as current source.
> +            type: boolean
> +
> +          adi,current-source-microamp:
> +            description: |
> +              The magnitude of the driver current.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [7500, 12500, 15000]
> +
> +          adi,output-mode:
> +            description: |
> +              Output driver mode.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2]
> +
> +        required:
> +          - reg
> +          - adi,current-source-microamp
> +          - adi,output-mode
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,ref-frequency-hz
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ad9545.h>
> +
> +    i2c1 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ad9545_clock: ad9545@4A {

clock-controller@4a

> +                compatible = "adi,ad9545";
> +                reg = <0x4A>;
> +
> +                adi,ref-crystal;
> +                adi,ref-frequency-hz = <52000000>;
> +
> +                #clock-cells = <2>;
> +                assigned-clocks = <&ad9545_clock AD9545_CLK_NCO AD9545_NCO0>,
> +                                  <&ad9545_clock AD9545_CLK_PLL AD9545_PLL1>,
> +                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1A>,
> +                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1B>;
> +                assigned-clock-rates = <10000>, <1875000000>, <156250000>, <156250000>;
> +                assigned-clock-phases = <0>, <0>, <0>, <180>;
> +
> +                aux-ncos {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        aux-nco-clk@AD9545_NCO0 {

Can't have defines in unit addresses. We generally don't have defines 
for 'reg' values.

> +                                reg = <AD9545_NCO0>;
> +                                adi,freq-lock-threshold-ps = <16000000>;
> +                                adi,phase-lock-threshold-ps = <16000000>;
> +                        };
> +                };
> +
> +                pll-clks {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        ad9545_apll1: pll-clk@AD9545_PLL1 {
> +                                reg = <AD9545_PLL1>;
> +
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;
> +
> +                                profile@0 {
> +                                       reg = <0>;
> +                                       adi,pll-source = <4>;
> +                                       adi,profile-priority = <0>;
> +                                       adi,pll-loop-bandwidth-uhz = <200000000>;
> +                                };
> +                        };
> +                };
> +
> +                output-clks {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        output-clk@AD9545_Q1A {
> +                                reg = <AD9545_Q1A>;
> +                                adi,output-mode = <DRIVER_MODE_DUAL_DIV>;
> +                                adi,current-source-microamp = <15000>;
> +                        };
> +
> +                        output-clk@AD9545_Q1B {
> +                                reg = <AD9545_Q1B>;
> +                                adi,output-mode = <DRIVER_MODE_DUAL_DIV>;
> +                                adi,current-source-microamp = <15000>;
> +                        };
> +                };
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/ad9545.h b/include/dt-bindings/clock/ad9545.h
> new file mode 100644
> index 000000000000..857d50e5715b
> --- /dev/null
> +++ b/include/dt-bindings/clock/ad9545.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * AD9545 Network Clock Generator/Synchronizer
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AD9545_H_
> +#define _DT_BINDINGS_CLOCK_AD9545_H_
> +
> +/* Input Driver Mode
> + * Use for adi,single-ended-mode:
> + */
> +#define DRIVER_MODE_AC_COUPLED_IF	0
> +#define DRIVER_MODE_DC_COUPLED_1V2	1
> +#define DRIVER_MODE_DC_COUPLED_1V8	2
> +#define DRIVER_MODE_IN_PULL_UP		3
> +
> +/* Input Driver Mode
> + * Use for adi,differential-mode:
> + */
> +#define DRIVER_MODE_AC_COUPLED		0
> +#define DRIVER_MODE_DC_COUPLED		1
> +#define DRIVER_MODE_DC_COUPLED_LVDS	2
> +
> +/* Output Driver Mode
> + * Use for adi,output-mode:
> + */
> +#define DRIVER_MODE_SINGLE_DIV_DIF	0
> +#define DRIVER_MODE_SINGLE_DIV		1
> +#define DRIVER_MODE_DUAL_DIV		2
> +
> +/* Clock types */
> +#define AD9545_CLK_OUT			0
> +#define AD9545_CLK_PLL			1
> +#define AD9545_CLK_NCO			2
> +#define AD9545_CLK_AUX_TDC		3
> +
> +/* PLL addresses */
> +#define AD9545_PLL0			0
> +#define AD9545_PLL1			1
> +
> +/* Outputs addresses */
> +#define AD9545_Q0A			0
> +#define AD9545_Q0AA			1
> +#define AD9545_Q0B			2
> +#define AD9545_Q0BB			3
> +#define AD9545_Q0C			4
> +#define AD9545_Q0CC			5
> +#define AD9545_Q1A			6
> +#define AD9545_Q1AA			7
> +#define AD9545_Q1B			8
> +#define AD9545_Q1BB			9
> +
> +/* NCO addresses */
> +#define AD9545_NCO0			0
> +#define AD9545_NCO1			1
> +
> +/* TDC addresses */
> +#define AD9545_CLK_AUX_TDC0		0
> +#define AD9545_CLK_AUX_TDC1		1
> +
> +/* Ex:
> + * Output Q0C clock: <&ad9545_clock AD9545_CLK_OUT AD9545_Q0C>;
> + * PLL0 clock: <&ad9545_clock AD9545_CLK_PLL AD9545_PLL0>;
> + * NCO1 clock: <&ad9545_clock AD9545_CLK_NCO AD9545_NCO1>;
> + */
> +
> +#endif /* _DT_BINDINGS_CLOCK_AD9545_H_ */
> -- 
> 2.25.1
