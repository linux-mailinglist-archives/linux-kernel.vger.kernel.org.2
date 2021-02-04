Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8254430E9C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhBDB7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBDB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:59:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9807C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 17:58:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 8so887876plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 17:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGukB2iE0IP7CR+peVZzKMvgCpGPowmSdynpcZyCwAk=;
        b=Ye0lsVfJ+1p1vCYEUGTanIyALPMLu1j+leUI1e3t7+EyK7kBY0s/x9zTsSFX6Gx1ix
         NdpvLBWNOB5vG6appzw0mAgFUGEFNKdKh0ar9ktH8CJ5lTsn4wftHXPN98FDXdGXufsC
         HFUQLTibxJjf3fJg2c1fy2AaFSRv7pzoyW7Kxhmocga+Kn1zi0d5MLICplj2/iLLKH0N
         PvC+9AL8dE9dog2NaXwMVsnRWj4BG5dBbZMa3kc3RQJpcJLwzJJ33qDoaJkK7OQYmZHY
         l1gY1f3pvFytUMbNiyn644XU0ruBr2YoBEz1EJPoIRs9ESNaHMgInV1JVGFgQolZTH9E
         wuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGukB2iE0IP7CR+peVZzKMvgCpGPowmSdynpcZyCwAk=;
        b=VnQWfO//YmDuHsNKIm00btkOv535ixYzkrswNoYyshGRKYfKrsT5j30yHGkSdXBfNP
         MnRE1Wopq5kgwBgyJsszPpWO3MX7hoRZ728W8JCcVaaNhb1Y0sZ09mpTioNk0FoNcGfk
         Lu0+8ikwcdeaR8HDqea+aj2CphzDCvlQj+El45YbdMWI1vVG0uhW7YC0J2TBtJkiwAeZ
         laMgbJ3hzpnJWzUMPAqSOu7oM4/MtvRIEo9TOM/OSJIcMzCjCHnJqHa5eohvQO3Oi37p
         PDd6hqmGOPXNWzHMcfDSVZMb+cEUuZiJIYkL1z5Xg/mNjy6jQtBKhulPL+U/mdT+fZ+G
         IYzQ==
X-Gm-Message-State: AOAM533QHZEmjsyT5KYH97nVom+2X+1oB5dgtOQHsLgu7L5+I+zzBuNL
        tkF03EuDGSgrjaT+JiUULamcg5A3HoUj6rwK
X-Google-Smtp-Source: ABdhPJztLxDVhYVIi7poqTiGtdisnrGU5cAD+oCcyZVg4wEqYjShq22mU5sHNHKt3zFLpDxWp90/6w==
X-Received: by 2002:a17:90a:5912:: with SMTP id k18mr5762148pji.169.1612403919277;
        Wed, 03 Feb 2021 17:58:39 -0800 (PST)
Received: from [10.2.218.189] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id b26sm3589981pfo.202.2021.02.03.17.58.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 17:58:38 -0800 (PST)
Subject: Re: [PATCH] misc: pvpanic: sysfs_emit uses should have a newline
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <13b1c892d52c27d4caeccc89506aadda74f61365.camel@perches.com>
 <3369537d-27a9-2a48-9a46-f241a5077dc2@bytedance.com>
 <YBq5yVokKwOxmcS8@kroah.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <acfc960d-4380-de0f-5c09-fd9bcf802e0a@bytedance.com>
Date:   Thu, 4 Feb 2021 09:58:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YBq5yVokKwOxmcS8@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 10:57 PM, Greg Kroah-Hartman wrote:
> On Mon, Feb 01, 2021 at 09:56:57AM +0800, zhenwei pi wrote:
>> On 1/30/21 3:08 AM, Joe Perches wrote:
>>> Add newline terminations to the sysfs_emit uses added by -next
>>> commit 8d6da6575ffe ("misc: pvpanic: introduce events device attribue")
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>> ---
>>>    drivers/misc/pvpanic.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
>>> index b1e4922a7fda..9f350e05ef68 100644
>>> --- a/drivers/misc/pvpanic.c
>>> +++ b/drivers/misc/pvpanic.c
>>> @@ -25,13 +25,13 @@ static unsigned int events;
>>>    static ssize_t capability_show(struct device *dev,
>>>    			       struct device_attribute *attr, char *buf)
>>>    {
>>> -	return sysfs_emit(buf, "%x", capability);
>>> +	return sysfs_emit(buf, "%x\n", capability);
>>>    }
>>>    static DEVICE_ATTR_RO(capability);
>>>    static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
>>>    {
>>> -	return sysfs_emit(buf, "%x", events);
>>> +	return sysfs_emit(buf, "%x\n", events);
>>>    }
>>>    static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
>>>
>>>
>>
>> Hi, Greg is the maintainer of this driver.
> 
> No I am not:
> $ ./scripts/get_maintainer.pl drivers/misc/pvpanic.c
> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> 
> As the developer of this driver, it would be great if you
> could review the change and provide a "Signed-off-by" line that I can
> use to accept this patch.
> 
> thanks,
> 
> greg k-h
> 

Commit 8d6da6575ffe ("misc: pvpanic: introduce events device attribue") 
is not merged into upstream currently, so this change should not affect 
the up layer users. It looks good to me.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

-- 
zhenwei pi
