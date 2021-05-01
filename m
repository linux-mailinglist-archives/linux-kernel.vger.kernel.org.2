Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D88370549
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhEAESg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 00:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEAESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 00:18:34 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709ADC06174A;
        Fri, 30 Apr 2021 21:17:45 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h9-20020a4a94090000b02901f9d4f64172so91492ooi.5;
        Fri, 30 Apr 2021 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJDuvtfrc0RGLNATyN9LqOHLzLo5/nuR2eVlldf361U=;
        b=F/XTece4lPxvU7e+hDbA5ZTepqltaHWDke39ztuxl5EdWMWw6Cd3qpLsFAtpX1GgQr
         XRPyUJwrU8DNT6a6x/+uYOUfOLqPd75NCalZf3v8edobW8zC9AIL4D83cQtIv319zEHt
         7ho0SGmb0mURmmxEg1+68QwJdwa/7wMRO582lrA1Ktff4do3NC/AEgiDSW/Lkd2It0Tv
         lhQzoQrjPLP2ke1sJXclGN7vQUmB6z8wdpSr4KXWCNEJ9H7ymSYzdTn0Xkafw+OgpzLK
         Pva7G9aQCSvmLu5M5HggI/p+W/KPQ9ObBr/SQhPBVMHl/6jtENT7nIH08sJbPZfqW6T3
         7nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mJDuvtfrc0RGLNATyN9LqOHLzLo5/nuR2eVlldf361U=;
        b=AkujpaFUVMC/oze5K9rBIl1glod39AqTk6VYjSOJM26AkhY1VnPeyb3l0VaD+0fpkU
         FsSB6cD4go5UJDV5Rnd/+ZtjqzrZIEO1fcZGMHEcR2VfeY2r5ZFGTvAqEEyJ2d3BfPkw
         1gRvY+wrTLhAA97VU2EahCuvsLCv8yTH8KcDuQh1UF2b4NR0Sgg79PpDdqc2c1V4RdyX
         DJdjWCzFzRTvBNrKJ6BJfN1U1bPiGQglq761zHP9n3KD9gKW9NWmvo2jyNWBVd/KPXcG
         T+vleqGJkldJD0K+Ys3JkOQuEP3lqmDqKNU+qHpd54yGaH0/pHvlcMTud57E4rXXU/Yl
         bw4w==
X-Gm-Message-State: AOAM533Z3wQub0esYOxRzZrAZX+YbX6zLnzXYJdu3mE/qz1H+yZcWg4f
        wB0bfwV3DiIwsTEXvTgH9vXtf3uvOes=
X-Google-Smtp-Source: ABdhPJwR0dk3it5pmx6p0GD9EvVkBCXIdejSuukp1/zah2aiYz48ygtpTYbqRlov+oh6qcHBI2enJw==
X-Received: by 2002:a4a:96e3:: with SMTP id t32mr7193949ooi.14.1619842664826;
        Fri, 30 Apr 2021 21:17:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z133sm949940ooa.2.2021.04.30.21.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 21:17:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 21:17:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (pmbus/zl6100) Update documentation for
 zl6100 driver
Message-ID: <20210501041743.GA3202083@roeck-us.net>
References: <20210423153329.33457-1-erik.rosen@metormote.com>
 <20210423153329.33457-3-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423153329.33457-3-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 05:33:29PM +0200, Erik Rosen wrote:
