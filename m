Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402B2415BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbhIWKO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhIWKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:14:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B94C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:12:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i25so24748491lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=XC27WisAxWMov8RtCGisxpmIIGaBu+NxFH6cQMHSlX0=;
        b=L289YyD4iRUDIVN4+WMvgaafGYobjZrXtKYlLIhDzGGF0xNxAe+IVz8y3/OAIGT5vV
         0KOFelCiHJ8nipL9GVVl7dXEKflIuXrfdxXpZhaKKgC5cAL3u8Lsn2JdYpQBlC2p+jnU
         OxBN808k9HxiiHW+LnVsHpXLar+t0qpU1k7L6E1KN8SJcBskvdPcIJyNG136HKXCT/uo
         sH3E/WsP2cDTEhVR7hJHdUuH+IdtBAlQeymgoLWEkmJgbSYIbr3lJW8YL4CZJjpdIla6
         zdMtiaZctmVahLe1nqReVC8Yo1c4+u/iDlev6+y9gg/Ci2VLDd7b1YC/QPD9nJknT/yw
         eAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=XC27WisAxWMov8RtCGisxpmIIGaBu+NxFH6cQMHSlX0=;
        b=19ZwxGAiOQII6uE/vMpUPuYxUJwfKV3HThdTWV3IdkN5lFWZMX0kMkryUxHmGZB9jD
         WuKlRxqJ9W/N85REO8qiYaQVa/Q62cUay8q21iEC27JDQwYeWAdHSFQlnaBbl1J/lCwU
         pAUw1KCYg8S0iG7LapLgnixVit6AV3g5/Mr45OSxdGgL3ECnTjg+9BoYidHyHjYiTKNb
         6qa3yrEIBWq1MPBo3HKgxa6gNMqsPpLn+S5+/rybzdZsTzB2yOUcPchPg1AM48zjsfyp
         xVVGx/zJdOhtYIfryHnxIEFtUjEwT55P5nzmx3mUYcVjI3LC+5PkNimvKPuOHtf9ZQkX
         O9KQ==
X-Gm-Message-State: AOAM533TDiBzTvPM8fCVlnWsw8zkbU2GG18NUbTy9Ff+jnYOTaSOtR8C
        PE3EYs3/QDf3Zr6wJeLe1dI=
X-Google-Smtp-Source: ABdhPJygTI8XNoUTiQfA6RefKdth8f0oKSiLTTONLXgr0b2C71bcYfk+yXv4gF811eP/aiJ8eXC/3Q==
X-Received: by 2002:a2e:9f0c:: with SMTP id u12mr4363156ljk.92.1632391974477;
        Thu, 23 Sep 2021 03:12:54 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.37])
        by smtp.gmail.com with ESMTPSA id bp5sm414552lfb.133.2021.09.23.03.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 03:12:53 -0700 (PDT)
Message-ID: <dfa76ffe-2306-01b3-9746-c9aa43c03398@gmail.com>
Date:   Thu, 23 Sep 2021 13:12:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v9 16/16] staging: r8188eu: remove usb_vendor_req_mutex
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
 <20210921181834.29677-17-fmdefrancesco@gmail.com>
 <dd99d40d-297e-8d27-dabe-d0e4c633d391@gmail.com>
 <4434c136-6bfc-9a25-d0ba-f989c655fa69@gmail.com>
In-Reply-To: <4434c136-6bfc-9a25-d0ba-f989c655fa69@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 11:47, Pavel Skripkin wrote:
> On 9/22/21 16:21, Pavel Skripkin wrote:
>> On 9/21/21 21:18, Fabio M. De Francesco wrote:
>>> From: Pavel Skripkin <paskripkin@gmail.com>
>>> 
>>> This mutex was used to protect shared buffer for USB requests. Since
>>> buffer was removed in previous patch we can remove this mutex as well.
>>> 
>>> Furthermore, because it was used to serialize the calls to the Core USB
>>> API, we thoroughly tested the enabling of concurrent firing of USB requests
>>> without the mutex and found no problems of any kind in common use cases.
>>> 
>>> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> 
>> Hi, Greg!
>> 
>> If all is OK with previous 15 patches, please, do not take this one, it
>>    causes problems with connection... :)
>> 
>> I don't understand what went wrong after v8, but anyway, this one should
>> not be applied for now, since it's broken
>> 
>> 
>> Thank you
>> 
>>
> 
> 
> Just to be clear: previous 15 patches _are_ tested and do not cause any
> misbehavior or bugs.
> 
> I guess, the stack buffer maybe the problem here, since it's the only
> change on this side since v8. I didn't have a chance to take a closer
> look, but I will do it on weekends, I hope :)
> 

Oh, I found the problem by just looking at the code with clear mind:

> -free_dvobj:
> -	if (status != _SUCCESS && pdvobjpriv) {
> +	if (pdvobjpriv) {
>  		usb_set_intfdata(usb_intf, NULL);
>  		kfree(pdvobjpriv);
>  		pdvobjpriv = NULL;

This if should be deleted completely, because we don't want to fail on 
every probe :)

Sorry for noise... :(

Greg, can you take first 15 patches, if they look good and then I will 
send fixed version of 16? AFAIU, you are ok with taking part of the series


Thank you


With regards,
Pavel Skripkin
