Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92DC41335B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhIUMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhIUMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:31:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B09C061574;
        Tue, 21 Sep 2021 05:30:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so9224230otx.3;
        Tue, 21 Sep 2021 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oYESg9U9RMvSLNwayzuL4e38Fp6KeUi0J2LalGvWZ4k=;
        b=pCclqY0K2IZDX7pr49+vMHvODMvdBbXoNWO8ndIkP8bw1WcAIzJ33IUu9NsazExddn
         3344t9cwq+5FUjTkiAEqeX2RE/Vv7EhIF+XeFE6pE7eXRzaHHjDAlifgL2Tzb540ynbw
         d20xk7IXdSgGbsfyRJWsEA5iWxr5a/iwPmyxlwtftzvcS2UnOHum9nHJL5H2Huxp3WIf
         OAHSKQCW3f1FMPsbwIrLKgTyB6w/arDwqKEtZsx28MOJOBHBaugnu3nKCPUdemuzNz4L
         JH9Aul+ih3Ca4cCNXHdh91SaphkOmpq6AlRyQe2lvV9S3a6zaytehzLEXQd+aFAs3fjf
         FmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oYESg9U9RMvSLNwayzuL4e38Fp6KeUi0J2LalGvWZ4k=;
        b=4k/oqAhWNlt7LEz/+5HZ5wcgxPL/NZ1vKhlMkqeOu30G1Cz4Xi7/zlIJuEfkby8Zfg
         03EnRhJB5SHxSDuPROAwjJyDW+tOYzdmr1P0oWJHWqNyLsqa8EQbVbqEFB3sV60UdGEk
         pYuRTpSQhsmyNt+whQ31WN4Kx1ZoEqJTRMUV31E4Y10gcWmvQLfiICgWx9lTIt9BjNHH
         bmIZBfWhWnXnqrQN8bxSCMZ/HwgNzSbMVkVk2/D5tsJ2FGHT/h8MVYOVxqL7bcKNU8js
         NxhQFOcS2mXLLkS9wUjafwEB43lpqXLkIAroVT2b+LbKX5FFxBOg2hUbZKl3pRy1nkgh
         dXmg==
X-Gm-Message-State: AOAM532Wl0FXY8YUmv9dc3vd5866jCFEcXUQq6DcwSawWMBrflXnW2vU
        X/36A9fKqGuLXy4WLzU/lKs=
X-Google-Smtp-Source: ABdhPJyUr1ZZjPsW5xB1nXxuo95XtHGWLo+lZv4AmduPM6mtW0E0fbo9OrOdRnRIdGMLLKBojIrc7Q==
X-Received: by 2002:a05:6830:10c7:: with SMTP id z7mr9112393oto.192.1632227427082;
        Tue, 21 Sep 2021 05:30:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e17sm733543oog.42.2021.09.21.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 05:30:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Sep 2021 05:30:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <20210921123025.GC1043608@roeck-us.net>
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

I won't accept any of those "move to trivial devices" patches. In many cases
the bindings are simply incomplete. I can not and will not make that call,
and I always did and will leave it up to driver authors to decide if they
want to add a device to trivial devices or provide explicit bindings.

Please stop sending those patches.

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
> -- 
> 2.30.2
> 
