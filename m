Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901724148BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhIVMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:25:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:23:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ee50so8987233edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryX8AVufL6sz0AeHFj2KeRQZPKI9g5rPyfUzoZrRzF8=;
        b=nMc9ftKDoxJV9zv9FfrApb2UzaTFmVXtHAnTJMZ5GsEnMdgI6cq8C6Dyrw81wtYySr
         BxJFrnyP1Ha56zlIEcr/KcPvU5RCo6gJ6vVJrGFGQZHH8pP1NCYsKr+0LPZuAojDdaHC
         q48Cpt2RMZ3jGycgVkbg0mAWKVKIIOkxxGdR2fVvUkBRfJ3v7HYLitoiqKC2XR+Xf524
         ZPfKCb+jUJWoCgMRtXDmUgkRU57h7x6sHftQsxm6oIXtemgX/CqmK0uB++p903MM9Dmx
         t1586Rc0SgEgo63fiM2cIQAoD48WQQXzxQt62sT8WvRo+7Z/gOoUZPq07ABWZx7yZx15
         bRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryX8AVufL6sz0AeHFj2KeRQZPKI9g5rPyfUzoZrRzF8=;
        b=jY0WN6AhQKXBrR7tpnzX0jq7bHyuve1w/juUYdclyssAhAKZnt/d4EGT9v/xnYFcDL
         uoefZUK4dRpT4CIZaqXiOWMWq4ZoF8PdJ7ZSRPx5jXCnNk4495QlQwCNAd051bK3vvVm
         57c3WFbtIMtTRElRMWIKG06DzjOH/nQpXR6vp/WhWaN9nYF4mxlgzSUl1bfz+Ra7zECF
         wfSZTxFmJC75PD//WBqdk9Pgj3IpM3ja21sbnWXuO59joCopCqBd0NHfgE/N1PC9fooh
         2uMxSoUdORh8qWK4WToYGvVNWJ8oQNkbQM+wh3bZjOZ8ZlCcbQoDuq6gj2l134A9zENG
         TH0Q==
X-Gm-Message-State: AOAM531P66QPXASjbF+2l3ewaAxFGGAz7H865qNFLx2MOR9uu5H04tao
        hKAPu813hdGXVq7y+QMBa2VxO3D/w3bI5w==
X-Google-Smtp-Source: ABdhPJxOhYEi3K8yP/ynTuUD76lhk0uPXuqWwtAQh2+Pu5PrUqNNdUiEYjD+KA4ccs6Yj+gQX0cerQ==
X-Received: by 2002:a05:6402:1d04:: with SMTP id dg4mr41309039edb.183.1632313431810;
        Wed, 22 Sep 2021 05:23:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m12sm876810edr.24.2021.09.22.05.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:23:51 -0700 (PDT)
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
 <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <181c4037-3c34-0f71-6bb7-a9c11b173064@linaro.org>
Date:   Wed, 22 Sep 2021 13:23:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 12:34, Ahmad Fatoum wrote:
> Hi,
> 
> On 08.09.21 12:02, Joakim Zhang wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Some of the nvmem providers encode data for certain type of nvmem cell,
>> example mac-address is stored in ascii or with delimiter or in reverse order.
>>
>> This is much specific to vendor, so having a cell-type would allow nvmem
>> provider drivers to post-process this before using it.
> 
> I don't agree with this assessment. Users of the OCOTP so far
> used this specific encoding. Bootloaders decode the OCOTP this way, but this
> encoding isn't really an inherent attribute of the OCOTP. A new NXP SoC
> with a different OTP IP will likely use the same format. Users may even
> use the same format on an EEPROM to populate a second off-SoC interface, .. etc.
> 

That is okay.

> I'd thus prefer to not make this specific to the OCOTP as all:
> 
>    * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX	/* ... */
> 
>    * cell-type = <NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX>;
> 

No, this is not okay, cell-type is just representing what is the cell 
type in a generic way, and its not intended to have any encoding 
information.

Encoding information should be derived from the provider specific 
bindings. If we start adding this info in generic binding we will endup 
with a mess.
And this has been discussed in various instances.

>    * and then the decoder is placed into some generic location, e.g.
>     drivers/nvmem/encodings.c for Linux

This is fine, we could have a library to do these post-processing, but 
only if we have enough users. For now its better to keep it within 
provider drivers till we have more consumers of these functions.


--srini
> 
> That way, we can reuse this and future encodings across nvmem providers.
> It's also more extendable: e.g. big endian fields on EEPROMs. Just stick
> the cell-type in, document it in the binding and drivers supporting it
> will interpret bytes appropriately.
> 
> It's still a good idea to record the type as well as the encoding,
> e.g. split the 32 bit encoding constant into two 16-bit values.
> One is an enum of possible types (unknown, mac_address, IP address ... etc.)
> and one is an enum of the available encodings.
> 
> What do you think?
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>>   include/dt-bindings/nvmem/nvmem.h                  |  8 ++++++++
>>   2 files changed, 19 insertions(+)
>>   create mode 100644 include/dt-bindings/nvmem/nvmem.h
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> index b8dc3d2b6e92..8cf6c7e72b0a 100644
>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> @@ -60,6 +60,11 @@ patternProperties:
>>               - minimum: 1
>>                 description:
>>                   Size in bit within the address range specified by reg.
>> +      cell-type:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        maxItems: 1
>> +        description:
>> +          Type of nvmem, Use defines in dt-bindings/nvmem/nvmem.h.
>>   
>>       required:
>>         - reg
>> @@ -69,6 +74,7 @@ additionalProperties: true
>>   examples:
>>     - |
>>         #include <dt-bindings/gpio/gpio.h>
>> +      #include <dt-bindings/nvmem/nvmem.h>
>>   
>>         qfprom: eeprom@700000 {
>>             #address-cells = <1>;
>> @@ -98,6 +104,11 @@ examples:
>>                 reg = <0xc 0x1>;
>>                 bits = <2 3>;
>>             };
>> +
>> +          mac_addr: mac-addr@90{
>> +              reg = <0x90 0x6>;
>> +              cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>> +          };
>>         };
>>   
>>   ...
>> diff --git a/include/dt-bindings/nvmem/nvmem.h b/include/dt-bindings/nvmem/nvmem.h
>> new file mode 100644
>> index 000000000000..eed0478f6bfd
>> --- /dev/null
>> +++ b/include/dt-bindings/nvmem/nvmem.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __DT_NVMMEM_H
>> +#define __DT_NVMMEM_H
>> +
>> +#define NVMEM_CELL_TYPE_UNKNOWN		0
>> +#define NVMEM_CELL_TYPE_MAC_ADDRESS	1
>> +
>> +#endif /* __DT_NVMMEM_H */
>>
> 
> 
