Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2975D44677D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKERDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhKERDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:03:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E6C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:01:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x131so4214668pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xsURJGLRNnzE+/ZVeB1/VoPg+vRN7TokqtjtTXhqXZ4=;
        b=K712YducHOeeG3nknJVfrZT1NcHoTLxMIV6GBxLnqtsxr8aV4Jhtxipo53pTp6jcOo
         6cpiAa+C3zRjwY11S6MZvCsIib8UlNJ2slfv3rofjM0I2aQ4x1bUdTGrbH7sUSKiXGyd
         z29h6HX8/ObTEY+7m/RsVy2TboMs9RIlBCjor3+wMXLqbzPvHX9gO/M7hoQDXCnmtrA6
         haBkJiHyzseb4VjZYcZ6M2OiUuaur9fPAUF9xEoVm15NyhaWuXmKx9VlaKxvO+TwSG7q
         Y3RKqrTx/Mu39mTHa03IB0Br5hnszo42LmDJDRiEwE3XIzFFyeTViHdbYD8m8rN0pw4C
         P7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xsURJGLRNnzE+/ZVeB1/VoPg+vRN7TokqtjtTXhqXZ4=;
        b=rce3kV08+aUAyaL+FYlR1a0bExgkx+SV9TDb5EAX+CRWVhmpYoB+wHjzCM7blbX3uW
         BgiI6O3BdChVHoaF4NJutBgUg1b8YG5Hb+j/W2aBM9oay97mIO3XxMiwi5BbMczFAilC
         E8aF+YqztBo5G63mtyimx/N6nSrJGEJm3NxnAlNEVNVI74MEU+NIvI0ZTw1CD3gVnqZ2
         ynGo4OhlAqLFEI2TGn3NqwiaER4bVCIQCxF4bAy9UdJgb3JcmW+pPjqqoJOi3OXRya+Q
         hbMAQdQO+Qs0NJI5zdhRVrBAJMsb3N0ei6ZSALL2Qim7giQJYd50nEpQNDYj9YsV3Egd
         WGNQ==
X-Gm-Message-State: AOAM533Caw+Ovxuhu9rFe4+pXuQT3HHIJQxxefPmoAtgISlokH0rByRi
        4WpIVMa3Qd+cEAGVQJZ5qC8=
X-Google-Smtp-Source: ABdhPJwrqnExkc17IhVVzj+2IbPPqG4ikL4QKYY7ynYNOGMYtY5ANpSxHSnuJ2MJ4SIZvnYkBmOCXg==
X-Received: by 2002:a63:f70a:: with SMTP id x10mr2372284pgh.12.1636131669430;
        Fri, 05 Nov 2021 10:01:09 -0700 (PDT)
Received: from [192.168.1.2] ([59.95.82.141])
        by smtp.gmail.com with ESMTPSA id q18sm8152946pfj.46.2021.11.05.10.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:01:08 -0700 (PDT)
Message-ID: <2bd55f74-be52-f182-b210-1d2d88fd8fdf@gmail.com>
Date:   Fri, 5 Nov 2021 22:31:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: core: remove the unused variable
 pAdapter
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YYNSAqGgDPhV1IE1@Sauravs-MacBook-Air.local>
 <YYT/s7TABtElQTnC@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YYT/s7TABtElQTnC@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/21 3:26 pm, Greg KH wrote:
> On Thu, Nov 04, 2021 at 08:52:42AM +0530, Saurav Girepunje wrote:
>> Remove the unused variable pAdapter from Efuse_Write1ByteToFakeContent
>> This variable is not used in the function.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_efuse.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
>> index 03c8431b2ed3..39c77f6b06ef 100644
>> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
>> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
>> @@ -40,10 +40,7 @@ static bool Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
>>  }
>>
>>  static bool
>> -Efuse_Write1ByteToFakeContent(
>> -			struct adapter *pAdapter,
>> -			u16 Offset,
>> -			u8 Value)
>> +Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)s
> 
> You can do this same thing in drivers/staging/rtl8723bs/core/rtw_efuse.c
> if you want to.
> 
> thanks,
> 
> greg k-h
> 

Yes, Now I have sent patch for drivers/staging/rtl8723bs/core/rtw_efuse.c also.
Thanks for pointing this.

Regards,
Saurav
