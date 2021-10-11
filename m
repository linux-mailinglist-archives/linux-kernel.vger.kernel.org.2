Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A24296FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJKSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJKSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:38:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE5C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:36:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g9so1471435plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pxXTQM6RmhgcrnSppRCCyFTXq3C8AV2fRPD4SkoIa0s=;
        b=Wjj5H/vUjx6TL9+Yy2uMDRw89NjPLWwl53D+Irgq0+DwQM0lkZkzoz/vBSNsAknDLJ
         gNSDWo7KgGd0QO9yx1Dz5nnh2/fC3VjFxHPAzD0Fp8TnOcEfu6ONeaEMeQ/bc2uyIv5P
         YAJ/E5RePFfwtqTjTbTY2J9eq0ksGLDue8pKRYfS0GXvOvCMajFzHW4Our+R7eNNPwIH
         GYw5o61bhtPR3OT9ZyyO1ToKAQMT7il/hFDwR6cQilxv647tsI3eBt5oftRur9u71qpK
         aR+YohvEuIbhhoYR/V+2iqb3mQ/YZv6AOeU4ekxIpksco3AN8d1azJdUY0V0MCeoyI9O
         2wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pxXTQM6RmhgcrnSppRCCyFTXq3C8AV2fRPD4SkoIa0s=;
        b=PnY++I5CHjOk/7pdFPxmd7Gc0S4QpoMW/K5ujoSA9KsEXGwNBhQPAP6DUACu8p88uq
         5DPg3JIObwzOztqf4hMedTQXTXhwuueiRcQSOJcddNDuD0xZKH583YVl/8ldRybCUg6f
         +BoPV7UEM/er+nKHJhcpf2Pp+ZqwPH4XHUECEdmxRsFrCoSj1atqc7DKSpLYMIzJ6mzf
         yhG05XgeYOFZyEVvSOMUvDOrmm1Yzy1h4npzgiNNkgkSDj+BelxDpJOuHH7/obJrBri2
         1w0AXNA6vdhtoGp48jxILy5hEjlKlOGqgLDRRZDpkLPMbQyWdgIuRu8Bq9wdWjH02mpS
         oqng==
X-Gm-Message-State: AOAM531Y2Y3xLwH9UBnONwGOGvvug19RzcV+A+fXrYiUvx9+il1b+/Th
        81iXvZ/hwWOf6eIaifcBfNq0MJfM5+/E2g==
X-Google-Smtp-Source: ABdhPJxdnp6pAhQX8JXoy40NovRqQ1x4lDqWH6jXll2OjEvH4sUX9wqC+LGadBAkS/5/+uBphLxPFw==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr718836pjv.90.1633977367251;
        Mon, 11 Oct 2021 11:36:07 -0700 (PDT)
Received: from [192.168.1.14] ([223.230.99.151])
        by smtp.gmail.com with ESMTPSA id j9sm8762349pgn.68.2021.10.11.11.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 11:36:06 -0700 (PDT)
Message-ID: <06a96ab3-9585-5d45-d316-8e6373cea705@gmail.com>
Date:   Tue, 12 Oct 2021 00:06:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-GB
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YWJ0vSrgsiKK7suE@user> <2482197.HNbSr4JpUv@localhost.localdomain>
 <4541535.Yaozv5YaVW@localhost.localdomain>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <4541535.Yaozv5YaVW@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 6:03 pm, Fabio M. De Francesco wrote:
> On Monday, October 11, 2021 10:54:11 AM CEST Fabio M. De Francesco wrote:
>> On Sunday, October 10, 2021 7:06:05 AM CEST Saurav Girepunje wrote:
>>> Remove the unneeded and redundant check of variable on goto out.
>>> Simplify the return using multiple goto label to avoid
>>> unneeded check.
>>>
>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>> ---
>>>
>>> ChangeLog V2:
>>> 	-Add goto out after the memcpy for no error case return with
>>> 	 ret only. Free is not required on no error case.
>>
>> Please write versions logs that reflect clearly and unequivocally what you 
>> changed between revisions and why. Subjects, Commit messages (Changelogs), 
>> and Versions logs are the "specifics" of your work. There must be no 
>> inconsistencies between these and the code or the history of the changes of 
>> the code.
>>
>> You may think that I'm pedantic, but since I acked your patch, I don't want 
>> to be misunderstood to be a promoter of approximate or clearly incorrect 
>> messages.
>>
>> "Free is not required on no error case" conveys the message that you have 
>> changed something that is not required but that is still potentially 
> allowed.
>>
>> This is not the case because the problem that you fix with v2 is _not_ 
>> something that is merely not required and unnecessary. You have fixed a bug 
>> that is introduced in v1. Introducing bugs is not allowed. If you do 
>> something that is not allowed you cannot simply say that it is not 
> required. 
>>
>>>
>>> ChangeLog V1:
>>> 	-Remove the unneeded and redundant check of variable on
>>> 	 goto out.
>>> 	-Simplify the return using multiple goto label to avoid
>>> 	 unneeded check.
>>>
>>>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 22 +++++++++----------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/
>> staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>>> index 0868f56e2979..ae9579dc0848 100644
>>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>>> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct 
> adapter 
>> *padapter, char *name, str
>>>  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>>>  	if (!mon_wdev) {
>>>  		ret = -ENOMEM;
>>> -		goto out;
>>> +		goto err_zmalloc;
>>>  	}
>>>
>>>  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
>>> @@ -2322,23 +2322,21 @@ static int rtw_cfg80211_add_monitor_if(struct 
>> adapter *padapter, char *name, str
>>>
>>>  	ret = cfg80211_register_netdevice(mon_ndev);
>>>  	if (ret) {
>>> -		goto out;
>>> +		goto err_register;
>>>  	}
>>>
>>>  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>>>  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
>>> +	goto out;
> 
> As Pavel noticed, probably you'd better return 'ret' here. The logic does not 
> change, but I guess that this is what Linux developers usually do.
> 
Yes, Logic does not change. However I was also not sure which one is more preferable 
therefore asked for input on v1 whether to use goto or simply return value from here.
It seems return from here is better choice for readability point of view. 
 
> From a review by Dan Carpenter of one of your other patches: "[] Do nothing
> labels only hurt readability and introduce "forgot to set the error code
> bugs.".
> 
> Thanks,
> 
> Fabio
> 
>>>
>>> -out:
>>> -	if (ret && mon_wdev) {
>>> -		kfree(mon_wdev);
>>> -		mon_wdev = NULL;
>>> -	}
>>> -
>>> -	if (ret && mon_ndev) {
>>> -		free_netdev(mon_ndev);
>>> -		*ndev = mon_ndev = NULL;
>>> -	}
>>> +err_register:
>>> +	kfree(mon_wdev);
>>> +	mon_wdev = NULL;
>>
>> Probably you have already read a message by Greg Kroah-Hartman that 
> confirms 
>> what I wrote in another message: "There is no need to set a local variable 
>> like this to NULL.".
>>
>> So please submit a v3. With the two changes requested above, my "acked-by" 
>> tag is confirmed again.
>>
>> Thanks,
>>
>> Fabio
>>
>>>
>>> +err_zmalloc:
>>> +	free_netdev(mon_ndev);
>>> +	*ndev = mon_ndev = NULL;
>>> +out:
>>>  	return ret;
>>>  }
>>>
>>> --
>>> 2.32.0
>>>
>>>
>>>
>>
>>
>>
>>
>>
> 
> 
> 
> 
Regards,
Saurav 
