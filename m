Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2E42809C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhJJLEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhJJLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:04:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4316C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 04:02:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 133so8046630pgb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:cc:subject:content-language
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=mGt9AjRyz59TKgLh09y9NCFfjgPuJll6eNqrTFHEAzw=;
        b=P8XtbNXAFvT1qDgRluJ3jMCie2isFNR6WZD79lKOdqcphRLa2g9ihFMtk1GZ8DcMYI
         IS4eblrL3XuNwYblQGkjzVdVvB+oRImzEhCydaSXP77oi3U+c5KNvQhU83Paumo2ReOA
         BxmOexVPl6o/Ot9KoseSDgUHUN6VnbwuFWXJ0jqkoi6j/67kgEklVK/HcHVibnPn4he1
         +388Q7rBEQdXfY9v1kCbDHmbXWI/sLMwDk4w1HJRqqVWuH678OyBBm0Lz9remLblPDxv
         0EmMIsZ+M+hBJi/VDDbmLtUCKdkyp3QUpwQyEplFDhxYvwUejc0briWDtP4LdxIH+yc7
         93HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mGt9AjRyz59TKgLh09y9NCFfjgPuJll6eNqrTFHEAzw=;
        b=gEmJMO9/6neOTPVKj4Bg1KwCxT7tMWcY2tagF2nFnyuPSV9fxTNyjUdfx6JXsnH+tm
         W21Bx/TQzaY/1Mwe84dYSLfWgMXfHDUluN1Dg7+9Baq7kfWX8djJKulPsNBWO31skgpO
         KeTJQpTKWHpchl8/A3yauE1QQdZytUjpAoqDFKPccRytOS5EoD1RpDICuKkot9diW8ex
         zspm7/4dcO/ex8/Ps88swtixaloj3htsrqi8/sajrFzbTaMhKirqmj2aSm0OFepNqYYS
         mnNl11gQFFqNOmV1ZoqsW26ALanL8aTo1i3jmfFxiACVHdx65AALvxRinZdLROWzm9U3
         qukw==
X-Gm-Message-State: AOAM532cLd6ggZ2hggoRtQI5FhAdgbD1zj8ldqW/a1fM0i5lZarlQad5
        sSjaG7lt2vaCdAjUrKjVqpv6g07DKGA=
X-Google-Smtp-Source: ABdhPJy930qii06q21V5rCtyuW9c0etlhTpXJyVEyPtZM8q5RW0ySqU1O/+IJNKeL7H8+EwB0DJKvA==
X-Received: by 2002:aa7:9285:0:b0:44c:caf5:341 with SMTP id j5-20020aa79285000000b0044ccaf50341mr17327648pfa.1.1633863733066;
        Sun, 10 Oct 2021 04:02:13 -0700 (PDT)
Received: from [192.168.1.6] ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id d22sm5073571pgi.73.2021.10.10.04.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 04:02:12 -0700 (PDT)
Message-ID: <9dca9f7e-f987-5be5-9523-7dd08c2b364e@gmail.com>
Date:   Sun, 10 Oct 2021 16:32:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Cc:     saurav.girepunje@hotmail.com, gregkh@linuxfoundation.org,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        lee.jones@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: remove if condition which is
 always false
Content-Language: en-US
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
References: <YWKXKGuA/Io9sEjf@user> <YWLFf1zPvK9gz+7+@agape.jhs>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YWLFf1zPvK9gz+7+@agape.jhs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/21 4:20 pm, Fabio Aiuto wrote:
> Hello Surav,
> 
> thanks for your patch, see a comment below,
> 
> On Sun, Oct 10, 2021 at 01:02:56PM +0530, Saurav Girepunje wrote:
>> Remove the if condition which is always false. The last update on
>> variable max_rf_path is value 1. It's value is not changing after that.
>> So if condition check for value 2 will be always false only.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>> index 392cc8a398f5..612575ba961a 100644
>> --- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>> +++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>> @@ -106,12 +106,10 @@ static s16 odm_InbandNoise_Monitor_NSeries(
>>   	pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
>>   	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];
>>
>> -	if (max_rf_path == 2) {
>> -		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
>> -		reg_c58 &= ~BIT7;
>> -		pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
>> -		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
>> -	}
>> +	reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
>> +	reg_c58 &= ~BIT7;
>> +	pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
>> +	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
>>   	pDM_Odm->noise_level.noise_all /= max_rf_path;
> 
> If the condition is always false the whole block can be wiped out,
> why did you keep it? Did you change the logic here?
> 
>>
>>   	/*  */
>> --
>> 2.32.0
>>
> 
> thank you,
> 
> fabio
> 

Thanks for review Fabio.
It is changing the logic . I should be careful for this. whole block of 
if statement should also be removed.


Please ignore this patch.

Regards,
Saurav
