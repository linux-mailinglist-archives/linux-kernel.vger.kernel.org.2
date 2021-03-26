Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9D34A29B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCZHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:38:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCZHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:38:05 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lPh2h-0004pt-H0
        for linux-kernel@vger.kernel.org; Fri, 26 Mar 2021 07:38:03 +0000
Received: by mail-wm1-f70.google.com with SMTP id r65-20020a1c2b440000b029010f4ee06223so2020637wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRtqa7yLsQvFT2lpOj4EynM8RgSn4Vk0wfShrT8ILwQ=;
        b=lrsjtzWMAR/1smSEH3MDVwENnnPkA5+DdfLpaxfQ35EUPlV/fzFcNhmGDzuA80P3Py
         bhd7BdIH4NNB2CcxTWFRdkkrDdJruKlg3T6NTAaRzGakmbNLWvH0e9nNmMClcJz+qZ2l
         Gm1gMJMZELsC5NxuxUfECbphDXe3sjwvr+hLT40V16ca5VJQRvsAsmIL4VeXEWiNQUCy
         vNsLXjwoeS26O2f5h1jTR6qjbN97toqcwnMM8AV98ZTqeeuWbv8BmRf3+2fN6ns9XCdt
         IwazmJ58AEGbKFOnkrFynlPcri1Hmve51xihaiT1QOOAWuB+F/j5QV0gsaqiwqIWHKce
         TjoA==
X-Gm-Message-State: AOAM5320XUOt0DsXQPiVLpOPQ/IoZZ67eYD6LnNAzisLT9Y0yMMxIsYN
        E/rOZXEMT8gIb1KrTTyLd2CH8i+Xv0bSFVqIHhsdG3Wfplg3Ngrbw9upomiLHcRcx0Ralneff1N
        BHocPDcwUKAHtzD9WJG8y1/5oQ7r2quU6YcJf+QJHJQ==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr12732361wra.103.1616744283164;
        Fri, 26 Mar 2021 00:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYcIF96pDeU5oc+LG7wrlIU/oMqagEKGvMa3QKpMiYqcmsN21wshw8dnjUa8GuRloLw8gKpQ==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr12732344wra.103.1616744283011;
        Fri, 26 Mar 2021 00:38:03 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id j12sm11449357wrx.59.2021.03.26.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 00:38:02 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] memory: tegra20: Correct comment to MC_STAT
 registers writes
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210323210446.24867-1-digetx@gmail.com>
 <799f54f6-6023-338f-4e8f-cc0dfbac30d8@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <63a3225e-7cae-8592-653e-04a76b7cf9c1@canonical.com>
Date:   Fri, 26 Mar 2021 08:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <799f54f6-6023-338f-4e8f-cc0dfbac30d8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 18:20, Dmitry Osipenko wrote:
> 24.03.2021 00:04, Dmitry Osipenko пишет:
>> The code was changed multiple times and the comment to MC_STAT
>> registers writes became slightly outdated. The MC_STAT programming
>> now isn't hardcoded to the "bandwidth" mode, let's clarify this in
>> the comment.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/tegra20.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
>> index 14caf5b9324c..4659c0cea30d 100644
>> --- a/drivers/memory/tegra/tegra20.c
>> +++ b/drivers/memory/tegra/tegra20.c
>> @@ -451,9 +451,8 @@ static void tegra20_mc_stat_gather(struct tegra20_mc_stat *stat)
>>  	control_1 = tegra20_mc_stat_gather_control(&stat->gather1);
>>  
>>  	/*
>> -	 * Reset statistic gathers state, select bandwidth mode for the
>> -	 * statistics collection mode and set clocks counter saturation
>> -	 * limit to maximum.
>> +	 * Reset statistic gathers state, select statistics collection mode
>> +	 * and set clocks counter saturation limit to maximum.
>>  	 */
>>  	mc_writel(mc, 0x00000000, MC_STAT_CONTROL);
>>  	mc_writel(mc,  control_0, MC_STAT_EMC_CONTROL_0);
>>
> 
> Krzysztof, please feel free to squash these 2 minor follow up patches
> into the original patch which added the the debug support, if you prefer
> this way more. I happened to notice these small itches only after you
> already picked up the previous patch.

No problem, in general I prefer to have incremental improvements.

Best regards,
Krzysztof
