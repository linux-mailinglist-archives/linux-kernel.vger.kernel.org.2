Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDEC426D5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhJHPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbhJHPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:17:37 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAFC061570;
        Fri,  8 Oct 2021 08:15:41 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso12000980otj.13;
        Fri, 08 Oct 2021 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJZtpd7hD5b0KIWZpJjJa7jxf+MQ6RsIzxaFpnA4ezs=;
        b=MPipi01MzNpqu9cR83Ny8yWH7iyiOoFD1u/FQmHC2oJALoRoOD7sDI3MbBYa2Bl0Qi
         NMMlY9Hz5v1hV+hHgOVGPOpuaDJkjnFLLPuD+pzOTlnsApPz7nw+SGbnJSuoEfMlK/+n
         fyiFRwWGBL8eBYMIa9ZSEB+nx54hT6/iMji7UaQPd/e15DIjtkzxcfuUFtt0viWu79mX
         Bs2Q2TnBbOOhlMpwk0/d8ZjC/rQc4crEy92KVPAV+kcDprerk+ENbu3//r04bNRYwSyx
         PPoxoOIZZ9VWLF2JFiygkNE2vQ9hyMBkwF0r1s0wqible8Ojf1zHAi3IrJJMAUD/taT8
         NbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJZtpd7hD5b0KIWZpJjJa7jxf+MQ6RsIzxaFpnA4ezs=;
        b=ixJg+P77gw9RI/0/ejl1o/uwXsThMnbn1Wpq3gNzmkrk2L6MsIRZqxqhiHBG1I5MZ0
         kqtGDOJOs9Q8oGsBlGNxmfrUo6asPAlQbn7lkj+izQCKkA698ympjmLdeL6PHtYGWctH
         XP+SXA9pHtCg82ewpc9FuG8C4Oc20Zvg7zTLoLjpBK7wqkxHyJsQad15jgC8AHeHfF8S
         tHOa3qtRe0U/t2q0INwwXDiYq6QLd1w0WItIbbQzwSp0LXRiUnN4dyTvAcaMSGTchkBr
         Ss7LBFuJuCL796JeXcv0Vc6zmLvVGYcbF2EjWkd9D8c3+AjoAsR1j71UFKKAcdHjOa/a
         VTCg==
X-Gm-Message-State: AOAM5303GQ4d1ywhYw/TUVLpKH4CVHFCYpNXkitar2z9wfN3ZD3GNyrG
        XsHT+2p0CGkyUkkhNgnhLyy5z+8t27o=
X-Google-Smtp-Source: ABdhPJwK+BKtP3uijn1ZOG8xG1T7/wQaK/AzHpA1IcEIEs8JsEJWyhJ5qR4cPagtWZIPZhY64Clbkg==
X-Received: by 2002:a9d:313:: with SMTP id 19mr9366632otv.189.1633706140648;
        Fri, 08 Oct 2021 08:15:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i42sm617251ota.43.2021.10.08.08.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 08:15:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
 <2c19f216-6347-e253-7f09-54f2a69f1481@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b8634536-c131-8ec6-bae7-ad76c0542529@roeck-us.net>
Date:   Fri, 8 Oct 2021 08:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2c19f216-6347-e253-7f09-54f2a69f1481@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 1:00 AM, Krzysztof Kozlowski wrote:
> On 24/09/2021 13:51, Guenter Roeck wrote:
>> On Fri, Sep 24, 2021 at 08:57:44AM +0200, Krzysztof Kozlowski wrote:
>>> On 23/09/2021 23:16, Rob Herring wrote:
>>>> On Mon, Sep 20, 2021 at 08:21:14PM +0200, Krzysztof Kozlowski wrote:
>>>>> Document bindings for NXP SE97B, a DDR memory module temperature sensor
>>>>> with integrated SPD and EEPROM via Atmel's AT24 interface.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml | 9 +++++++++
>>>>>   1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>>> index a7bb4e3a1c46..0e49b3901161 100644
>>>>> --- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>>> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>>>>> @@ -10,6 +10,14 @@ maintainers:
>>>>>     - Jean Delvare <jdelvare@suse.com>
>>>>>     - Guenter Roeck <linux@roeck-us.net>
>>>>>   
>>>>> +select:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      const: jedec,jc-42.4-temp
>>>>> +
>>>>> +  required:
>>>>> +    - compatible
>>>>> +
>>>>
>>>> Is this supposed to be in the last patch? And why is it needed?
>>>
>>> Yes, this is here on purpose because of nxp,se97b which is sensor with
>>> at24-compatible EEPROM.
>>>
>>> arch/arm/boot/dts/at91-nattis-2-natte-2.dts:
>>> 169         temp@18 {
>>> 170                 compatible = "nxp,se97b", "jedec,jc-42.4-temp";
>>>
>>> 171                 reg = <0x18>;
>>> 172                 smbus-timeout-disable;
>>> 173         };
>>> 174
>>> 175         eeprom@50 {
>>> 176                 compatible = "nxp,se97b", "atmel,24c02";
>>
>> How would that be handled anyway ? Yes, the chip includes both a temperature
>> sensor and an eeprom, but this node should most definitely not instantiate as
>> temperature sensor.
>>
> 
> I am not sure if I understand the problem you are mentioning. You have
> two nods in DT, two different compatible sets and two difference
> devices. One eeprom and other one a temperature sensor.
> 

I didn't realize that the driver is supposed to bind to "jedec,jc-42.4-temp"
and that "nxp,se97b" is really informational.

Sorry for the confusion.

Guenter
