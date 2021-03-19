Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D93427DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhCSVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCSVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:31:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E99C06175F;
        Fri, 19 Mar 2021 14:31:11 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso9880537otq.3;
        Fri, 19 Mar 2021 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3tP1yffxFh4g5lNGA0wRa/qEAQmOuEjgkMUh6SA5pU=;
        b=Vjd1Sso2HIhTeVWqkxFf0VIGFjw6NwHn4WhrCpcqmrJH+CP5E88UlnJX/SmLjt1eV9
         F6iG2on/mw2Bks4HNJhvy5TkXYb+neNhfEAEzCSlkZoAmzhcvoJlaxNAj70Udkl803px
         hQqdG/zuFO/LaGEYNA1WEMPDfwWV8WUFq0vaC/bnWZupRc4frZWuj/hwcdy7tppC5U8g
         rgT8UrtLGDLX6RVVwc6fauUXnKrUNo9n464ryUT2Vj/PK/f8++LWzI2MY2QaJnXpujFc
         8gO1HgK89AOw5+2B8GolPTO9AkQC0bfOB+90E89mihdxTOwcM9vHlAKSUluWt1cC7JNa
         4bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3tP1yffxFh4g5lNGA0wRa/qEAQmOuEjgkMUh6SA5pU=;
        b=B+tdChx6XejzIfw96Gq0n30f8DZA+PFNTI8uWn4LkT0i+bbEUNKCDi7kPBvXuGBJ2C
         GwGdMI3sI85amHN/xHXXpFulEERqaAwCZlAinjPjej8yONpFX8JWzGgewIdgPd5eE8LA
         sypOQc3+O9rkcTt/wMuse+Q/s4bu0b/drvtY30vqg/Ax54hO5gD5vOopDOlbm6mJUYLy
         NfBem3It+t2PPBQRIt5sisa1FPbwiiSUb5ymwMRA0A3tNl2YP0vD7oMgdvq1pVnsMArx
         M76/Y3/jm7NKmzGcZJUBm8k1PXVqaEFn3Zm8D88XtBtuClOXSBMDr3auMoonru35Vbzd
         6ddA==
X-Gm-Message-State: AOAM531rl/9fjd2Dba1Uj4FaEdvNCBJPIQYKwJBQFHvLq56kzJS7Jl5Z
        +FbCO1g8cIEW0EeOAfnhEpM=
X-Google-Smtp-Source: ABdhPJzgTe1u0b/7yaDVHD4QCOf/M/jN28/0o+Ynd67gM3j1RoFO13+OBO54DWUNwVwoVCRvH9B/ng==
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr2533310ota.29.1616189471444;
        Fri, 19 Mar 2021 14:31:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f22sm1431639otl.10.2021.03.19.14.31.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Mar 2021 14:31:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Mar 2021 14:31:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix and trivial device
 for BluTek BPA-RS600
Message-ID: <20210319213109.GA24334@roeck-us.net>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:02:29PM +1300, Chris Packham wrote:
> Add vendor prefix "blutek" for BluTek Power.
> Add trivial device entry for BPA-RS600.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

For my reference (waiting for bindings approval):

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - None
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index a327130d1faa..569236e9bed0 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -50,6 +50,8 @@ properties:
>            - atmel,atsha204a
>              # i2c h/w elliptic curve crypto module
>            - atmel,atecc508a
> +            # BPA-RS600: Power Supply
> +          - blutek,bpa-rs600
>              # Bosch Sensortec pressure, temperature, humididty and VOC sensor
>            - bosch,bme680
>              # CM32181: Ambient Light Sensor
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f6064d84a424..d9d7226f5dfe 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -169,6 +169,8 @@ patternProperties:
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
>      description: Bitmain Technologies
> +  "^blutek,.*":
> +    description: BluTek Power
>    "^boe,.*":
>      description: BOE Technology Group Co., Ltd.
>    "^bosch,.*":
