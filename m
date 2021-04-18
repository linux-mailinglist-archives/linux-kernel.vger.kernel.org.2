Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F1363666
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhDRPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 11:40:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60715 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhDRPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 11:40:22 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lY9Wb-0004a3-4d
        for linux-kernel@vger.kernel.org; Sun, 18 Apr 2021 15:39:53 +0000
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so9725807edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 08:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9JyrHCcIAgU62n209ZEUzZ15xktsnDu9faqnaWqMak=;
        b=ilPqyE2IzPh1ynXE5TNvU5TuTOSVz1f1QGjPgc8mQz+LtNNC5ayhw1A68RDc5npnOb
         W/Em1sLT9lQygoQHc5z+EyQcCNQ6nEVnFPgvTAzx8ftii3cEojtaE+1mEhW8h/24nYid
         gZcfYYMNku2eRz5R/qcH9rZW8LXoxtHPU8JRjwrBG8ZHzxmiRF2eNs3srlVhKXC7xnVF
         OqUpUuvD5TycW0VnlVGAV1XL6CBRkjBd+CghavxMh0KUn0ZbcZUz9I0IOmyR6GmLqbUL
         cl30djwc25mOUdnwNqGVmi1rACkwssIVMRQPI0xgk0uxrK6o+Q969LvfaUEcCOpawhzf
         Bu8w==
X-Gm-Message-State: AOAM53049DuMtdY0ZrFZR4q+CfcOS4MwBhLRgocQTSOb9velZocfYAJV
        XR7elqp8bcPgPQGv/n6PRVgTzImnY4PFpzoBNJSRKhyUWUfkIluI9bk35o8wBF3RQbS96Mj2Hbd
        LyGzp3sQE+gfPGyfcCy/rmF4shp++OqiTPnTznOJaBA==
X-Received: by 2002:a05:6402:2708:: with SMTP id y8mr21045641edd.265.1618760392471;
        Sun, 18 Apr 2021 08:39:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCgFtOHi7GuyeFXeAZGt5/M2fMsUw71W0Ns5LRVTvYdHDn2UadbxmhKPnb05SUTxBpJXA7Vw==
X-Received: by 2002:a05:6402:2708:: with SMTP id y8mr21045629edd.265.1618760392336;
        Sun, 18 Apr 2021 08:39:52 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id mj3sm8376987ejb.3.2021.04.18.08.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 08:39:51 -0700 (PDT)
Subject: Re: [PATCH] extcon: maxim: Fix missing IRQF_ONESHOT as only threaded
 handler
To:     Guangqing Zhu <zhuguangqing83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210415113648.21660-1-zhuguangqing83@gmail.com>
 <28b4db83-1381-f3aa-614b-08c065d4d409@canonical.com>
 <4479c7f8-6a80-8d30-0602-b8cc10dd901e@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <005ae6c3-2cd0-4c1e-b820-2674cb758de9@canonical.com>
Date:   Sun, 18 Apr 2021 17:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4479c7f8-6a80-8d30-0602-b8cc10dd901e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2021 16:41, Guangqing Zhu wrote:
> 
> 
> On 16/04/2021 16:43, Krzysztof Kozlowski wrote:
>> On 15/04/2021 13:36, zhuguangqing83@gmail.com wrote:
>>> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>>>
>>> Coccinelle noticed:
>>>    1. drivers/extcon/extcon-max14577.c:699:8-33: ERROR: Threaded IRQ with
>>> no primary handler requested without IRQF_ONESHOT
>>>    2. drivers/extcon/extcon-max77693.c:1143:8-33: ERROR: Threaded IRQ with
>>> no primary handler requested without IRQF_ONESHOT
>>>    3. drivers/extcon/extcon-max77843.c:907:8-33: ERROR: Threaded IRQ with
>>> no primary handler requested without IRQF_ONESHOT
>>>    4. drivers/extcon/extcon-max8997.c:665:8-28: ERROR: Threaded IRQ with
>>> no primary handler requested without IRQF_ONESHOT
>>>
>>> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
>>> ---
>>>   drivers/extcon/extcon-max14577.c | 2 +-
>>>   drivers/extcon/extcon-max77693.c | 2 +-
>>>   drivers/extcon/extcon-max77843.c | 3 ++-
>>>   drivers/extcon/extcon-max8997.c  | 2 +-
>>>   4 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
>>> index ace523924e58..af15a9e00ee9 100644
>>> --- a/drivers/extcon/extcon-max14577.c
>>> +++ b/drivers/extcon/extcon-max14577.c
>>> @@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
>>>   
>>>   		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
>>>   				max14577_muic_irq_handler,
>>> -				IRQF_NO_SUSPEND,
>>> +				IRQF_NO_SUSPEND | IRQF_ONESHOT,
>>
>> The same with all other patches for IRQF_ONESHOT which are send recently:
>> 1. On what board did you test it?
> 
> I didn't test it.
> 
>> 2. Is this just blind patch from Coccinelle without investigation
>> whether it is needed (hint: it's not needed here, it does not use
>> default primary handler).
> 
> I found the error notice from Coccinelle and I saw the code. Maybe
> I'm mistaken, I think it's needed here. Because handler == NULL and
> thread_fn != NULL, it use irq_default_primary_handler() in
> request_threaded_irq().

No, the primary handler is nested, not default one. Otherwise it would
have absolutely never worked. Therefore you are not fixing anything,
except Coccinelle report.


Best regards,
Krzysztof
