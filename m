Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7B3A3EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFKJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:13:00 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:46032 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:12:59 -0400
Received: by mail-wm1-f51.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so8041579wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NX126hpMiyEKZfg/tNYE1IRnANTVXUNFh6dD86kPlIo=;
        b=bSHjZKljwlAaS/yHFGviWarTCTvsGDM4kVmAWVf1eKrDgedt+sSXGKNc1qAHRrqXhC
         h4PGorAMQrzvS4qihU0ijRSsh0pekd8nMmUXOjtvRF78zknCh6S6pCuXqC7MLK2oRX7W
         vVjK9xyNj1+WAocnfD4aAogg7boMoYvcdtbsJZEH3Vvyw+pHMrQCkydyGjr3tWXtlGnI
         X8B7aLcfaIkKQBIf24yBMHBse75CIspGGUudp2qN5o4fMzrBxUVebgpsRCorbMd6qFFC
         rFcHiMthBdDnTLR/+Wf7klZObbuoEXpMYClBBn0qnLM8g7l9DExmG3VL7Vxs3TAwCr/E
         RrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NX126hpMiyEKZfg/tNYE1IRnANTVXUNFh6dD86kPlIo=;
        b=NmSDSNVR0+XleljbhxeMqD+uCfbvgoy1bagDE2R7KImMNsViW12eiFcgfL6Hr1UQ02
         AOuugcYVucUt+Bhk1wILj8DkTrmk9hdCsrDgIwuONb2ksxStYe5ZUVWyyuWvbG1JFWER
         NO8TZZiZnRYSFwQBwz5NYz4dCWXeSMmK2zODUCCGKZwT2EX00UwWDckQEzxZ9XjUgfyv
         IHVBJQOt9iFp1zV4fEW7KCs3eoqYhQ/7axIPSXlJfb4nMSC6GSAQ01fl7OR+cp3a8+bu
         7zsgo6SNn8+Y3Xw/oktDzTn6F5AT0Nghaw2479zRKcoUgAg6CvVGYrwTVYLow69Aez33
         bxvw==
X-Gm-Message-State: AOAM5301FiUzkedNjF9TivVwJVjGs+BdTT5bmBo5PpMiNYNWENxUzwuR
        aoVh4qDmlO5TzHfhOf0rTHnN997MpLFvuA==
X-Google-Smtp-Source: ABdhPJy7pDNUJPfeN6V7JNTBPefnkBnCfPZTF7lXBcg2T4h4pl2uICwfmMUi4ASHnHdWwCzafhsp7g==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr5786398wmp.77.1623402588114;
        Fri, 11 Jun 2021 02:09:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n20sm5412135wmk.12.2021.06.11.02.09.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:09:47 -0700 (PDT)
Subject: Re: [PATCH 1/9] nvmem: sprd: Add missing MODULE_DEVICE_TABLE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bixuan Cui <cuibixuan@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-2-srinivas.kandagatla@linaro.org>
 <YMMk7dr1dKyO1JyZ@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3d7d67fe-f8cf-e4dc-4839-beb64418c1f4@linaro.org>
Date:   Fri, 11 Jun 2021 10:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMMk7dr1dKyO1JyZ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 09:55, Greg KH wrote:
> On Fri, Jun 11, 2021 at 09:33:40AM +0100, Srinivas Kandagatla wrote:
>> From: Bixuan Cui <cuibixuan@huawei.com>
>>
>> This patch adds missing MODULE_DEVICE_TABLE definition which generates
>> correct modalias for automatic loading of this driver when it is built
>> as an external module.
>>
>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/sprd-efuse.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>> index 59523245db8a..5d394559edf2 100644
>> --- a/drivers/nvmem/sprd-efuse.c
>> +++ b/drivers/nvmem/sprd-efuse.c
>> @@ -425,6 +425,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
>>   	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
>>   	{ }
>>   };
>> +MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);
> 
> Why is this needed?  Do you have reports of this module not being
> properly auto-loaded?
> 
> I have been rejecting these types of patches from the "Hulk Robot" as
> they were just blindly going through the tree and not determining if
> this actually is a thing that needed to be fixed.

I will keep that in mind and I guess we can drop these 3 patches for now 
until someone reports the real issue.

--srini

> 
> Also, if it is a real fix, shouldn't it also go to the stable kernel
> trees?  If so, you didn't mark it as such :(
> 
> thanks,
> 
> greg k-h
> 
