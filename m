Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7F3A401A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFKKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFKKWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:22:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:20:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l2so5478489wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XfgBfzFvsPdgrcJj8hm266ct8iEuijNJFoCqNb4usnY=;
        b=gCbp8nRl+F81Q8+Gw5TMV8g8i5VVIQZ9utDBRHgUwkcjHBTk/X+NRYc70kXI4G5krO
         i/iM6+Wqeb2luua2cG5mynHq6uOVl2yTe5gyLhPV0EYnaRiUpUqoHXNH9j1j6mF62Oib
         WEJU5YtrTv1j+COQPOPXxPs6naKEZwfcNFgrLg2y5gRTSGoNGwAW2RUGvgNTU/2Qz/R1
         1MkOgM+DpSZtcvH1oU1OexPZJ69UJvisRGEhh4a9g7233drhQXVD5eiaRzZqyaVJKcP0
         hNbwn7PRLbuv/jo7QnBCiErpoSlWHXPaShCovBII//8rsn88sksZBfpqjxjKE/9g7VRD
         cwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XfgBfzFvsPdgrcJj8hm266ct8iEuijNJFoCqNb4usnY=;
        b=D9pU+vXXU1/sepE8tZkJBFPyeyDI8VGwvv5NPsjo/hB8d0gwyJksWSDxHIs+3ADwj+
         DkaLs4ujSFMMYecjzXS1M6WkilBlGJV4CKA1ZDB72A80uj8IQevMcFM9cEJoKX6yLD2J
         0IbGW1cXOnZz3TklN51m0uTW/TivuBZsCUZLWSAW9Rb44sRLwGyjgZALNUjY0JyFTb5b
         cXmcscPLPyt0ofuPU40q5zH5KeQsv1bES6+0PO5itTxIKbZOJ/ZwrzqV8CQc7ne02fdp
         YMxZ7CfxDfOl1tlSD+laGIALxkGnOlo9jZYPCNbuomBxFfNbkmyIbkPApVEYLlYuX5J+
         QmdA==
X-Gm-Message-State: AOAM530hy82xjsp0avwp/ibs12Lmx6EhebG/T1qJKciXnXMel9MkNmu7
        3k3f59hB3cyaFXpsf0Br6J2VcA==
X-Google-Smtp-Source: ABdhPJxaS5lsSbOM25zwxrZvsnsRIMq1rflF6qJyp9P1CceK8i3D7IK0RJ4JCAkyjuoYgKW55Uariw==
X-Received: by 2002:a5d:6485:: with SMTP id o5mr3168607wri.91.1623406817882;
        Fri, 11 Jun 2021 03:20:17 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n42sm11797472wms.29.2021.06.11.03.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 03:20:17 -0700 (PDT)
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
 <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
 <YMMqPlknDF+k466x@kroah.com> <YMMwteJ5XvDST+zH@kroah.com>
 <7bd13064-8a50-2723-4ebe-d4ff7563c199@wanadoo.fr>
 <YMM4O2HEN9D8mJv9@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <85b5c0a9-945b-9d5e-9e56-0704d541438c@linaro.org>
Date:   Fri, 11 Jun 2021 11:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMM4O2HEN9D8mJv9@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 11:17, Greg KH wrote:
> On Fri, Jun 11, 2021 at 12:10:58PM +0200, Marion & Christophe JAILLET wrote:
>>
>> Le 11/06/2021 à 11:45, Greg KH a écrit :
>>> On Fri, Jun 11, 2021 at 11:17:50AM +0200, Greg KH wrote:
>>>> On Fri, Jun 11, 2021 at 10:05:40AM +0100, Srinivas Kandagatla wrote:
>>>>>
>>>>> On 11/06/2021 09:56, Greg KH wrote:
>>>>>> On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
>>>>>>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>>>
>>>>>>> 'ret' is known to be 0 here.
>>>>>>> The expected error status is stored in 'status', so use it instead.
>>>>>>>
>>>>>>> Also change %d in %u, because status is an u32, not a int.
>>>>>>>
>>>>>>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>>>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>>> ---
>>>>>>>     drivers/nvmem/sprd-efuse.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>>>>>>> index 5d394559edf2..e3e721d4c205 100644
>>>>>>> --- a/drivers/nvmem/sprd-efuse.c
>>>>>>> +++ b/drivers/nvmem/sprd-efuse.c
>>>>>>> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>>>>>>>     	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>>>>>>>     	if (status) {
>>>>>>>     		dev_err(efuse->dev,
>>>>>>> -			"write error status %d of block %d\n", ret, blk);
>>>>>>> +			"write error status %u of block %d\n", status, blk);
>>>>>> Shouldn't this be %pe and not %u?
>>>>> This is not error pointer its status value read back from a register.
>>>>>
>>>>> I think %u should be good here.
>>>> Argh, you are right, my fault.  For some reason I thought this worked
>>>> for integers as well.  Don't we have such a printk modifier somewhere to
>>>> turn error values into strings?  Let me dig...
>>> Ah, errname() will do it.
>>>
>>> Looks like no one uses it, so nevermind, sorry for the noise.  I'll go
>>> apply this one now.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi,
>>
>> errname() depends on CONFIG_SYMBOLIC_ERRNAME.
>> Is this widely used?
> 
> It is set by default if you enable CONFIG_PRINTK
> 
>> If not, using errname() directly would loose the error code.
>> (note that %pe already deals with it)
>>
>> Dan Capenter already spoke about a potential %e extension, but I don't think
>> anyone did anything yet.
> 
> That would be a fun and simple beginner task for someone to do.  Maybe
> I'll mention it to this new round of interns that have just started...

There seems to be some work on this side in the past.

http://lkml.iu.edu/hypermail/linux/kernel/1309.2/01027.html

This should be a good starting point.


--srini
> 
> thanks,
> 
> greg k-h
> 
