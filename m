Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30321382D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhEQNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:41:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhEQNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:41:06 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lidTI-0002WE-FB
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 13:39:48 +0000
Received: by mail-qv1-f71.google.com with SMTP id q15-20020a0cf5cf0000b02901ecb7d57bccso4714393qvm.17
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0GyDjKGOaiBFyj0VO0VDbfQWmuxm8DN2JEDjCxcBww=;
        b=CmpluaoJzq2OWqQOJ/pDW1B8AXcqwlP9xHyzIwmZZ85Cq3an53qvjbvZeJBao+SuP/
         QHy/KoK6AgiUZv1d9VbZR4cPIIKyYKOKww/1UEdNciJqLSgNTdVwDNsfYauwTjrn/naw
         0BMMBhfjHP4DG+3qiqSSyjMH5TGhcNllBGrXjlNz46qOKwhcqhUN8hrHY8PczBFdGZsj
         1l5EZcVmeiteGWHl7GNcmqcZLlkiUx+kEGptnj4aZ8Pxnf2qzDBuyzn23uuvAoL/LL3S
         AMeZyzhradTpJRWbE+mxRD+7CspGOBdl9GZ5cxeTNLTQqpXjfi0jKWr7zjvn0HnHtnFH
         SjyQ==
X-Gm-Message-State: AOAM532io42lyMZzQCzqmZAeh/8CQLWqhk8v4I2HwhGGMb9U/KTh4Y5f
        kv75RXj8XsTOFlXAuIEqJoL3zjAazmm2OxL4bunkXmHozSI+iMfPz7HO8a9FK+RINHZPKEJaGJx
        Rk9GJzlfA8MZx8jrMPgqHfWrjMDEAZi9yzjAD478CVQ==
X-Received: by 2002:a05:622a:344:: with SMTP id r4mr36301248qtw.386.1621258787585;
        Mon, 17 May 2021 06:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNpgwiRCMC1E5bCQ1cvtZJWI8VjLot+FfJ7j2qWWMbKItZy9C4icnOrxmzTz8ALMWXJF4piw==
X-Received: by 2002:a05:622a:344:: with SMTP id r4mr36301230qtw.386.1621258787417;
        Mon, 17 May 2021 06:39:47 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id t17sm1417011qto.92.2021.05.17.06.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 06:39:46 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] memory: tegra124-emc: Fix compilation warnings on
 64bit platforms
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210516161214.4693-1-digetx@gmail.com>
 <20210516161214.4693-4-digetx@gmail.com>
 <936cfc7d-737e-a582-ea60-ad2ba5b4ca72@canonical.com>
 <1d80ee0f-de4c-24d0-154f-20841874bf20@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4ea1bf29-c353-6fcf-5248-bfee67d5c361@canonical.com>
Date:   Mon, 17 May 2021 09:39:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1d80ee0f-de4c-24d0-154f-20841874bf20@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2021 09:35, Dmitry Osipenko wrote:
> 17.05.2021 14:28, Krzysztof Kozlowski пишет:
>> On 16/05/2021 12:12, Dmitry Osipenko wrote:
>>> Fix compilation warning on 64bit platforms caused by implicit promotion
>>> of 32bit signed integer to a 64bit unsigned value which happens after
>>> enabling compile-testing of the driver.
>>>
>>> Suggested-by: Nathan Chancellor <nathan@kernel.org>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/memory/tegra/tegra124-emc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
>>> index 5699d909abc2..c9eb948cf4df 100644
>>> --- a/drivers/memory/tegra/tegra124-emc.c
>>> +++ b/drivers/memory/tegra/tegra124-emc.c
>>> @@ -272,8 +272,8 @@
>>>  #define EMC_PUTERM_ADJ				0x574
>>>  
>>>  #define DRAM_DEV_SEL_ALL			0
>>> -#define DRAM_DEV_SEL_0				(2 << 30)
>>> -#define DRAM_DEV_SEL_1				(1 << 30)
>>> +#define DRAM_DEV_SEL_0				(2u << 30)
>>> +#define DRAM_DEV_SEL_1				(1u << 30)
>>
>> Why not using BIT()? This would make even this 2<<30 less awkard...
> 
> The bitfield 31:30 is a enum, 3 is a wrong value. Formally it's
> incorrect to use the BIT() macro here.

Why "3"? BIT(31) is the same as 2<<30. It's common to use BIT for
register fields which do not accept all possible values. Now you
basically reimplement BIT() which is error-prone.


Best regards,
Krzysztof
