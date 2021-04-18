Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A33635E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhDROm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhDROm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 10:42:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EEC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 07:41:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c17so21494074pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HA/nQ9a0aIaMmJh37TeuAfZ0WRE/1l2oAPKs1EQpS28=;
        b=e9KqHfrf9/scwbYvQpxWMwjJ+R/6VvwlQln+VUyrdRhDEknG+FFOUECNxXkmH4L4uX
         Pfjf0j4N78CoDv9ZlUwnN8hQfNRn4yG22FlzTzNV4lH8kBVS5M+xxkyfmFVeTohByQPL
         USJJMOi7PmND3ELgA0BW0P+q0iqFrrRmkYjpnvgpVOcsGRlxb8n8sZT4UYaGEU6Lx/lq
         cix/KxBJFLmnJVHHkEvU4XjLmiQMhNp9ndvGH1HbO7KjcOrZ+f/kCw0ezxULzavt53wm
         c/ZWkTHDprgI6DizmazTPUTCJrt4cBRlJSqdfYgv+Lam3rFsZcibG62OC+uthJ5E+QqY
         xrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HA/nQ9a0aIaMmJh37TeuAfZ0WRE/1l2oAPKs1EQpS28=;
        b=AHtO+f1FawKOlBgPMki/3TM6avvtngugoRZJG9p4IKayhVGQKJeqZxHAMh+vwKgrgU
         QJJPlbr0SQYS4Uq/b1yfkMdspccr3nWOVgWCPPfUSbOlkJRmcqvIORUEpfvgNGGWYQ7Y
         +rweAoMp6Mhvc14BzcL1yTHRpPZ7/9Z5kwZdm1zH9SsEaqcGUCrLt6Ek54vGkEXCs4ZX
         sgt3szvdDah+Q3ty4OBGMvJMxGI/3b61gFGyxVLL9BNftS9L+AHFLgj5in0gm2vsFoF/
         snhDnzwNKuNtKyuYUfai+DewvbfH1mBYnwmdpSIXIht7xYzSzk9eU/UfdQwQT6H62Rb3
         JvTg==
X-Gm-Message-State: AOAM533Dq7liF8hWALF3yQAnOLTZgDHOq9t67xyIg2Xb1p4PsA7Qvp0U
        IxEkDmdV6TUg9En4YOaOIS70dPLxu3opQv//
X-Google-Smtp-Source: ABdhPJyqUfjtoQE3hYcbKDquq4fyBJ8YrUawKuurjQubZocmmKVjc20Mi951ZWrEOujcSmbGx+KumA==
X-Received: by 2002:a63:d143:: with SMTP id c3mr7507007pgj.99.1618756918541;
        Sun, 18 Apr 2021 07:41:58 -0700 (PDT)
Received: from [0.0.0.0] ([2600:3c01::f03c:92ff:fe9c:eb22])
        by smtp.gmail.com with ESMTPSA id lt11sm11693916pjb.23.2021.04.18.07.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 07:41:58 -0700 (PDT)
Subject: Re: [PATCH] extcon: maxim: Fix missing IRQF_ONESHOT as only threaded
 handler
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210415113648.21660-1-zhuguangqing83@gmail.com>
 <28b4db83-1381-f3aa-614b-08c065d4d409@canonical.com>
From:   Guangqing Zhu <zhuguangqing83@gmail.com>
Message-ID: <4479c7f8-6a80-8d30-0602-b8cc10dd901e@gmail.com>
Date:   Sun, 18 Apr 2021 22:41:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <28b4db83-1381-f3aa-614b-08c065d4d409@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2021 16:43, Krzysztof Kozlowski wrote:
> On 15/04/2021 13:36, zhuguangqing83@gmail.com wrote:
>> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>>
>> Coccinelle noticed:
>>    1. drivers/extcon/extcon-max14577.c:699:8-33: ERROR: Threaded IRQ with
>> no primary handler requested without IRQF_ONESHOT
>>    2. drivers/extcon/extcon-max77693.c:1143:8-33: ERROR: Threaded IRQ with
>> no primary handler requested without IRQF_ONESHOT
>>    3. drivers/extcon/extcon-max77843.c:907:8-33: ERROR: Threaded IRQ with
>> no primary handler requested without IRQF_ONESHOT
>>    4. drivers/extcon/extcon-max8997.c:665:8-28: ERROR: Threaded IRQ with
>> no primary handler requested without IRQF_ONESHOT
>>
>> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
>> ---
>>   drivers/extcon/extcon-max14577.c | 2 +-
>>   drivers/extcon/extcon-max77693.c | 2 +-
>>   drivers/extcon/extcon-max77843.c | 3 ++-
>>   drivers/extcon/extcon-max8997.c  | 2 +-
>>   4 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
>> index ace523924e58..af15a9e00ee9 100644
>> --- a/drivers/extcon/extcon-max14577.c
>> +++ b/drivers/extcon/extcon-max14577.c
>> @@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
>>   
>>   		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
>>   				max14577_muic_irq_handler,
>> -				IRQF_NO_SUSPEND,
>> +				IRQF_NO_SUSPEND | IRQF_ONESHOT,
> 
> The same with all other patches for IRQF_ONESHOT which are send recently:
> 1. On what board did you test it?

I didn't test it.

> 2. Is this just blind patch from Coccinelle without investigation
> whether it is needed (hint: it's not needed here, it does not use
> default primary handler).

I found the error notice from Coccinelle and I saw the code. Maybe
I'm mistaken, I think it's needed here. Because handler == NULL and
thread_fn != NULL, it use irq_default_primary_handler() in
request_threaded_irq().

> 3. If you think otherwise, please explain.
> 
> Best regards,
> Krzysztof
> 

Thanks for your review.

Best regards,
Guangqing Zhu
