Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9C31992F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBLEdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLEd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:33:29 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A86C061574;
        Thu, 11 Feb 2021 20:32:48 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id l5so1812164ooj.7;
        Thu, 11 Feb 2021 20:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xsOPczLGfI7n7RHjYinC5J14JbYSByA43sfelhBS05I=;
        b=ZlRNJk/jJEBQWTYESFevm5JccRvNWSUEZnY5eOFahj05E3RSxLCMm9muH4aOGubsTg
         QnyxIaxqj71fzpwiVLCkjS3fAkqHn6ywlDmXQDhj3Mz6X80mus6McECxADVal3tqC4aH
         9tIXMy3lAehqCurlJpy77R+1Tvpizgf4gkJvWWp6wyJ2Cjd5mn6RT8FITTQGIMvf0U+4
         2VO6IvtQtSyv0NezcQmDHrM78geazeDQFbTmpZ5IsjtoPgo1Y7y4h8X00+Uk6JJQ/DC7
         QvRhD7S3hajHKo1/pUl2giox4hExEw4+jcoHFwakUJJVOx3fwRGa6rTghsPkO5PGLmG3
         zuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xsOPczLGfI7n7RHjYinC5J14JbYSByA43sfelhBS05I=;
        b=qLpPfHxCcTW6/9+DGPzh+4DyEdi3xyFB4QAoYxS4GQG0+M9rjC+dJKtCsyiGJWBb39
         9K8b1D0Z+GiZrUZAcSFEggjnLAlRWmrmBJm/+5mAcNJ+16xrMzABR0FE+95xlzWaz/0E
         KRgwpFWKHGfNR4rUB3ba65mlyKM6gmOrUAOF4takdWTZHCgaT9kInWZUSyi2b19tfzXr
         ccAJ6MMUWq/cyexP0EFC8wsVrFJHLx0m3ZTANnRaur2od1WzyJxYoZOF4jwgq0gSDhFQ
         Xp/7LLpu2y20JQ4utO4HM9RK6CEea2aAvTuWmDjBIERtHSy9ciOeTVwzFYda9AfmQ1aj
         rDyA==
X-Gm-Message-State: AOAM530/3Qej921apZ1iDNhPDz7tmhCQBEgXclOnuLKnIPBX4jDTDEPd
        qfNoDmPOXynCn6VcBp/N7AY=
X-Google-Smtp-Source: ABdhPJwVS1wmzEazLpd7tf4P2eENTXemBoxf3OO+tRygwVj59uvRBGy2AVfb7PXxCAsmXMaCj3/RFA==
X-Received: by 2002:a4a:c44d:: with SMTP id h13mr768850ooq.65.1613104368047;
        Thu, 11 Feb 2021 20:32:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20sm1342727oos.46.2021.02.11.20.32.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:32:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:32:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Message-ID: <20210212043246.GA105010@roeck-us.net>
References: <20210121134434.2782405-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121134434.2782405-1-robert.marko@sartura.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:44:32PM +0100, Robert Marko wrote:
> Document bindings for the Texas Instruments TPS23861 driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> Changes in v5:
> * Drop uint32 reference
> 
> Changes in v4:
> * Correct shunt binding
> 
>  .../bindings/hwmon/ti,tps23861.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> new file mode 100644
> index 000000000000..3bc8e73dfbf0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS23861 PoE PSE
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  The TPS23861 is a IEEE 802.3at Quad Port Power-over-Ethernet PSE Controller.
> +
> +  Datasheets:
> +  https://www.ti.com/lit/gpn/tps23861
> +
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps23861
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: The value of curent sense resistor in microohms.
> +    default: 255000
> +    minimum: 250000
> +    maximum: 255000
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
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          tps23861@30 {
> +              compatible = "ti,tps23861";
> +              reg = <0x30>;
> +              shunt-resistor-micro-ohms = <255000>;
> +          };
> +    };