> Update documentation for zl6100 driver and fix dead links to technical
> specifications
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/zl6100.rst | 132 ++++++++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/hwmon/zl6100.rst b/Documentation/hwmon/zl6100.rst
> index 968aff10ce0a..d42ed9d3ac69 100644
> --- a/Documentation/hwmon/zl6100.rst
> +++ b/Documentation/hwmon/zl6100.rst
> @@ -3,87 +3,103 @@ Kernel driver zl6100
>  
>  Supported chips:
>  
> -  * Intersil / Zilker Labs ZL2004
> +  * Renesas / Intersil / Zilker Labs ZL2004
>  
>      Prefix: 'zl2004'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6847.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2004-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL2005
> +  * Renesas / Intersil / Zilker Labs ZL2005
>  
>      Prefix: 'zl2005'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6848.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2005-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL2006
> +  * Renesas / Intersil / Zilker Labs ZL2006
>  
>      Prefix: 'zl2006'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6850.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2006-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL2008
> +  * Renesas / Intersil / Zilker Labs ZL2008
>  
>      Prefix: 'zl2008'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6859.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2008-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL2105
> +  * Renesas / Intersil / Zilker Labs ZL2105
>  
>      Prefix: 'zl2105'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6851.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2105-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL2106
> +  * Renesas / Intersil / Zilker Labs ZL2106
>  
>      Prefix: 'zl2106'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6852.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl2106-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL6100
> +  * Renesas / Intersil / Zilker Labs ZL6100
>  
>      Prefix: 'zl6100'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6876.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl6100-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL6105
> +  * Renesas / Intersil / Zilker Labs ZL6105
>  
>      Prefix: 'zl6105'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn6906.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl6105-datasheet.pdf
>  
> -  * Intersil / Zilker Labs ZL9101M
> +  * Renesas / Intersil / Zilker Labs ZL8802
> +
> +    Prefix: 'zl8802'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl8802-datasheet
> +
> +  * Renesas / Intersil / Zilker Labs ZL9101M
>  
>      Prefix: 'zl9101'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn7669.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl9101m-datasheet
>  
> -  * Intersil / Zilker Labs ZL9117M
> +  * Renesas / Intersil / Zilker Labs ZL9117M
>  
>      Prefix: 'zl9117'
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.intersil.com/data/fn/fn7914.pdf
> +    Datasheet: https://www.renesas.com/us/en/document/dst/zl9117m-datasheet
> +
> +  * Renesas / Intersil / Zilker Labs ZLS1003, ZLS4009
> +
> +    Prefix: 'zls1003', zls4009
> +
> +    Addresses scanned: -
> +
> +    Datasheet: Not published
>  
> -  * Ericsson BMR450, BMR451
> +  * Flex BMR450, BMR451
>  
>      Prefix: 'bmr450', 'bmr451'
>  
> @@ -91,17 +107,39 @@ Supported chips:
>  
>      Datasheet:
>  
> -http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146401
> +https://flexpowermodules.com/resources/fpm-techspec-bmr450-digital-pol-regulators-20a
>  
> -  * Ericsson BMR462, BMR463, BMR464
> +  * Flex BMR462, BMR463, BMR464
>  
>      Prefixes: 'bmr462', 'bmr463', 'bmr464'
>  
>      Addresses scanned: -
>  
> -    Datasheet:
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr462
> +
> +  * Flex BMR465, BMR467
> +
> +    Prefixes: 'bmr465', 'bmr467'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr465-digital-pol
> +
> +  * Flex BMR466
> +
> +    Prefixes: 'bmr466'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr466-8x12
>  
> -	http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146256
> +  * Flex BMR469
> +
> +    Prefixes: 'bmr469'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-bmr4696001
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
>  
> @@ -109,8 +147,8 @@ Author: Guenter Roeck <linux@roeck-us.net>
>  Description
>  -----------
>  
> -This driver supports hardware monitoring for Intersil / Zilker Labs ZL6100 and
> -compatible digital DC-DC controllers.
> +This driver supports hardware monitoring for Renesas / Intersil / Zilker Labs
> +ZL6100 and compatible digital DC-DC controllers.
>  
>  The driver is a client driver to the core PMBus driver. Please see
>  Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
> @@ -147,12 +185,12 @@ Module parameters
>  delay
>  -----
>  
> -Intersil/Zilker Labs DC-DC controllers require a minimum interval between I2C
> -bus accesses. According to Intersil, the minimum interval is 2 ms, though 1 ms
> -appears to be sufficient and has not caused any problems in testing. The problem
> -is known to affect all currently supported chips. For manual override, the
> -driver provides a writeable module parameter, 'delay', which can be used to set
> -the interval to a value between 0 and 65,535 microseconds.
> +Renesas/Intersil/Zilker Labs DC-DC controllers require a minimum interval
> +between I2C bus accesses. According to Intersil, the minimum interval is 2 ms,
> +though 1 ms appears to be sufficient and has not caused any problems in testing.
> +The problem is known to affect all currently supported chips. For manual override,
> +the driver provides a writeable module parameter, 'delay', which can be used
> +to set the interval to a value between 0 and 65,535 microseconds.
>  
>  
>  Sysfs entries
> @@ -182,24 +220,32 @@ in2_crit		Critical maximum VMON/VDRV voltage.
>  in2_lcrit_alarm		VMON/VDRV voltage critical low alarm.
>  in2_crit_alarm		VMON/VDRV voltage critical high alarm.
>  
> -			vmon attributes are supported on ZL2004, ZL9101M,
> -			and ZL9117M only.
> +			vmon attributes are supported on ZL2004, ZL8802,
> +			ZL9101M, ZL9117M and ZLS4009 only.
>  
> -inX_label		"vout1"
> +inX_label		"vout[12]"
>  inX_input		Measured output voltage.
>  inX_lcrit		Critical minimum output Voltage.
>  inX_crit		Critical maximum output voltage.
>  inX_lcrit_alarm		Critical output voltage critical low alarm.
>  inX_crit_alarm		Critical output voltage critical high alarm.
>  
> -			X is 3 for ZL2004, ZL9101M, and ZL9117M, 2 otherwise.
> +			X is 3 for ZL2004, ZL9101M, and ZL9117M,
> +			3, 4 for ZL8802 and 2 otherwise.
> +
> +curr1_label		"iin"
> +curr1_input		Measured input current.
> +
> +			iin attributes are supported on ZL8802 only
> +
> +currY_label		"iout[12]"
> +currY_input		Measured output current.
> +currY_lcrit		Critical minimum output current.
> +currY_crit		Critical maximum output current.
> +currY_lcrit_alarm	Output current critical low alarm.
> +currY_crit_alarm	Output current critical high alarm.
>  
> -curr1_label		"iout1"
> -curr1_input		Measured output current.
> -curr1_lcrit		Critical minimum output current.
> -curr1_crit		Critical maximum output current.
> -curr1_lcrit_alarm	Output current critical low alarm.
> -curr1_crit_alarm	Output current critical high alarm.
> +			Y is 2, 3 for ZL8802, 1 otherwise
>  
>  temp[12]_input		Measured temperature.
>  temp[12]_min		Minimum temperature.
