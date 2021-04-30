Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8524836F707
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhD3IVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhD3IVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:21:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A13C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:20:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so277557wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3V7PIJt4df52x4EhJvQyNhxcs7GT3vwtzimn9FSBpE=;
        b=JOFR5P4z2JgXwIzzvzUuxVUDGInvtmF/Ji0eODgv9me7xLvxYX+/YftiHdCIkMxwcq
         dX8QUfX37saKnVR26QTbhiDI33H1uwjT+Zf5GCdFyvDHMdEC/KQKBSfp+4JEFjg6VQze
         PUFoyG3opZ5Gh+E8Z3C3UR73y5Imz7ESWVqq0xMYlod7fMrRemuftXs9t3pvUUBPQYHS
         JXp1kp8dMxWRjJfpwHMjEkJLT3Rati3hr/cF6k+npMbB9reFWiOPrpJXsIcmStFW4IjG
         AR7FzIdL74nsE9HDPO4dHz5rxND0LRGh+Gueeu/OS+Yoe5xIz901CYyw06AT+AJht8ai
         RSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3V7PIJt4df52x4EhJvQyNhxcs7GT3vwtzimn9FSBpE=;
        b=RVlVBw9iXXU2TJGYb+gmc9qSCafuwLeE48LtmhJ6ug1EfPbHGljgnBwBTHYwqwOCDW
         WpbxcodfgFzwejhmQXYUmwQZx/UChRmr/DcLORhuLGkRivf4tZYK0AkUj9wbctEbHXtq
         CGg3GhtJ8UwNmpYJoLoKVU8gWfQypoXHcb1AlvJfs6UfCz/2IE7wZGRfkxaKjQZLvUkD
         38QXE88x+RKHy2DyaNTwMKTch3CWyxpPAHG8XmOda88zxtSu8MHak1L/YEmNFG2IIbaW
         BMuqI2KcNaYZAejvUPefyIDSLM/BA91HWSD3QR7x+3VT9juRqv0GMp9LOEL8i2zy4rAA
         62TA==
X-Gm-Message-State: AOAM532/4cPzYuhpaALcUmSPn46ojvaseB7bP6p/vBgMsJ7zJ28WUB4+
        fnqD9/8woB/KU7o+88xBSvRFfQ==
X-Google-Smtp-Source: ABdhPJwj2Jtz4lfgLVo8vX67xmuo0x4uN8Ad9r42TOq6WHEsTP+wOyClRvouTstm8/Iy4PJPH0I2JQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr14890660wmc.172.1619770818847;
        Fri, 30 Apr 2021 01:20:18 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 18sm12705810wmo.47.2021.04.30.01.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:20:18 -0700 (PDT)
Subject: Re: [PATCH v4 1/9] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-2-srinivas.kandagatla@linaro.org>
 <20210415162947.GA1511094@robh.at.kernel.org>
 <96e7c752-a962-cb5b-c936-8151fd4c32ea@linaro.org>
