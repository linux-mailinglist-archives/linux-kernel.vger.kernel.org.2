Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0460A361098
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhDOQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhDOQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:58:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:57:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so29258088ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3DgCO52fftNeZ41idappXG0DEfdrTMom3c7Wz2waGIc=;
        b=zDujCGHhaJGpB03Y8csiGEnu2TlKuSIiAyw5BbLnVhntUDWISiQY0pre2AKCezZkzw
         6cWjr+JIFvepZ9RZBujdjrQalMmbQRTfkAjky9igeT96ZKGFMUgC1c662fqo7VGZ2W0U
         gMfe3Q39SE4y91BJEpZtHUEL36U1j6dXONhO4YNUkRQamSr67fP+YM9d7TK44uyDs2VT
         n0qBlI2MTdEc3AmlfD8J6DKhKCq+OudbE7JYaxuBgC6WFmZShhC1xoxsbBllH/6rTB+d
         hbmerLU8HwZlPJs2Zr3g6SSGZQKzm3nuW38nNpv2b2PdqNNP6MNjacC4MypEB2MOwGjJ
         8lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3DgCO52fftNeZ41idappXG0DEfdrTMom3c7Wz2waGIc=;
        b=OogMjnPEKTTAwkZWkRUjUfe7TqfYMv5Uqur9RbxJGQuhkDLXDZpZ6u1jpiAKUCI8WA
         BF53qXIvUKp/6xlqQ3ikRg2dOqeHJx4U4XW8k/6REQi3Uf73Pdct0IPTPdjXnOx+PQY9
         Uw4lpiowihRUQbZglGGIDo90dPCvBU6EWIL34UmPZLFaFMPMPEJvb0CJbjgyzZYnFW74
         A1WWdRej1k7SYC5Z34KQMgwGB+cFCHWGXTKZriIFn5HTmNExOg73UyN4Coz68nYpZ3US
         Old55mLsJ768cfUjJRxSU3Mw00wEXZ5QAAiTtcKK/xmT5nzidjPOvigPd9A1X/ywMjFg
         B0MQ==
X-Gm-Message-State: AOAM533zy9hUMPw++mkK8vZvDuA4Q+EX//o1V6j5eoZfeP63LrURE5Gr
        YcL6gVKD1v2a/czpbVwc522BYdlQgZyPgA==
X-Google-Smtp-Source: ABdhPJy6gp4jWVe189u4BauC4L6mG/7JLHUHTYQJmlJd1gLmtdY4ro6AZVCQPt5FMgB6G++44TvNcA==
X-Received: by 2002:a17:906:1519:: with SMTP id b25mr4441330ejd.254.1618505878656;
        Thu, 15 Apr 2021 09:57:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id bw14sm2313535ejb.89.2021.04.15.09.57.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:57:58 -0700 (PDT)
Subject: Re: [PATCH v4 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for
 wcd938x-sdw
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
 <20210415163912.GA1524320@robh.at.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2458de43-2747-d377-e115-f014fb2b9907@linaro.org>
Date:   Thu, 15 Apr 2021 17:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210415163912.GA1524320@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 17:39, Rob Herring wrote:
> On Wed, Apr 14, 2021 at 04:48:40PM +0100, Srinivas Kandagatla wrote:
>> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
>> connected over SoundWire. This device has two SoundWire devices RX and
>> TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wcd938x-sdw.yaml      | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
>> new file mode 100644
>> index 000000000000..fff33c65491b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wcd938x-sdw.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for Qualcomm SoundWire Slave devices on WCD9380/WCD9385
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
>> +  It has RX and TX Soundwire slave devices. This bindings is for the
>> +  slave devices.
>> +
>> +properties:
>> +  compatible:
>> +    const: sdw20217010d00
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  qcom,direction:
>> +    description: direction of the SoundWire device instance
>> +    enum:
>> +      - rx
>> +      - tx
> 
> Was thinking these were some established bus properties...
> 
> This would just be implied by the 'reg' property index. You could define
> 'reg-names' too I guess.
> 
>> +
>> +  qcom,port-mapping:
>> +    description: |
>> +      Specifies static port mapping between slave and master ports.
>> +      In the order of slave port index.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 4
>> +    maxItems: 5
> 
> qcom,rx-port-mapping and qcom,tx-port-mapping?
> 

If we have this property then "qcom,direction" becomes redundant.

> Or keep a single property and the driver knows how many slave ports for
> each direction. IOW, an array of 9 with first 4 entries for tx and last
> 5 for rx.

We can't have a single property with 9 entries as these are two separate 
devices, rx SoundWire Slave has 5 ports implemented where as tx SounWire 
slave has only 4 ports implemented in hw.

And the are on different SoundWire buses.

--srini
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - qcom,direction
>> +  - qcom,port-mapping
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    soundwire@3230000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03230000 0x2000>;
>> +
>> +        codec@0,3 {
>> +            compatible = "sdw20217010d00";
>> +            reg  = <0 3>;
>> +            qcom,direction = "tx";
>> +            qcom,port-mapping = <2 3 4 5>;
>> +        };
>> +    };
>> +
>> +...
>> -- 
>> 2.21.0
>>
