Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7D32BC5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447339AbhCCNsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582437AbhCCKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:21:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739AC08E8BB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:38:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so2489318wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gno5LNftd5fU23GdPDJL4/R3qgxi1GRLBhAYz1fO15s=;
        b=RJY5xPj8lMMP5j7PmPVfn8jOsDGJNGDxwte/A3qscYft3Xmf5m3FN+49PUw/+opj9o
         28CoD+lQh4IPPRMWEEL4GesxuLChewgGlUoFO74kPEj0sMatwlsPQJgCgK+WB87b7XuK
         RStDnN95Emvuh0Zv4N5VTQ4mYmyaOADrNycB/x+bsrSZLqiJm1AIDXdUyNPvwa2Na083
         cd20f1bYQezlPQ/RG8Vd3O4qmeOAS1u+KYGdrjh/a4tAKj3bb6HncJEl2c/xle1OLXtq
         dl7aNHG7Jzc3EsXEJl1iC4pSlaEjdMf4Sir6IRAnoNqrXUwZnLoOMoeT7iKP9IjeMLUm
         eXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gno5LNftd5fU23GdPDJL4/R3qgxi1GRLBhAYz1fO15s=;
        b=llnTdM2yFkZRI1i7gD57QI5M23k6jl4I3bDZ7C0GCOf8BY+QHhk0GfN9WQ9PWFT50/
         ZftjM84tSFEVU8TC0EXCBn2QACrXde2tkSFzw0+pIiHwkR4oQq7bYPRQobFb1E9G1Ojz
         CnRXSeEz70ifaLqs68IlbrbpPtq1lzh+zyyB1gOXndt76vSWbVHoIVayVFYh16+fViJ7
         TSnEGpIhnOlwi5prJNeiMDNxYAI2y9tl0DOfi/1CBlqWYJEdBs4MHHeua5pe710DyYMQ
         ft+NnP/d848Bcys7eb9gNmOhcnb9BLl08BKjRecPNKW6n2AbZvkMLJjQ4gdXu+9enbuQ
         55vA==
X-Gm-Message-State: AOAM530UY3YtvUvef12XPEFA3xta8Z9UziBPlxREYvPoBCTbdGjnu6gp
        kSeg3OiRuZfjKn13+3WQtg6wHA==
X-Google-Smtp-Source: ABdhPJy7H6SvacbZI1FFlL8zT14GA6Isd2F0lFkveXK03mL0huuRpm4RNaQ0DPKl78jybKUPtnvguw==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr8486821wmm.64.1614764302566;
        Wed, 03 Mar 2021 01:38:22 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id c26sm32565672wrb.87.2021.03.03.01.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 01:38:22 -0800 (PST)
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
 <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
Date:   Wed, 3 Mar 2021 09:38:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/2021 14:34, Pierre-Louis Bossart wrote:
> 
> 
>>>> +        if (!val1 && !val2)
>>>> +            break;
>>>> +
>>>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>>>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>>>> +            ((u64)buf1[0] << 40);
>>>> +
>>>> +        sdw_extract_slave_id(bus, addr, &id);
>>>> +        /* Now compare with entries */
>>>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>>>> +            if (sdw_compare_devid(slave, id) == 0) {
>>>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>>>> +                if (status == SDW_SLAVE_ATTACHED) {
>>>> +                    slave->dev_num = i;
>>>> +                    mutex_lock(&bus->bus_lock);
>>>> +                    set_bit(i, bus->assigned);
>>>> +                    mutex_unlock(&bus->bus_lock);
>>>> +
>>>> +                }
>>>
>>> And that part is strange as well. The bus->assigned bit should be set 
>>> even if the Slave is not in the list provided by platform firmware. 
>>> It's really tracking the state of the hardware, and it should not be 
>>> influenced by what software knows to manage.
>>
>> Am not 100% sure If I understand the concern here, but In normal (non 
>> auto enum) cases this bit is set by the bus code while its doing 
>> enumeration to assign a dev number from the assigned bitmap!
>>
>> However in this case where auto enumeration happens it makes sense to 
>> set this here with matching dev number!
>>
>> AFAIU from code, each bit in this bitmap corresponds to slave dev number!
> 
> Yes, but the point was "why do you compare with information coming from 
> platform firmware"? if the hardware reports the presence of devices on 

This is the logic that hardware IP document suggests to use to get get 
the correct the device number associated with the slave!


> the link, why not use the information as is?
> 
> You recently added code that helps us deal with devices that are not 
> listed in DT or ACPI tables, so why would we filter in this specific loop?
> 
>>>> +    complete(&ctrl->enumeration);
>>>
>>> you have init_completion() and complete() in this patch, but no 
>>> wait_for_completion(), so that should be added in a later patch, no?
>>
>> make sense, will move that to other patch!
> 
> Actually on this one comment that I missed last time is that you are 
> using a completion only for the resume() case, and I think it should 
> also be used for the regular probe() case, no?
Good Idea, I can try that and see how to works out!

--srini
> 
