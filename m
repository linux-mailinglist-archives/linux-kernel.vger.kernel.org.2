Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17F4169D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhIXCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbhIXCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:07:52 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E047C061574;
        Thu, 23 Sep 2021 19:06:20 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso2782536oov.13;
        Thu, 23 Sep 2021 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+4U7rgc8Q2pLe8wXaWcnPnHaZdMN+AhJiyiLw+ldfgE=;
        b=NMihe6KZIK/Q1GGMi/iDF39ltN/I3mJWR3MUY9l4cAkGc9B084TFnL68teKWVDAkn2
         BWj1iH0ZswkyMs9m4Gx3ciHPICWmdSTDmDQt2Szxqup7DdByEcPBPwy+PNVNZLq0ej0d
         v10XpKNbun71E2peiVK+dP8Y5n004lo/wJ32g7RmbNtfmeHxO3U9KleHCZNThJSatBXJ
         T8mXWJb38nUyJCtWwE4jCNHonYIru2by6Tllucc2LAxrOwyy/ui2i5fAhWxVIBRylz3o
         XJIOxbYYl5Xq/lPQycSoSDiZ/wGVoT1szXEUTuOCwt+me4Il+awJcMo6VV4d65lrbX6P
         DrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+4U7rgc8Q2pLe8wXaWcnPnHaZdMN+AhJiyiLw+ldfgE=;
        b=Tvi+heXCyDydXVFmBIrbnjy22f3caTpCSl+y5/e3uD9zy9XM82kTHY5b/q3Yqerq+1
         oZlONTC2xd4bZ3CVHU+qZLhVxvBYUopJI5urfEzqOtKNnjAbTYweBsAsmL4uSTTjfEL2
         rpBnT/upJruXCFYGbqkm22p/72ab1pvfOrd/v9YU3WUkOOGl8kN4DTUZOuR2i70T3/lI
         5BeyZ5srZJeG+zcvxZyf2TJRKGslIksZTtMLr+qr2r/m/KzB/j6gDAqoGLMLM1kFr7Yh
         eItBWpDQkAqnPdWacR8/gvyQQbIQNKYougasdMfq1KSNvTpZZh0M/QtwY5aWdBPOTOFZ
         LQOA==
X-Gm-Message-State: AOAM530RmLVKlzeezQKNmlIRRagPjHvLrEox7BdLEOKIJ4jUlwNvfCKq
        3JrEZ5rnoW74c7IQi+lLUa0=
X-Google-Smtp-Source: ABdhPJyBCuHOk7RAcPb3vFi5CadONXuuZTonU5IEPU1Dkjkc5Opvmy54Hd3k2hE3mG9Jzzb3jsRlhA==
X-Received: by 2002:a4a:9510:: with SMTP id m16mr6535516ooi.14.1632449179684;
        Thu, 23 Sep 2021 19:06:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i23sm1531441oof.4.2021.09.23.19.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:06:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:06:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: dps650ab: move to trivial devices
Message-ID: <20210924020617.GA3031985@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:11PM +0200, Krzysztof Kozlowski wrote:
> The dps650ab bindings are trivial, so it can be integrated into trivial
> devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, per Rob's comments and because it is somewhat unlikely that this
device will need special properties.

Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/dps650ab.txt  | 11 -----------
>  .../devicetree/bindings/trivial-devices.yaml          |  2 ++
>  2 files changed, 2 insertions(+), 11 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/dps650ab.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> deleted file mode 100644
> index 76780e795899..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -Bindings for Delta Electronics DPS-650-AB power supply
> -
> -Required properties:
> -- compatible : "delta,dps650ab"
> -- reg        : I2C address, one of 0x58, 0x59.
> -
> -Example:
> -	dps650ab@58 {
> -		    compatible = "delta,dps650ab";
> -		    reg = <0x58>;
> -	};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 1bbfa98a85d8..b1bad299ec66 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -73,6 +73,8 @@ properties:
>            - dallas,ds4510
>              # Digital Thermometer and Thermostat
>            - dallas,ds75
> +            # Delta Electronics DPS-650-AB power supply
> +          - delta,dps650ab
>            # Delta Electronics DPS920AB 920W 54V Power Supply
>            - delta,dps920ab
>              # 1/4 Brick DC/DC Regulated Power Module
