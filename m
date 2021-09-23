Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560D416791
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhIWVi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:38:57 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39615 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbhIWViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:38:51 -0400
Received: by mail-ot1-f43.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so10487347ota.6;
        Thu, 23 Sep 2021 14:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbjFCOlJlbx4SbaGurKbZs2byZ6bHJqMjwDwtqafseo=;
        b=FlLKG9X+eqjM7P9iLB+tI6i0KXrlSf+XjUs0PhprNvY1faNiVQcmkz8kebju821Jai
         W76nJaQdBinXWH8DQKRQlYHB7hMTWqy0lwMIC2A+/uzkg0JxLxXo75A52Ga3JA6oKFJ3
         pdiPEqxy+YU1n3nyLM08RZ2VrXSVZG0TLaoagTX337/uJoK29r542X/2GZHEnFvzlxeW
         AL/LHDVTqMIj6mTZx/PDA2gkeeKfFuvcJGbtgwusmpnpFKKYhBEEze/BtuetA+Mj3g1I
         zQRAGpS9KjOs3yXvmXfLhka5xICQjAiLdqI1dOO/KnurPcqk7PX4ylG8AJOrpVa4Dp8v
         2xWQ==
X-Gm-Message-State: AOAM533MXikHI8IF9DIDa15i1NsOlAuAvHdaiRcXtfM7KGdjRWAY/CJd
        wnjTtq7VulfxBYJLuwiqTA==
X-Google-Smtp-Source: ABdhPJw9O910RBB8A8n+sNR/MsA9Mhom39GmnQpb8UhkS6Adr5dy3tU9MjBf9Q4AZZ6ab2VkDe4ejA==
X-Received: by 2002:a9d:615c:: with SMTP id c28mr768898otk.381.1632433039231;
        Thu, 23 Sep 2021 14:37:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm1536267otu.11.2021.09.23.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:37:18 -0700 (PDT)
Received: (nullmailer pid 3568677 invoked by uid 1000);
        Thu, 23 Sep 2021 21:37:17 -0000
Date:   Thu, 23 Sep 2021 16:37:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <YUzzjYMwNKwMFGSr@robh.at.kernel.org>
References: <20210921004627.2786132-1-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921004627.2786132-1-osk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:46:26PM -0400, Oskar Senft wrote:
> Document bindings for the Nuvoton NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..7512acbc9d1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,92 @@
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

Should be someone that cares about this h/w, not who applies patches.

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
> +  temperature-sensors:
> +    type: object
> +    description:
> +      |

Drop. Not needed if formatting is not needed to be maintained. (Also 
belongs on the prior line.)

> +      Configuration for temperature sensors. If temperature-sensors
> +      is not provided at all, the internal temperature sensor will be
> +      enabled. If temperature-sensors is provided, only the listed
> +      sensors will be configured as specified. The runtime configuration
> +      for un-listed sensors will not be touched in the chip. This allows
> +      sensors to be configured at power-up time from an EEPROM connected
> +      to the chip and at the sime time allows to override these settings
> +      using device tree configuration.
> +
> +    properties:
> +      ltd:
> +        type: object
> +        description: Internal Temperature Sensor ("LTD")

No child properties?

> +
> +      rtd3:
> +        type: object
> +        description:
> +          |
> +          Remote Temperature Sensor ("RTD3"). This sensor only supports
> +          thermistor mode.

No child properties?

> +
> +    patternProperties:
> +      "^rtd[1-2]$":
> +        type: object
> +        description: Remote Temperature Sensor ("RTDx")
> +        properties:
> +          "type":

Don't need quotes.

> +            description: Sensor type (3=thermal diode, 4=thermistor).

2nd time I've seen this property this week[1]. Needs to be more specific 
than just 'type'.

> +            allOf:

Don't need allOf.

> +              - $ref: "http://devicetree.org/schemas/types.yaml#/definitions/uint32"
> +              - items:
> +                  - enum: [ 3, 4 ]
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
> +            temperature-sensors {
> +                ltd {
> +                  status = "disabled";

Don't show status in examples.

> +                };
> +
> +                rtd1 {
> +                  status = "okay";
> +                  type = <4> /* thermistor */;
> +                };
> +            };
> +        };
> +    };
> -- 

[1] https://lore.kernel.org/all/CAL_Jsq+NXuF+F7OE3vyEbTUj6sxyMHVWHXbCuPPoFaKjpyZREQ@mail.gmail.com/
