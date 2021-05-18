Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14A38706D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 06:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEREBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhEREBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:01:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:00:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d78so5575719pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3POdstfkt+dZTR4OIcnuNy8s2PWHNkzuJgiQuuTgAQ=;
        b=KS1e8JpG2CnFawuDNSvvKKQUfQMW1Q6fDV4/tOM2M+VNKTUmdwpVHCtL94rRPUxT5x
         BwFmCm+m4kgbn+glU8S7n/JOr9RPbau2vSLv8bNFyvJevoFQ6J5bif/nM5qu6dRjzaFj
         FtsjMMnbvwnGImjh3KMrGgT0Vg8FFC90sBZowIDDdka/Wib0HAMZEkG1LPc06v8JVonx
         xO7cJ082vJF5WL1LuAFQirgogZoFi6mH8L3uc9Hjx+6+Zbdhpsp3p6m6C65fEYYKuakA
         djQcgJE+0xrpeVjtfPnLILdlc8Etf+Ho0bswHVY6Q+H/3AULtyH9JGBE9FYuApnb1n1L
         48lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3POdstfkt+dZTR4OIcnuNy8s2PWHNkzuJgiQuuTgAQ=;
        b=PS2rxSV1M9Z99EReoGNjoqiwHTEXrJPaemf4xJ2pI+/bFXyaApk4U2/83g9oWJG7Qr
         bL3H+W8jDgdv95/TDLkRruTuxei7VWBDsE3+G/1uiMSTbxl16YZUYk99FuUhgRsrWJ4x
         g9B8nsVTaJZxCDytpAk9i1las4RU19+3VYD0No0Wd5LB0LnUB8ufrUkc0fZrr674S1Ky
         /iIvKiEcSqjO8FNuU/npbYt9/Enw5RwyV413memlWq+84UlLIak4mloyVfgI7yBfsYAF
         NGPkC47xnmAGeoAh7uAAUAyGLfKlYKXBWUBdWm9pKK7BFfZ/UeIMwK8L1WcyKIuKdDZy
         PMtg==
X-Gm-Message-State: AOAM531nRYlNT/wjcQ9kVY1e5SSa2CarkFbaVv9fiZsD7k33+D2F9LEN
        hf0lcmec9KsP07miBSLUfRYvxv59ofeV02UVlx70nA==
X-Google-Smtp-Source: ABdhPJwQWx4oTSaAqUlBwAQjgE4KgZqzb3+auhP7v9j+gC5Dm7V3K4AxQGfbZAClrVmLrLJ+ss6pDQ==
X-Received: by 2002:aa7:8d5a:0:b029:227:7b07:7d8b with SMTP id s26-20020aa78d5a0000b02902277b077d8bmr3130429pfe.26.1621310431545;
        Mon, 17 May 2021 21:00:31 -0700 (PDT)
Received: from [10.71.15.213] ([203.126.139.254])
        by smtp.gmail.com with ESMTPSA id f6sm10795529pfe.74.2021.05.17.21.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 21:00:30 -0700 (PDT)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, fmdefrancesco@gmail.com,
        eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, skhan@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
 <20210516122927.1132356-8-desmondcheongzx@gmail.com>
 <20210517101302.GF1955@kadam>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Subject: Re: [PATCH 7/7] Staging: rtl8723bs: fix block comment in
 HalBtc8723b1Ant.c
Message-ID: <197c91ac-5db2-f439-0f88-0f3da04842f6@gmail.com>
Date:   Tue, 18 May 2021 00:00:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517101302.GF1955@kadam>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/5/21 6:13 am, Dan Carpenter wrote:
> On Sun, May 16, 2021 at 08:29:27AM -0400, Desmond Cheong Zhi Xi wrote:
>> This commit fixes the following checkpatch.pl warning:
>>
>> WARNING: Block comments use * on subsequent lines
>> +		/*
>> +		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
>> index cc7f558903ac..87156b2cd1f0 100644
>> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
>> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
>> @@ -2511,10 +2511,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>>   		CL_PRINTF(cliBuf);
>>   
>>   		/*
>> -		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
>> -			pCoexDm->errorCondition);
>> -		CL_PRINTF(cliBuf);
>> -		*/
>> +		 *CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)",
>> +		 *	pCoexDm->errorCondition);
>> +		 *CL_PRINTF(cliBuf);
>> +		 */
>>   	}
> 
> Always just delete dead code.  Otherwise the patchset seems good.
> 
> regards,
> dan carpenter
> 

Thanks for the feedback, Dan. I'll remove the dead code in a v2 patchset.

Best wishes,
Desmond
