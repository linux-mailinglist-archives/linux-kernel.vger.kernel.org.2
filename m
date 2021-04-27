Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE636C9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhD0RCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhD0RCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:02:36 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD21C061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:01:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e186so7258207iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b876UjohryLnLBt0sbG3B3eADOVObhbRmCe7rh9+yis=;
        b=kJ781N0stR3fbOoEfL8BVyV0JoqpgRqoee8zXAvnuQiFwi9eKXkxTzkyxuvf7k7sFn
         uxYHcbB0x40BwB58jsZydILvOV7LH6oxNrdIGa38/hPIGLpgMlGidQ+Hve6G5FFGZh5O
         03jbFPVwhcVxQggc0jivXKFfYdsmwFS3M/L2YXVvKvxPStdLZN7bkvjJMQB9SoOLN+eR
         WfJrTz5BArKTDwDJGht7rpqx3uvEYzU2B/DOBW2hH0cyY7AAe9fmubRxes4NyWMoMD8u
         izHoS/dKQ6y/wZj5s7pqwEncFbcULmSDaMEKb/R+UQ9yrkqPza6BhQgtLFk0X/1w4RPB
         lQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b876UjohryLnLBt0sbG3B3eADOVObhbRmCe7rh9+yis=;
        b=EKKAPc6cb8iLYGiXhe+zJq63Tf+kWWDYERfa9ZJA/ktkiB6uT0rUggy7qCgjZxtWxw
         ORmAuADFNqtzlnHSap5MLgo44WyYBv9C0nZVokreTu9E4QnpE2cH3K4hcd4B4DopsRIH
         5nBGeiZESydnQhG7PlONlX2ZD+/XkRzUXdrpIxkDT9EIpAvcnwM5zL7OUdrx70+32TMz
         0lwErjtMOpq6eIq/EivodPmXi1NAcAmljahYO69YMxMJtz3VmF5IMqWiDcjwJQso6JZM
         9fopRpni9zjEAVXQt2DmUpJEA77rQeoAD8BUFdYYLqdZx6EFCAy3JH+g8l4RJrj8Mj+1
         uSGQ==
X-Gm-Message-State: AOAM533gVmMH8lDawbHCPYIX09MSmIuKNQPoHEnZXBVAXqAF3qllvGpd
        mybQPNDGP/YhfkyctfQ6v3qDrQ4Ek/5wkA==
X-Google-Smtp-Source: ABdhPJxP/aqFNihV/FAJZbWDiJDmDW/36R7RFcxmn945cuRF7pBrZdt6QLOLGiwb4jk1tIygN2CT5g==
X-Received: by 2002:a02:8308:: with SMTP id v8mr23049196jag.143.1619542911177;
        Tue, 27 Apr 2021 10:01:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v26sm181930ioh.42.2021.04.27.10.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 10:01:50 -0700 (PDT)
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk> <YIgLIscB1I8MxkWP@kroah.com>
 <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
 <e2ee4904-b13b-fd75-7066-d28e5a7ca711@kernel.dk> <YIg34SBa78u3KMNH@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81445991-8217-57e5-509d-4a6ea59afb9f@kernel.dk>
Date:   Tue, 27 Apr 2021 11:01:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIg34SBa78u3KMNH@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 10:12 AM, Greg KH wrote:
> On Tue, Apr 27, 2021 at 08:39:15AM -0600, Jens Axboe wrote:
>> On 4/27/21 8:03 AM, Peter Rosin wrote:
>>> On 2021-04-27 15:01, Greg KH wrote:
>>>> On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
>>>>> On 4/22/21 3:29 PM, Peter Rosin wrote:
>>>>>>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
>>>>>>
>>>>>> The reverted patch looks fishy.
>>>>>>
>>>>>> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
>>>>>> memory is kfree:d but the variable is NOT zeroed out.
>>>>>>
>>>>>> AFAICT, the above leads to a double-free on exit by the added line.
>>>>>>
>>>>>> I believe gd.cd_info should be kfree:d on remove instead.
>>>>>>
>>>>>> However, might not gc.toc also be kfree:d twice for similar reasons?
>>>>>>
>>>>>> I could easily be mistaken.
>>>>>
>>>>> >From taking a quick look the other day, that's my conclusion too. I
>>>>> don't think the patch is correct, but I don't think the surrounding code
>>>>> is correct right now either.
>>>>
>>>> Thanks for the review from both of you, I'll keep this commit in the
>>>> tree.
>>> Err, which commit is "this" and what tree are you keeping it in? I
>>> think you mean that you are keeping the revert in your tree with
>>> reverts, and not that you mean that we should keep the original
>>> commit in Linus' tree.
>>>
>>> In any case, I'd think that the original memory leak is somewhat
>>> better than the introduced double-free and therefore the revert
>>> should be done.
>>
>> It should probably look like the below, though I doubt it matters
>> since only one device is supported anyway. As long as the free
>> happens post unregister, it likely won't make a difference. But
>> it is cleaner and easier to verify, and should double device support
>> ever be introduced, the existing code is buggy.
>>
>> But given that, I don't think we should keep the revert patch.
>>
>> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
>> index 9874fc1c815b..02d369881165 100644
>> --- a/drivers/cdrom/gdrom.c
>> +++ b/drivers/cdrom/gdrom.c
>> @@ -831,6 +831,8 @@ static int remove_gdrom(struct platform_device *devptr)
>>  	if (gdrom_major)
>>  		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
>>  	unregister_cdrom(gd.cd_info);
>> +	kfree(gd.toc);
>> +	kfree(gd.cd_info);
>>  
>>  	return 0;
>>  }
>> @@ -862,8 +864,6 @@ static void __exit exit_gdrom(void)
>>  {
>>  	platform_device_unregister(pd);
>>  	platform_driver_unregister(&gdrom_driver);
>> -	kfree(gd.toc);
>> -	kfree(gd.cd_info);
>>  }
>>  
>>  module_init(init_gdrom);
>>
>> -- 
>> Jens Axboe
>>
> 
> I'll add this fix to the tree after the revert, and give you the credit
> for the fix :)

Sounds good, thanks Greg.

-- 
Jens Axboe

