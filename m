Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3B36048F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhDOImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:42:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhDOImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:42:09 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxZK-0000BB-7Y
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 08:41:46 +0000
Received: by mail-ed1-f70.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so4830346edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi9RAwPaSe5m0kq6sTRon9limNuBDI5Ubk2v5g6X0T8=;
        b=Myv4b5sp3pCvy67qFqhU7AVWNseWwaPMfAEfAzlBoVJmltm04uZvhSlSFl8tZvhV2+
         i09iYccCTuVbJYGPX7jYSr0BG/cjQBh/k52ovw7tRLU32yhBF9hEDX+uKSvgByezR6YZ
         SrdUjiBZf0WXfA7Db8Hw3Zy4qQ8jms5o+X+U3EUN7VLZIA2FLFkbD/Gg+5b5t5JVYTzc
         lnWY+wPtQB3WGjthqT+akJl2yJ9tEYcDnwWkh0BONeR81riPMTbVPk7UigZU2deBkjKE
         jfpAfvKxXYWEQpu+BiZTAC7LiTqI9K28Tnl4zevL21U/F6hIyYqvcwphSzvxlgt1KMhL
         AXqg==
X-Gm-Message-State: AOAM5302fPKDw5a83AIsXSgdTJkOrheHeLFXaaJ4XbEIWr5+0oZEtng9
        6ex5q0Hu+bPPiKCbhb3AHOUoJyraNCOXeR/2i0XgcNy1RWsf92sDGp/9g97qH6VM0H3L9E/4lsc
        RM3RGD2xG9X0Vhxtf8H1pTtcmkIrhwp9sOggwDBl1MQ==
X-Received: by 2002:a50:ec93:: with SMTP id e19mr2825517edr.50.1618476105956;
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXAkMKWmdA2rywHv5eaow+dB7GK6Y4X4sednUAUsDZq1L6GupvMkgFX7rHbqiQqb8XW0RLQ==
X-Received: by 2002:a50:ec93:: with SMTP id e19mr2825500edr.50.1618476105796;
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id a17sm1423391ejx.13.2021.04.15.01.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference
 when probed via platform
To:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
 <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
 <74059494-3610-c24e-7d09-b89106c0a396@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f66d3d81-d824-18e9-18e2-098b1f85f664@canonical.com>
Date:   Thu, 15 Apr 2021 10:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <74059494-3610-c24e-7d09-b89106c0a396@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 18:49, Sylwester Nawrocki wrote:
> On 14.04.2021 17:25, Krzysztof Kozlowski wrote:
>> On 14/04/2021 17:12, Krzysztof Kozlowski wrote:
>>> The driver can be matched by legacy platform way or OF-device matching.
>>> In the first case, of_match_node() can return NULL, which immediately
>>> would be dereferenced to get the match data.
>>>
>>> Addresses-Coverity: Dereference null return value
>>> Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
>>> -#ifdef CONFIG_OF
>>> -static const struct of_device_id sdhci_s3c_dt_match[];
>>> -#endif
>>> -
>>>   static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>>>   			struct platform_device *pdev)
>>>   {
>>>   #ifdef CONFIG_OF
>>> -	if (pdev->dev.of_node) {
>>> -		const struct of_device_id *match;
>>> -		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
>>
>> Now I have second thoughts whether NULL pointer can actually happen.  If
>> device is matched via platform/board files, maybe the pdev->dev.of_node
>> will be NULL thus skipping this branch?
>>
>> Could there be a case where device is matched via platform_device_id()
>> (which has different name than compatible!) and (pdev->dev.of_node) is
>> still assigned? Maybe in case of out of tree DTS?
> 
> That seems unlikely, the platform device would need to be initialized
> via board file and then its of_node assigned somehow. It doesn't make
> much sense to me. We either use board file or dtb to instantiate devices.
> 
>> Anyway, the patch makes the code simpler/smaller, so I still think it is
>> reasonable. Just the severity of issue is questionable...
> 
> Yes, the patch looks good. Similar cleanups are already done in most of
> the s3c/s5p/exynos drivers.

Thanks Sylwester, I'll resend with different description.


Best regards,
Krzysztof
