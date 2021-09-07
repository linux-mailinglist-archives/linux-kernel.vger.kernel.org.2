Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFF4026ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbhIGKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbhIGKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:12:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739BC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:11:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so2828013wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M6VI7hu6nrDpy/FRYqSASE+rFeGiqe0QFHElCOeveOo=;
        b=JoHF+/ZC176lyR574CMp6AL3EzeDLGm5VH0Qs0aWw0+KT4pwFKBxaQXrM1/pbi5c/B
         eLwTpd6IVqXkfoD1Ex1PQwaMva+jmJvKdHGPpotMoNPUrCcsKiXupsBimWnq7fiB+7lh
         faCiPPxMe/4Q/0PG9GahTIDyO2E233ngAgK6Z3Vcz6eWCShcBEoRMOPYASEWG5cbx6iy
         xjDaMzWgj2s5bVVxPvxB/IDvL/iHoQvmky/d2XBxBsLyB4oWodvWK1wPnBDRUDXBReFZ
         EHI57bHP0nAbqhQ8rvIf/c4mI1VPlGpbfKaTOOp+oTRU/yY17pVkGbp8gN83/sP9JEbb
         Hs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M6VI7hu6nrDpy/FRYqSASE+rFeGiqe0QFHElCOeveOo=;
        b=hFy9GpOqfbN+Y2FFRcYGF9M+Kd9P2EvaYZPm4BxswDRkjCBf3AptdzWQx4cxHEl00d
         aXWXe2yKxngBYY9C9lbQJV/uqRvLCDPdtVaDXbysZCDT97J4cQJO0wssDzWNN4ZHU7cj
         J72xMawcELRaniHqA0vVGHn1676pH6H+EflSUhhPxhvj74AqZ3t5TpaM8I5fCfFi6Xxh
         vAKPbxXI9OW48hr04ZCn+7RPm4CkrwNtkPYE7bnFtIxfGCnL9ABculjzo0SPO6c6QkOZ
         Lrjw290sDHN3FH7H4e3c1QSoSrxZKgICETYXEWglNe7mRq7FDTkIDj+aSJlzRRKiqXKd
         Pr0g==
X-Gm-Message-State: AOAM530R/F2kMvMW5Npmn+iDD5xYajzjqQ1Byh/lcD1bFlH6mKkWoPbJ
        5Czovf+Na1CjfLJOq5CAcIicSxP5pyxyaQ==
X-Google-Smtp-Source: ABdhPJw/72hnzp8nPnw3j3a18oHNzb1ZPr7q4elKahn8jbAr0432H+P3Fcpb4Jf48s5E6grM1sr4Qw==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr18243805wre.380.1631009506860;
        Tue, 07 Sep 2021 03:11:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l16sm8117637wrh.44.2021.09.07.03.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 03:11:46 -0700 (PDT)
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
 <f572aca2-167a-be26-d89a-810c7023092f@linaro.org>
 <DB8PR04MB67953613ED725D00027E972BE6D29@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2ab0b16d-5a22-2abe-e228-c058b5a853ff@linaro.org>
Date:   Tue, 7 Sep 2021 11:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67953613ED725D00027E972BE6D29@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,


On 06/09/2021 09:58, Joakim Zhang wrote:
> 
> Hi Srinivas,
> 
>> -----Original Message-----
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Sent: 2021年9月3日 20:38
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; Rob Herring
>> <robh@kernel.org>
>> Cc: shawnguo@kernel.org; kernel@pengutronix.de; dl-linux-imx
>> <linux-imx@nxp.com>; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
>> property
>>
>> Hi Joakim,
>>
>> On 18/08/2021 08:54, Joakim Zhang wrote:
>>>
>>>> -----Original Message-----
>>>> From: Rob Herring <robh@kernel.org>
>>>> Sent: 2021年8月18日 3:58
>>>> To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>; shawnguo@kernel.org;
>>>> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
>>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
>>>> property
>>>>
>>>> On Wed, Aug 11, 2021 at 11:16:49AM +0100, Srinivas Kandagatla wrote:
>>>>>
>>>>>
>>>>> On 10/08/2021 08:35, Joakim Zhang wrote:
>>>>>> Introduce "reverse-data" property for nvmem provider to reverse buffer.
>>>>>>
>>>>>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>>>> b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>>>> index b8dc3d2b6e92..bc745083fc64 100644
>>>>>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>>>>> @@ -61,6 +61,11 @@ patternProperties:
>>>>>>                   description:
>>>>>>                     Size in bit within the address range specified by
>> reg.
>>>>>> +      reverse-data:
>>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>>> +        description:
>>>>>> +          Reverse the data that read from the storage device.
>>>>>> +
>>>>>
>>>>> This new property is only going to solve one of the reverse order
>>>>> issue here.
>>>>> If I remember correctly we have mac-address stored in various formats ex:
>>>>> from old thread I can see
>>>>>
>>>>> Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped)
>>>>> Type
>>>>> 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so
>>>>> on)
>>>>> (Swapped/non-Swapped)
>>>>> Type 3: Is the one which stores mac address in Type1/2 but this has
>>>>> to be incremented to be used on other instances of eth.
>>>>> Type 4: Octets as bytes/u8, swapped/non-swapped
>>>>>
>>>>> I think its right time to consider adding compatibles to nvmem-cells
>>>>> to be able to specify encoding information and handle post processing.
>>>>
>>>> Yes. Trying to handle this with never ending new properties will end
>>>> up with a mess. At some point, you just need code to parse the data.
>>>
>>> Thanks, Rob.
>>>
>>> Hi Srinivas,
>>>
>> Firstly Sorry for taking so long to reply as I was on vacation.
>>
>>> Do you plan to implement it?
>>
>> No, Am not planning to do this. But am happy to walk-thru the ideas that I
>> have.
>>
>>>
>>> Or need me follow up? If yes, please input your insights to point me how to
>> work for it.
>>
>> Do we have some kind of meta data/information in nvmem memory to indicate
>> the storage encoding?
> 
> No, none of these.
> 
>> Am I correct to say that this is only issue with mac-address nvmem cell?
> 
> I think, yes.
>   
>> Irrespective of where this encoding info comes from we have 2 options.
>>
>> Option 1: Add callback to handle mac-address post-processing with in the
>> provider driver.
> 
> Sorry, I am not very familiar with nvmem framework, what's this "callback" mean?
> Do you also want to introduce a common callback for different vendor drivers to
> work for mac-address post-processing? Extend the " struct nvmem_config"?
> 
>> Pros:
>> - It can deal with vendor specific non-standard encodings, and code is mostly
>> with-in vendor specific nvmem provider driver and bindings.
>> - will keep nvmem core simple w.r.t handling data.
>>
>> Cons:
>> - provider driver implement callback and new bindings.
>> - might need to add a nvmem-cell-type binding to be able differentiate the cell
>> types and handle post-processing.
> 
> Ahhh, I am not quite understand how to implement for it? Could you please give some
> draft hints?
> 
> If we extend the struct nvmem_config, add a callback to handle mac address, how can we
> determine which is the mac-address device node? There is no device node info from .reg_read
> callback.


