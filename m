Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D33AC120
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhFRC5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhFRC5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:57:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA806C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:55:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m17so765145plx.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oD/lPmbYpR+flY3ngmMvMRUJurU8Z44y+AyucteNA/8=;
        b=G6ta/BMQj9o34vXd7ou/YOIaNZRkgj9MLKZNrM8CDmrPZUN+UhQCb3L0RdA+IjJn5G
         jrk22sYfXarrySBr3qlZ/W2KPEpEKnOa5GU4cxU1iGkSsFuHKHXHEk4T74IGyNxTOt3g
         xMdMluZ1hvTiuYHeyMFaQJnrv7+xBxf6qORGE5iaRmZh0T4mTSw+juXRG2PojvtqzToW
         3NevaUqrq6uqbPZSPoIBKor+pKomn6CCnyyBud9JuFtHWwoZxTxLZOs4OYOUKFXUDbNs
         RiebIW9QEoM/qvkLx6FnkhSlDxwP+hR5oYliUMdHCFb3FQoxQkP6k9Oij9cdmxWe1+7T
         Nrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oD/lPmbYpR+flY3ngmMvMRUJurU8Z44y+AyucteNA/8=;
        b=VhxWDPOzSQf1glnTS6Re38KLYQYGnahja8LG/+y8RJ213Hb3XeczQoH+fm759fz9+E
         Xt8uGR6oMEcwmTXzsu4svouiiM1uUPNsix0OW/RwT81mnbYLm9elMkaAOzpge/HlI4c5
         R75AZ9H16mEXlB0R5WVCMIdF7L3ZcEykSZgqxz+eMG2pRsC3CnbdbhtqsczKaOTPHBcB
         4nnbZEhTIl5TjUSCgCD2tJFgm7+70NwyBhMbqpbf2RqNicsTdwEFDC6FweXMH7xUQhfC
         dzKYqqAh+xP9+8x/O9oS8FM6VOvhr0yG/3I4w8IMBj+n9MFFfliJUzDM+9+Bl1Akwj/w
         A9tg==
X-Gm-Message-State: AOAM53282EZRdghQJYSl1IG5y7uHR6K9aQSWxAOJxRQvmz8ANJ1MayiM
        vshG7uJIg9ebVjk2mO0r9r7zXzzwGgEFOINYlH8=
X-Google-Smtp-Source: ABdhPJxQtIJ7wA1HP94MBKX8MQ9KWjHMW8rcONoLQSAmQmXf52cl+s1tuhb+aHwu/PmfkqWor3hVow==
X-Received: by 2002:a17:902:ecd1:b029:119:50c6:e449 with SMTP id a17-20020a170902ecd1b029011950c6e449mr2764132plh.30.1623984903283;
        Thu, 17 Jun 2021 19:55:03 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id m1sm6825685pgd.78.2021.06.17.19.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 19:55:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drm: Add a locked version of drm_is_current_master
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com
References: <20210615023645.6535-1-desmondcheongzx@gmail.com>
 <20210615023645.6535-2-desmondcheongzx@gmail.com>
 <YMuAYaZF+qW7GUFT@phenom.ffwll.local>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <793cf08c-a766-637e-b473-91f6c8de12ec@gmail.com>
Date:   Fri, 18 Jun 2021 10:54:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMuAYaZF+qW7GUFT@phenom.ffwll.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/6/21 1:03 am, Daniel Vetter wrote:
> On Tue, Jun 15, 2021 at 10:36:44AM +0800, Desmond Cheong Zhi Xi wrote:
>> While checking the master status of the DRM file in
>> drm_is_current_master(), the device's master mutex should be
>> held. Without the mutex, the pointer fpriv->master may be freed
>> concurrently by another process calling drm_setmaster_ioctl(). This
>> could lead to use-after-free errors when the pointer is subsequently
>> dereferenced in drm_lease_owner().
>>
>> The callers of drm_is_current_master() from drm_auth.c hold the
>> device's master mutex, but external callers do not. Hence, we implement
>> drm_is_current_master_locked() to be used within drm_auth.c, and
>> modify drm_is_current_master() to grab the device's master mutex
>> before checking the master status.
>>
>> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>> ---
>>   drivers/gpu/drm/drm_auth.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
>> index 232abbba3686..c6bf52c310a9 100644
>> --- a/drivers/gpu/drm/drm_auth.c
>> +++ b/drivers/gpu/drm/drm_auth.c
>> @@ -61,6 +61,8 @@
>>    * trusted clients.
>>    */
>>   
>> +static bool drm_is_current_master_locked(struct drm_file *fpriv);
> 
> A bit a bikeshed, but we try to avoid forward declarations when they're
> not needed. If you don't want to tear apart drm_is_current_master and the
> _locked version then just move them together.
> 
> Can you pls do that and respin?
> 
> Otherwise looks all great.
> -Daniel
> 
> 

Yeah, I was trying to keep the logic in _locked close to 
drm_is_current_master. But got it, will do.

