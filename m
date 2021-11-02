Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE15442E80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKBMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:54:23 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:47036 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:54:21 -0400
Received: by mail-oo1-f51.google.com with SMTP id f80-20020a4a5853000000b002bcede04f10so14158oob.13;
        Tue, 02 Nov 2021 05:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcQE/94Iq+GuqYxHvokJdZhomDKbyTbhHa9FD+IRDlQ=;
        b=VH36ed27rX9v3BbA+sVyiJXzNOqQpofpDdNAg5Uxaf3/af7ZzIFddAHX1C3s9wTWk6
         OimaZ75y7ROOZV4l2SfKaWcDfZgzXg4Hn9ZL2LMwAVcqZfmmiRDVcmQ7eymLjL/bbW4o
         o/ToYea1JqnTT6lTcG7WublwS1vXo+Llx0GPjQLOPQVj3GQ8UQ0kLpEUQBK9fU3LNlXL
         5UqcX5nqORbEaAeSddbsRPZmsnNNxwOoP7gnk9uDqFR9PLUzIjQ48h2Z1y9QZzeOn+3e
         aPjR8l0LPnV636dR7UfPcdy2aOJ4WHKrzPbmde/flsHH2IneE3g6SgSoVXCMwREAZAxL
         LfsQ==
X-Gm-Message-State: AOAM53155PF+Do/Ld/3dQ4iC7V66NJoebEln82W2a9gVN4iGgbN2Wprk
        zbr6Uao9cjE2gSz6RHUH0g==
X-Google-Smtp-Source: ABdhPJxIksWXYyhp4C7yKs1jgB3KCfEsuUHCfWrdOv82RADHeNtOnkzEI/vk8bYOorgOYSmZ1GuHmA==
X-Received: by 2002:a4a:ce83:: with SMTP id f3mr17491717oos.45.1635857506753;
        Tue, 02 Nov 2021 05:51:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 187sm4867893oig.19.2021.11.02.05.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:51:46 -0700 (PDT)
Received: (nullmailer pid 2660361 invoked by uid 1000);
        Tue, 02 Nov 2021 12:51:45 -0000
Date:   Tue, 2 Nov 2021 07:51:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH 4/5] Documentation: bindings/mfd: sensehat: Raspberry Pi
 Sense HAT device tree binding
Message-ID: <YYE0YTXdXd4ude5p@robh.at.kernel.org>
References: <20211029215516.801593-1-cmirabil@redhat.com>
 <20211029215516.801593-5-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029215516.801593-5-cmirabil@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:55:15PM -0400, Charles Mirabile wrote:
> This patch adds the device tree binding
> for the Sense HAT in yaml form.

For the subject, follow the format of the subsystem (run git log 
--oneline) and no need to say 'binding' multiple times:

dt-bindings: mfd: Add Raspberry Pi Sense HAT schema

> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  .../bindings/mfd/raspberrypi,sensehat.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> new file mode 100644
> index 000000000000..e00cd02a3752
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Mwesigwa Guma <mguma@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description: |

'|' is not needed if there is no formatting to preserve.

> +  The Raspberry Pi Sensehat is an addon board originally developed
> +  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
> +  as well as several environmental sensors. It connects via i2c and
> +  a gpio for irq.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:

Don't need oneOf when there is only one entry.

> +        - raspberrypi,sensehat
> +        - rpi,rpisense

'rpi' is not a vendor prefix.

What's the fallback for anyways?

> +
> +  reg:
> +    items:
> +      - description: i2c bus address
> +
> +  keys-int-gpios:
> +    items:
> +      - description: gpio pin for joystick interrupt

For an interrupt, use 'interrupts'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - keys-int-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      sensehat@46 {
> +        compatible = "raspberrypi,sensehat";
> +        reg = <0x46>;
> +        keys-int-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> -- 
> 2.31.1
> 
> 
