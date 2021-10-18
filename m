Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA4432431
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhJRQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:53:31 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42613 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhJRQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:53:00 -0400
Received: by mail-ot1-f47.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso565851ota.9;
        Mon, 18 Oct 2021 09:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/8ZdPCDpzCIf++N+/tm/eQVkJplZHCJWzFtvEkgSvE=;
        b=pyq0yNM7vFy880eL+v2p33mGRvjl+aFNNUc5uGEGhVRA9/m5FhHCMNgiV6k6JM3gmN
         glD56CY5Nth2M/GPg1TIoe2xlDOdfbsBYGNZD2MoxkrivYXZ+1S9LaIgPTMe32BX5JJq
         QIWxAjNigtEiTPgXgh2F+Q31dOGugR08ZkrH9VhTNPoAsKWrr+aZ4KbFfIiRdZrdPuDD
         4MO5+BJTv2MjnQR+xkOvVEQphCthaFFTkRnD6/9/93LERdzfDGGAv2xD0zd6OohxADnI
         xPjc3Uuyz0v6PoYczdWcUopcO4L2T1g6oBZcpU8eIUmsn5mwahyBorp15IWyfA4qGxC6
         qGNg==
X-Gm-Message-State: AOAM533Fi/Np20yBkuqVdq20hWOCaEcey9+2+1f5EM0SS46RN+9dgO0f
        qmIMmVNWRP7yxFS6lYothQ==
X-Google-Smtp-Source: ABdhPJxi73W9ObWJAjfMigXJBzyssvZtHIUGhEVyxD6AIHc53L87lFuMcGjh8KWtklEqPM0P46wzqQ==
X-Received: by 2002:a9d:718e:: with SMTP id o14mr767288otj.299.1634575849116;
        Mon, 18 Oct 2021 09:50:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j8sm689565otu.59.2021.10.18.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:50:48 -0700 (PDT)
Received: (nullmailer pid 2544249 invoked by uid 1000);
        Mon, 18 Oct 2021 16:50:47 -0000
Date:   Mon, 18 Oct 2021 11:50:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <YW2l5yTj2Adc+Kjz@robh.at.kernel.org>
References: <20211011012212.91357-1-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011012212.91357-1-osk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 09:22:11PM -0400, Oskar Senft wrote:
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
> Changes from PATCH v6:
> - Fixed formatting error reported by yamllint
> 
> Changes from PATCH v5:
> - Refactored to use patternProperties.
> - Added validation for sensor-type and temperature-mode.
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..a0a245938528
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7802Y Hardware Monitoring IC
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
> +  5 remote temperature sensors with SMBus interface.
> +
> +  Datasheets:
> +    https://www.nuvoton.com/export/resource-files/Nuvoton_NCT7802Y_Datasheet_V12.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object

I would move the 'additionalProperties' here. I think that's a bit 
easier to read.

> +    properties:
> +      reg:
> +        items:
> +          - enum:
> +              - 0    # Local Temperature Sensor ("LTD")
> +              - 1    # Remote Temperature Sensor or Voltage Sensor 1 ("RTD1")
> +              - 2    # Remote Temperature Sensor or Voltage Sensor 2 ("RTD2")
> +              - 3    # Remote Temperature Sensor or Voltage Sensor 3 ("RTD3")

blank line

> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage

blank line

> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode

blank line

> +    required:
> +      - reg

blank line

> +    allOf:
> +      # For channels RTD1, RTD2 and RTD3, require sensor-type to be set.
> +      # Otherwise (for all other channels), do not allow temperature-mode to be
> +      # set.
> +      - if:
> +          properties:
> +            reg:
> +              items:
> +                - enum:
> +                    - 1
> +                    - 2
> +                    - 3
> +        then:
> +          required:
> +            - sensor-type
> +        else:
> +          not:
> +            required:
> +              - sensor-type
> +
> +      # For channels RTD1 and RTD2 and if sensor-type is "temperature", require
> +      # temperature-mode to be set. Otherwise (for all other channels or
> +      # sensor-type settings), do not allow temperature-mode to be set
> +      - if:
> +          properties:
> +            reg:
> +              items:
> +                - enum:
> +                    - 1
> +                    - 2
> +            sensor-type:
> +              items:
> +                - enum:
> +                    - temperature
> +        then:
> +          required:
> +            - temperature-mode
> +        else:
> +          not:
> +            required:
> +              - temperature-mode
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
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7802@28 {
> +            compatible = "nuvoton,nct7802";
> +            reg = <0x28>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 { /* LTD */
> +              reg = <0>;
> +              status = "okay";

Don't show status in examples.

> +            };
> +
> +            channel@1 { /* RTD1 */
> +              reg = <1>;
> +              status = "okay";
> +              sensor-type = "voltage";
> +            };
> +
> +            channel@2 { /* RTD2 */
> +              reg = <2>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermal-diode";
> +            };
> +
> +            channel@3 { /* RTD3 */
> +              reg = <3>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +            };
> +        };
> +    };
> -- 
> 2.33.0.882.g93a45727a2-goog
> 
> 
