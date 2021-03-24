Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD2346F96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhCXCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhCXCdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:33:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D4C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:33:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l76so1543734pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lzaRRaMft0jory4q1mDJxpzGwlb7Q2/FGx4f0ZTwcG8=;
        b=Rx2naT70/fIl7Wo+VXOdQIVUP8Xs6r0WTQO/hWpxA8kb+/TuskhKXqqWlkHz2QjoO2
         UOSJohP800OXd7ovQo6EVUkrsflbjP2x/Sq0soaB4u4vGdAu3nC/9EbSkzJ+j3dkePgW
         u4bVkLSYDS844Xi6eTAXMQ3Jy2SzL9ZhfHsmNY2gPVZvN3gRB6U9gJhMyGw3NIfVTlSd
         kBB71dc5xp53aAL3p9hOT0I8Imfk3drnQ8xQH25h9quuziFn4GEK6E/92GCCTQyJdIsC
         r/Oy+Irn0Y3RpCPOuzOtAUTI7nl91xRxEPQcx6mTvW7lA/I/9TOUxW2iwPdSfSFSbyRH
         ilmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lzaRRaMft0jory4q1mDJxpzGwlb7Q2/FGx4f0ZTwcG8=;
        b=WzdU5wNYxz+W51za+inwL3Jqx+YUEpsnlEa24L+Cp8iEo1vjgA1C2o64+58n7CEOPS
         u2MefR0vhZDMluiF2LMvIhrd1HeizRoW78VBVZuKqjE8vRvxoO0zscWU6m8UK+aEXIJ7
         //VAjXVoiOMhlJ9GOu+GfbMtsAhrbn7D4BoqOsI3w1dMzNVLQnCkbAzgv5UapmGu1rob
         u9B10KsYn2QlT8SCgg0NPEYHEZl8fq71ZKSGVrKxE5VN8EySU2ncAGUEEh7B72OR0gM6
         71WCYAjQA8kEA9ACkQ3eECUzW5o4H3GHKRq4NeIOYRmF8kTGfut8gcp3Vs5UIgoH4Na5
         eZjA==
X-Gm-Message-State: AOAM533Ee5g2JIOa3U55es6ONtqyEHMXuD961NCpXi4ztKRyf1Eaz1xT
        F1A/akvrwLZ6dIGoIaDKfaFOI8iij2RWeA==
X-Google-Smtp-Source: ABdhPJyPusi5p5hrZAmxa9du4yqIswA581Oc9wOfrOIaokfUJnExOHtjUskszZnMbzuVxClHMW2Kww==
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id e10-20020aa7980a0000b029020c54025de9mr1049963pfl.18.1616553203482;
        Tue, 23 Mar 2021 19:33:23 -0700 (PDT)
Received: from [10.146.0.22] ([45.135.186.62])
        by smtp.gmail.com with ESMTPSA id w189sm466719pfw.86.2021.03.23.19.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 19:33:22 -0700 (PDT)
Subject: Re: [PATCH] base: dd: fix error return code of driver_sysfs_add()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20210305102405.14940-1-baijiaju1990@gmail.com>
 <YFnztyaTn47fjlnr@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <0de7b406-2df8-20cf-2863-11754dc087f6@gmail.com>
Date:   Wed, 24 Mar 2021 10:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YFnztyaTn47fjlnr@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/23 21:57, Greg KH wrote:
> On Fri, Mar 05, 2021 at 02:24:05AM -0800, Jia-Ju Bai wrote:
>> When device_create_file() fails and returns a non-zero value,
>> no error return code of driver_sysfs_add() is assigned.
>> To fix this bug, ret is assigned with the return value of
>> device_create_file(), and then ret is checked.
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/base/dd.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 9179825ff646..f94bbef95258 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -413,8 +413,11 @@ static int driver_sysfs_add(struct device *dev)
>>   	if (ret)
>>   		goto rm_dev;
>>   
>> -	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump ||
>> -	    !device_create_file(dev, &dev_attr_coredump))
>> +	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
>> +		return 0;
>> +	
> Trailing whitespace :

Ah, sorry, I will send a V2 patch.


Best wishes,
Jia-Ju Bai
