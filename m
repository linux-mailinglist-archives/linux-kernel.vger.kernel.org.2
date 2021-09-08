Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD39403E94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbhIHRsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348609AbhIHRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:48:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB3C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:47:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so3383629pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OOd8EUezoHMaD7SBxQOj/wkf/YElyn1NT0bABpDYLWg=;
        b=Qbl7QKMPEhaeDCJmmRufF0NKCPQCmsu77fTe9ZZ7gNSLqRFHoI02mmSuDwQi2Ldfs+
         DUJviYtUtSGUiIJVgqJZKIm6jccEtCy5iOp/V+ivisfEGEOS8l2RYTMzqJpMYYPTpR8+
         Au77mm7JvbnXCa2rEv9IDsddLZrSpLdBqhVl8wXgcSW/Bq+/Moq6qRbygA+NGgcUGH0k
         nLsJqoO80xd/h2ShfUJZC5fRAC9kUGoagaX5vjQgRMinujdBj/F+8zz88sEjw3QIEHnC
         RFaUdY0h5egvhzD+Com3ADkm3GocF/1FxmdscRjvjc/JvLi+JCyI9Rpc5ZOzjN9WZkRT
         FQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOd8EUezoHMaD7SBxQOj/wkf/YElyn1NT0bABpDYLWg=;
        b=Efpvl31MM2mR6jfjvxzZVtaHJ9gZQ7SoDv0jcSRVbsPLCySoWWXzBYZE74P5SBe7LX
         7jyHt/eATF3Ya0/CKsgs9Rkqn/rMqr1gvcNGPXuOOMBfUkHXS13md7SPF+7xXHyT6Adb
         WnLiZSNPHvICtutv+iwz0bbgVCNTdXKKsGos2CUdoUTrH0xw1T8unw9soat+xRcyr5Vy
         4XwlW+6SlwO6+0snlWQgVzUVAgDvW2wZ0p2rGKni5ZcnfdCPRWiWKAK/aXp9cT3uTxpE
         tuXKJs1IRpK2xojsBep3fsvSs4ARmbYibtJv1wrVrBqyna1Kh6VIJkzG8HKtkcugxc26
         6y0Q==
X-Gm-Message-State: AOAM532VTr++kIcZsb20TPT/6Yf127hIPaEi3RbJij6m2DC65JdGCPWO
        imsnwqT8WW4koAbiB05PuKZaBzgLTaBePw==
X-Google-Smtp-Source: ABdhPJzz8Ps5YZiC7IBV0kkhOT9QLCVdGXqDyjbcnO31dAaAbhAEK48vFqGfTV9XPgevyjAR4wkrlg==
X-Received: by 2002:a63:3602:: with SMTP id d2mr4970800pga.134.1631123245558;
        Wed, 08 Sep 2021 10:47:25 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id c24sm3123361pfd.145.2021.09.08.10.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 10:47:25 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: simplifiy the rtw_resume
 function
To:     Greg KH <gregkh@linuxfoundation.org>
References: <YTNjNLcNvPfD9+5Z@user> <YTTYo2BSG/JTuijx@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <41bd374e-3122-0580-f38d-bb03401730b6@gmail.com>
Date:   Wed, 8 Sep 2021 23:17:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTTYo2BSG/JTuijx@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/21 8:18 pm, Greg KH wrote:
> On Sat, Sep 04, 2021 at 05:44:44PM +0530, Saurav Girepunje wrote:
>> Remove unused variable ret and pwrpriv.
>> Remove the condition with no effect (if == else) in usb_intf.c
>> file.
>> Remove rtw_resume_process() and move whole thing to rtw_resume().
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>
>> ChangeLog V2:
>> - Remove rtw_resume_process() and move whole thing to rtw_resume().
>> ---
>>   drivers/staging/r8188eu/include/usb_osintf.h |  2 --
>>   drivers/staging/r8188eu/os_dep/usb_intf.c    | 12 ------------
>>   2 files changed, 14 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
>> index d1a1f739309c..34229b1cb081 100644
>> --- a/drivers/staging/r8188eu/include/usb_osintf.h
>> +++ b/drivers/staging/r8188eu/include/usb_osintf.h
>> @@ -24,6 +24,4 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
>>   void nat25_db_expire(struct adapter *priv);
>>   int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);
>>
>> -int rtw_resume_process(struct adapter *padapter);
>> -
>>   #endif
>> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
>> index bb85ab77fd26..77b03e7631b7 100644
>> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
>> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
>> @@ -493,18 +493,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
>>   {
>>   	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
>>   	struct adapter *padapter = dvobj->if1;
>> -	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
>> -	int ret = 0;
>> -
>> -	if (pwrpriv->bInternalAutoSuspend)
>> -		ret = rtw_resume_process(padapter);
>> -	else
>> -		ret = rtw_resume_process(padapter);
>> -	return ret;
>> -}
>> -
>> -int rtw_resume_process(struct adapter *padapter)
>> -{
>>   	struct net_device *pnetdev;
>>   	struct pwrctrl_priv *pwrpriv = NULL;
>>   	int ret = -1;
> 
> You can also remove the test for padapter being NULL in this function,
> as you just proved it could never be null otherwise the above function
> you removed would have crashed, right?  You should do that all at once
> so we remember why that test was removed.
> 
> thanks,
> 
> greg k-h
> 

Yes, padapter was deference without checking it could be NULL on rtw_resume.

I think having NULL check would be safe. However if padapter is NULL 
then on goto exit "if (pwrpriv)" condition  will never true as pwrpriv 
is initialized with NULL. There should be one more goto exit just to 
return.!

let me know you thought greg,

Regards,
Saurav Girepunje
