Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707E140EAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhIPTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhIPTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:36:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B07C061574;
        Thu, 16 Sep 2021 12:35:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso9751890ots.5;
        Thu, 16 Sep 2021 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/5An8ZJhvhfRlZxTeIIggw/jOkq6WE1Xp3iVwLwkX0=;
        b=GoI3555vu1+SkUsvIX0T8i1fySL0jZPBdfh2WGeXZ3sq4vVDs1rMGe3saO9LT9sOjk
         +yVa9+5P7kabIW06OrQJzg6D+Drsv6oyAPioWrxD7Aov64cSHfOBlKH3AFjLUsRT67ip
         XW+efkrtdL2YGHDuCIe8HpRDgFsU8+1lrLcGQ4SnEQj5lhcF+IwPstwHFZVRx8fCVNuR
         BzpzQJdi8quku959XzfWO2d8z0zYqJj068ZvUS8w8CNDSc7Jve2SQSpeMk4ZC0a2ABcW
         EVTt/xRwX57XjlA7TbPPG1fhDp9VI6Hw7VZRFa/T3TbjcaSZtp/I/keYvmORa9RkNoyS
         8yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/5An8ZJhvhfRlZxTeIIggw/jOkq6WE1Xp3iVwLwkX0=;
        b=EzjWoE8HPL/uFDn3QhYC4+fBAHkKzf0wgZaKktLUqCt2+bZzVjD2dQuy9PApZ1Yqho
         Lz8GPc/HDtA8nkPG6bJHbykHL5+S2yd8RHWL0LM4iSnhDpqQk+dLT9crZCXXz4Nn32JO
         elyZQiQkem2v5LpEQbIHDwEW6o/T8KRvoSCL2fTzeI7am6GJrox4+zz1nRENxouGf9cl
         Pdnwxow/nJKh/UeeRBrcDwa+G3ozYEAezD+00RprtUODQelBflhRCQ5wfQyCJBvKMBJX
         oVpKIqlvEezundL41JmAkYTOzzQEFqoBWLW19ZR081FWyYrzqJHJ2Rps88aOQ27kOE1a
         mgcw==
X-Gm-Message-State: AOAM532WFObicfwiQ96QaYjGFe6kjsDSY7aap5CXhhHUOGYlZxiDzT8Q
        GQuJ0ve+LXBL0y8t4XUbheY=
X-Google-Smtp-Source: ABdhPJwQ39Meb8g3bD5LeTVGWQS66NTxcbxEnijMnzcz57csCZzYg4F9uVLdSV2Q/k6jC16/IG7+ag==
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr6128825oto.233.1631820899562;
        Thu, 16 Sep 2021 12:34:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x198sm878970ooa.43.2021.09.16.12.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:34:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
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
 <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net>
 <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net>
Date:   Thu, 16 Sep 2021 12:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 12:19 PM, Oskar Senft wrote:
>      Hi Guenter
> 
>>> Would it be acceptable to simply number the sensors and document which
>>> sensor has which number?
>>>
>>> Something like this:
>>> 0 = LTD
>>> 1 = RTD1
>>> ...
>>>
>> That might be a possibility, though it would have to be well defined
>> for each chip (nct7802 also has voltage sensors). We'll have to discuss
>> this with Rob.
>>
>> Personally I think I would prefer using a type qualifier - that seems
>> cleaner. But that is really a matter of opinion.
> 
> Another existing way I found is in ltc2978. Following that, we could
> do it as follows:
> 
> i2c {
>      #address-cells = <1>;
>      #size-cells = <0>;
> 
>      nct7802@28 {
>          compatible = "nuvoton,nct7802";
>          reg = <0x28>;
>          #address-cells = <1>;
>          #size-cells = <0>;
> 
>          sensors {
>              ltd {
>                  status = "okay";
>                  label = "my local temperature";
>              };
> 
>              rtd1 {
>                  status = "okay";
>                  mode = <0x2>; /* 3904 transistor */
>                  label = "other temperature";
>              };
> 
>              rtd3 {
>                  status = "okay";
>                  mode = <0x3>; /* thermal diode */
>                  label = "3rd temperature";
>             };
>          };
>      };
> };
> 

Ah, using the node name as indication for both sensor type and
index ? SGTM, though we'd really need input from Rob.
I guess one could also consider something more generic like
"temperature-sensor@0", "voltage-sensor@0", and so on (instead
of [mis-]using reg and a sensor-type field).

Thanks,
Guenter

> 
>>> The NCT7802Y can self-program from an EEPROM, so I assume we should
>>> honor the "power-up configuration" obtained from there? I.e. if no
>>> configuration is provided in the device tree, the driver should use
>>> whatever configuration the chip has when the driver is loaded.
>>>
>> Definitely yes. My question was more what to do if the information
>> in devicetree nodes is incomplete.
> I think there are two cases:
> 1) If the new "sensor" tree is missing, the driver should behave as it
> does today to not break existing users.
> 2) If the new "sensor" tree is present, then each of the sensors that
> should be disabled needs to have "status = 'okay'" and have the mode
> set (unless it's LTD). In the above example, rtd2 is missing and would
> therefore be considered disabled.
> 
> Does that make sense? I still need to find out whether this is
> actually valid DT and how to express that in the YAML, though ...
> 
> Thanks
> Oskar.
> 

