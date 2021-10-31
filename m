Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96729441069
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhJaTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhJaTUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:20:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08969C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:17:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 127so14394064pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IAQ9nS8zKiAKP+4KgFuPNyKJDmfU+i6EpAM9T4tSUtw=;
        b=i0EYSUQ7VpH5A/MnbnEC0gEINup6xLh2LbKSvdklw8xQz5OpPD4PcA8WrICnUcqkc5
         gRxQhg8nasVHZldUCompSYSz3D9ugrVPh81OOI394f5AwDcVna0XSJK1XXp0KqhjKz/S
         1g7xXRWIWtrnv/N7sfgnmdERZNiXZtKvEqR1VQ3WB0IXwAwLk4DBJ0p0hC0pqtTGnKsj
         bcDRsGG0tOExnllq2RNzJYPtKt1f4jtkXDVyMSstzHN59ehMW6xtSeGUZ8n6tLnPAsCK
         WSGAMtI5dDXmq35UuCHxMg+L++HJHbDXjXXSmLlwkCKG3bVe+hLeGcyEas9TVe+F/ZsT
         +8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IAQ9nS8zKiAKP+4KgFuPNyKJDmfU+i6EpAM9T4tSUtw=;
        b=bPEZtgACI5roOAJkQvZ1KIGPlraDNfY8gd7aoNhiRFh909RWZCCeW/IML2F7PxfSuY
         HD/II+QrPD2NBBCh5xJjyUeqFsuDWVU9EZ21lU+EduOvnVGwJnFVF4UYrtun00pAJECl
         GydU5Y58UAbGeGwAI9xz2MSyu1e77vqU8UhQsjK0U50cRG9zUNupaJjDlY2GtyKgfE5/
         1zUfTpgOjbFI0FYGrbqnIbkor9dcBQ5gWQnJZEmT+tQTVB0hWmnwKsRMfYb7++PhEwLD
         OqKunNJ9Z6xdjCRGHq6Nrvq7+OJBsnhlnWD4L7YodkONSi/E6ULGhSaHY9tlAy3Imbf5
         ONIQ==
X-Gm-Message-State: AOAM533WCYADq+x1Oe87oKtNJRM677mkJXC4zj99CNlzHduviAmguDEg
        fVVPCNXa3pLSv+patB2IfwE=
X-Google-Smtp-Source: ABdhPJyfyL7jHzp387xHqNSgFcLlUrBgq9kV4JwSY6f7SCVTQqhZEIWgEkv7sKTZsI5cMno3Ob49zA==
X-Received: by 2002:a05:6a00:1906:b0:44c:b35d:71a8 with SMTP id y6-20020a056a00190600b0044cb35d71a8mr24421320pfi.51.1635707868249;
        Sun, 31 Oct 2021 12:17:48 -0700 (PDT)
Received: from [192.168.1.2] ([59.95.88.136])
        by smtp.gmail.com with ESMTPSA id z10sm13461694pfh.106.2021.10.31.12.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:17:48 -0700 (PDT)
Message-ID: <a74bd1d9-746c-650f-74e7-4a4b597348b7@gmail.com>
Date:   Mon, 1 Nov 2021 00:47:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-GB
To:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
 <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/21 12:13 am, Pavel Skripkin wrote:
> On 10/31/21 21:10, Saurav Girepunje wrote:
>> Remove the goto statement from rtw_init_drv_sw(). In this function goto
>> can be replace by return statement. As on goto label exit, function
>> only return it is not performing any cleanup. Avoiding goto will
>> improve the function readability.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
>>   1 file changed, 12 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
>> index 1418c9c4916c..4b409479108e 100644
>> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
>> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
>> @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>>   {
>>       u8    ret8 = _SUCCESS;
>>
> 
> 
> Btw, this variable can be removed completely then. It's used only for:
> 
> ret8 = rtw_init_default_value(padapter);
> 
> with your patch applied, but rtw_init_default_value() always returns _SUCCESS.
> 
I think rtw_init_default_value should return void. It's return value is not useful.
> 
>> -exit:
>>      return ret8;
>>  }
> 
> 
> And just `return _SUCCESS;` here.
> 
However rtw_init_drv_sw should return _SUCCESS here.
> 
> With regards,
> Pavel Skripkin


Regards,
Saurav 
