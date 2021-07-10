Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB23C357F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhGJQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhGJQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 12:20:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94575C0613DD;
        Sat, 10 Jul 2021 09:17:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so9012533ott.1;
        Sat, 10 Jul 2021 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wxs+/K3FGTfKiz55eZA+g3TwYilHUhNyCFpHBBA5jYo=;
        b=i7Awlq0bMUhm8TlgcGv/iaIAjc4iLdCzHt8N5Q7oMRWEGlzOvhKhxtl77iyFw4Npen
         ABLI2x7wEm6NR4l0KBWnPUeFYBwfkS8RaYv6eBjuQO8U0KsoHTWIUlRPb8yEHrizuAW0
         rlxBc1072aGtPLsc8/jGa3oNXthjylURQVses0W8TK0mxzXGQEQMPYM/1s//2yyIl53n
         XRL+I8zIDmlU5heaFQ13pgdkJmZV7lJJ8d0xe7KsSVpMnG0z/HVQZkIphWBRPRX3syMa
         7WMHzVVtyYjyVhL1JWKZQc4Tx7EOG/yi3rsiITTRZ8VjJgoYuzp8bt3LKXED1lWpNpyA
         R+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wxs+/K3FGTfKiz55eZA+g3TwYilHUhNyCFpHBBA5jYo=;
        b=I2ph3h2Q01doypHUEpOOImUTjx/4THBqZusF0CiSY6GfBirM/sQK5E0027d0AGMZ6N
         Oj9ZW55Z+67DrHRBKS0pJkdSBYC20DP63/ITGtfKz9bC3VdbVklaGhXQlfAHAg1Wvk1A
         ZR+hSF5mu/soOvsveft4s3V6hlx2DaMSv7NkUt/YpIz4e023i9jiAP/XnUvzRpamSiU7
         mW5Q7Nxu5E4SUbsIO7ImGfXcAfDci8lx+cssFUHvu1Xdje708YQHjl681hCkkNIBkYuS
         y52oInFvdg3c5DvFsTPGyem4W/MBHCImyMyqFhNlZWeu9y/RKgWhTip8tQyDu54jqrYo
         a+FA==
X-Gm-Message-State: AOAM532IQ7ggshVOBQ/LehvruPSC2iMJFrc1nwulNINgxL18FRn/Sk+h
        j4Hr5/xTzsL5yxrW1jlFmqI=
X-Google-Smtp-Source: ABdhPJy6AlgprEnNgQ0LBhrwagJSzUSO3IbhcOu9CW5S6g413ok/0FtSawoQC1QkkBGQ2GHkIP6r5w==
X-Received: by 2002:a9d:7f91:: with SMTP id t17mr32689778otp.22.1625933862979;
        Sat, 10 Jul 2021 09:17:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23sm1860358ote.4.2021.07.10.09.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 09:17:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
 <31e410523358f7069c36eb981ab96613346ffe37.1625662290.git.plr.vincent@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/3] Documentation: hwmon: New information for DA9063
