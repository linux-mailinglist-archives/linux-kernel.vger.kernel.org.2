Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD6439CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhJYREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbhJYRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:03:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8DC0611C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:00:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k26so11326667pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bjCnpTmMk/HRFGYFZBty4la+9CytdreB3FPvUgm7mYA=;
        b=GFVQKt0Y6A2BgEVTITFDRw0hqTW8buNxHYiJ/MNqlx+Lujajo5QjX4bRi4ACDhTVnI
         hnqJzRo4NyaP0cP2AUNIrrgBG5EsEDIDWr870KEwkudizMizKNT58uqjtYuhwJ2/osRy
         fe3LJ0xeKdBkprR73iMxx+FzR5TX5SLhrN9NJ3ksz/FESY7xLTtxwor46GkfYKwbtQ+A
         MHvRv005gsP2n5MQTD5RK+RxvQVPpKn/m96Rsg70JvaWq6MEViosEnsEvJu5DHc5YCZp
         zjTd2h9iNysVVIaqilMoHf9KB74B4/XOjKEJUzMh5WSfuchfaLBrmFzXIlB15qbgi93N
         ZMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bjCnpTmMk/HRFGYFZBty4la+9CytdreB3FPvUgm7mYA=;
        b=bDG30MQJhtU43PZLz11Bu+e0zx41DiiX4V69sPJFsIqlyeOIGSIvid58Cyf6AXbptX
         +7mOAqR/GTa0+l4ri6X25GZ9GGHaJC8mrYs2kWOBevB35j46JVx+IlM0H+fHTHa7YCw+
         XrkwJ426hpIlvZHU+ZtFbLDD1oAtVCeL39t1T6JI0/vI5uaJHXgZVXxRo8SeEZ/e7pyn
         bb8bTqHRUQtmOo52O9vEAnZzy3IOsRiI9YmNe/gz2qeQsHuS0tYV+aCppwT/PWmxCxsO
         vZnjYs06cOYjyxAXy5gf9grnq1TsH9fUzd1AWiS/4k3hHz9kNXywH62EyYPSxLbnYPD1
         WysA==
X-Gm-Message-State: AOAM532p29D71aA+u/hduLGvBvZr3ZbQaA6mTvam0K0/Mzs2ONy9K6Df
        bHnGMxbFcUns2bzeWkG/bEaR6lvKnBk=
X-Google-Smtp-Source: ABdhPJwouE59q8I1qzBB7xR+BVlQDpSR2rYzUizfnc0z7hI3FQ8kxC9M3zgmpIicBNIJkYfmBr+Ufw==
X-Received: by 2002:a62:6d86:0:b0:448:152d:83a4 with SMTP id i128-20020a626d86000000b00448152d83a4mr19760475pfc.38.1635181244232;
        Mon, 25 Oct 2021 10:00:44 -0700 (PDT)
Received: from [192.168.1.4] ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id ls7sm19681872pjb.16.2021.10.25.10.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:00:43 -0700 (PDT)
Message-ID: <e2020caf-1b0c-ce0e-3d94-d105be85ed38@gmail.com>
Date:   Mon, 25 Oct 2021 22:30:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Content-Language: en-GB
To:     Larry Finger <Larry.Finger@lwfinger.net>, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
 <7dc4eba4-c009-b8b7-bc08-5b608bdf86a0@lwfinger.net>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <7dc4eba4-c009-b8b7-bc08-5b608bdf86a0@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/21 8:45 pm, Larry Finger wrote:
> On 10/25/21 07:15, Saurav Girepunje wrote:
>> Remove the goto statement from rtw_do_join(). In this function goto
>> can be replace by return statement. As on goto label exit, function only
>> return it is not performing any cleanup. Avoiding goto will improve
>> the function readability.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>
Hi Larry,
 
> You need to read section 14 of Documentation/process/submitting-patches.rst to learn how to submit a revised patch. 
Resubmitting such a revision using the same subject line is likely to confuse reviewers and maintainers alike, if not patchworks.
>
This is original patch (v1). I haven't get any review comment for this patch.
 
> Larry

Regards,
Saurav 
> 
>>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
>> index 2b54cdfa9d6e..411b06e135be 100644
>> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
>> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
>> @@ -51,7 +51,7 @@ u8 rtw_do_join(struct adapter *padapter)
>>               ret = _FAIL;
>>           }
>>
>> -        goto exit;
>> +        return ret;
>>       } else {
>>           int select_ret;
>>
>> @@ -78,10 +78,9 @@ u8 rtw_do_join(struct adapter *padapter)
>>
>>                   rtw_generate_random_ibss(pibss);
>>
>> -                if (rtw_createbss_cmd(padapter) != _SUCCESS) {
>> -                    ret =  false;
>> -                    goto exit;
>> -                }
>> +                if (rtw_createbss_cmd(padapter) != _SUCCESS)
>> +                    return false;
>> +
>>                   pmlmepriv->to_join = false;
>>               } else {
>>                   /*  can't associate ; reset under-linking */
>> @@ -102,8 +101,6 @@ u8 rtw_do_join(struct adapter *padapter)
>>           }
>>       }
>>
>> -exit:
>> -
>>       return ret;
>>   }
>>
>> -- 
>> 2.33.0
>>
> 
