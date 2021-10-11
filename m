Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC72D42968D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhJKSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhJKSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:12:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C5C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:10:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e7so11568652pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V2qwMwE4Z/z5csEUUB1Fs1TS8L6+ma70mWZapSc+y34=;
        b=XXFoI4eJfByYgGHb1AA2jcV93WtzuMR+I8tx+jmMDXycaVhRVoTZQUvN/DZ5xbyx5v
         HLjdG5C+AgK/OvlAJYelaDy9iuXhGdMbiU2+A7J7uaFC7LzyJOu2xZffkrGQTHhEzzYg
         T2tF0w1195FGS57pfu87ET20WmB5b2KYRYLDpudBlMmsd0WG6SVdoO5RymOMGN/5znti
         zXlA0n+vVEWGG7PNN889cQ3tzPiZmUnUw0mr/Ws8ysQ/0e2FQ2OekxyV1CsZeYc3Q9Nf
         QQFJ8PtLH9n02fwF0LveJa+o5P+9FvoP+WEKG1B8GQVy0NPrRH9enUtu8RNWk3zS2eyl
         o6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V2qwMwE4Z/z5csEUUB1Fs1TS8L6+ma70mWZapSc+y34=;
        b=a2qkQJ+EPCXPmAQUCsofsbY1iYNkDHSQPCVZJlTBq0pQ7M0QGoIENrRhbRyNfyhjxZ
         e03Uziw7YCl8/PLlNmhLtF7ebi3pyB7bDEADaakVqTyhffBLMzYbh8/774/QTenyMLse
         nyw2eK0yGkV3Wl5tUiPSEUX/JXZ6wJJJEGNEQQhb5UbNdFelB/bmoqFQsdt+W32mx2JC
         lciMYr1e+ip16aeFZv0mFZJljgmcSD6550bUlf1dGbdRIoRX7bXFadnp91n969Dv85rE
         ioNetBpahaBpb25tQvLWkL3K+hfQoDnMzrcd7s3TvAmY8WJ5BZ8jvt2fJPcgHJ0hU4EG
         5Cpw==
X-Gm-Message-State: AOAM530bqEhwK6ag1qc2WUiC/H8B80FfbAcEQD/ZDiricIR/Me+rGQNU
        D2nCFBvuWlv8Xs4yeDU6WQ4=
X-Google-Smtp-Source: ABdhPJxsGpDd9BpkUbq67Ww5VPBW1wkU6AGOdcamfPFt9XqttFJ/Q9GFxn28yRAyZLAOT2KmRAuhaw==
X-Received: by 2002:aa7:843d:0:b0:44d:2199:3ecb with SMTP id q29-20020aa7843d000000b0044d21993ecbmr7007871pfn.78.1633975822873;
        Mon, 11 Oct 2021 11:10:22 -0700 (PDT)
Received: from [192.168.1.14] ([223.230.99.151])
        by smtp.gmail.com with ESMTPSA id k35sm124402pjc.53.2021.10.11.11.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 11:10:22 -0700 (PDT)
Message-ID: <b9ba5a6f-ac0c-de0f-d105-90c50235ea5c@gmail.com>
Date:   Mon, 11 Oct 2021 23:40:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-GB
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YWJ0vSrgsiKK7suE@user> <5843476.m7FxXixzUK@localhost.localdomain>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <5843476.m7FxXixzUK@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/21 12:54 pm, Fabio M. De Francesco wrote:
> On Sunday, October 10, 2021 7:06:05 AM CEST Saurav Girepunje wrote:
>> Remove the unneeded and redundant check of variable on goto out.
>> Simplify the return using multiple goto label to avoid
>> unneeded check.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>
>> ChangeLog V2:
>> 	-Add goto out after the memcpy for no error case return with
>> 	 ret only. Free is not required on no error case.
>>
>> ChangeLog V1:
>> 	-Remove the unneeded and redundant check of variable on
>> 	 goto out.
>> 	-Simplify the return using multiple goto label to avoid
>> 	 unneeded check.
>>
>>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 22 +++++++++----------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/
> staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> index 0868f56e2979..ae9579dc0848 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter 
> *padapter, char *name, str
>>  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>>  	if (!mon_wdev) {
>>  		ret = -ENOMEM;
>> -		goto out;
>> +		goto err_zmalloc;
>>  	}
>>
>>  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
>> @@ -2322,23 +2322,21 @@ static int rtw_cfg80211_add_monitor_if(struct 
> adapter *padapter, char *name, str
>>
>>  	ret = cfg80211_register_netdevice(mon_ndev);
>>  	if (ret) {
>> -		goto out;
>> +		goto err_register;
>>  	}
>>
>>  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>>  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
>> +	goto out;
> 
> I think this is the right thing to do in order to remove the bug you 
> introduced in v1. Well done.
> 
Most of the people suggesting to use return 0 from here instead of goto.
I will send another patch.
>>
>> -out:
>> -	if (ret && mon_wdev) {
>> -		kfree(mon_wdev);
>> -		mon_wdev = NULL;
>> -	}
>> -
>> -	if (ret && mon_ndev) {
>> -		free_netdev(mon_ndev);
>> -		*ndev = mon_ndev = NULL;
>> -	}
>> +err_register:
>> +	kfree(mon_wdev);
>> +	mon_wdev = NULL;
>>
>> +err_zmalloc:
>> +	free_netdev(mon_ndev);
>> +	*ndev = mon_ndev = NULL;
> 
> Not sure about what the Linux coding guidelines say, but I think that 
> assigning NULL to local (on stack) pointers (mon_wdev, mon_ndev) at this 
> point is unnecessary. There is no risk of reusing them after the "out" 
> labelled block, because at function exit they are destroyed when the stack is 
> unwound.
> 
> If you decide to remove these assignments, take care to leave "*ndev = NULL;" 
> as-is (why?).
> 
Yes, This is also improvement needed on this function.
> Aside from this minor objection...
> 
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks,
> 
> Fabio
> 
>> +out:
>>  	return ret;
>>  }
>>
>> --
>> 2.32.0
>>
>>
>>
> 
> 
> 
> 
Regards,
Saurav
