Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85F400AA7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbhIDJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhIDJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:42:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D960C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 02:41:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v123so1444339pfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2CvcJSiEN9MNXuAzxJzwyEfnTU0mKkfe0+AjDJ9kifY=;
        b=PSAR8amj8SgeZssZ3i6aMhFnhx1d4yc7BYIy+eXaxcMCN1aRoV2VqqXOM2pmH1LvRh
         suidGUSlvYdrWD6WtmksppAQQejgzqMFdNY+FvjO2wKBY14MmY1LOB888gf890VzaV2I
         nTP5g2G8jyoBaDxBGJRLcDQ98Vvq67nwdzFCIbge+CWR77ynC61LFys+8KVF4qlIBI/U
         3osF4Ki1nBsfaUgPkJ7opkfRy4sw6+tt2mY5fFzIoT4i/ZCfU51LENFPBxUD7MkJG+C8
         W2A8sc/jgNGKU16m2bGUqCtY95b23dyuP4WZomR7tlXbXhUpd+fsXmuYtrmciKNqFgzN
         n1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CvcJSiEN9MNXuAzxJzwyEfnTU0mKkfe0+AjDJ9kifY=;
        b=TendqE8SIpPDHej45IpLhYvaPWln5Hw680WjfTY4DLArRJx2rZYaKXX5yW36RQAzk9
         i3t91YjGX+N0+XHLWxcz4GfL4V74Y24j/SL1emuV+/kXC+otXVBeLNbHJ20XQnqERhVG
         lVmNewbiL0RjF/ummR6IVeRBTDsbSdgQjeCX0nAnX6acCGM7LYWF+3qSNSf2OWET6ru8
         xn771Xp/aJBEZekJBrgq2xeb02eh8eenzaNRfop7DuS5GBnxlT93/AZLdCH0BqH/p4E+
         ofAv46UArejR1FpjJVvaZQVT8owwKFLDsbBisL2V9TPngmjHeRNiIZWgu2skOgx2VWtH
         DwZw==
X-Gm-Message-State: AOAM531OehqRaRmhNN3nUWBGS3kLiXSf3B4fl6+/OZcx6CFhgj4V1H0g
        TIAgNmodydJ1OtgVplJvlP0uIMn5GfRIhg0d
X-Google-Smtp-Source: ABdhPJxq2rms+uXKvb4icD3P3JOkrs3NOtHPFvW/WtVyj4BtTwAnf8MfiVqQ6s96O3u9y/XiLBUpcg==
X-Received: by 2002:a63:ef58:: with SMTP id c24mr2902397pgk.299.1630748461514;
        Sat, 04 Sep 2021 02:41:01 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id d15sm1797118pfh.34.2021.09.04.02.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 02:41:00 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc
 and memcpy
To:     Phillip Potter <phil@philpotter.co.uk>
References: <YTJhwQstKPUYRwN+@user>
 <CAA=Fs0mP7xqiS7+EX+J5MYH-AkEN_5SgtLrxAd669kXHG7Jk+A@mail.gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <52642929-cec1-d03b-03f1-130a54c0c289@gmail.com>
Date:   Sat, 4 Sep 2021 15:10:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0mP7xqiS7+EX+J5MYH-AkEN_5SgtLrxAd669kXHG7Jk+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/21 12:23 am, Phillip Potter wrote:
> On Fri, 3 Sept 2021 at 18:56, Saurav Girepunje
> <saurav.girepunje@gmail.com> wrote:
>>
>> Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>> index 81d4255d1785..495fadd2b8c8 100644
>> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
>> @@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>>          }
>>
>>          if (ielen) {
>> -               buf = kzalloc(ielen, GFP_KERNEL);
>> +               buf = kmemdup(pie, ielen, GFP_KERNEL);
>>                  if (!buf) {
>>                          ret =  -ENOMEM;
>>                          goto exit;
>>                  }
>>
>> -               memcpy(buf, pie, ielen);
>> -
>>                  /* dump */
>>                  {
>>                          int i;
>> --
>> 2.32.0
>>
> 
> Dear Saurav,
> 
> Looks good, thanks:
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Regards,
> Phil
> 

Thanks for review Phil

Regards,
Saurav Girepunje
