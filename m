Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF644036D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351360AbhIHJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351317AbhIHJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:23:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CCC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 02:21:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so2199383wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nS+TQNLnq4FEJNrW462G2s7CfEi1/BnWJvgcmlinvMw=;
        b=nfUnMZ6OHC8ke4ASEgy8gCYfmyYVY7nHJM9+N/qgyof697LSufnCRly45AJOTSJxUI
         0JNGACYMzb8cvQhpbCrBki/HHmxN3S3hFc1jFZ3qG4iHWrus+Gho2aWfUaDRh+E3kenj
         vckSHv46/ixlOyXU0m7GwfwglB+LuhAo1Aw88j2MAOQReZyLb4R6Rg68/fkk7ZVRBzUU
         agYXC0oJ8OR3rgGhPwFN2G6qyngDhWQcxHISyMeOT6n+4eL6SrJZf2ZY8hP9v4CUXC9h
         sggL2EGcXH75bNrCtClJstqPBIl2uw0CmNIhebrQQeC9ZoseIKP+dv70eP3VDrX90NaS
         5B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nS+TQNLnq4FEJNrW462G2s7CfEi1/BnWJvgcmlinvMw=;
        b=W0y8nXZe0U13P+BrnIi0E2LnBnunNDwIlpuP9CeTN/JsKb/x/iTxt5k8VRKiyHrGaK
         ZVJJAy/PcOtAaZuk6O0365V5hrwK85BvCIaUSz/a5DG8eDSpxT0L88GguhS9EvX0Zfb8
         NGTwS81zb0OXJz1G7m5A6woCgLK/vyt2Rl2CIauX2DI3U3M6OtuwU0lcXhhShENWAvyY
         7arN1pJSLE7+yjMIM2v/lB9ZYkoWhadlvRicUUTcB7fwBVKzxSJaJbXDlUsm/OT/JypS
         hTB/X+O6lifyMkdrbNY+9J17UBuulwrhggQDEksTu2gzp45s0bYlm+bB0F2+LVZjqbyA
         WLLQ==
X-Gm-Message-State: AOAM530y3zo5h9aeoY9TL1QA/7EUUfIymW0QKMQ2gW1SE1XnIgFVBRNQ
        OCAQZs3YPYk0DpFslkdP9Hn96htNrg9mIg==
X-Google-Smtp-Source: ABdhPJwFmMqQoutuscofX3SwHUNi2CAmgGuU86QFaa+fM4Ide7jf3GTZ3a4AvIIEToJFXpQg575F4A==
X-Received: by 2002:a5d:6cca:: with SMTP id c10mr2784271wrc.224.1631092914221;
        Wed, 08 Sep 2021 02:21:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k14sm1531223wri.46.2021.09.08.02.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 02:21:53 -0700 (PDT)
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
 <2ab0b16d-5a22-2abe-e228-c058b5a853ff@linaro.org>
 <DB8PR04MB6795046DC70B8238963C343AE6D49@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <a25379a9-621c-3fda-d933-9cc2d2fc706a@linaro.org>
 <DB8PR04MB679589EB203FAF1517FC4811E6D49@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b0e291e1-9b36-5f08-99d3-37b2d10ada12@linaro.org>
