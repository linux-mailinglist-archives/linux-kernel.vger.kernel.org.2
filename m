Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC344333A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhKBQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhKBQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:42:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAAFC0432C7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:30:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k2so5449230pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pfwgbe2ksFAA3UJkUKv7Buq35y1OMHoVJCtwm+mmfws=;
        b=DtmfFBw1GdShKLk7kJwiwEjT73512QMSF3A/yBK1FObyez5Kx59YSwT8B8T3reAsNp
         EqSe5UmDrEFGmBbnY0Y/S0eb4/K1RGkyPvpEsTN/MaLEIwichvvw3fnGytsQFmAkPekH
         G7KeUly6c1LoevgzNPdH1TgbxeDZfTG7yWRIjVRVRtx306vj/Gk1a9oA1KMqM2KkMWLD
         mKLqGbfqd20v5NJLB1DHkWxIVCmRUKT+8f+nOUR13nqm5eQDJuszc7lHxW27iz3AIwaE
         5z/bVzewT+CitSAZX4ArqNCWlI0xVhKfwdp83Ae94i8g54dtyQ7sMqMZ9fQeaqCn4G1v
         lL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pfwgbe2ksFAA3UJkUKv7Buq35y1OMHoVJCtwm+mmfws=;
        b=5zP/V/mbxRpinV/d/yPG1n1W5lfNKUzgSa9tam9FcO+ogOCn8BvGuBle6qsJCd50ML
         nb0JvVYaR2p3VYMlQWtIehE/5w3pkd1Seshy1P5ELIuHsqeMHI31vhthk8rSBQC826Z4
         ukwvLruWpL7MtY296v+g3MoPvrhdafQ7CB9qteZengQgahlyrkaLrUg3dLVRMX9vHeBI
         JRHhmnjE7UGKV/kYiu/qEPt0Ig+PYbTyYbaL2QZ+RoUq8Qf0Zyv1Ad7YLaKmlVcB2lIX
         vPjEGpFt5Fh5uoLZcY1DcV8w80sWy/ZIYYBarisGBylZcN7t+KqfioxoJ1aIi2eUjL53
         LXwQ==
X-Gm-Message-State: AOAM5319fCnnWEqaKc+3g7oD4AVrWhB//eqcxZTwQk2vs6G0SPwjx4SW
        h+ZKtbkZ/iih7dJYVDz1qOQ=
X-Google-Smtp-Source: ABdhPJwKUqqfB/vDdiLKQ/5v2QLyxMDw4R1pMy9hzE0DiaKGH4dEzcyqIbaUAEk3/BayGvKaSpZK6w==
X-Received: by 2002:a05:6a00:1312:b0:44c:becf:b329 with SMTP id j18-20020a056a00131200b0044cbecfb329mr37976011pfu.5.1635870624634;
        Tue, 02 Nov 2021 09:30:24 -0700 (PDT)
Received: from [192.168.1.2] ([59.95.93.69])
        by smtp.gmail.com with ESMTPSA id s22sm18820163pfe.76.2021.11.02.09.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 09:30:18 -0700 (PDT)
Message-ID: <9bbc97e2-ab20-efb4-d055-ebce021b7c97@gmail.com>
Date:   Tue, 2 Nov 2021 22:00:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
 <YX/lJMEfqXqlserL@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YX/lJMEfqXqlserL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/21 6:31 pm, Greg KH wrote:
> On Sun, Oct 31, 2021 at 11:40:18PM +0530, Saurav Girepunje wrote:
>> Remove the goto statement from rtw_init_drv_sw(). In this function goto
>> can be replace by return statement. As on goto label exit, function
>> only return it is not performing any cleanup. Avoiding goto will
>> improve the function readability.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
>>  1 file changed, 12 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
>> index 1418c9c4916c..4b409479108e 100644
>> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
>> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
>> @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>>  {
>>  	u8	ret8 = _SUCCESS;
>>
>> -	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
>> -		ret8 = _FAIL;
>> -		goto exit;
>> -	}
>> +	if (!rtw_init_cmd_priv(&padapter->cmdpriv))
>> +		return _FAIL;
>>
>>  	padapter->cmdpriv.padapter = padapter;
>>
>> -	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
>> -		ret8 = _FAIL;
>> -		goto exit;
>> -	}
>> -
>> -	if (rtw_init_mlme_priv(padapter) == _FAIL) {
>> -		ret8 = _FAIL;
>> -		goto exit;
>> -	}
>> +	if (!rtw_init_evt_priv(&padapter->evtpriv) || !rtw_init_mlme_priv(padapter))
>> +		return _FAIL;
> 
> These are functions that are being called so keeping them separate as
> the code you removed did makes it "obvious" what is happening here.
> 
> So can you keep it that way please?
> 
I will make them separate as they were.

> But my larger question is do these functions create state or allocate
> memory that needs to be unwound properly if an error does happen?  Right
> now the function seems to not be doing that at all, but that does not
> mean it is correct as-is...
> 
> thanks,
> 
> greg k-h
> Regards,
Saurav

