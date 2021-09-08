Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972A9403654
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbhIHIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbhIHIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:50:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639BC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:48:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so773625wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBaw+0MEZmNz/V4WGI1nWGa5bDvasKJPyvcySVos4iY=;
        b=f8pEDk1KCMoBI8uo44LOs9m+S700RyuWBsUfhA5ao0xZjgt9FdyHuuwxoabYm6ZFlA
         fbLadZeTYJl4cgcxjT+n2SN2u8WPhyz9ZpcVNiadAVUkJSgkwL7NIcujdcFyhAaSWIUr
         JjiEFf+0d0dOZboFIhoete1wz8i6ARjCSasKQZsrTt4AQAcnOyGxn1NsVMJmjcDwo/3l
         OIOJLFoxwF7MqnpQspJRwYiK8d9TA0RqF2lz3DxQVGxCRMsmWo04A27FeJMuTzV/7aex
         pTfQjLlKSt+PifB+1CwjVt8WBvYGvho0BjHnyhtUVSqX4Fwn3p/GZ/NGZEpVTdn0KeK6
         N/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBaw+0MEZmNz/V4WGI1nWGa5bDvasKJPyvcySVos4iY=;
        b=Mgij/Tv5bWPrJf7naQC0WCPGcmv9hHq4ysIz3wQjtozYYhHSAX3I+3vxWCCyWCNogE
         rqLiB5opQn7Dd9KWe/12IFMQBv9NJHh5ew7VbbW3IzQjmiE7dS3nkmyXw05TkU3IBl1b
         cuuucFSQ7V3wyMwqV0OYa4gqorkQLb7FYbNViP/fVCf4REUPBvlFs5hxIvjESLttOZSK
         CfCXeA1ZDamVuVbEdFSst11gQsqhPNIdQh1ju9DYWU2xHTphFCax0nZtyqcSDYhlIy9p
         gxoR7USI6x3Hxk09B5z3joaln41HP3f2TfRqb1le7CCrnR2AQIcUqKUde3oKsobwMSvU
         1w4g==
X-Gm-Message-State: AOAM533oy6oAJUdBLC/yEPSApF99gMAhMJjV/SEaDeLLoe1Wsqt0KMbd
        hlL9sjxhjlzVZMWk9f9mQyhwqHfQMIpi5Q==
X-Google-Smtp-Source: ABdhPJwvWo1Vu0ZqcZOVxw2kzcCOELSArjlRsp6vSZV3kmdap68l4Gv7YrJEIXdkNGjugy1lo18+FQ==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr2373787wml.45.1631090935107;
        Wed, 08 Sep 2021 01:48:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id d8sm1544895wrv.20.2021.09.08.01.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 01:48:54 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a25379a9-621c-3fda-d933-9cc2d2fc706a@linaro.org>
Date:   Wed, 8 Sep 2021 09:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795046DC70B8238963C343AE6D49@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2021 08:14, Joakim Zhang wrote:
> 
> Hi Srinivas,
> 
> [...]
>> I have pushed some nvmem core patches which are just compile tested to
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kern
>> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fsrini%2Fnvmem.git%2Flog%
>> 2F%3Fh%3Dtopic%2Fpost-processing&amp;data=04%7C01%7Cqiangqing.zhan
>> g%40nxp.com%7Cadfa3ba63c634937876308d971e7e71f%7C686ea1d3bc2b4c6
>> fa92cd99c5c301635%7C0%7C0%7C637666063097239185%7CUnknown%7CT
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
>> XVCI6Mn0%3D%7C1000&amp;sdata=W9yAnGm9rYzlSZuAAGiN4VHUtKYUTt9S
>> oyGQ9QsY7fI%3D&amp;reserved=0
>>
>> This should provide the callback hook I was talking about.
> 
> Thanks a lot! Yes, this could be more common, vendors can parse their mac
> address for different encoding style, also can extend for other cases.

Yes, that is the idea,
> 
>> Can you take a look at them and let me know if it works for you.
> 
> There are some small issues need to be update:
> 1) https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=topic/post-processing&id=624f2cc99b48bbfe05c11e58fb73f84abb1a646e
> 	of_get_property() can't get the cell value, so I change to of_property_read_s32()
> 2) https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=topic/post-processing&id=a424302c7b15da41e1e8de56b0c78021b9a96c1e
> 	if (!nvmem->cell_post_process) {} should be if (nvmem->cell_post_process) {}, if we have this callback, we need do the post-processing.
> 
I have pushed these changes now to the branch.

>> I have also added some test changes to imx provider driver as well, which you
>> might have to take a closer look to get it working.
>>
>> You need to look at adding/changing two things:
>>
>> 1. setting reverse_mac_address flag in imx driver.
>> 	Does IMX always has mac-address reversed? if yes then we do not need
>> any new bindings for imx nvmem provider, if no we might need to add some
>> kind of flag to indicate this.
> 
> No, it's depend on how to program the effuse.
> To avoid introducing consumer property in devicetree, I prefer to move reverse_mac_address
> flag into ocotp_params struct, since each platforms has their own, it's easy to indicate this. I tried
> it, and works. >

As long as provider can figure out how the efuse is programmed then it 
is fine with me.


>> 2. In imx devicetree for mac-address nvmem cell make sure you add
>>
>> cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>>
>>
>>
>>
>>>
>>>> Option 2: nvmem core handles the post processing.
>>>>
>>>> Pros:
>>>> - provider driver does not need to implement callbacks
>>>>
>>>> Cons:
>>>> - We have to find a way to define vendor specific non-standard
>>>> encoding information in generic bindings which is going to be a
>>>> challenge and high chance of ending up in to much of clutter in generic
>> bindings.
>>>>
>>>> Finally, The way I look at this is that once we start adding
>>>> post-processing in nvmem core then we might endup with code that will
>>>> not be really used for most of the usecases and might endup with
>>>> cases that might not be possible to handle in the core.
>>>>
>>>>
>>>> Does Option 1 work for you?
>>>
>>> Yes, I also prefer to implement it in specific driver, as you mention
>>> above, these code are for very rarely use cases.
>>>
>>> If we chose Option 1, I want to implement it totally in specific
>>> driver(imx-ocotp.c), and I have a draft, could it be acdeptable?
>> Yes, this is the direction, however we need a proper callback to do this. And
>> offset information is still comes from Device tree.
>>
>>
>> Have a look at the patches pushed into topic/post-processing branch.
> 
> I have improved this patch set according above comments and tested it. Also rebase to
> the nvmem/for-next branch.
> 
> I plan to keep you as the nvmem part author and send out this patch set with dts changes. If it's fine for you?

Yes please, can you pick the new patches from the branch before you send 
the series out.

--srini
>    
> Best Regards,
> Joakim Zhang
> 
