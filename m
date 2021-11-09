Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E163E44B406
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbhKIUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKIUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:35:05 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95BC061764;
        Tue,  9 Nov 2021 12:32:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id m6so960923oim.2;
        Tue, 09 Nov 2021 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=51wtgkIuQxPGEgby/XEIn59LztIHPWFiQyA5sYNuT0A=;
        b=QfIxpjbmpnXM6n7kMOJP0SicLxwqS5wthZZ/ISnZoxMxezXZa+bk8MpK/+Z+dHDYoq
         Ks0CRG/oTScuh9LdfMdbnFqwtKQasPAA/L5Cneunkm67u8alDN01qs9VbQ0X/Nn1sLRL
         1v+IZPRi0Nu3ZmWNaJ3h7tFKHbtYTREWFIWOefpH5cRelyAeS5GHVexQGgXKP/oQl9BK
         0F+q8PmKtT2GTrQY3KGbV2OlwDZ9C+U6DTs9C1KOdybiMrVnoShSh9gJaabm/iCYjraS
         nqFlmgHhR8mk/+VPy4p/pKrCvZ04vZjtn4oapdQtP/Zq2pG0Nfy7FvxAr7ZC/3C0tuoM
         B2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=51wtgkIuQxPGEgby/XEIn59LztIHPWFiQyA5sYNuT0A=;
        b=gD/UaYIPoCoJqfyUYEDv7ObO1NiUKlN6GulR8pl12istjAh4U9PeipkUTE98xsuD9W
         3Svqk91zum1SSznFNi/EmoGzRndFH1szd8XWx36f5M3Uu+mOFMGXooTiPFBujzG5hP81
         WI4tUdI2gamy1et5FdosVmsTGRohTwZ/+quFrjxcw9603XjWK+Ytnsfm3gi1hBtndAhc
         QuXKYoGB4bfFa0ibzk+J7TttOlichjsjQVlCpZVuZG7HFoOgHfr7/MhCayDB9IGkJm55
         SYL9BGT9DnV0uxvy8iNJa1sRomx84jsFw/2ChX7qsxiC4UZ1ekpMJ9+kfY7iPKjcN0LQ
         bzFQ==
X-Gm-Message-State: AOAM5316sNgGaTa60Ry8D7yTVUnjuyfrn4yZW+WKKPfPoaYwy19WpIPY
        qvYM4vKcoLHmV8wWSqNkKV4=
X-Google-Smtp-Source: ABdhPJwKAfV0+TLZmOT52lT5nCa9ZAa1omp30qLKt6g55D2X13ROzMrti90yVMCkViHkpqnqtFj3ig==
X-Received: by 2002:a05:6808:1305:: with SMTP id y5mr5007636oiv.83.1636489938376;
        Tue, 09 Nov 2021 12:32:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16sm2173454oop.8.2021.11.09.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:32:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Nov 2021 12:32:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain
 property
Message-ID: <20211109203216.GA3693367@roeck-us.net>
References: <20211102052754.817220-0-nathan@nathanrossi.com>
 <20211102052754.817220-2-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052754.817220-2-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 05:27:54AM +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Add a property to the binding to define the selected shunt voltage gain.
> This specifies the range and accuracy that applies to the shunt circuit.
> This property only applies to devices that have a selectable shunt
> voltage range via PGA or ADCRANGE register configuration.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v2:
> - Added binding for shunt-gain
> 
> Changes in v3:
> - Fix schema error, setting $ref to uint32
> - Improve the description to detail exactly how to define the property
>   and how the property affects initial device configuration and
>   calculation of values
> ---
>  .../devicetree/bindings/hwmon/ti,ina2xx.yaml        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> ---
> 2.33.0
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index 180573f26c..47af97bb4c 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -36,6 +36,27 @@ properties:
>        Shunt resistor value in micro-Ohm.
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  ti,shunt-gain:
> +    description: |
> +      Programmable gain divisor for the shunt voltage accuracy and range. This
> +      property only applies to devices that have configurable PGA/ADCRANGE. The
> +      gain value is used configure the gain and to convert the shunt voltage,
> +      current and power register values when reading measurements from the
> +      device.
> +
> +      For devices that have a configurable PGA (e.g. INA209, INA219, INA220),
> +      the gain value maps directly with the PG bits of the config register.
> +
> +      For devices that have ADCRANGE configuration (e.g. INA238) a shunt-gain
> +      value of 1 maps to ADCRANGE=1 where no gain divisor is applied to the
> +      shunt voltage, and a value of 4 maps to ADCRANGE=0 such that a wider
> +      voltage range is used.
> +
> +      The default value is device dependent, and is defined by the reset value
> +      of PGA/ADCRANGE in the respective configuration registers.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +
>  required:
>    - compatible
>    - reg