Message-ID: <f0c0fef4-9e5a-df23-bfbb-db490bc591c0@roeck-us.net>
Date:   Sat, 10 Jul 2021 09:17:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <31e410523358f7069c36eb981ab96613346ffe37.1625662290.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 6:25 AM, Vincent Pelletier wrote:
> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Addition of HWMON documentation for the DA9063 driver.
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Updated temperature formula, as of datasheet rev 2.3.
> Converted to ReStructuredText.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> Changes in v3:
> - Reference added to index.rst
> 
> Changes in v2:
> - ReST-ified
> 
> Originally submitted by Steve Twiss in 2014:
>    https://marc.info/?l=linux-kernel&m=139560868209856&w=2
> 
>   Documentation/hwmon/da9063.rst | 73 ++++++++++++++++++++++++++++++++++
>   Documentation/hwmon/index.rst  |  1 +
>   2 files changed, 74 insertions(+)
>   create mode 100644 Documentation/hwmon/da9063.rst
> 
> diff --git a/Documentation/hwmon/da9063.rst b/Documentation/hwmon/da9063.rst
> new file mode 100644
> index 000000000000..aae69c58a5d6
> --- /dev/null
> +++ b/Documentation/hwmon/da9063.rst
> @@ -0,0 +1,73 @@
> +Kernel driver da9063-hwmon
> +==========================
> +
> +Supported chips:
> +
> +  * Dialog Semiconductor DA9063 PMIC
> +
> +    Prefix: 'da9063'
> +
> +    Datasheet: Publicly available at the Dialog Semiconductor website:
> +
> +	http://www.dialog-semiconductor.com/products/power-management/DA9063
> +
> +Authors:
> +	- S Twiss <stwiss.opensource@diasemi.com>
> +	- Vincent Pelletier <plr.vincent@gmail.com>
> +
> +Description
> +-----------
> +
> +The DA9063 PMIC provides a general purpose ADC with 10 bits of resolution.
> +It uses track and hold circuitry with an analogue input multiplexer which
> +allows the conversion of up to 9 different inputs:
> +
> +- Channel  0: VSYS_RES	measurement of the system VDD (2.5 - 5.5V)
> +- Channel  1: ADCIN1_RES	high impedance input (0 - 2.5V)
> +- Channel  2: ADCIN2_RES	high impedance input (0 - 2.5V)
> +- Channel  3: ADCIN3_RES	high impedance input (0 - 2.5V)
> +- Channel  4: Tjunc	measurement of internal temperature sensor
> +- Channel  5: VBBAT	measurement of the backup battery voltage (0 - 5.0V)
> +- Channel  6: N/A	Reserved
> +- Channel  7: N/A	Reserved
> +- Channel  8: MON1_RES	group 1 internal regulators voltage (0 - 5.0V)
> +- Channel  9: MON2_RES	group 2 internal regulators voltage (0 - 5.0V)
> +- Channel 10: MON3_RES	group 3 internal regulators voltage (0 - 5.0V)
> +
> +The MUX selects from and isolates the 9 inputs and presents the channel to
> +be measured to the ADC input. When selected, an input amplifier on the VSYS
> +channel subtracts the VDDCORE reference voltage and scales the signal to the
> +correct value for the ADC.
> +
> +The analog ADC includes current sources at ADC_IN1, ADC_IN2 and ADC_IN3 to
> +support resistive measurements.
> +
> +Channels 1, 2 and 3 current source capability can be set through the ADC
> +thresholds ADC_CFG register and values for ADCIN1_CUR, ADCIN2_CUR and
> +ADCIN3_CUR. Settings for ADCIN1_CUR and ADCIN2_CUR are 1.0, 2.0, 10 and
> +40 micro Amps. The setting for ADCIN3_CUR is 10 micro Amps.
> +
> +Voltage Monitoring
> +------------------
> +
> +The manual measurement allows monitoring of the system voltage VSYS, the
> +auxiliary channels ADCIN1, ADCIN2 and ADCIN3, and a VBBAT measurement of
> +the backup battery voltage (0 - 5.0V). The manual measurements store 10
> +bits of ADC resolution.
> +
> +The manual ADC measurements attributes described above are supported by
> +the driver.
> +

Not really. The driver only reports VSYS and VBBAT plus the temperature,
so this documentation is very misleading. Please provide a list of supported
attributes and their association to the ADC channels.

> +The automatic ADC measurement is not supported by the driver.
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are sampled by a 10 bit ADC.  Junction temperatures
> +are monitored by the ADC channels.
> +
> +The junction temperature is calculated:
> +
> +	Degrees celsius = -0.398 * (ADC_RES - T_OFFSET) + 330;
> +
> +The junction temperature attribute is supported by the driver.
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 9ed60fa84cbe..b3aba6525157 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -51,6 +51,7 @@ Hardware Monitoring Kernel Drivers
>      corsair-psu
>      da9052
>      da9055
> +   da9063
>      dell-smm-hwmon
>      dme1737
>      drivetemp
> 

