Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE305382E50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhEQOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:06:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbhEQOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:05:41 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lidr6-0004TN-CW
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 14:04:24 +0000
Received: by mail-qt1-f200.google.com with SMTP id h12-20020ac8776c0000b02901f1228fdb1bso1768658qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nNt7p8/XpkMjdfYomnfwPohk68DN8/DKf++9T5aVd0=;
        b=UinjGARH1hQCzch9VfbCtKJhmM64x9bGLj+go2ZZrLE4RXdfmrLkbq8M2XTasfDOHR
         C2FCaSxNZdhx8HxRy+9RNgxUiTH0P1vbb4OdSkukbz9Lxn4Fz2u+R9Rj9Vabc86TVMhZ
         reT9lLn4c0pBIHx5rlMxoHI8BTJTfpa2RR+PIJ7GCq5zp9+ma3Li2bmBgqXeuXPjxMkk
         1aVJxDH3SSfE0yqVo+QKkLhFkMmtdyoZWQnqMMDMQoia/anYTOa9HDsEz0G9t7WtiQp9
         FctB4BqQbRZ0Ubg3fbVvlVKLGpRYC42XedS7ri8lhoRPL6n23bD9sDfPbwNFDYwGisA3
         V/vg==
X-Gm-Message-State: AOAM533sA0zHr4wIDT3Hqg/0f26/aN2ASde+cwYDsk4ijPnK4xfskfkr
        MXrrQrs0EiK4vXxOz48BtlUhJIeT1oqTr/hCE3mgTzMu14PQLh8J2OyaEpsQMsS6qgdKQ2NKWgu
        s7Rjiinh2wTIfCAQTEw2GOTOaaUkbWs1NNYw/M3I7CQ==
X-Received: by 2002:ac8:4319:: with SMTP id z25mr58436994qtm.262.1621260263525;
        Mon, 17 May 2021 07:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWt/qyHrHTiRrV9XefovdlniWXO+Q/V4ZIQpCKkD+hCnqGqyLmKZ5nKHMU30KlJqDxYO14Ug==
X-Received: by 2002:ac8:4319:: with SMTP id z25mr58436977qtm.262.1621260263312;
        Mon, 17 May 2021 07:04:23 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id i129sm10505301qke.103.2021.05.17.07.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:04:22 -0700 (PDT)
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
 <4ea1bf29-c353-6fcf-5248-bfee67d5c361@canonical.com>
 <c120ecf5-7202-9f1d-6e70-a99db2f5335f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1cde1d43-f139-cb90-395e-8f8fceb41bce@canonical.com>
Date:   Mon, 17 May 2021 10:04:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c120ecf5-7202-9f1d-6e70-a99db2f5335f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2021 09:47, Dmitry Osipenko wrote:
> 17.05.2021 16:39, Krzysztof Kozlowski пишет:
>>>>>  #define DRAM_DEV_SEL_ALL			0
>>>>> -#define DRAM_DEV_SEL_0				(2 << 30)
>>>>> -#define DRAM_DEV_SEL_1				(1 << 30)
>>>>> +#define DRAM_DEV_SEL_0				(2u << 30)
>>>>> +#define DRAM_DEV_SEL_1				(1u << 30)
>>>>
>>>> Why not using BIT()? This would make even this 2<<30 less awkard...
>>>
>>> The bitfield 31:30 is a enum, 3 is a wrong value. Formally it's
>>> incorrect to use the BIT() macro here.
>>
>> Why "3"? BIT(31) is the same as 2<<30.
> 
> By 3 I meant BIT(31)|BIT(30). This bitfield is explicitly designated as
> a enum in the hardware documentation.

I understand it and using BIT() here does not mean someone has to set
both of them. BIT() is a helper pointing out that you want to toggle one
bit. It does not mean that it is allowed to do so always!

> 
>> It's common to use BIT for
>> register fields which do not accept all possible values. Now you
>> basically reimplement BIT() which is error-prone.
> 
> Could you please show couple examples? The common practice today is to
> use FIELD_PREP helpers, but this driver was written before these helpers
> existed.


There are plenty of such examples so I guess it would be easier to ask
you to provide counter ones. Few IT for enum-like registers found within 2 minutes:

https://elixir.bootlin.com/linux/latest/C/ident/MAX77620_CNFG_GPIO_INT_MASK
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/regulator/max77650-regulator.c#L18
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/regulator/tps6524x-regulator.c#L62
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/regulator/tps80031-regulator.c#L39
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/regulator/da9121-regulator.h#L200
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/regulator/da9121-regulator.h#L231

Best regards,
Krzysztof