Date:   Wed, 8 Sep 2021 10:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB679589EB203FAF1517FC4811E6D49@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2021 09:57, Joakim Zhang wrote:
> 
> Hi Srinivas,
> 
>> -----Original Message-----
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Sent: 2021Äê9ÔÂ8ÈÕ 16:49
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; Rob Herring
>> <robh@kernel.org>
>> Cc: shawnguo@kernel.org; kernel@pengutronix.de; dl-linux-imx
>> <linux-imx@nxp.com>; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
>> property
>>
>>
>>
>> On 08/09/2021 08:14, Joakim Zhang wrote:
>>>
>>> Hi Srinivas,
>>>
>>> [...]
>>>> I have pushed some nvmem core patches which are just compile tested
>>>> to
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
>>>> .kern%2F&amp;data=04%7C01%7Cqiangqing.zhang%40nxp.com%7Cb8b85
>> eab6bc34
>>>>
>> 917b86e08d972a57dee%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
>> 7C6376
>>>>
>> 66877370588296%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
>> JQIjoiV2
>>>>
>> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=diFgK2ufOUK
>> eXwd
>>>> 0Ez8pCFjCUH8rXz5jfW7io8KDKmw%3D&amp;reserved=0
>>>>
>> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fsrini%2Fnvmem.git%2Flog%
>>>>
>> 2F%3Fh%3Dtopic%2Fpost-processing&amp;data=04%7C01%7Cqiangqing.zhan
>>>>
>> g%40nxp.com%7Cadfa3ba63c634937876308d971e7e71f%7C686ea1d3bc2b4c6
>>>>
>> fa92cd99c5c301635%7C0%7C0%7C637666063097239185%7CUnknown%7CT
>>>>
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
>>>>
>> XVCI6Mn0%3D%7C1000&amp;sdata=W9yAnGm9rYzlSZuAAGiN4VHUtKYUTt9S
>>>> oyGQ9QsY7fI%3D&amp;reserved=0
>>>>
>>>> This should provide the callback hook I was talking about.
>>>
>>> Thanks a lot! Yes, this could be more common, vendors can parse their
>>> mac address for different encoding style, also can extend for other cases.
>>
>> Yes, that is the idea,
>>>
>>>> Can you take a look at them and let me know if it works for you.
>>>
>>> There are some small issues need to be update:
>>> 1)
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kern
>> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fsrini%2Fnvmem.git%2Fcom
>> mit%2F%3Fh%3Dtopic%2Fpost-processing%26id%3D624f2cc99b48bbfe05c11e
>> 58fb73f84abb1a646e&amp;data=04%7C01%7Cqiangqing.zhang%40nxp.com%
>> 7Cb8b85eab6bc34917b86e08d972a57dee%7C686ea1d3bc2b4c6fa92cd99c5c3
>> 01635%7C0%7C0%7C637666877370598253%7CUnknown%7CTWFpbGZsb3d8e
>> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %7C1000&amp;sdata=APDzSbLob%2FRiZyyhU7VAhoUEAmSG95NsilQDQ53Hbf
>> A%3D&amp;reserved=0
>>> 	of_get_property() can't get the cell value, so I change to
>>> of_property_read_s32()
>>> 2)
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kern
>> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fsrini%2Fnvmem.git%2Fcom
>> mit%2F%3Fh%3Dtopic%2Fpost-processing%26id%3Da424302c7b15da41e1e8d
>> e56b0c78021b9a96c1e&amp;data=04%7C01%7Cqiangqing.zhang%40nxp.com
>> %7Cb8b85eab6bc34917b86e08d972a57dee%7C686ea1d3bc2b4c6fa92cd99c5c
>> 301635%7C0%7C0%7C637666877370598253%7CUnknown%7CTWFpbGZsb3d8
>> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %7C1000&amp;sdata=5E49DVzkpBVdkA4a%2B9tMXN%2B6k%2BG%2B3rQuVJ
>> qTUgdbmKU%3D&amp;reserved=0
>>> 	if (!nvmem->cell_post_process) {} should be if (nvmem->cell_post_process)
>> {}, if we have this callback, we need do the post-processing.
>>>
>> I have pushed these changes now to the branch.
>>
>>>> I have also added some test changes to imx provider driver as well,
>>>> which you might have to take a closer look to get it working.
>>>>
>>>> You need to look at adding/changing two things:
>>>>
>>>> 1. setting reverse_mac_address flag in imx driver.
>>>> 	Does IMX always has mac-address reversed? if yes then we do not need
>>>> any new bindings for imx nvmem provider, if no we might need to add
>>>> some kind of flag to indicate this.
>>>
>>> No, it's depend on how to program the effuse.
>>> To avoid introducing consumer property in devicetree, I prefer to move
>>> reverse_mac_address flag into ocotp_params struct, since each
>>> platforms has their own, it's easy to indicate this. I tried it, and
>>> works. >
>>
>> As long as provider can figure out how the efuse is programmed then it is fine
>> with me.
>>
>>
>>>> 2. In imx devicetree for mac-address nvmem cell make sure you add
>>>>
>>>> cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>>> Option 2: nvmem core handles the post processing.
>>>>>>
>>>>>> Pros:
>>>>>> - provider driver does not need to implement callbacks
>>>>>>
>>>>>> Cons:
>>>>>> - We have to find a way to define vendor specific non-standard
>>>>>> encoding information in generic bindings which is going to be a
>>>>>> challenge and high chance of ending up in to much of clutter in generic
>>>> bindings.
>>>>>>
>>>>>> Finally, The way I look at this is that once we start adding
>>>>>> post-processing in nvmem core then we might endup with code that will
>>>>>> not be really used for most of the usecases and might endup with
>>>>>> cases that might not be possible to handle in the core.
>>>>>>
>>>>>>
>>>>>> Does Option 1 work for you?
>>>>>
>>>>> Yes, I also prefer to implement it in specific driver, as you mention
>>>>> above, these code are for very rarely use cases.
>>>>>
>>>>> If we chose Option 1, I want to implement it totally in specific
>>>>> driver(imx-ocotp.c), and I have a draft, could it be acdeptable?
>>>> Yes, this is the direction, however we need a proper callback to do this. And
>>>> offset information is still comes from Device tree.
>>>>
>>>>
>>>> Have a look at the patches pushed into topic/post-processing branch.
>>>
>>> I have improved this patch set according above comments and tested it. Also
>> rebase to
>>> the nvmem/for-next branch.
>>>
>>> I plan to keep you as the nvmem part author and send out this patch set with
>> dts changes. If it's fine for you?
>>
>> Yes please, can you pick the new patches from the branch before you send
>> the series out.
> 
> As you define the type variable is "int", so had better use of_property_read_s32(), instead if of_property_read_u32(), right?

We should probably make that u32, as we are not expecting any negative 
range.

I tried to fix this in new patches.

--srini
> 
> Best Regards,
> Joakim Zhang
> 
