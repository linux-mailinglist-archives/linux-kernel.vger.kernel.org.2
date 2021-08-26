Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2503F9060
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhHZV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbhHZV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:57:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47904C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:56:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z2so9999393lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipkobGRVLZJc+vL0XXw9zFS+e6eRpUL7qQQ+kOwygyU=;
        b=FMdO8v5MHJt9fZRvFRs16ZRKLMhXFG6unthmn/CwHJDhI+EvJjGtQRwHxeKJcBYynO
         bHXAO3Y7DuRRCdpl6GR09PCHRNqCr8PS6aXGuCUFW+NomB789JkdQNOSoBEoovq/IFKm
         FO/B+MKMh91ZnQwz15uNJrKkkYx3U+eaU98xj/AaKxmFnL3RpwOE5v8ldIpzH2A/8uoT
         /qkn8XVoB8wR8of+COf1fIwUNmDqHkq8WRfKvU5iD5y7+DGOyq1BPwHYwiIlURXX4rv5
         wp1WDO2uZd73xUvtzA8FztxK0g5Xw+oie0hM8EslYu5r8lwgQFuR9L+ZvQQoLTbEH7Q5
         8ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipkobGRVLZJc+vL0XXw9zFS+e6eRpUL7qQQ+kOwygyU=;
        b=Gax9wkXltX83c2/7Ky2B5tlizjudMVWZXpgOgXOWqlzc6KSf6Rj5qCkPUdawCdNKYv
         zt9fuIvVEPQ17LrBW8miWdUCfEmwoB4ax7NOuybith3gZSRn8GzaAzY95YFqzuMSaiNU
         TtH7ZUzBa4REs8iu73yXAuH9H5UijsHZfe4D7I3kiSFTufyWXvaEBLfyFw+eZCvxUvn0
         CAiiHVD1S89DyPGZAYWuNoatoneJl4fsoc/8cpcmpSiwrkY/RLcD2H6uZRkU5aTygr3n
         3KQLDg7R06QoRYGw4lf0LeGgX5hsnn0hUSuqds70u6F8GTQ+4Qd2qAntKHym8CvRyuv6
         R2gg==
X-Gm-Message-State: AOAM532iwoec9GytVXQxDP4eiJxmIhvQ5gZI2awt7XsGjpHzeASynXnL
        sZuYHR7OUkrdXExFVBeh6f7YVFRh1++J9g==
X-Google-Smtp-Source: ABdhPJy/Kb42Fp9sNpU4Lp9seHJVgQxLZ0KFdpsDaoSfavQ64wBkXTpTfrEBfrnKdmcb2QpOF8qUag==
X-Received: by 2002:a05:6512:224a:: with SMTP id i10mr4402655lfu.539.1630014984316;
        Thu, 26 Aug 2021 14:56:24 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d19sm416238lfv.74.2021.08.26.14.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:56:23 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] clk: qcom: use power-domain for sm8250's clock
 controllers
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
 <163000270629.1317818.2836576068466077505@swboyd.mtv.corp.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <42c3fa20-7ffa-255f-ca28-6f0aa2aa4a13@linaro.org>
Date:   Fri, 27 Aug 2021 00:56:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <163000270629.1317818.2836576068466077505@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2021 21:31, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2021-07-27 13:19:56)
>> On SM8250 both the display and video clock controllers are powered up by
>> the MMCX power domain. Handle this by linking clock controllers to the
>> proper power domain, and using runtime power management to enable and
>> disable the MMCX power domain.
>>
>> Dependencies:
>> - https://lore.kernel.org/linux-arm-msm/20210703005416.2668319-1-bjorn.andersson@linaro.org/
>>    (pending)
> 
> Does this patch series need to go through the qcom tree? Presumably the
> dependency is going through qcom -> arm-soc

It looks like Bjorn did not apply his patches in the for-5.15 series, so 
we'd have to wait anyway. Probably I should rebase these patches instead 
on Rajendra's required-opps patch (which is going in this window).

> 
>>
>> Changes since v5:
>>   - Dropped devm_pm_runtime_enable callback to remove extra dependency
>>
>> Changes since v4:
>>   - Dropped pm_runtime handling from drivers/clk/qcom/common.c Moved the
>>     code into dispcc-sm8250.c and videocc-sm8250.c
>>
>> Changes since v3:
>>   - Wrap gdsc_enable/gdsc_disable into pm_runtime_get/put calls rather
>>     than calling pm_runtime_get in gdsc_enabled and _put in gdsc_disable
>>   - Squash gdsc patches together to remove possible dependencies between
>>     two patches.
>>


-- 
With best wishes
Dmitry
