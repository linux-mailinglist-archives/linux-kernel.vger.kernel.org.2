Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD232E690
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCEKkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCEKjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:39:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06DDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:39:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id w7so995836wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QAdiWW4xwrryTGLdOvOtGLA/wZ8tOat9yGLAJoNAxMg=;
        b=zSq01aMNZU/0lbjMkjkR1Uw1zAN1FtTgasQkQglRVDE9fQtiNLSJ346wtKBSn/qbsP
         //qeKC0aTNWf4/I9QENg940YXKDXMaxje+guRsevzMpW931uh2m3y/AFE2jhMXNe1PAD
         NYx587Huhc2tdlTd+Re0llJ8+7Jhrs09WNfp2Li77VNZHS6q5w8f4+oyibgeqE+DsWzR
         LOURo4gs2+u+TOycVrYnOcgUnhJhaH1fVdmbVdGXt7C3lusS7VQRMb2+S96OFXwJY+X9
         ys25kGCEjb0pZyi5/c2guIM0kWkyh5t/BnfA6PRxJ+CqyJW/22VeuRWbdoWUPHBVq+we
         T5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAdiWW4xwrryTGLdOvOtGLA/wZ8tOat9yGLAJoNAxMg=;
        b=gpq8kMpL6Q1heXPe7utO0eXsC8vmbG+Bc71n+Ts2tygRHi7rHleUcy76V4NVzOinAY
         O7VzWKQsDSEteyVRJjbs5N6btTdAxY1q0xvdGlo/NyQNxaIYW3hArY5tIXEJ3Z+is4cC
         chYhCDTtt2lK7FHEECfiBTQ0CjjaDHprijEraE2DWDGstAXX3YBIAUyCtz/ix5tVnbOX
         4ug5lsoWks1STIegHc60LYuEy3RkVOZxNzdN4RNbb5R5th0gm6w+Fp6KsN+e2O3ZaLkF
         ugTJv7Ot/aaQ3fgt5oyv36a7JvVWtFXKCg+Eun56iuXHvqZYJ7ucK7WPfLaPeeWYSwD5
         eZfg==
X-Gm-Message-State: AOAM5324CTfVlhZEH1UCz6ULpNd75UzD+3fEKZWDBQ5vQ+BvBJ/wxsH+
        FqXpFr7JLePNLPv0dOmIDmRZhQ==
X-Google-Smtp-Source: ABdhPJyg+mYo+eyJo4nlyLEW6IIs5uu8pJlCxPE06eXsjVFve/od1o2v389wAUalmaTvP7K1+U1x6A==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr8192686wmq.102.1614940791595;
        Fri, 05 Mar 2021 02:39:51 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id t8sm4115141wrr.10.2021.03.05.02.39.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:39:51 -0800 (PST)
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
 <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
 <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
 <c5fe182d-1769-73ed-0268-5353fd030521@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5b067c8d-0d90-1531-a1b1-118fa73c0078@linaro.org>
Date:   Fri, 5 Mar 2021 10:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c5fe182d-1769-73ed-0268-5353fd030521@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2021 16:35, Pierre-Louis Bossart wrote:
> 
> 
> On 3/3/21 3:38 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 02/03/2021 14:34, Pierre-Louis Bossart wrote:
>>>
>>>
>>>>>> +        if (!val1 && !val2)
>>>>>> +            break;
>>>>>> +
>>>>>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>>>>>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>>>>>> +            ((u64)buf1[0] << 40);
>>>>>> +
>>>>>> +        sdw_extract_slave_id(bus, addr, &id);
>>>>>> +        /* Now compare with entries */
>>>>>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>>>>>> +            if (sdw_compare_devid(slave, id) == 0) {
>>>>>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>>>>>> +                if (status == SDW_SLAVE_ATTACHED) {
>>>>>> +                    slave->dev_num = i;
>>>>>> +                    mutex_lock(&bus->bus_lock);
>>>>>> +                    set_bit(i, bus->assigned);
>>>>>> +                    mutex_unlock(&bus->bus_lock);
>>>>>> +
>>>>>> +                }
>>>>>
>>>>> And that part is strange as well. The bus->assigned bit should be 
>>>>> set even if the Slave is not in the list provided by platform 
>>>>> firmware. It's really tracking the state of the hardware, and it 
>>>>> should not be influenced by what software knows to manage.
>>>>
>>>> Am not 100% sure If I understand the concern here, but In normal 
>>>> (non auto enum) cases this bit is set by the bus code while its 
>>>> doing enumeration to assign a dev number from the assigned bitmap!
>>>>
>>>> However in this case where auto enumeration happens it makes sense 
>>>> to set this here with matching dev number!
>>>>
>>>> AFAIU from code, each bit in this bitmap corresponds to slave dev 
>>>> number!
>>>
>>> Yes, but the point was "why do you compare with information coming 
>>> from platform firmware"? if the hardware reports the presence of 
>>> devices on 
>>
>> This is the logic that hardware IP document suggests to use to get get 
>> the correct the device number associated with the slave!
>>
>>
>>> the link, why not use the information as is?
>>>
>>> You recently added code that helps us deal with devices that are not 
>>> listed in DT or ACPI tables, so why would we filter in this specific 
>>> loop?
> 
> I don't think my point was understood, so let me try to explain it 
> differently.
> 
> it's my understanding that the hardware reads the DevID registers and 
> writes a Device Number - so that the entire enumeration sequence started 
> by reading DevID0 and finished by a successful write to SCP_DevNum is 
> handled in hardware.
> 
> The question is: what happens if that device is NOT described in the 
> Device Tree data? The loop over bus->slaves will not find this device by 
> comparing with known devID values, so the set_bit(i, bus->assigned) will 
> not happen.

yes, that is true, There is no way we can assign a dev_number to the 
device which is not enumerated on the bus!

Am sure this is the same behavior with soundwire core too, atleast form 
the code I can see it sets the assigned bit for only the devices that 
are enumerated on the bus! Not all the devices specified in DT!
Unless I missed something!

--srini


--srini
> 
> 
