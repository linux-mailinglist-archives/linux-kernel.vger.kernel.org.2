Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08D43CFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbhJ0Rpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ0Rpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:45:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FFC061570;
        Wed, 27 Oct 2021 10:43:09 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so4643322otq.12;
        Wed, 27 Oct 2021 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8T3iKaajnLQ50SzCr8FSJA5lHkizBtciDyKyGwL3bg=;
        b=A2EpsjmCuwAVXT3+W6sy6uzLsf3wZcjOG9ruZHlzrg5SoijB+uTHr+m771vYBq1hgf
         5qAeUc0oyC/oe2vS43NteSInZ76MGJJxIXkfQ3HE3V6Pl3p1NDKX2a0+AbdofoNB0l/P
         rpYAbSL9VHbb0vI0RNZtJbzP/OOo5v/MEyJOTcvqUwmBPTyfdDCAP+TGTAruCnW1dK39
         MSvDaIIbLBDdYj0JqxxhDrKY6dL2+8+ZN1OjTXlpssImD7UqagvBFljOD5iIO1eGa9Ke
         naelecwjNEV9fUvAMC/8h847iB08zynNqhbr7D+PE2fTcpwnqpVTvVx84j3JcUr7bE8x
         OIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=x8T3iKaajnLQ50SzCr8FSJA5lHkizBtciDyKyGwL3bg=;
        b=TXU4UtGXceqWN0ymmb9zUQ7aVkNixveIpb+gfJwPjevfhx2Bh5sd/yZATWBHcReTSF
         y9FYOp+difnr8OR8j61OB9kojrHR6ZKj7ABDhTW5QBu+MVe5TgfXIWgfHpVsEEmkDj/o
         +roeQfaJZlnGVP+CUngfLI5ThW4a6lxVtFRN6b8yxPrtr+Aw8NpRZCjNFtuRUEqdbjHH
         JW7TtBdaYa/R8wlBu67n3D1FIE68a0dADxqKVRLZkeD4kDat8ZQqWs7IobH2eb35OaKE
         ll7l5Jsu38a/CMMyYZ3pPO98MQdCP9f479LdbMyR7aJ4gPxNXzGiTKskHURf2Erfh7ko
         lWNg==
X-Gm-Message-State: AOAM532VAnPQz9whI+yZNBcvVllZSWCKW2XLXsxFe5xJqTU+u8r0+2tm
        juuEkZHEO2giDNwz3CgrL8bzAKIRRVY=
X-Google-Smtp-Source: ABdhPJwAZC2YzlblMqm+i3WO8/xXFn/RpvP+KaDaMNHmcr7F+PjblbAum/KrZ2J8gFJ1xKw8ahrthA==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr24473307otp.76.1635356589069;
        Wed, 27 Oct 2021 10:43:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf3sm277264oib.34.2021.10.27.10.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:43:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Oct 2021 10:43:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <20211027174307.GA2751517@roeck-us.net>
References: <20211020164213.174597-1-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020164213.174597-1-osk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:42:12PM -0400, Oskar Senft wrote:
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> Changes from PATCH v7:
> - Implemented review comments:
>   - Added blank lines to increase readability.
>   - Moved "additionalProperties" up to increase readability.
> 
> Changes from PATCH v6:
> - Fixed formatting error reported by yamllint
> 
> Changes from PATCH v5:
> - Refactored to use patternProperties.
> - Added validation for sensor-type and temperature-mode.
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..2f0620ecccc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,145 @@
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
> +additionalProperties: false
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
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        items:
> +          - enum:
> +              - 0    # Local Temperature Sensor ("LTD")
> +              - 1    # Remote Temperature Sensor or Voltage Sensor 1 ("RTD1")
> +              - 2    # Remote Temperature Sensor or Voltage Sensor 2 ("RTD2")
> +              - 3    # Remote Temperature Sensor or Voltage Sensor 3 ("RTD3")
> +
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +
> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode
> +
> +    required:
> +      - reg
> +
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
> +required:
> +  - compatible
> +  - reg
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
> +            };
> +
> +            channel@1 { /* RTD1 */
> +              reg = <1>;
> +              sensor-type = "voltage";
> +            };
> +
> +            channel@2 { /* RTD2 */
> +              reg = <2>;
> +              sensor-type = "temperature";
> +              temperature-mode = "thermal-diode";
> +            };
> +
> +            channel@3 { /* RTD3 */
> +              reg = <3>;
> +              sensor-type = "temperature";
> +            };
> +        };
> +    };
