Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448730BBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhBBKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBBKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:20:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:19:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l12so785970wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4TQrH08/UJxeSx7AxArBpXQ8JwuPZp/xsO/RczEeCRE=;
        b=n4o2SdsTccQ0UfkE8WKWBF5rX+gbqGIWlvhdAIPiRVbm6dSAK4V0kEmehB3aW85elU
         fzDLLevgmyYIvUehwcb5Lt4HvkO4S+ySa4TLciQH+JdeVOVoTJnJCAfoaLSZ9pPwWn4e
         pwYaZAETKDC3gmiqrrnm3xLZPoO/TjAayU42nxC4jFjSGy+jQfLv1JkA7i3prMVwmRtL
         JIk3yRlz46jZRF7b15v71FsMw4TPfEAxP5tIDNCLyJ84Df5GzX//ere3obTQlxVmFB1T
         jy+LSiP99/L+OTqY5aGBT0c/mqbHlr+9YafIGTkkJ4fEubFXkqRWSmQAtAHXGmj/DLYD
         ZE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TQrH08/UJxeSx7AxArBpXQ8JwuPZp/xsO/RczEeCRE=;
        b=qUL6It4js7a+8UGigRZT4QndZd8fNkrepw56caFOr/waFMmTVa9L2/UeYrbWGv/01X
         scpBIiWCYTQJI+M3IErSkXck6evafqGI7xL3fDAEIM4JOCoXTGQeQYspnvpYToCUAFHb
         C/rCs5hqPoT7ZID5tSbm1Xcrxoog7OBSIh00l5A0llXRJQrEOpnaJAXFNFfK7eTQCmc+
         f6gmLlAfRPzb2H4qsjQw91AcQntmXEVaT0wV3VT9vGDiT9yp/cflt8s6Nhm4z9ca1VfI
         I3L2ys9/WO4tZJbj+rciHzfovGytdrIew5qqThCRcMND3Ft+5l2G/IBDgi21UqPlGDFC
         oGRA==
X-Gm-Message-State: AOAM533Hv3/0Ouw3/ajGA3eD4w1zfs8NvLJScChtT9U+/eAKOxE8oGe9
        Er4ptpjoeNY0fj+iUBL6zNrvcQ==
X-Google-Smtp-Source: ABdhPJwyXFkSxEsGTLVNCkjDES3J4BtRb+cT9X4fkRDyERvmjJlmSNWrgyEMn3QRnpE6zbX3+6/GtA==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr2951091wmh.4.1612261188570;
        Tue, 02 Feb 2021 02:19:48 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id v13sm1847921wrd.51.2021.02.02.02.19.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 02:19:47 -0800 (PST)
Subject: Re: [PATCH 5/6] soundwire: qcom: update register read/write routine
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
 <5c69ed09-60be-2f3d-ed25-f6dbfcb9d62f@linux.intel.com>
 <3a2b5c2d-21aa-2bf5-62df-ef85c7c9293c@linaro.org>
 <b87758d0-5862-3b4e-5a90-7b27d0c78d0d@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4e3ebb99-5647-f71c-1256-a2c55bd9995f@linaro.org>
Date:   Tue, 2 Feb 2021 10:19:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b87758d0-5862-3b4e-5a90-7b27d0c78d0d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 16:42, Pierre-Louis Bossart wrote:
> 
> 
> On 2/1/21 9:50 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 29/01/2021 19:33, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
>>>> In the existing code every soundwire register read and register write
>>>> are kinda blocked. Each of these are using a special command id that
>>>
>>> what does 'kinda blocked' mean?
>>
>> I meant read/writes are waiting for completion interrupt!
>>
>>>
>>>> generates interrupt after it successfully finishes. This is really
>>>> overhead, limiting and not really necessary unless we are doing
>>>> something special.
>>>>
>>>> We can simply read/write the fifo that should also give exactly
>>>> what we need! This will also allow to read/write registers in
>>>> interrupt context, which was not possible with the special
>>>> command approach.
>>>
>>> This is really unclear, sorry.
>>
>> If read/writes are waiting for an interrupt, it becomes difficult to 
>> read or write to any registers from same interrupt handler!
> 
> Well, yes, you need to handle the complete() at a lower level than the 
> code that initiates the transactions otherwise you self-deadlock.
> 
> IIRC in the Intel initial code, the complete was in the handler and the 
> register IOs in the thread.
> 
Yes, we did the same in previous version of the code, however with this 
patch reading/writing fifo directly without need of completion should 
remove that need of another thread!
>>
>>
>>>
>>>> +    if (id != SWR_BROADCAST_CMD_ID) {
>>>> +        if (id < 14)
>>>> +            id += 1;
>>>> +        else
>>>> +            id = 0;
>>>
>>> that is really odd. if id=13 (group2) then id becomes 14 (master 
>>> address). A comment is really needed here.
>>
>> This is magic value for each fifo read or write, so that we can verify 
>> that them by comparing with this magic value!
>>
>> This has nothing to do with device number!
> 
> You should probably add a comment here then, or use a #define instead of 
> the 14 which threw me off.

I agree!
> 
>>
>>>
>>>> +    if (cmd_id == SWR_BROADCAST_CMD_ID) {
>>>> +        /*
>>>> +         * sleep for 10ms for MSM soundwire variant to allow broadcast
>>>> +         * command to complete.
>>>
>>> that's also super-odd. There is nothing in SoundWire that makes any 
>>> difference between a regular and a broadcast command. they all 
>>> complete in the same time (a frame).
>>>> +         */
>>>> +        ret = wait_for_completion_timeout(&swrm->broadcast, (2 * 
>>>> HZ/10));
>>>
>>> is this 10ms really or dependent on CONFIG_HZ?
> 
> comment missed?
Not intentionally :-)


I should probably to use msecs_to_jiffies here to keep it inline with 
the comment!

--srini
> 
>>>
>>>> +        if (!ret)
>>>> +            ret = SDW_CMD_IGNORED;
>>>> +        else
>>>> +            ret = SDW_CMD_OK;
>>>
>>> no CMD_FAILED support?
>>
>> Qcom controllers does not provide that information if the command is 
>> ignored or failed by any means!
>>
>> That was the behavior from the starting of this driver.
> 
> ah yes, now I remember this.
