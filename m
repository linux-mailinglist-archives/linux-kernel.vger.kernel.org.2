Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3F427C92
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJISTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJISTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:19:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0ABC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:17:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v20so1241163plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:cc:subject:content-language
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=007I3r/K6V+qYxnE5VmcGCIC1RlYnIaC4Ivz6Ke0WkI=;
        b=QpKpSVYoRRYXZ6KuyGcVBossh3kIvBTZm92Bn98cYu5WxY7vQbPwRdlRte264B3F/C
         u/8+o/UucxDJEX5sSqgh+zDhiTv/fAdZgMdQVdcx2Q9NLf83MPhkVnicJ/qMgKyKXjq8
         FqMZVbD2s6jpMjiSfVnX0U+It/av/AhM7964eej7VjkGI8XLSzA+NkejMOBPNmRDU0us
         UAlPi5TwwT6JRmDjYnEt8jNqoIMlO5h5lAXkEQxa0mZe6bHzniVVu4wTH2MbejhIe4EY
         Hyh2vWB8lOSZJ7/IKGjkYV4qXG1CXprmtic62VJK7oCLUH4w8RuXt/sXoI23ldrf7eHZ
         7THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=007I3r/K6V+qYxnE5VmcGCIC1RlYnIaC4Ivz6Ke0WkI=;
        b=AtlNAZJoS7xQK4CrDolfulZldDjPjRRkgld+GuWDm/1+WHBMZIa8rNldV+e813z2h2
         MF8C8P3oR5hbXUdlacGv7ceCA5TiIivKjB22elqXgiSNUcox10cFvP0NbAnXzX6VItlt
         7cuSIbyolMWhBQ+HgSp8meVjzwjtrNV0scCpJdSX9T2x2vD5W2EUMoOra4OMO9sr2npm
         tXHTo6CIDz9I3DuiScNwkLK2f6aGpd1mpZ71vBXRRfSmH2STmURlYkT/pW9bPSnCxAls
         4/k9zi0xcfxuse06HUU2fSTk7Pg5A/pb1BIMCnQTFVWQwYWggFo4UJxIGpvxQjePjYFE
         1YBQ==
X-Gm-Message-State: AOAM533aDjNlTUlqeEoo3kbWMDotYwoJ0wHObdn/1NZcHJdrOjuV4h76
        qS2Bk9lj/ADITmDguvrYVKfWoI0/7zwslg==
X-Google-Smtp-Source: ABdhPJy3vrMGr2AAysKOKpCIABD9bWNf/h6ylAPSMt7LGOS/RGUqc9yxi8AqK90dRM/9guQ0Rlrmzw==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr19111548pjb.127.1633803424956;
        Sat, 09 Oct 2021 11:17:04 -0700 (PDT)
Received: from [192.168.1.6] ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id b16sm2838646pfm.58.2021.10.09.11.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 11:17:04 -0700 (PDT)
Message-ID: <50527d62-3c4e-3b61-5f17-225379c1d6c3@gmail.com>
Date:   Sat, 9 Oct 2021 23:47:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Cc:     saurav.girepunje@hotmail.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev
References: <YWG3oIchovDZnPl8@user> <1661874.ovfstkzlfj@localhost.localdomain>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <1661874.ovfstkzlfj@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/21 10:29 pm, Fabio M. De Francesco wrote:
> On Saturday, October 9, 2021 5:39:12 PM CEST Saurav Girepunje wrote:
>> Remove the unneeded and redundant check of variable on goto out.
>> Simplify the return using multiple goto label to avoid
>> unneeded check.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++++---------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/
> staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> index 0868f56e2979..574fdb6adce7 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> @@ -2282,18 +2282,18 @@ static int rtw_cfg80211_add_monitor_if(struct
> adapter *padapter, char *name, str
>>
>>   	if (!name) {
>>   		ret = -EINVAL;
>> -		goto out;
>> +		goto err_out;
>>   	}
>>
>>   	if (pwdev_priv->pmon_ndev) {
>>   		ret = -EBUSY;
>> -		goto out;
>> +		goto err_out;
>>   	}
>>
>>   	mon_ndev = alloc_etherdev(sizeof(struct
> rtw_netdev_priv_indicator));
>>   	if (!mon_ndev) {
>>   		ret = -ENOMEM;
>> -		goto out;
>> +		goto err_out;
>>   	}
>>
>>   	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
>> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter
> *padapter, char *name, str
>>   	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>>   	if (!mon_wdev) {
>>   		ret = -ENOMEM;
>> -		goto out;
>> +		goto err_zmalloc;
>>   	}
>>
>>   	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
>> @@ -2322,22 +2322,23 @@ static int rtw_cfg80211_add_monitor_if(struct
> adapter *padapter, char *name, str
>>
>>   	ret = cfg80211_register_netdevice(mon_ndev);
>>   	if (ret) {
>> -		goto out;
>> +		goto err_register;
>>   	}
>>
>>   	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>>   	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
>>
>> -out:
>> -	if (ret && mon_wdev) {
>> -		kfree(mon_wdev);
>> -		mon_wdev = NULL;
>> -	}
>> +err_register:
>>
>> -	if (ret && mon_ndev) {
>> -		free_netdev(mon_ndev);
>> -		*ndev = mon_ndev = NULL;
>> -	}
>> +	kfree(mon_wdev);
>> +	mon_wdev = NULL;
>> +
>> +err_zmalloc:
>> +
>> +	free_netdev(mon_ndev);
>> +	*ndev = mon_ndev = NULL;
>> +
>> +err_out:
>>
>>   	return ret;
>>   }
>> --
>> 2.32.0
>>
> At a quick look it seems that now you unconditionally free memory and free a
> network device immediately after the last memcpy().
> 
> Why are you doing this even if no errors are returned from device and memory
> allocations (i.e., while "ret" is still equal to zero)?
> 
> Thanks,
> 
> Fabio
>   
> 
> 
> 

Thanks Fabio for review. Yes, That is missed.
I can do that in either one of the way.
Either I should check for ret before free or I should use goto out(may 
be I will rename err_out goto label to "out" only) just after the memcpy 
statement so that function will not free for no error case and return 
ret value only.

Please let me know you input on above.

Regards,
Saurav Girepunje
