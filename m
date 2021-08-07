Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716B03E3584
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhHGN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHGN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:26:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B4C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 06:26:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b11so14887329wrx.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Etnoc6nnWfJcIYwslUL+Pe0oROfutBM969yB6Z48UhI=;
        b=wBT0htqPdfYlPutk1soRDIinGh1NPljgTyFjB17PxtFMvdydl/sQISSvK+tLbmiQhS
         +M+wWYW0ivNN0ZOsddfOy4Eljv7ibUu9xG6mu1jbkh8FezbzRX7Vumwj5iVabv85eAgc
         er9HzeSWbFNSNUson7aB76I0F0qpJAwCuJ7o65qnvf/8sqpGdki7d3uxUv7vvmlgM7er
         jgyfR90TAYT9hLTnN5FjPlm8SRixCYSweqPKQwygdqDw+36cJkpH9PiEgZ7kaCwsD+7/
         0+GUSB7FbGIMCkiNmFnFXROyjR+fLjMSGIfXXYuyatlDiI4sd5dvJ9tXbPkepf4lm4kd
         p+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Etnoc6nnWfJcIYwslUL+Pe0oROfutBM969yB6Z48UhI=;
        b=RXZ16b3K7ZY+xkwL0C/XUZyPd5PF+bp7kmU1zqW5iMB4bX6Hr1VKLu6qwHaUn953NE
         dKp/kSqVq2aACrXM5vD0m34vLwAbwc7iZGJttzfVTFAROV0cuH64ZXeX6yBGQkgQMGRJ
         1cbeDTpuJBX1sXuZJnzh2P+X1hheNjdXyQ0z2UO91GF4E5EdBiXwfnt3LN4IGLkbdoaA
         j92GW2fUlIS9yGqWrvY4MSBGb7CUkWkVZxvlInaizV4VlY+3iF90oGYeMrWnFqWTlxR+
         W4vivFlYNMGqzeRntuuiAtaA7iZWMMdTaegbDlsNsav0ozis44x4RjpEqBYsmxXGJlqh
         A4kQ==
X-Gm-Message-State: AOAM530B4U66/5zXHrGS7sKS43xBZAORAdhTwVy9ga8gooxtNfe3rPRF
        DwT1NndoG4P1d1HrBpyy6UT6ElWjYgE9DA==
X-Google-Smtp-Source: ABdhPJxbcfJsM/vEXxGvVrnfh1kzkUzSWX75m1jkwbPfsq8yAVXxwI4t+tY0oqZuMkQO4tHyv3+N+A==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr16032228wrx.83.1628342773286;
        Sat, 07 Aug 2021 06:26:13 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w3sm11369936wmi.44.2021.08.07.06.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 06:26:12 -0700 (PDT)
Subject: Re: [PATCH 0/4] slimbus: patches (set 1) for 5.15
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
 <YQ03FPyxF8DFlwI7@kroah.com>
 <71200533-db05-157f-480a-d64812e1d9c2@linaro.org>
 <YQ6EMKD0gOIJn+FL@kroah.com>
 <e737f324-400e-824b-3865-017d2d2a5543@linaro.org>
 <YQ6F3GFJZClaF+QE@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <97b911ff-3fd6-45eb-81ec-01971e4c2741@linaro.org>
Date:   Sat, 7 Aug 2021 14:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQ6F3GFJZClaF+QE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2021 14:08, Greg KH wrote:
> On Sat, Aug 07, 2021 at 02:04:39PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 07/08/2021 14:01, Greg KH wrote:
>>> On Sat, Aug 07, 2021 at 11:48:48AM +0100, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 06/08/2021 14:20, Greg KH wrote:
>>>>> On Fri, Aug 06, 2021 at 10:16:35AM +0100, Srinivas Kandagatla wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Recently runtime pm testing on slimbus reveled that its
>>>>>> totally broken on SlimBus ngd drivers.
>>>>>>
>>>>>> Below are the fixes to get it back working.
>>>>>>
>>>>>> - One of the reason begin incorrect device pointer used for
>>>>>> runtime pm and in some places
>>>>>>
>>>>>> - Second one was to do with unable to validate transaction id
>>>>>>     which resulted in negative runtime pm count.
>>>>>>
>>>>>> - Other fix was to do with resetting dma addresses once ngd
>>>>>> controller is power-cycled.
>>>>>>
>>>>>> With all these fixed runtime pm is now fully functional on NGD
>>>>>> controllers.
>>>>>>
>>>>>> Currently I marked them all with Cc: <stable@vger.kernel.org>
>>>>>> as these all patches are required to fix runtime pm on SlimBus
>>>>>> NGD controller.
>>>>>>
>>>>>> Can you please queue them up for 5.15.
>>>>>
>>>>> Why do you want these for 5.15-rc1 when you need them to fix problems in
>>>>> 5.14?  Shouldn't they go into 5.14-final?
>>>>
>>>> Yes, these should go to other stable trees aswell.
>>>> I assumed that Fixes tag will automatically backport those patches.
>>>
>>> Yes, but that can not happen until they hit Linus's tree, which would
>>> not be until 5.15-rc1.  Do you want to delay until that long from now?
>>>
>>> How about splitting this into 2 patch series, one that you want to see
>>> get into 5.14-final, and one for 5.15-rc1.
>>
>> All the patches in these series are fixes so the can go to 5.14-final.
> 
> Then why did you say originally that you wanted them in 5.15?

TBH, I tend to send out SlimBus and nvmem patches only once around 
rc5-rc6 time which also includes some minor fixes, and you normally 
apply them for next rc1 release.

In this particular case I should have explicitly said to pick them up 
for 5.14 next rc.

Do you want me to resend them with proper cover letter? or are you okay 
to take them as they are?

>  > confused,

My Bad, I will be careful with my wording next time around.

thanks,
--srini
> 
> greg k-h
> 