Message-ID: <22bab947-e760-be72-084b-41059bf02d19@linaro.org>
Date:   Fri, 30 Apr 2021 09:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <96e7c752-a962-cb5b-c936-8151fd4c32ea@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15/04/2021 17:53, Srinivas Kandagatla wrote:
> Thanks Rob for quick review,
> 
> On 15/04/2021 17:29, Rob Herring wrote:
>> On Wed, Apr 14, 2021 at 04:48:37PM +0100, Srinivas Kandagatla wrote:
>>> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
>>> connected over SoundWire. This device has two SoundWire device RX and
>>> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
>>> 7 x TX diff inputs, 8 DMICs, MBHC.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../bindings/sound/qcom,wcd938x.yaml          | 176 ++++++++++++++++++
>>>   1 file changed, 176 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml 
>>> b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>>> new file mode 100644
>>> index 000000000000..4c8fa8290af0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>>> @@ -0,0 +1,176 @@
> 
> ...
> 
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    codec {
>>> +        compatible = "qcom,wcd9380-codec";
>>> +        reset-gpios = <&tlmm 32 0>;
>>> +        #sound-dai-cells = <1>;
>>> +        qcom,tx-device = <&wcd938x_tx>;
>>> +        qcom,rx-device = <&wcd938x_rx>;
>>> +        qcom,micbias1-microvolt = <1800000>;
>>> +        qcom,micbias2-microvolt = <1800000>;
>>> +        qcom,micbias3-microvolt = <1800000>;
>>> +        qcom,micbias4-microvolt = <1800000>;
>>> +        qcom,mbhc-hphl-switch;
>>> +        qcom,mbhc-ground-switch;
>>> +        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
>>> +        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
>>> +        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
>>> +        qcom,mbhc-button3-vthreshold-microvolt = <500000>;
>>> +        qcom,mbhc-button5-vthreshold-microvolt = <500000>;
>>> +        qcom,mbhc-button6-vthreshold-microvolt = <500000>;
>>> +        qcom,mbhc-button7-vthreshold-microvolt = <500000>;
>>> +    };
>>> +
>>> +    /* ... */
>>> +
>>> +    soundwire@3230000 {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +        reg = <0x03230000 0x2000>;
>>> +        wcd938x_tx: codec@0,3 {
>>> +            compatible = "sdw20217010d00";
>>> +            reg  = <0 3>;
>>> +            qcom,direction = "tx";
>>> +            qcom,port-mapping = <2 3 4 5>;
>>> +        };
>>> +
>>> +        wcd938x_rx: codec@0,4 {
>>> +            compatible = "sdw20217010d00";
>>> +            reg  = <0 4>;
>>> +            qcom,direction = "rx";
>>> +            qcom,port-mapping = <1 2 3 4 5>;
>>> +        };
>>
>> This is a single device, right? We shouldn't need 3 nodes to describe
>> it. I think this should all be a single node like this:
>>
> No, WCD938x is a Audio Codec which has two SoundWire Slave device (TX 
> and RX). WCD938X reset lines and supplies are common for both TX and RX 
> SoundWire devices.
> 
> However TX SoundWire device only has register access to codec 
> CSR(Control Status registers).
> 
> So there are two SoundWire devices and a WCD938X common parts. Now 
> making the common Codec part as a separate device made more sense here.
> So we ended with total 3 devices.
> 
> 1 . WCD938x Codec which deals with all the codec side including Common 
> parts.
> 2. TX SoundWire device to configure TX SoundWire ports/interface and 
> provide CSR access.
> 3. RX SoundWire device to configure RX Soundwire ports/interface
> 


Are you okay with the existing device layout after providing the above 
information?


  codec {
         compatible = "qcom,wcd9380-codec";
         reset-gpios = <&tlmm 32 0>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd938x_tx>;
         qcom,rx-device = <&wcd938x_rx>;
         qcom,micbias1-microvolt = <1800000>;
         qcom,micbias2-microvolt = <1800000>;
         qcom,micbias3-microvolt = <1800000>;
         qcom,micbias4-microvolt = <1800000>;
         qcom,mbhc-hphl-switch;
         qcom,mbhc-ground-switch;
         qcom,mbhc-button0-vthreshold-microvolt = <75000>;
         qcom,mbhc-button1-vthreshold-microvolt = <150000>;
         qcom,mbhc-button2-vthreshold-microvolt = <237000>;
         qcom,mbhc-button3-vthreshold-microvolt = <500000>;
         qcom,mbhc-button5-vthreshold-microvolt = <500000>;
         qcom,mbhc-button6-vthreshold-microvolt = <500000>;
         qcom,mbhc-button7-vthreshold-microvolt = <500000>;
     };


soundwire-controller@3230000 {
     reg = <0 0x3230000 0 0x2000>;
     compatible = "qcom,soundwire-v1.5.1";
     wcd938x_tx: codec@0,3 {
         compatible = "sdw20217010d00";
         reg  = <0 3>;
         qcom,direction = "tx";
         qcom,port-mapping = <2 3 4 5>;
     };
};


soundwire-controller@3210000 {
     reg = <0 0x3210000 0 0x2000>;
     compatible = "qcom,soundwire-v1.5.1";
      wcd938x_rx: codec@0,4 {
         compatible = "sdw20217010d00";
         reg  = <0 4>;
         qcom,direction = "rx";
         qcom,port-mapping = <1 2 3 4 5>;
     };
};


thanks,
srini


> 
>> codec@0,3 {
>>          reg = <0 3>, <0 4>;
> 
> We can't have this, as these two SoundWire devices hang on different 
> SoundWire bus instances.
> 
>>     compatible = "sdw20217010d00";
>>
>>          reset-gpios = <&tlmm 32 0>;
>>          #sound-dai-cells = <1>;
>>          qcom,micbias1-microvolt = <1800000>;
>>          qcom,micbias2-microvolt = <1800000>;
>>          qcom,micbias3-microvolt = <1800000>;
>>          qcom,micbias4-microvolt = <1800000>;
>>          qcom,mbhc-hphl-switch;
>>          qcom,mbhc-ground-switch;
>>          qcom,mbhc-button0-vthreshold-microvolt = <75000>;
>>          qcom,mbhc-button1-vthreshold-microvolt = <150000>;
>>          qcom,mbhc-button2-vthreshold-microvolt = <237000>;
>>          qcom,mbhc-button3-vthreshold-microvolt = <500000>;
>>          qcom,mbhc-button5-vthreshold-microvolt = <500000>;
>>          qcom,mbhc-button6-vthreshold-microvolt = <500000>;
>>          qcom,mbhc-button7-vthreshold-microvolt = <500000>;
>> };
>>
>> You'll have to figure out the qcom,direction and qcom,port-mapping parts
>> though.
> 
> That is the reason why we ended up with 3 devices here.
> 
> --srini
>>
>> Rob
>>
