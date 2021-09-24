Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02AC41699F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbhIXBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:52:44 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4AC061574;
        Thu, 23 Sep 2021 18:51:12 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso2785952ooq.8;
        Thu, 23 Sep 2021 18:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPANwq5D3QjAAV224OPoOdEUgvvO6sHJqMsCL2qJyks=;
        b=WamoEAoO4OgK3eDXQ3Hz6BBsohhXxo5dNDVDBj1jSNv+m6/ji+lTnEJ39DmwzfAng8
         T6ByQcAYJq6qKonDIQYFcudsqH1cDG0iV86O7T7tGGIZUDDSYRVvjms4Jdb6X6TT2jjE
         SAuZawN0Jq4zRY8EVH4vnctJbViKVnFW/CfGrlnmFn8vRjdZUfkD+O/Pn/CACCdH5s3z
         faa0md2AkrdigPjYJLXC7FIQl6ffLepuGfvR8/YgBVn6ZS7WUksxmRqqEpSZs0x855IC
         0ZoQwtsaU8qCBh2u81nck6Lv3ztSClsiW8QIZ9rYoSSh0DoHQd0Xmimk0TLpasfReJo+
         VVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TPANwq5D3QjAAV224OPoOdEUgvvO6sHJqMsCL2qJyks=;
        b=TSUEND2oBFkO2hR7EBbSui+CKJfvyQPhPDUFVozmibIjhBtKf5Y0alxTCDvwzEgsN9
         Abc/dlp+s6t2+t93cAJJ/spDUUas1PYX+eCf21iINCzeGNQFTiI10LbELbOFT2NrGh02
         stzaL+FgT3DAhIpYFJRe4oOs0r+dsD5SzM7kE+StTSOxqhh0z9rUnZOdX37s5AK7Q6+I
         6sPV5MvzWGHRd3DB7aBaAONuRVNpx2Pv/XHn2GD/9N8B28BPay3vPR04FVwwilg9jNc3
         HpMUpqzixDaVfEoi5YJ5Z5X2QCrXo9/xmnE0Dx68VHZ2WBb5fuF1IebhftuAN/tZHkFV
         exCw==
X-Gm-Message-State: AOAM533Binqq0pMzo/mmbt0XDAEYxU7qf85KQWLE1bb6/f9zMnlqGNK+
        UsvCabA4iTlYqZcVkXvpGdw=
X-Google-Smtp-Source: ABdhPJyj+YByoddur8auY2/o3wA2BAh+cavN3tOG/ouFd4nDnDKSVZP99cPun8HU9jv7K0lyFbGGtA==
X-Received: by 2002:a05:6820:1050:: with SMTP id x16mr6509968oot.40.1632448271676;
        Thu, 23 Sep 2021 18:51:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9sm1745561oir.10.2021.09.23.18.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:51:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:51:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: hwmon: lm70: move to trivial devices
Message-ID: <20210924015109.GA3029984@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:09PM +0200, Krzysztof Kozlowski wrote:
> The lm70 thermometer bindings are trivial, so like many other I2C/SPI
> temperature sensors can be integrated into trivial devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, per Rob's comment that he prefers devices as .yaml
over .txt, and would rather have a transition from device.txt ->
trivial.yaml -> device.yaml than no transition at all.

Guenter

> ---
>  .../devicetree/bindings/hwmon/lm70.txt        | 22 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  8 +++++++
>  2 files changed, 8 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm70.txt b/Documentation/devicetree/bindings/hwmon/lm70.txt
> deleted file mode 100644
> index ea417a0d32af..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/lm70.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -* LM70/TMP121/LM71/LM74 thermometer.
> -
> -Required properties:
> -- compatible: one of
> -		"ti,lm70"
> -		"ti,tmp121"
> -		"ti,tmp122"
> -		"ti,lm71"
> -		"ti,lm74"
> -
> -See Documentation/devicetree/bindings/spi/spi-bus.txt for more required and
> -optional properties.
> -
> -Example:
> -
> -spi_master {
> -	temperature-sensor@0 {
> -		compatible = "ti,lm70";
> -		reg = <0>;
> -		spi-max-frequency = <1000000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 1eb4ce7dcdfd..183ee0da22c6 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -303,8 +303,13 @@ properties:
>            - ti,hdc1050
>              # Temperature and humidity sensor with i2c interface
>            - ti,hdc1080
> +            # Thermometer with SPI interface
> +          - ti,lm70
> +          - ti,lm71
>              # Temperature sensor with 2-wire interface
>            - ti,lm73
> +            # Thermometer with SPI interface
> +          - ti,lm74
>              # Temperature sensor with integrated fan control
>            - ti,lm96000
>              # I2C Touch-Screen Controller
> @@ -313,6 +318,9 @@ properties:
>            - ti,tmp102
>              # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>            - ti,tmp103
> +            # Thermometer with SPI interface
> +          - ti,tmp121
> +          - ti,tmp122
>              # Digital Temperature Sensor
>            - ti,tmp275
>              # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
