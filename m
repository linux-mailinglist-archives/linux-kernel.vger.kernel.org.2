Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880FB3FFFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhICMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhICMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:39:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E92C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 05:38:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m9so8069880wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OuZDvpS+EQVaSGwn969u13tka0CIVphMryeurQ0nmRQ=;
        b=ONLnij8FQAAfgmL2Le+UlTO7y8rX6Xubj6BPdejsFlZhhMJe7qd52njrp6pv0ZUSxs
         IbKd1eehLLCUC53Igvf3XXD4wIzPym2FhYF7US7eu2LYAchUsRKWvMpTtkrConX8oupa
         g4eP5FUNqefshQbMy6v9zMz2qBoXA7D9MlouWu8M84YTUhrooNjU1U8/VSQ6ClWp+GXA
         kButNldr72ZgR9I+6V6bDOEl6qCCJbA1Quabwuv61FUSRBP1uRZDTyBcGpKGOPA8SV7w
         BBz1wd8QgFkTHlI39bCK2PR2sUw3W6kiQUN7i20PN52f2D3HZ4tv9ScIHtxfAZuKKxh5
         r1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OuZDvpS+EQVaSGwn969u13tka0CIVphMryeurQ0nmRQ=;
        b=s4vFGxL3iLNRJaeB9/tbAUharG1ybKtLSKviLTu8IGA0ptyLAV4U6eWQhIbBsoOEi8
         t//GIJOufkQA7f5B4u0PrczI35vFuXqWtNH/cBTO835+LaeHlAW7Q2n5MPuyK+Mw2Hwt
         D28bj12+O4NrRlJLTnu9NGuOUoUd8PyaEhIXZiKdS10+l64kgrifRMTkk9PUiE2qu2ty
         3oSzruaoplyzzGlzwF6YdJo5uja48qlhNSoCJY3B5e8Q+itoE6C4//iiKSP4SGZvIIke
         fFvkjjWreF+gA0LQAH3TeZmpFBuKq9bKCMVkeCmHJy+GIGtaTmpNvGYrdOaujyRbns9K
         GtMg==
X-Gm-Message-State: AOAM530efp35J6xE25zW0FJE1MiyUyueAMxmGyTglTCmL0E/4BGfoAiu
        hziyyYzKIuRrpKNav11WM94h89XX4V8X7g==
X-Google-Smtp-Source: ABdhPJwWPPIedDTTn/4nWD8alSIBvjZcjCC8Smui9MD+vIC1h91M1C7f44OuHrdayKxuTH6YNFPofQ==
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr3847211wrx.357.1630672681439;
        Fri, 03 Sep 2021 05:38:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k18sm4305879wmi.25.2021.09.03.05.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:38:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Rob Herring <robh@kernel.org>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
 <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
 <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
Message-ID: <f572aca2-167a-be26-d89a-810c7023092f@linaro.org>
Date:   Fri, 3 Sep 2021 13:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On 18/08/2021 08:54, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: 2021Äê8ÔÂ18ÈÕ 3:58
>> To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>; shawnguo@kernel.org;
>> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
>> property
>>
>> On Wed, Aug 11, 2021 at 11:16:49AM +0100, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 10/08/2021 08:35, Joakim Zhang wrote:
>>>> Introduce "reverse-data" property for nvmem provider to reverse buffer.
>>>>
>>>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>> b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>> index b8dc3d2b6e92..bc745083fc64 100644
>>>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>> @@ -61,6 +61,11 @@ patternProperties:
>>>>                  description:
>>>>                    Size in bit within the address range specified by reg.
>>>> +      reverse-data:
>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>> +        description:
>>>> +          Reverse the data that read from the storage device.
>>>> +
>>>
>>> This new property is only going to solve one of the reverse order
>>> issue here.
>>> If I remember correctly we have mac-address stored in various formats ex:
>>> from old thread I can see
>>>
>>> Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped) Type
>>> 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so on)
>>> (Swapped/non-Swapped)
>>> Type 3: Is the one which stores mac address in Type1/2 but this has to
>>> be incremented to be used on other instances of eth.
>>> Type 4: Octets as bytes/u8, swapped/non-swapped
>>>
>>> I think its right time to consider adding compatibles to nvmem-cells
>>> to be able to specify encoding information and handle post processing.
>>
>> Yes. Trying to handle this with never ending new properties will end up with a
>> mess. At some point, you just need code to parse the data.
> 
> Thanks, Rob.
> 
> Hi Srinivas,
> 
Firstly Sorry for taking so long to reply as I was on vacation.

> Do you plan to implement it?

No, Am not planning to do this. But am happy to walk-thru the ideas that 
I have.

> 
> Or need me follow up? If yes, please input your insights to point me how to work for it.

Do we have some kind of meta data/information in nvmem memory to 
indicate the storage encoding?

Am I correct to say that this is only issue with mac-address nvmem cell?

Irrespective of where this encoding info comes from we have 2 options.

Option 1: Add callback to handle mac-address post-processing with in the 
provider driver.

Pros:
- It can deal with vendor specific non-standard encodings, and code is 
mostly with-in vendor specific nvmem provider driver and bindings.
- will keep nvmem core simple w.r.t handling data.

Cons:
- provider driver implement callback and new bindings.
- might need to add a nvmem-cell-type binding to be able differentiate 
the cell types and handle post-processing.

Option 2: nvmem core handles the post processing.

Pros:
- provider driver does not need to implement callbacks

Cons:
- We have to find a way to define vendor specific non-standard encoding 
information in generic bindings which is going to be a challenge and 
high chance of ending up in to much of clutter in generic bindings.

Finally, The way I look at this is that once we start adding 
post-processing in nvmem core then we might endup with code that will 
not be really used for most of the usecases and might endup with cases 
that might not be possible to handle in the core.


Does Option 1 work for you?

--srini

> 
> Thanks.
> 
> Best Regards,
> Joakim Zhang
>> Rob
