Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE84398CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhJYOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJYOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:42:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C8C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:40:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 75so11143882pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iGNob6sTb6S2amKiUvAi/+pjHea/cA815c+QZDOlSkk=;
        b=SRja/ig4qID04QNrtzOjXzHx68AuZ/JPjGRN0FSNg1iR2DONyR08nTjffkI0ZQf1Hj
         rBU5DvjoQpB33IAEWPyTY4RgcvR9UjXxEGjzBWRy9NjU/LA9reBg+agUxHM1hpAB1ePs
         q4m9XMDlTxtngfMuMCuzJDhe50MeEQfEjnXnkoSwWsYljVk3s/G9cunMS9KA71nOUIjU
         J+BNm9SygUzwaZKFALZ/OX+H/UBn9HEQg4qI6/G3fo4++lJNX2fv3vtSFZnxqKaWofza
         +fkGhq9nj/pGTRdlcoPaftB6Z3nexedio+kYnZEmzZzNljYNXrjs3sLtq3Vq/BKXcdWR
         XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGNob6sTb6S2amKiUvAi/+pjHea/cA815c+QZDOlSkk=;
        b=kxOd4WkypJn3PaQsUHSds5ln8aDYDH7cFwCuY54MW8hNczf4tIvhoT6iaxFUNeCBc1
         ODwmpxpuoB+NXf0ZYIooEr2N/YBZdHgc+at3Sr2oRjLgkauZ0USLZU7hBVtDqI9eg90S
         xBKHBOlJJ+jzPAUZWu5s+Htc1ReYZ83w+GBf3JY+0GlDN4hjmM2+ztdGjK5F1g+iRMdD
         4v8s2qX8/BgAXls0ZD1NM/slT+XXJdlsbEn2lWXuSt48mET8zuHJ8Z2uuNrVo/KKIxY3
         NA+1Pd800+fpV3PF7U7+81uA89n2+N7pFdJVOWWJAEWRSM/Qm1EPCcmB0ImnDMsnFimN
         UDHA==
X-Gm-Message-State: AOAM531AvuBVovUagShyUB9OfUJIY8ciSJmVKr6bxdFjvor+YOw6phOW
        qmCBkhOBNDn1b5PzevivK0A=
X-Google-Smtp-Source: ABdhPJyZqBQsSw8EwvP3aF9kmS1Y+v5FEtKrCTF7pKjlFvN1AKLq3DXTqBs8jU/U242PPj8qvF7EiA==
X-Received: by 2002:a63:e510:: with SMTP id r16mr13954005pgh.34.1635172801462;
        Mon, 25 Oct 2021 07:40:01 -0700 (PDT)
Received: from [192.168.1.4] ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id z12sm21357381pjh.51.2021.10.25.07.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:40:01 -0700 (PDT)
Message-ID: <79254f8c-1d11-320a-6fdb-3ca066a8862a@gmail.com>
Date:   Mon, 25 Oct 2021 20:09:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: avoid use of goto statement
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YXY5jtR6neQ+ad+C@Sauravs-MacBook-Air.local>
 <YXZVV9j2DMA22MUS@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YXZVV9j2DMA22MUS@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/21 12:27 pm, Greg KH wrote:
> On Mon, Oct 25, 2021 at 10:28:54AM +0530, Saurav Girepunje wrote:
>> Remove the goto statement from _rtw_init_cmd_priv(). In this function
>> goto statement can be replace by return statement. By replacing the
>> goto statement with return statement local variable "res" is also
>> not required.As on goto label exit, function only return it is not
> 
> You need a ' ' after the '.' here please.
> 
>> performing any cleanup.Avoiding goto will simplify the function.
> 
> Same here.
> 
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_cmd.c | 16 +++++-----------
>>  1 file changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
>> index e17332677daa..22046bd5cf82 100644
>> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
>> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
>> @@ -19,7 +19,6 @@ No irqsave is necessary.
>>
>>  static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>>  {
>> -	int res = _SUCCESS;
>>
> 
> Please also remove the extra blank line.
> 
> thanks,
> 
> greg k-h
> 

Thanks greg for review. I have updated the patch and sent v2.

Regards,
Saurav Girepunje 
