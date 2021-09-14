Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235E540B5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhINRfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:35:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC616C061574;
        Tue, 14 Sep 2021 10:34:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 6so222259oiy.8;
        Tue, 14 Sep 2021 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Var4fQF1XhsoVmdTJ7YRQUllwNpqTaomfukEwbYbZQ=;
        b=PZxToyoB/iGvr8rt2v1pfgJfVpTI5N0w6XI6pLImxPZivPPloYRbZHZARAA13TT6kB
         7NlESFpcSohzlpoii9z27Ixx02SOO+pfctFH8LH/k2U3VyS6pY86oMt23SkEweecYtWP
         8HFdxbuT6flbYz8qKGeMeaNJzr6TGxH+PH6mDyes8nh82v0Zoy20eerbmk4Zvp8obwkJ
         twEYt/KHIrc8+/noY4RUU71nOLw6iwbcgOLSSGNiUkFyQrGi6TBFW1iNWFplUm7idOL7
         2ZVfS3Zc7BxH2jfHnVmpsFVli2brZ6iL+Oo1BL7JKx3HGmvUymdplQDryMQ5kpSo4Que
         eO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Var4fQF1XhsoVmdTJ7YRQUllwNpqTaomfukEwbYbZQ=;
        b=gEuenI5wM4+fHGfw2++Yqjb4XWNWZZl8TlwJoI+GWkNZ8cewOMMnmchkcPrtkoj0S3
         /ORVcLXErd6zvLXzUskmjIrVQl6Q5jBFTVfRqK1XvlTDdEle34vGunEWL2XgUn8L5epn
         jR69CHzLr5XrmQgzf5W1nb5a5vHpMyjOmQPMikIYkwhD892daVpF5XzWd7yAr+slxEey
         Y/ECyU2FeESWPdTPAxqJjehi1tiSGfImEfIXMt8UvurWX3q0lUelY9wq5mk0IMThZ8PY
         NgMhSR+H2CzmTpH+sjLinkuIeYnOxRsVP3CpLGGvzn6spoNQK6NmwhvnNIQ9U42vpEgb
         NBfg==
X-Gm-Message-State: AOAM532rSFAWKr0XfL48uV/WF66X166Rkc3/3ll5NMZQHGPUCjPStk4I
        biDlgltBJMMjor7d0ie88JI=
X-Google-Smtp-Source: ABdhPJzdfEBxf3YhjeaJoYbBfVki2x3p9gdFKon2ehXCuG9yDEaZ1WWuaIgvXSKRGffb+2ZcPTLB/Q==
X-Received: by 2002:aca:6254:: with SMTP id w81mr2242540oib.83.1631640840079;
        Tue, 14 Sep 2021 10:34:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u19sm2746582oof.30.2021.09.14.10.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:33:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210910130337.2025426-1-osk@google.com>
 <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
 <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net>
 <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net>
Date:   Tue, 14 Sep 2021 10:33:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 10:11 AM, Oskar Senft wrote:
> Hi Guenter
> 
>>> Following the example from tmp421, this could then be like this:
>>
>> Something like that, only we'll need something to distinguish
>> temperature sensors from other sensor types, eg voltage or current.
>> Maybe a "type" property. I'd suggest "sensor-type", but we have
>> non-sensor attributes such as fan count and pwm values which should
>> be covered as well. But it looks like a good start for a set of
>> generic sensor properties.
> Would it be acceptable to simply number the sensors and document which
> sensor has which number?
> 
> Something like this:
> 0 = LTD
> 1 = RTD1
> 2 = RTD2
> 3 = RTD3
> 4 = FAN1
> 5 = FAN2
> 6 = FAN3
> 
That might be a possibility, though it would have to be well defined
for each chip (nct7802 also has voltage sensors). We'll have to discuss
this with Rob.

Personally I think I would prefer using a type qualifier - that seems
cleaner. But that is really a matter of opinion.

> Would we also want to be able to define PWMs? From what I can tell the
> driver does not support running individual pins in GPIO mode, right?
> So I'm not quite clear what "disabling PWM" would actually mean.
> 
The ABI states that fans should run at full speed in that case,
though that may be chip dependent (some chips stop the fan if pwm
control is turned off).

> Anyway, if we simply go by "sensor number", that would mean that we'd
> have different attributes depending on the sensor number. Would that
> be ok?
> 
That is a question for Rob to answer.

> Also, I'm sorry, I think I just realized that in "voltage mode" we
> don't seem to get a temperature reading. I hadn't actually looked
> through more of the datasheet except for the single MODE register
> before. But I don't think this makes a difference for what I proposed
> so far?
> 

We don't ? I thought this reflects temperature measurement with a
transistor instead of a diode (which would be current based).
Hard to say - the datasheet is a bit vague in that regard.

>>>          /* LTD */
>>>          input@0 {
>>>              reg = <0x0>;
>>>              status = "okay";
>>
>> Not sure what the default is here ('okay' or 'disabled').
>> We'd also need to define what to do if there is no data
>> for a given sensor.
> I think I'd like to keep previous behavior unmodified. From what I can
> tell previous behavior was:
> - xTDs enabled by default
> - RTD modes unmodified, i.e. defaulting to whatever the HW comes up with
> 
> The NCT7802Y can self-program from an EEPROM, so I assume we should
> honor the "power-up configuration" obtained from there? I.e. if no
> configuration is provided in the device tree, the driver should use
> whatever configuration the chip has when the driver is loaded.
> 
Definitely yes. My question was more what to do if the information
in devicetree nodes is incomplete.

Thanks,
Guenter

>>>              label = "voltage mode";
>>
>> That isn't the idea for "label", as "label" would be expected to
>> show up as tempX_label (and a label of "voltage mode" would be odd).
>> The label should indicate where the sensor is located on a board,
>> such as "inlet" or "outlet".
> Yes, absolutely. This was a bad example on my part. In my
> understanding "label" is just a string that we pass through.
> 
> Oskar.
> 

