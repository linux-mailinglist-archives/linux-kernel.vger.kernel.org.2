Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283B03A3FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhFKKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:11:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:09:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m3so2552851wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6/L+hVgnl08iS1Yjwr/Jr2LVCtU5B5E/MhsxQ+oOWLg=;
        b=kZux87wYetWkgAEVmMib+LvupSB3/ictTWJtSuntNnb3gB6qvdvouuH6sm+zZlBALD
         ljacH1jFGw25PFCbzCejBseU6KNmfMoVHDqPHiKFSdlUWl4QKv/Z8oyGOqj4uEybEtvj
         +faFNIEvZtHRe1kWH/kLTrbOh6u6Rkjfkhj6/gXXyQ911pvZh5bC0nMUFgAtUM3IyghE
         jNHbV4umwHjuh7t7wEw5j/VmDbqp5yi/dKaBUnnaln+BKalL2xo92KIHDvzK7aW3to/z
         1WfffI6gyBAIBIcUoAJAwFjU488AVziF2zHoy7MiC8Ckln4iXGz/2RmXU757y2u8pzjk
         OxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/L+hVgnl08iS1Yjwr/Jr2LVCtU5B5E/MhsxQ+oOWLg=;
        b=EH+gFBZ/XLImDAliFK34T1L4SFzYNtA67rUldG2XN/YkpYYTLm7CnXHViTXLnAYu8J
         bP/JJkEswGjoIx75CLl1o41UkSbNW+sjKyOBg9dnU4eTWkNDC3q8gwZFV80MMW7fJmN0
         sVXP9omFIv0wT6GRSdyG6e+5Sf0Mi3UeTDYQI0+McAVxakbCKuHG8Qtn7XvLO6ISE65E
         DspvmgmjkJ+eNvnbfa/02J+JZw3o4nKYNKsBz8eLDQmIaYsCHdvZ1a+pkCzaJkdh5tMG
         +Xwh1foCLjw3YE0vRORAmLd4pXrOfBnf0pvtPzYMeOvnoYajmT3KCLp5PvnwHQZrnzxr
         MvHQ==
X-Gm-Message-State: AOAM530ACjmITOrJyPp38eHY2lfMEWa+LxNAiqofewj5rSy8UvLk+3FG
        ERS/xcjX963sRkwjLVqltdcqxQ==
X-Google-Smtp-Source: ABdhPJzDkuduCR16W8hwvg6WeU6xqW5vr3Di4m86iIZg7lD9Dt4WaWd5/iq/Y+CJ5I1VKCXoA46QPA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr19284109wmg.19.1623406172729;
        Fri, 11 Jun 2021 03:09:32 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id v132sm13082277wmb.14.2021.06.11.03.09.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 03:09:32 -0700 (PDT)
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
 <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
 <YMMqPlknDF+k466x@kroah.com> <YMMwteJ5XvDST+zH@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ddd9e8d3-e2dd-fa22-61d3-20c66d4815c5@linaro.org>
Date:   Fri, 11 Jun 2021 11:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMMwteJ5XvDST+zH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 10:45, Greg KH wrote:
> On Fri, Jun 11, 2021 at 11:17:50AM +0200, Greg KH wrote:
>> On Fri, Jun 11, 2021 at 10:05:40AM +0100, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 11/06/2021 09:56, Greg KH wrote:
>>>> On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
>>>>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>
>>>>> 'ret' is known to be 0 here.
>>>>> The expected error status is stored in 'status', so use it instead.
>>>>>
>>>>> Also change %d in %u, because status is an u32, not a int.
>>>>>
>>>>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>    drivers/nvmem/sprd-efuse.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>>>>> index 5d394559edf2..e3e721d4c205 100644
>>>>> --- a/drivers/nvmem/sprd-efuse.c
>>>>> +++ b/drivers/nvmem/sprd-efuse.c
>>>>> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>>>>>    	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>>>>>    	if (status) {
>>>>>    		dev_err(efuse->dev,
>>>>> -			"write error status %d of block %d\n", ret, blk);
>>>>> +			"write error status %u of block %d\n", status, blk);
>>>>
>>>> Shouldn't this be %pe and not %u?
>>>
>>> This is not error pointer its status value read back from a register.
>>>
>>> I think %u should be good here.
>>
>> Argh, you are right, my fault.  For some reason I thought this worked
>> for integers as well.  Don't we have such a printk modifier somewhere to
>> turn error values into strings?  Let me dig...
> 
> Ah, errname() will do it.
> 
Thanks for looking this up,
looks like errname is more of stringfy rather than translating it in to 
proper description like strerror() does.

It would do something like:
  errname(EIO) -> "EIO"
  errname(-EIO) -> "-EIO"


> Looks like no one uses it, so nevermind, sorry for the noise.  I'll go
> apply this one now.


Noticed that It does not apply to your tree, I will resend it along with 
other patch.


thanks,
srini
> 
> thanks,
> 
> greg k-h
> 
