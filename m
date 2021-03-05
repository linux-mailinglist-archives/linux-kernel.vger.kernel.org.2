Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4C32F540
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCEVUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:20:48 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41954 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:20:44 -0500
Received: by mail-oi1-f179.google.com with SMTP id y131so1153820oia.8;
        Fri, 05 Mar 2021 13:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rh1qgvbXxAkbdYcoJFmXp/DwN/2yHtElA4fo2FZcYJQ=;
        b=myumaA44KylUQYcKJcxFctupkXWCCkK0PPmSYO8OPjuaMR/AngIQQIUmuX5FcbV3kr
         XS/JdC1OQY+bW2z1eKKHC6ts47Bl0W8G/msrFkHA7NxbBvE7oeXlPXX55NQqY64idKmd
         34Zw9jrn7NmZP/Na9vlPsya83throaMD1Z34hSCV9t/3Oh7Ya4t9+Syvo6MssTRRUlzU
         uivpnh+dIwYcJi4wiEs2XT/UpFD0uEsMpZfzAvHuHCM/9WWw8OKEU8LCfPKErMnQwqy6
         XphMMtDbQNHQDHpN2qW3gxLenP6pCx9OahnTko9+OrPvTBl4oGmjsMcEbZCneOyY4q+f
         Znmg==
X-Gm-Message-State: AOAM5334+u5NasxcmaCJrRpYGslGtTzLl8fb1PDJvNiujjzmQPC0QvBv
        7WOrIAPeRzjUFlj6knFBAg==
X-Google-Smtp-Source: ABdhPJxlkrL3arc8uZHcYMDWYC9kW1TVNV4dHgQNxb3qJWruTgw5+pGtz1xUqextHkRgQ7a+5EYzYg==
X-Received: by 2002:aca:3946:: with SMTP id g67mr8462018oia.42.1614979243774;
        Fri, 05 Mar 2021 13:20:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g14sm783337oon.23.2021.03.05.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:20:43 -0800 (PST)
Received: (nullmailer pid 666678 invoked by uid 1000);
        Fri, 05 Mar 2021 21:20:42 -0000
Date:   Fri, 5 Mar 2021 15:20:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 32/34] dt-bindings: misc: hddl_dev: Add hddl device
 management documentation
Message-ID: <20210305212042.GA658055@robh.at.kernel.org>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-33-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222304.110194-33-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:23:02PM -0800, mgross@linux.intel.com wrote:
> From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> 
> Add hddl device management documentation
> 
> The HDDL client driver acts as an software RTC to sync with network time.
> It abstracts xlink protocol to communicate with remote IA host.
> This driver exports the details about sensors available in the platform
> to remote IA host as xlink packets.
> This driver also handles device connect/disconnect events and identifies
> board id and soc id using gpio's based on platform configuration.

Not sure any of this belongs in DT, but trivial comments below.

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: C Udhayakumar <udhayakumar.c@intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> ---
>  .../bindings/misc/intel,hddl-client.yaml      | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml b/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
> new file mode 100644
> index 000000000000..522b461663b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel,hddl-client.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel hddl client device to handle platform management in Bay series
> +
> +maintainers:
> +  - Udhayakumar C <udhayakumar.c@intel.com>
> +
> +description: |
> +  The HDDL client driver acts as an software RTC to sync with network time.
> +  It abstracts xlink protocol to communicate with remote host. This driver
> +  exports the details about sensors available in the platform to remote
> +  host as xlink packets.
> +  This driver also handles device connect/disconnect events and identifies
> +  board id and soc id using gpio's based on platform configuration.
> +
> +select: false

That's nice. If you never want to use this schema, why write it? One way 
to avoid the errors it has I guess.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: intel,hddl-client
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 4

Looks like only 1 in the example. If 4 entries, you need to say what 
each one is.

> +
> +  xlink_chan:

Vendor specific properties need vendor prefixes.

s/_/-/

> +    minItems: 1
> +    maxItems: 1
> +    description: xlink channel number used for communication
> +                 with remote host for time sync and sharing sensor
> +                 details available in platform.
> +
> +  i2c_xlink_chan:
> +    minItems: 1
> +    maxItems: 1
> +    description: xlink channel number used for communication
> +                 with remote host for xlink i2c smbus.
> +
> +  sensor_name:
> +    type: object
> +    description:
> +      Details about sensors and its configuration on local host and remote
> +      host.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: intel_tsens
> +
> +      reg:
> +        description: i2c slave address for sensor.
> +
> +      local-host:
> +        minItems: 1
> +        maxItems: 1
> +        description: enable bit 0 to register sensor as i2c slave
> +                     in local host (normal i2c client)
> +                     enable bit 1 to mimic sensor as i2c slave
> +                     in local host (onchip sensors as i2c slave)
> +                     enable bit 2 to register i2c slave as xlink smbus slave
> +                     in local host.
> +      remote-host:
> +        minItems: 1
> +        maxItems: 1
> +        description: enable bit 0 to register sensor as i2c slave
> +                     in remote host (normal i2c client)
> +                     enable bit 1 to mimic sensor as i2c slave
> +                     in remote host (onchip sensors as i2c slave)
> +                     enable bit 2 to register i2c slave as xlink smbus slave
> +                     in remote host.
> +
> +      bus:
> +        minItems: 1
> +        maxItems: 1
> +        description: i2c bus number for the i2c client device.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - local-host
> +      - remote-host
> +      - bus
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlink_chan
> +  - i2c_xlink_chan
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hddl_dev{
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        hddl@20320000 {
> +                compatible = "intel,hddl-client";
> +                status = "disabled";

Don't show status in examples.

> +                reg = <0x0 0x20320000 0x0 0x800>;
> +                xlink_chan = <1080>;
> +                i2c_xlink_chan = <1081>;
> +                kmb_xlink_tj {
> +                  status = "okay";
> +                  compatible = "intel_tsens";
> +                  local-host = <0x3>;
> +                  remote-host = <0x3>;
> +                  bus = <0x1>;
> +                };
> +        };
> +    };
> -- 
> 2.17.1
> 
