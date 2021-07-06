Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA33BC459
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGFAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGFAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:24:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016ECC061574;
        Mon,  5 Jul 2021 17:21:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q23so22540397oiw.11;
        Mon, 05 Jul 2021 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XvPBT7KkiObkd6e6JMdzD5CDOKspZ9xiVqMwNuz6gnk=;
        b=rRT/6n5C/OQl94SdQsHivWVwBAt63ThH8pbPk35ku3gHfuW3iqstK2RvRjeNOcLT5f
         kK2RBhYy8s7D4etDzJj5w46WLlJCEEIEhcqxgxHQiYvrKc2ROsvKDcci1o7DQQpR7vnE
         WfrrRQ6mR1SmYkrM4g4Q5DuPpabNBX46jiIr1jlwE1KUECys3wAj+oaImxxHF7lmNurH
         wRx7500eoXeN22+Q/pOcoMlmd8rd+JrBWzso6ARcgj9SA1XmY2jyR64RYuj5pap0lvyr
         lZQ9/h8P4oRH/XrCwKBQtHTQKp1ZOPH/Ge7CTM751MPna+rnRjsfOqan04cAeRaIScEd
         INrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvPBT7KkiObkd6e6JMdzD5CDOKspZ9xiVqMwNuz6gnk=;
        b=TCkBhVQQqp5svV3OjM6Eop5fUTY75gyFNV7V38cK5UQyDmxeLgNwQoIrnk33c3ytlX
         NcLVWN6SvsX3h8pOo2yd+F17Dx8CJbU16zH3q95ktCVCrB/B/7s1N6JqKcQ7ZbgLh15U
         NYrtW+9sr/KtDcGgZsA54kHYLAWgIGL/TDmDLZUgHDLhhD8ughY947EOSXhTf0GiBAXr
         N1Jd6OgSwY7GvJzCEeHspvmwMAm9FhkpFHZKGXaz2PPHNjoJN3S17k2Sai6WujP2d6db
         FvQyu3V7RbYZx2NIMvdft18ASq1+z32lFRg8XrJpcYOPzJ7N8VYzpgnBSxSdfzklh71v
         F2fQ==
X-Gm-Message-State: AOAM531EeNFFQGdaIJ+91bBdzYAA20pLIjvkI2muYntU34avE8yZnmce
        N1kCyPP4gXTDz/m+3eZoW+o=
X-Google-Smtp-Source: ABdhPJxCvuFvl+qJLzZ4zewBgnLEeg2Um84keh7jC7Emu/bnVkdUynWVEHjBzwVTKUvY0JO+4FBXSw==
X-Received: by 2002:aca:b2d5:: with SMTP id b204mr64224oif.113.1625530917359;
        Mon, 05 Jul 2021 17:21:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d18sm2190155otc.40.2021.07.05.17.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 17:21:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] Documentation: hwmon: New information for DA9063
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
 <aef8227a9ac7246791bf3f086008e2d381ddd463.1625529219.git.plr.vincent@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <380d242c-3ec7-05ee-0365-360f07f75f29@roeck-us.net>
Date:   Mon, 5 Jul 2021 17:21:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aef8227a9ac7246791bf3f086008e2d381ddd463.1625529219.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 5:01 PM, Vincent Pelletier wrote:
> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Addition of HWMON documentation for the DA9063 driver.
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Updated temperature formula, as of datasheet rev 2.3.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> Originally submitted by Steve Twiss in 2014:
>    https://marc.info/?l=linux-kernel&m=139560868209856&w=2
> 
>   Documentation/hwmon/da9063 | 67 ++++++++++++++++++++++++++++++++++++++

Documentation is now in .rst format.

>   1 file changed, 67 insertions(+)
>   create mode 100644 Documentation/hwmon/da9063
> 
> diff --git a/Documentation/hwmon/da9063 b/Documentation/hwmon/da9063
> new file mode 100644
> index 000000000000..879f1d0fb3e4
> --- /dev/null
> +++ b/Documentation/hwmon/da9063
> @@ -0,0 +1,67 @@
> +
> +Kernel driver da9063-hwmon
> +==========================
> +
> +Supported chips:
> + * Dialog Semiconductor DA9063 PMIC
> +    Prefix: 'da9063'
> +    Datasheet:
> +	http://www.dialog-semiconductor.com/products/power-management/DA9063
> +
> +Authors: S Twiss <stwiss.opensource@diasemi.com>
> +
> +Description
> +-----------
> +
> +The DA9063 PMIC provides a general purpose ADC with 10 bits of resolution.
> +It uses track and hold circuitry with an analogue input multiplexer which
> +allows the conversion of up to 9 different inputs.
> +
> + Channel  0: VSYS_RES	measurement of the system VDD (2.5 - 5.5V)
> + Channel  1: ADCIN1_RES	high impedance input (0 - 2.5V)
> + Channel  2: ADCIN2_RES	high impedance input (0 - 2.5V)
> + Channel  3: ADCIN3_RES	high impedance input (0 - 2.5V)
> + Channel  4: Tjunc	measurement of internal temperature sensor
> + Channel  5: VBBAT	measurement of the backup battery voltage (0 - 5.0V)
> + Channel  6: N/A	Reserved
> + Channel  7: N/A	Reserved
> + Channel  8: MON1_RES	group 1 internal regulators voltage (0 - 5.0V)
> + Channel  9: MON2_RES	group 2 internal regulators voltage (0 - 5.0V)
> + Channel 10: MON3_RES	group 3 internal regulators voltage (0 - 5.0V)
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
> +The automatic ADC measurement is not supported by the driver.
> +
> +Temperature Monitoring
> +----------------------
> +
> +Channel 4 (Tjunc) will be used to measure the output of the internal
> +temperature sensor. The ADC measurement result and the T_OFFSET value can
> +be used by the host to calculate the internal junction temperature
> +
> +	Tjunc = -0.398 * (ADC - T_OFFSET) + 330;
> +
> +The junction temperature attribute is supported by the driver.
> 

