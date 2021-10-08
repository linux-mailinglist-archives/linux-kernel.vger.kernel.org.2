Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F871426B66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbhJHNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJHNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:04:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572FC061570;
        Fri,  8 Oct 2021 06:03:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v10so13604599oic.12;
        Fri, 08 Oct 2021 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RnDy90zGkmnNy7TioUKWbmT3Tf/BHpUr+QhKrUdfflA=;
        b=dq8GilYwFgJEM5sErjmvQ/srEaFhxezwXDhufioUjD8SZ5HCGQgNyVto8N+ivuzCzw
         Ah5sL34GPO9KqBMOPDPwDOXyaGDwyT5FpGfI3hTeSc9oZTMsin6OWz1Hc5iqLSKyO4fx
         n1EngoufJMtjUQbSzdE9OLSkTASeeRUvbMcKLPH6IFd6eQCiFQkqVZGXky0F1AOI2tWt
         6bhXJVztJEksY+RXBgjhdOxr67Bjmc/94C6vL1qF9auwWwmccb2lVWimwYW8V4zAv0qs
         OwnYB8SAx10X3FuJK3/qd0A3Cjpz65Y1eSjR3x1x8xlKYAc/GdPR9jUqLq6DMd/mZqL0
         yJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RnDy90zGkmnNy7TioUKWbmT3Tf/BHpUr+QhKrUdfflA=;
        b=tp5XvmtO9NGOtyZ8h2Kcrj2U/r4/mo4asslyGCwQmCJtxvSB0ra3pNCChd3dFMAaNb
         0rWUS1VgtpFAy+TihIPQfVPdcT4XEIG4kencFSckE0Yy09y4nUaxGK5FtKO5pkk9mFTi
         BblRBtWntKtVSBX6Sw3WDZqjRn13Wp4+/4hKYqtqdRh5kKAShyGWgz64Bzes9THkCZ5L
         SrPTYyRnim+p+cBieQA2Zhv8pFJX5PPWLOFxsO2OjaQZ/wrnE6KJdjXbLnyXqMmA3k5Z
         r5LUQi3DC5iv+L/KD8Y3jB/KZROlM0Uu28IEZ6uZXvZZc+GRgkUBHsSp4Nrf63dS0RuN
         Ddtg==
X-Gm-Message-State: AOAM532HqrlMfebnzvT6nlvexmfjvvjjvGWgzfwAmfntTb//0BDkwtrj
        om8V9gPnv3nJNDEnG96Qvsc=
X-Google-Smtp-Source: ABdhPJwk/DJFQJlB7Tte3OVChyyKTA7n4DzI7j0A2+ZiLIaTz8L/W6Mfk4C9V163xcRGsuQ0qfoZ6A==
X-Received: by 2002:a05:6808:cf:: with SMTP id t15mr7255602oic.93.1633698182633;
        Fri, 08 Oct 2021 06:03:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r25sm472982ooq.43.2021.10.08.06.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:03:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:03:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <20211008130300.GA3670503@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:29PM +0200, Krzysztof Kozlowski wrote:
> The IBM Common Form Factor Power Supply Versions 1 and 2 bindings are
> trivial, so they can be integrated into trivial devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Following Rob's suggestion:

"... I'd much rather have a schema for these than wait on 
someone to decide to convert them. That could mean a device.txt -> 
trivial-devices.yaml -> device.yaml trip, but that doesn't seem that 
terrible to me. Then we at least are running schema checks on the 
devices and know if actual users have more undocumented properties."

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ibm,cffps1.txt  | 26 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  6 +++++
>  MAINTAINERS                                   |  1 -
>  3 files changed, 6 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> deleted file mode 100644
> index d9a2719f9243..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Device-tree bindings for IBM Common Form Factor Power Supply Versions 1 and 2
> ------------------------------------------------------------------------------
> -
> -Required properties:
> - - compatible				: Must be one of the following:
> -						"ibm,cffps1"
> -						"ibm,cffps2"
> -						or "ibm,cffps" if the system
> -						must support any version of the
> -						power supply
> - - reg = < I2C bus address >;		: Address of the power supply on the
> -					  I2C bus.
> -
> -Example:
> -
> -    i2c-bus@100 {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -        #interrupt-cells = <1>;
> -        < more properties >
> -
> -        power-supply@68 {
> -            compatible = "ibm,cffps1";
> -            reg = <0x68>;
> -        };
> -    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6ad0628741cf..791079021f1b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -113,6 +113,12 @@ properties:
>            - mps,mp2975
>              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>            - honeywell,hi6130
> +            # IBM Common Form Factor Power Supply Versions (all versions)
> +          - ibm,cffps
> +            # IBM Common Form Factor Power Supply Versions 1
> +          - ibm,cffps1
> +            # IBM Common Form Factor Power Supply Versions 2
> +          - ibm,cffps2
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38064 Voltage Regulator
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15c4d3c809e8..cc5df54bdc51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14956,7 +14956,6 @@ S:	Maintained
>  W:	http://hwmon.wiki.kernel.org/
>  W:	http://www.roeck-us.net/linux/drivers/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> -F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
>  F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
>  F:	Documentation/devicetree/bindings/hwmon/max31785.txt
>  F:	Documentation/hwmon/adm1275.rst
