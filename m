Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626D03833FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhEQPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:04:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42895 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbhEQOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:54:06 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1liebv-0000UT-KN
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 14:52:47 +0000
Received: by mail-qt1-f197.google.com with SMTP id b19-20020ac84f130000b02901d543c52248so5392362qte.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YT3ArZkIAvGWeYJPmgevYctfMIJLv6m5yBthvtx2HM=;
        b=q3GvT+L96JoSSusgAJhiVcneUBhxZfz9MIehPeJwRxQ/QfV4JhG+SLi+IcQFKe9SAB
         k04R0/RrPQeRVD6aNN3LlEeetIpzGdq0J89uKklEZchClu3cZS22UyN3a+7HRU0LGXPa
         j/RXThQREg5id6OqOY7EGA17NTtlFiE7hVyIhWeuSkxZOMGn7kQPmbi6pGiEPoU8DjBl
         o0MpDEqV8vrhWooFNXIS40Cck/jdDX+n53q23YlGyl7JJeZQv4rsf9NQJn1KtXeiHKgj
         K+LpgwyF1gZ42TMesnRagLKCD2oSk07LbgvPAXazw52FP8Rtpt0Z7HXvDoZoIr8qnXOx
         +MKQ==
X-Gm-Message-State: AOAM530r1DKV4h1qdAIu2VVk8qFhlaDgt24WjXp1RNB9vM8ZK2L+OBHf
        VA1529KtySOl833MzvkaagyrMob1cAxEUqP6rd2dkENFXJAgZRYaQoB+oq6hTpvo267JvC/JhEU
        XrHXL+zNeZefaxvfw9TA8mx2dBAmNevM3iZD9yNBjZw==
X-Received: by 2002:ad4:5613:: with SMTP id ca19mr93492qvb.3.1621263166302;
        Mon, 17 May 2021 07:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz1sTR2nEo8tVy3soUcg7dJtwe6XA2FzYNjxD+WxF5X8O633T/gloDETC7dA01uBs4CI398A==
X-Received: by 2002:ad4:5613:: with SMTP id ca19mr93463qvb.3.1621263166122;
        Mon, 17 May 2021 07:52:46 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id h65sm10642727qkd.112.2021.05.17.07.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:52:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210516205138.22501-1-digetx@gmail.com>
 <20210516205138.22501-2-digetx@gmail.com>
 <3ea6b48f-af3f-51db-8d7b-1292a68ae74e@canonical.com>
 <a3b42449-4cd8-f692-c41a-205cbaa987eb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d56d1e1e-73fe-9708-34ec-e31f10e17b44@canonical.com>
Date:   Mon, 17 May 2021 10:52:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a3b42449-4cd8-f692-c41a-205cbaa987eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2021 10:47, Dmitry Osipenko wrote:
> 17.05.2021 14:43, Krzysztof Kozlowski пишет:
> ...
>>> +static int tegra_core_dev_init_opp_state(struct device *dev)
>>> +{
>>> +	struct dev_pm_opp *opp;
>>> +	unsigned long rate;
>>> +	struct clk *clk;
>>> +	int err;
>>> +
>>> +	clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(clk)) {
>>> +		dev_err(dev, "failed to get clk: %pe\n", clk);
>>> +		return PTR_ERR(clk);
>>> +	}
>>> +
>>> +	rate = clk_get_rate(clk);
>>> +	if (!rate) {
>>> +		dev_err(dev, "failed to get clk rate\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
>>> +
>>> +	if (opp == ERR_PTR(-ERANGE))
>>> +		opp = dev_pm_opp_find_freq_floor(dev, &rate);
>>> +
>>> +	err = PTR_ERR_OR_ZERO(opp);
>>> +	if (err) {
>>> +		dev_err(dev, "failed to get OPP for %ld Hz: %d\n",
>>> +			rate, err);
>>> +		return err;
>>> +	}
>>> +
>>> +	dev_pm_opp_put(opp);
>>> +
>>> +	/* first dummy rate-setting initializes voltage vote */
>>> +	err = dev_pm_opp_set_rate(dev, rate);
>>> +	if (err) {
>>> +		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
>>> +		return err;
>>> +	}
>>
>>
>> The devm_pm_opp_set_clkname will call clk_get(), so here you should drop
>> the clk reference at the end. Why having it twice?
> 
> The devm_pm_opp_set_clkname assigns clock to the OPP table.
> 
> The devm_clk_get() is needed for the clk_get_rate(). OPP core doesn't
> initialize voltage vote and we need this initialization for the Tegra
> memory drivers.

I did not get the answer to my question. Why you need to keep the clk
reference past this point? Why you cannot drop it after getting rate?

> The reference count of the clk will be dropped automatically once device
> driver is released. The resource-managed helper avoids the need to care
> about the error unwinding in the code, making it clean and easy to follow.

I am not saying there is a leak.

> 
> ...
>>> +EXPORT_SYMBOL_GPL(devm_tegra_core_dev_init_opp_table);
>>> diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
>>> index 98027a76ce3d..e8eab13aa199 100644
>>> --- a/include/soc/tegra/common.h
>>> +++ b/include/soc/tegra/common.h
>>> @@ -6,6 +6,36 @@
>>>  #ifndef __SOC_TEGRA_COMMON_H__
>>>  #define __SOC_TEGRA_COMMON_H__
>>>  
>>> +#include <linux/errno.h>
>>> +#include <linux/types.h>
>>> +
>>> +struct device;
>>> +
>>> +/**
>>> + * Tegra SoC core device OPP table configuration
>>> + *
>>> + * @init_state: pre-initialize OPP state of a device
>>> + */
>>> +struct tegra_core_opp_params {
>>> +	bool init_state;
>>> +};
>>> +
>>> +#ifdef CONFIG_ARCH_TEGRA
>>>  bool soc_is_tegra(void);
>>> +int devm_tegra_core_dev_init_opp_table(struct device *dev,
>>> +				       struct tegra_core_opp_params *params);
>>> +#else
>>> +static inline bool soc_is_tegra(void)
>>
>> This looks unrelated. Please make it a separate patch.
> 
> The missing stub for soc_is_tegra() popped up multiple times before.
> Hence it didn't look like a bad idea to me to add stub for it since this
> patch touches code around it.
> 
> I'll factor it out into a separate patch in v2.

Thanks!


Best regards,
Krzysztof
