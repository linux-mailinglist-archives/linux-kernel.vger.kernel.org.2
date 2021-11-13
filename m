Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFB44F158
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhKMFSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 00:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhKMFSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 00:18:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 21:15:43 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k4so10017278plx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 21:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f6RV46JFP1vnddjnNTCzC7CXwyM/jUs5OPYC1QMeUvs=;
        b=FWlXtTaKEdajLInMJq5MS27S9bx9AzGj3jxhvVDH1Oz6rqj/YTPWHkluMEf4oVgvYA
         HA6JSz1pYRvQvloVmrXfZPu7TuSaYUK31WYF9Xcq/d4pn2U+5zqKVI5EUaH54VQC3HPi
         Aoiw1ztz6H1pmrKdXjD3NA6YlSotwnTssmNCQ2dSR/4I6uHUsIuR2Zm0Ew3pnE2d6KtI
         MQmigDwIg34yUQQy4GjE7SFsWjE6xD7Gv/yssrc+1LX/3L4HUgejLuRGdKI3NgMeUTIp
         7r8pyWxJQHeAXcydnzj6CzieJ6lWxfJfWDXtvl3Iw3QyXi9sm6vOCobyl8xQW54maOeM
         EQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f6RV46JFP1vnddjnNTCzC7CXwyM/jUs5OPYC1QMeUvs=;
        b=lmFhY1qQnHlCwe3DrSjKcvKfUiLPI+CmNQzBSJ5alKqHiMyoXPWQJVgEFxmax+NHrr
         B5q71eB8aEn1R8WFr1FJALP04ARLDzvoiv38JQSFVdtCDDfixDq0IjlsrAiT00SZlxDj
         Ju4nPLVnG0xjArGVaFq0UKRqnfS7n4d0yuArDNFudulr7zrxup7gxqGi+KGLHUEY+iU4
         rLwRw0/+GP69H5EnwISDNow4FVGaJCBkSl00kigAP/GRyj4dvb5v6MQHzY9VJ4k+XU7T
         vu/7bHzSRh+YcaKt3Kh//vHfqpI1zUz0FwSC6/SEwBkFoUDuRvHr7j0DDVuaF4nxpVdc
         WbWQ==
X-Gm-Message-State: AOAM531PqUopizr8+wafTPFdeUKmJZ+TbfBrpyXvebfopsppLrXI4y8A
        FGEmunjISrMQ/PM4m3txAo6gH+yOSHk=
X-Google-Smtp-Source: ABdhPJxFuJgR3xZOql4c3JCRvPhcVjrvi+5FZY8aaqWF5MgyRe+QXo0TJACfIgX98hB3fbeZ+1IFHw==
X-Received: by 2002:a17:90b:3882:: with SMTP id mu2mr21805426pjb.165.1636780542391;
        Fri, 12 Nov 2021 21:15:42 -0800 (PST)
Received: from [192.168.1.2] ([59.88.110.49])
        by smtp.gmail.com with ESMTPSA id q6sm6092687pgn.42.2021.11.12.21.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 21:15:41 -0800 (PST)
Message-ID: <6ff3bdd8-cc32-1cc0-a31a-3a3b48c87f55@gmail.com>
Date:   Sat, 13 Nov 2021 10:45:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YYwMq15pQYf7nvt9@Sauravs-MacBook-Air.local>
 <20211110184525.GM2001@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <20211110184525.GM2001@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/21 12:15 am, Dan Carpenter wrote:
> On Wed, Nov 10, 2021 at 11:47:15PM +0530, Saurav Girepunje wrote:
>> Remove the goto statement from _rtw_init_recv_priv(). In this function goto
>> can be replace by return statement. As on goto label exit, function
>> only return it is not performing any cleanup. Avoiding goto will
>> improve the function readability.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_recv.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
>> index 51a13262a226..b38af76f3a67 100644
>> --- a/drivers/staging/r8188eu/core/rtw_recv.c
>> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
>> @@ -58,10 +58,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
>>
>>  	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
>>
>> -	if (!precvpriv->pallocated_frame_buf) {
>> -		res = _FAIL;
>> -		goto exit;
>> -	}
>> +	if (!precvpriv->pallocated_frame_buf)
>> +		return _FAIL;
> 
> 
> I hate pointless "goto exit;" labels, but there isn't a rule against
> them and I feel like this is not a good enough patch on its own.  There
> is so much other stuff wrong with this function.  It probably *should*
> have some error handling for example.
> 
> I don't think this patch really adds enough value.  Take a look at the
> function and almost every line can be improved...
> 
> regards,
> dan carpenter
> 

OK, I will send the other patch to improve this function,
Thanks Dan for review.


Regards,
Saurav 