I have pushed some nvmem core patches which are just compile tested to 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=topic/post-processing

This should provide the callback hook I was talking about.

Can you take a look at them and let me know if it works for you.

I have also added some test changes to imx provider driver as well, 
which you might have to take a closer look to get it working.

You need to look at adding/changing two things:

1. setting reverse_mac_address flag in imx driver.
	Does IMX always has mac-address reversed? if yes then we do not need 
any new bindings for imx nvmem provider, if no we might need to add some 
kind of flag to indicate this.

2. In imx devicetree for mac-address nvmem cell make sure you add

cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;




> 
>> Option 2: nvmem core handles the post processing.
>>
>> Pros:
>> - provider driver does not need to implement callbacks
>>
>> Cons:
>> - We have to find a way to define vendor specific non-standard encoding
>> information in generic bindings which is going to be a challenge and high chance
>> of ending up in to much of clutter in generic bindings.
>>
>> Finally, The way I look at this is that once we start adding post-processing in
>> nvmem core then we might endup with code that will not be really used for
>> most of the usecases and might endup with cases that might not be possible to
>> handle in the core.
>>
>>
>> Does Option 1 work for you?
> 
> Yes, I also prefer to implement it in specific driver, as you mention above, these code are for
> very rarely use cases.
> 
> If we chose Option 1, I want to implement it totally in specific driver(imx-ocotp.c), and I have a draft,
> could it be acdeptable?
Yes, this is the direction, however we need a proper callback to do 
this. And offset information is still comes from Device tree.


Have a look at the patches pushed into topic/post-processing branch.

--srini
> 
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -76,6 +76,8 @@
>   #define IMX_OCOTP_WR_UNLOCK            0x3E770000
>   #define IMX_OCOTP_READ_LOCKED_VAL      0xBADABADA
> 
> +#define IMX_OCOTP_MAC_MAX              0x2     /* The maximum numbers of MAC instance */
> +
>   static DEFINE_MUTEX(ocotp_mutex);
> 
>   struct ocotp_priv {
> @@ -93,11 +95,18 @@ struct ocotp_ctrl_reg {
>          u32 bm_rel_shadows;
>   };
> 
> +struct mac_config {
> +       u32 offset;
> +       u32 size;
> +       bool reverse_byte;
> +};
> +
>   struct ocotp_params {
>          unsigned int nregs;
>          unsigned int bank_address_words;
>          void (*set_timing)(struct ocotp_priv *priv);
>          struct ocotp_ctrl_reg ctrl;
> +       struct mac_config mac[IMX_OCOTP_MAC_MAX];
>   };
> 
>   static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
> @@ -211,6 +220,20 @@ static int imx_ocotp_read(void *context, unsigned int offset,
>          }
> 
>          index = offset % 4;
> +
> +       /* Handle MAC address reverse byte if required */
> +       for (i = 0; i < IMX_OCOTP_MAC_MAX; i++) {
> +               if (offset == priv->params->mac[i].offset &&
> +                   bytes == priv->params->mac[i].size &&
> +                   priv->params->mac[i].reverse_byte) {
> +                       u8 *org = &p[index];
> +                       int j;
> +
> +                       for (j = 0; j < bytes/2; j++)
> +                               swap(org[j], org[bytes-j-1]);
> +               }
> +       }
> +
>          memcpy(val, &p[index], bytes);
> 
>   read_end:
> @@ -556,6 +579,12 @@ static const struct ocotp_params imx8mp_params = {
>          .bank_address_words = 0,
>          .set_timing = imx_ocotp_set_imx6_timing,
>          .ctrl = IMX_OCOTP_BM_CTRL_8MP,
> +       .mac[0].offset = 0x90,
> +       .mac[0].size = 6,
> +       .mac[0].reverse_byte = true,
> +       .mac[1].offset = 0x96,
> +       .mac[1].size = 6,
> +       .mac[1].reverse_byte = true,
>   };
> 
>   static const struct of_device_id imx_ocotp_dt_ids[] = {
> 
> 
> Best Regards,
> Joakim Zhang
> 
