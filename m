Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB5407B73
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 06:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhILEEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhILEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 00:04:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D8C061574;
        Sat, 11 Sep 2021 21:03:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso8335700ots.5;
        Sat, 11 Sep 2021 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdB/e3psdiALZR/YkF+nz15PIU8JJhD2qY+r04G1VXI=;
        b=MG4DHYBd2ry5PoivqUkyoLfzyvQGvSaAHmyrgHJdA2IZev54QRn2OrTZ+qgDY/Y++T
         qkQdRcbuV+TWg/t41ju785C9vQc77skdTeuamNreGTSUgA37kSjtXGlAgU/uAr01m09N
         Ir+qI286cPzlXR4v8DcT4rc3duUCi2g+4ifopZgBnluavcX1nB6V4xF8MHtFOxp63tsf
         kp3c6uMd66asBCsS9sfCW9AWbAxbVdYNqdu3LgvMm+kvZLagB67xd10GUO/7ECFOAaOh
         tu58YaUGpxtD1bifqx3m9MRnMU8CGzDiCkVBPBFiG59lyCrEtGhoEmRjwHAthhaCJV5b
         64BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdB/e3psdiALZR/YkF+nz15PIU8JJhD2qY+r04G1VXI=;
        b=I/RjxPUf5jRLx+URfBY92jwpoojyUVmtSoOu9AEYwYSqkwKlQ6mkEaLfAhle4V3CZr
         K/B7esfbN6LI2/qWWeSkRPNFC3w1KQ+Fu7GlWpO74uSDFLuWKR4tm4VB54E3Jc7SscsJ
         HUqBVZYx0SohFEfCuZE/DX/d7+tP1bO730NgPtim8ydjZ//sgIqGoahmUlz4oTMIEnmk
         wjj4rgYsg6BXuiMmoW3jQ+lU8Slq5I0k6gn9LffCls/4ptMcgA4HszbOj5Y4/cqXq503
         73Ev7immQAl6eKz1XFh9H8OTrdGfVqoajG4X73+3Gh+xso58RdBMhhWYQqENStXhMP71
         gY1A==
X-Gm-Message-State: AOAM533zYP8cPYg2MDjcUzBHbGD7F66bR47smojwbN+skbaeAI/qxegM
        K7kjsEsjyvAph1QhIuWWVO+NtDXvi30=
X-Google-Smtp-Source: ABdhPJzFow8lyV6CdkYEhDj3FWDlELW0zwdE6emeMxG8WDX/5aajSagJBQRCOy9ErHBKDu1J9vwkCA==
X-Received: by 2002:a05:6830:2e8:: with SMTP id r8mr4442360ote.171.1631419403104;
        Sat, 11 Sep 2021 21:03:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm801890oiw.46.2021.09.11.21.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 21:03:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210910130337.2025426-1-osk@google.com>
 <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
Message-ID: <f1e6c2b7-d668-9aa5-32fd-9a38c901cd3e@roeck-us.net>
Date:   Sat, 11 Sep 2021 21:03:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 1:44 PM, Oskar Senft wrote:
> Hi Guenter
> 
> Thanks for the quick feedback!
> 
>>> +  nuvoton,rtd-modes:
>>> +    description: |
>>> +      Select modes for the three RTDs.
>>> +
>> At the very least, "RTD" should be defined. The datasheet doesn't say explicitly,
>> but I suspect it means "Remote Temperature Diode".
> Ha, good point. As I understand, RTD means "Resistance Temperature
> Detector". But TBH, I'm not sure how that squares with Nuvoton's use
> of "LTD" for the local sensor ... sigh.
> 
>>> +      Valid values for RTD1 and RTD2 are:
>>> +        "closed",
>>> +        "current",
>>> +        "thermistor",
>>> +        "voltage"
>> I am not sure what "closed" means (the datasheet doesn't say), but I suspect it means
>> that the sensor is disabled (?). For the other modes, the translation to the standard
>> ABI is:
> Thanks for that pointer, I now found that in
> Documentation/hwmon/sysfs-interface. Given that there's no definition
> for "disabled", I guess I'll just leave that out of the device tree
> binding for now? That way we'll stay consistent with the sysfs ABI.
> 

Sure there is. A possible set of bindings - in that case for tmp421 -
is suggested with the series at
https://lore.kernel.org/linux-hwmon/cover.1631021349.git.krzysztof.adamski@nokia.com/

That specifically includes the ability to enable or disable channels
using the standard 'status' property. While that series is primarily
for the n-factor property supported by the tmp421, the same approach
can be used for all temperature sensor properties.

Guenter

> That gives us the following mapping for sysfs / device tree -> nct7802 HW:
> 2 (3904 transistor) -> 3 (voltage)
> 3 (thermal diode) -> 1 (current)
> 4 (thermistor) -> 2 (thermistor)
> 
> I'll update the device tree binding to be an array then. I also update
> the temp_type functions to support all 3 values.
> 
> Oskar.
> 



