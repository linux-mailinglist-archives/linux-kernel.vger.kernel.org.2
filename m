Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472C42658C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJHIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:03:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39366
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233072AbhJHICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:02:53 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D3F73FFDE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633680054;
        bh=UhvRFg6J81eubpJZYTlrZiRc4zy2yqJEO477Q5ePwLM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JXRF+YJS3o0ZWR/4fORURaYONVy3eBcj08tRe699UorRTEuIL6y6e+cBm/oUxjl+u
         JdneX0JBxDY8IIKrSAiUSADYyERq/WBsyTfkw+FQg71FPlHK1VGE3np6VKmQaQk59K
         4Yha1C+/2LhsaGiN/iICMC9D3ZywNfiDG6DRa5Zz1442jg4nM9DtYh0eKLJDnbV/UB
         je8v+pVH32VpD2rud2JQjfaxYLniOehHO1nFWh1j3S3R69hUDtH9yhJN6hJDm/6szv
         Rbn2czd5HGD3Zo7MhmCk0NvxgFQdkK0Vlzy6TMDqAWFHXrF2lrsDmRIGDQa/jRD6Bu
         vvUSPnu167FgA==
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so6672836wrg.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhvRFg6J81eubpJZYTlrZiRc4zy2yqJEO477Q5ePwLM=;
        b=E4Na+IGvgkI+tnA9bqIwK2XrqXD6eRWyB4e4E6o1Ijb6TdAVWSRfXuNDLRbAfTLKkE
         v+TMnHpmQtLZyY2yzZcv8OZ1dXVA74FLhtcAedOfU0DMofcJUpJeRHGFviwrqe8ONhuP
         7DoDxzQfP3EoUQQ8DPCQTGPQv0+sM1zcAP6BInP7QxWviFnqRBKDRsGQFEOEx8zCbZbW
         8XVHX3tpiRrQ9ceJxESlIJOBbbNk8FlNwPGXMILMuZXdWXzK3IiJInXbkbUeEhkKVr8A
         CQcBzsXYe8tHqb1E/Usl99coBLDbkVQSVKSX3l3V+qWJI0eYgdU0K+eEaxtfV0OC9cif
         CjPA==
X-Gm-Message-State: AOAM531G7mWiqeX8sCLjcwHUCgJpW4zJbOL123TR7E8jUuAO9RvRaHH0
        t8cIese7IoJVcfr47ZTEjVQ5YFqajPGuT0x67n51WZdJTbBogR2l62bSwBCIN5vZAb98RdYbKg/
        eOnXe0+MSsnTvPDJYjRx4KyGgVG7N1xS5RYEGd4SV8w==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr1848283wmc.108.1633680053005;
        Fri, 08 Oct 2021 01:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEDTGsh/gLhVeCZutYpGk/6baUHgeM4bfvl6fc9nzb//eqtmfQ4kjKeNy7B9SCIW5ZaGEsJg==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr1848251wmc.108.1633680052698;
        Fri, 08 Oct 2021 01:00:52 -0700 (PDT)
Received: from [192.168.1.24] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id 73sm1844525wmb.40.2021.10.08.01.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:00:52 -0700 (PDT)
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-6-krzysztof.kozlowski@canonical.com>
 <YUzuyG3e7sHlMHAJ@robh.at.kernel.org>
 <8871dd77-f9f1-bf25-78ad-48f97efcf7d9@canonical.com>
 <20210924115152.GC2694238@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2c19f216-6347-e253-7f09-54f2a69f1481@canonical.com>
Date:   Fri, 8 Oct 2021 10:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924115152.GC2694238@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2021 13:51, Guenter Roeck wrote:
> On Fri, Sep 24, 2021 at 08:57:44AM +0200, Krzysztof Kozlowski wrote:
>> On 23/09/2021 23:16, Rob Herring wrote:
>>> On Mon, Sep 20, 2021 at 08:21:14PM +0200, Krzysztof Kozlowski wrote:
>>>> Document bindings for NXP SE97B, a DDR memory module temperature sensor
>>>> with integrated SPD and EEPROM via Atmel's AT24 interface.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>> index a7bb4e3a1c46..0e49b3901161 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>> @@ -10,6 +10,14 @@ maintainers:
>>>>    - Jean Delvare <jdelvare@suse.com>
>>>>    - Guenter Roeck <linux@roeck-us.net>
>>>>  
>>>> +select:
>>>> +  properties:
>>>> +    compatible:
>>>> +      const: jedec,jc-42.4-temp
>>>> +
>>>> +  required:
>>>> +    - compatible
>>>> +
>>>
>>> Is this supposed to be in the last patch? And why is it needed?
>>
>> Yes, this is here on purpose because of nxp,se97b which is sensor with
>> at24-compatible EEPROM.
>>
>> arch/arm/boot/dts/at91-nattis-2-natte-2.dts:
>> 169         temp@18 {
>> 170                 compatible = "nxp,se97b", "jedec,jc-42.4-temp";
>>
>> 171                 reg = <0x18>;
>> 172                 smbus-timeout-disable;
>> 173         };
>> 174
>> 175         eeprom@50 {
>> 176                 compatible = "nxp,se97b", "atmel,24c02";
> 
> How would that be handled anyway ? Yes, the chip includes both a temperature
> sensor and an eeprom, but this node should most definitely not instantiate as
> temperature sensor.
> 

I am not sure if I understand the problem you are mentioning. You have
two nods in DT, two different compatible sets and two difference
devices. One eeprom and other one a temperature sensor.


Best regards,
Krzysztof
