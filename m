Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51FF401E93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbhIFQfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbhIFQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:35:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:34:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d18so3093070pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O8n18z7rLfx8uTlu8mbd5ZKgxRoRp5FaBMjpyRXXLzQ=;
        b=qSBPybT9cuwckbQInt2HezUbkHGkVLBIcpKInkdzKF+i6yidPA/ZjQMG6QiSSvgLdQ
         4ye/gosKJR8QUOGj1pYVLR/Ai2eP1QtRLUXPnRU99y8K/+MTMBVUW9ic1l2rVYe2moSZ
         xZ14bnJzQ9SqXtks4X/uSKwPs1T+FmAouTYDFkZ0p6pxqd0wc45yoQsxoDIEjgyS3Ist
         5vxtVr9gE7LUCTsLre8ZVJ0sJjJPhChVkgXykQNs/sbVt83VXbfqFRSBbMTK8Q0ECnvL
         lENcC3yCZSmIsco+Xwt/3S2xJtzHEhJj8V0udGiSmX/LC21Agz7nmGlJa+Rox2GWDcYn
         g3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8n18z7rLfx8uTlu8mbd5ZKgxRoRp5FaBMjpyRXXLzQ=;
        b=mC3hycrLi013YBhBGRjH520kJBaoDHC6D/K7NUL4E8ZlwoekH4f2LeEtl7f1XTC1mo
         W4W8JSTAyK6f9u1Bw5/5AYZQUUch4ItSSecO6GwecgDNLg2yNIEnTJSn952bLvSy4d2u
         q9ZvsPfKr7DUEf7r3ZL/zt8SdHjAIsbpzI9zUAuokKxyB/NDXdtNvDlebnelJbcszYLS
         iVSaMDa55zxhBPUNsoDFnmHTcDKlQrVaPo2hYW7NUtHVjzjlHV1RKbCt3DXNZSJul/gb
         GzM6hh8BzaPSaHZMWzN+TJeAzQ/XPXkv3b1iYWTZfAyh4Ft/R2YXJAG/M5eh34MFv4CP
         2Y6Q==
X-Gm-Message-State: AOAM532t+C9KjrW+1zq22JlLG44xzGIPFIjOqw5oQHKVHGrLQBaP0cK5
        JcIdULI21suTq9JMtZR8FG1l/T+N/LTBAQ==
X-Google-Smtp-Source: ABdhPJwLeHuF8wr765sCOGlzuchOeDAdtHUBSP5yWXWKrrWVQxAia0PB35JpDOmdEhZ2U1vrQ5sHsA==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr14886159pjo.29.1630946053137;
        Mon, 06 Sep 2021 09:34:13 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id cm17sm4800pjb.35.2021.09.06.09.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:34:11 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: include: remove duplicate declaration.
To:     Greg KH <gregkh@linuxfoundation.org>
References: <YTRuXTu/kePBDwAF@user> <YTXj+6QU10tYmec7@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <c6cfec10-dc13-7d02-d122-76278b3d15be@gmail.com>
Date:   Mon, 6 Sep 2021 22:04:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTXj+6QU10tYmec7@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/21 3:18 pm, Greg KH wrote:
> On Sun, Sep 05, 2021 at 12:44:37PM +0530, Saurav Girepunje wrote:
>> Remove below duplicate declaration from rtl8188e_led.h file
>>
>> void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
>> void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/r8188eu/include/rtl8188e_led.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
>> index b00954198764..02cdc970bb17 100644
>> --- a/drivers/staging/r8188eu/include/rtl8188e_led.h
>> +++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
>> @@ -12,7 +12,5 @@
>>   /*  */
>>   void rtl8188eu_InitSwLeds(struct adapter *padapter);
>>   void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
>> -void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
>> -void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
>>
>>   #endif
>> --
>> 2.32.0
>>
> 
> This email did not make it to lore.kernel.org again:
> 	https://lore.kernel.org/r/YTRuXTu/kePBDwAF@user
> 
> Any ideas what is happening?
> linux-staging@lists.linux.dev
> thanks,
> 
> greg k-h
> 

I missed to add the linux-staging@lists.linux.dev. I will resend it v2 
version of this patch.
However I am able to see it on  https://lore.kernel.org .

https://lore.kernel.org/all/YTRuXTu%2FkePBDwAF@user/

Regards,
Saurav Girepunje
