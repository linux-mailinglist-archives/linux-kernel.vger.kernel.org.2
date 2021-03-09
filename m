Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587B0332EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCITEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCITDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:03:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:03:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so4676971wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6PLkoXri99IRan82c3cqiiPesgYQohiG3dKjmiV44I=;
        b=KzCny+hDVmg/sJtXmbDqw0LiIQOJ22FDtHjsnKTtHCuQ1x8EHf6gdzD6hlW3gzGjEE
         NcMG9FMBT3OcFJBhAxmhqO9lHbEtc/ZXf98iVmFmjn2U4+vzfolAFb3QJDZPLXMTjemU
         m67/559PYCY6h6+YGO1WID2w/k5fx2XyNiPaxqBYnfxladke8hvAdFjP7uzP2L3D7OHB
         vrJO0Xf1MRqr4apIjFAcqeiQ67mvJPxRApBXPrEBbTCA8wl0HddIVWsWhsWwktI6ZpFy
         YR0Fdg968vbr+WO57czHVQrOiz93fG7+8lOSZNjR/XdtdhylPZvpcTdgZFyLQZzlOlZu
         Q6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6PLkoXri99IRan82c3cqiiPesgYQohiG3dKjmiV44I=;
        b=JPW+HhHgcuhZBSQtBVb9GnzPK9WWur5zrwT4UXY0P8d5C3lZbD65tnNpPsmT3Mg6eV
         aPIxW7eqUawueowKvjjY/7aCU6ih48rj2hTdzB6pOhzDnwtCKrWQuPux8lCct5J3hIGf
         d4TUQ4dxpnswRwdP7N+0LZ/3TBmVUsy4IwHgPoM/1ypKGiX7IMN7BPuFOdYVAkADm7ly
         zPpJgY3py2lWh8mF8VSGHVoIYV8JbITZkq0OsX2ovl2kRQHVvcHvc5UMtL4Q2qYvJZVz
         2F9oU27LYuUnWV+BziQqSWgxCz+KLNOhJ6dRSNBnDIeN/Lb6Ql1G8FlgEcAoA7gxdC4i
         hdZA==
X-Gm-Message-State: AOAM530MI+rCHZ+sToUFF4CGQ05HFaf0XExDc4u7CTMfdDgYDcsfx/ZG
        mqr3y3HvLDdC4HMCdhelQL6mfg==
X-Google-Smtp-Source: ABdhPJyc80yz5lzcPs93cuhOSRY3a64F/jNQg9lEONS45cPOM2Q1yEPrUi6Jovd/BJxLzsWa95K3NQ==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr5650442wmj.52.1615316632605;
        Tue, 09 Mar 2021 11:03:52 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8499:4f69:106b:da0? ([2a01:e34:ed2f:f020:8499:4f69:106b:da0])
        by smtp.googlemail.com with ESMTPSA id 18sm5593307wmj.21.2021.03.09.11.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:03:52 -0800 (PST)
Subject: Re: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-5-daniel.lezcano@linaro.org>
 <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1dac038-2100-abdb-2ffe-d0d93952ca21@linaro.org>
Date:   Tue, 9 Mar 2021 20:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

thanks for your comments, one question below.

On 09/03/2021 11:01, Lukasz Luba wrote:

[ ... ]

>>   +static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)
> 
> renamed 'cpus' into 'pd_mask', see below
> 
>> +{
>> +    unsigned long max, util;
>> +    int cpu, load = 0;
> 
> IMHO 'int load' looks odd when used with 'util' and 'max'.
> I would put in the line above to have them all the same type and
> renamed to 'sum_util'.
> 
>> +
>> +    for_each_cpu(cpu, cpus) {
> 
> I would avoid the temporary CPU mask in the get_pd_power_uw()
> with this modified loop:
> 
> for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> 
> 
>> +        max = arch_scale_cpu_capacity(cpu);
>> +        util = sched_cpu_util(cpu, max);
>> +        load += ((util * 100) / max);
> 
> Below you can find 3 optimizations. Since we are not in the hot
> path here, it's up to if you would like to use all/some of them
> or just ignore.
> 
> 1st optimization.
> If we use 'load += (util << 10) / max' in the loop, then
> we could avoid div by 100 and use a right shift:
> (power * load) >> 10
> 
> 2nd optimization.
> Since we use EM CPU mask, which span all CPUs with the same
> arch_scale_cpu_capacity(), you can avoid N divs inside the loop
> and do it once, below the loop.
> 
> 3rd optimization.
> If we just simply add all 'util' into 'sum_util' (no mul or div in
> the loop), then we might just have simple macro
> 
> #define CALC_POWER_USAGE(power, sum_util, max) \
>     (((power * (sum_util << 10)) / max) >> 10)

I don't understand the 'max' division, I was expecting here something
like: ((sum_util << 10) / sum_max) >> 10)

no ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
