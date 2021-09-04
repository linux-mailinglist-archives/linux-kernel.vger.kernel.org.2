Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200884009D4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhIDEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 00:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhIDEww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 00:52:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559DC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 21:51:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so715060plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 21:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:from:to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rSC+wsvApcFev2eGAY1v7kdeN81+/4Sh3ZwQ0aBGzF0=;
        b=OlUtuLW4JFX5yUDu/HMNsPr7nDw3wid2fAHpemmEj5LNxgQCOClojrezBnJYRD6o1z
         fNvh78hAg25vZnc1F+eWgPcx5SreVSXosb4UXIeg6JpbrkTXzQTlQgLWOwnHxWk7/k1C
         /67exeg9axav6aE4tYabqWu8OJUQhpypHYZD2TjlhT5xLJmOzC7mLmBMuKwnK9kvg+Mb
         HtqW23nrEgmrTgnZhx1DFQ/RnBS116da/XrmnE8H99appPU0gdAHE4k4O+hVksnWVQy3
         q7eMxuOeEfo5koNKVUp0LhPkCV0Ay/sO5NXzDweoCNI7U82YPVG+WVk4ZXBLkVr5i64U
         hvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rSC+wsvApcFev2eGAY1v7kdeN81+/4Sh3ZwQ0aBGzF0=;
        b=tV+KHh0/FxIan6w4Q0E/8RQsi0OxvpGbWA9tQRCa71P6whw715eCHbb6gLK+DJvWNX
         anp8EDwld3yVTaJ6v7U48g1aKMHZ3Zz49yaoVWhmPz6xvHe6bvR/C1Yy6GXNeJkz6fIr
         5fYiuiU6KGJj3U9Yn4gjz/iVXpKYcPDzq1gmtyTaUUzYdJCJLLVJoO66RLUqEAy1gdrT
         7LZ/G2yJBt4yV6AxwCQX+wmBDjEbO1J8AUqpUCY3x58MNLWTd4rGP1QAjVl4/A230D+K
         XPeXPV8SojxQ2pnKCenWRg97ZnOhXvCXx6ZwoznXOVmMQnPhpJtB7X+L8iqxP6Ymy8bg
         +Dmw==
X-Gm-Message-State: AOAM533zCPBywxag+cVTrjPhTSlqfiVTKQKQ2qPgMAamImoSOZ/FA2N5
        /1thZVNKzHoaD4WgqrL9pc0=
X-Google-Smtp-Source: ABdhPJywqxVKGQN/plFMg539PKBgWcUvrN2vuU9YsWQ2itoX0Ogmwu10zR60hgRsUeOEx5efXW9jTA==
X-Received: by 2002:a17:90a:4ce2:: with SMTP id k89mr2387002pjh.233.1630731111066;
        Fri, 03 Sep 2021 21:51:51 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id y12sm961937pgl.65.2021.09.03.21.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 21:51:50 -0700 (PDT)
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc
 and memcpy
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
References: <YSp9z2/JmvHGhW5m@user> <YTCXef5o9JHtQhuD@kroah.com>
 <YTJf9odBRwxHZTs8@user>
Message-ID: <972f6b6c-ffdc-e32d-4433-38df7e8a78d1@gmail.com>
Date:   Sat, 4 Sep 2021 10:21:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTJf9odBRwxHZTs8@user>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/21 11:18 pm, SAURAV GIREPUNJE wrote:
> On 02 Sep 2021 11:20, Greg KH wrote:
>> On Sat, Aug 28, 2021 at 11:47:51PM +0530, Saurav Girepunje wrote:
>>> Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c
>>>
>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>> ---
>>>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>>> index 81d4255d1785..495fadd2b8c8 100644
>>> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>>> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>>> @@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>>>   	}
>>>
>>>   	if (ielen) {
>>> -		buf = kzalloc(ielen, GFP_KERNEL);
>>> +		buf = kmemdup(pie, ielen, GFP_KERNEL);
>>>   		if (!buf) {
>>>   			ret =  -ENOMEM;
>>>   			goto exit;
>>>   		}
>>>
>>> -		memcpy(buf, pie, ielen);
>>> -
>>>   		/* dump */
>>>   		{
>>>   			int i;
>>> --
>>> 2.32.0
>>>
>>>
>>
>> This patch never showed up on lore.kernel.org for some reason.  Please
>> resend and see if it was a mailing issue on your side...
>>
>> thanks,
>>
>> greg k-h
> 
> 
> Ok, I will resend this patch.
> 
> Thanks,
> Saurav Girepunje
> 

Hi Greg,

I have resend the patch, But the last patch also on lore.kernel.org
https://lore.kernel.org/all/YSp9z2%2FJmvHGhW5m@user/

Regards,
Saurav Girepunje
