Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637D8428368
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 21:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhJJTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 15:34:17 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:42530 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhJJTeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 15:34:06 -0400
Received: by mail-oo1-f48.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so4667171oof.9;
        Sun, 10 Oct 2021 12:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oK4cASLRG9KDw6Buwhljv1jwTC0VF/5L0ZVtZoaadh4=;
        b=I2A0ETz2IjrEpmlITvUS5so/Ltb3Iq3HbWpeWDCvjj9ibapPJZLVZkhVghuDDnlEXw
         s+xRKd0h9n270PznxiZtvMU9x9LBWfUX0VPbeENWKPkbTQv1piRCK/l5ORLU1W90+qE4
         mWYj/mp3qXhhd7uzGOUPmsV0S07rx7bbR388h63eqShBkdAoiwzulfTZHdkTaI2od0T1
         RyxudA3IP1rET72uGSIP14RSTiBSlK6EVkaknvZIFnO4HCeRO+kuUFnIcW2pHUv1LZ42
         n9fGh0gKcA0OGjAs1uBBKdefzVbbwBoOM0802/DRcOM4T3k6n5jujIqbdaUdO8pTxGmV
         ulCw==
X-Gm-Message-State: AOAM531TUya+pEdxKGVymYFZNoCSjVEm87xMLvRxvp4tl9Tm6yo+Yfpt
        h7ug2E7uDqcM/sfUCycIRg==
X-Google-Smtp-Source: ABdhPJw/3P18DACANSvasaUJGLn0BgTelQ5sB9S5VvdRh2KhSyIwW4IzTCeFWzSXcM8rcl8Z5Nwj/Q==
X-Received: by 2002:a4a:e499:: with SMTP id s25mr16419515oov.46.1633894326677;
        Sun, 10 Oct 2021 12:32:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b19sm1298316otk.75.2021.10.10.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 12:32:06 -0700 (PDT)
Received: (nullmailer pid 3158664 invoked by uid 1000);
        Sun, 10 Oct 2021 19:31:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
In-Reply-To: <20211009104309.45117-1-david@ixit.cz>
References: <20211009104309.45117-1-david@ixit.cz>
Subject: Re: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt bindings to yaml
Date:   Sun, 10 Oct 2021 14:31:56 -0500
Message-Id: <1633894316.403809.3158663.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2021 12:43:09 +0200, David Heidelberg wrote:
> Convert fan devices connected to GPIOs to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1538743


fan: 'gpio-fan,speed-map' is a required property
	arch/arm/boot/dts/kirkwood-nas2big.dt.yaml
	arch/arm/boot/dts/kirkwood-net2big.dt.yaml

gpio-fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
	arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml

gpio_fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml

gpio-fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
	arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml

gpio_fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml

