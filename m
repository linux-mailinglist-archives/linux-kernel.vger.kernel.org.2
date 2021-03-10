Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF133342E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhCJQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhCJQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:19:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA1C061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:19:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so1814956wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OyyK0iMN0zrtwD8ueN0whglwDEUuQKYsF/12IovrSoM=;
        b=autgssREh3pC4yNLuTPfEA7vunAJ9ob7VNuYwvHr0O6xs8/oq60sckg2XeE1njodq5
         SzKLLMTDEb4+GJ7rsu2VcuuD6/qhV0qmjmQU5C/3+Bz9tJw13suWpZ44qWRynytWhWr2
         VwsdAmSkuUugoqTCGQ6g/ZBkaUbqMOac9kiMunG51Df82MgwaZu7iZoJvY7iqi82u9Ru
         WyU821X8t2iBgJNvlx/5knWEZGScVJJp2/5D2MGbZMZH0024/5YqZMayARfUUPtS1kTS
         QBkJxBd/HGMkRP6Lh2uPPBYV/iSIA00q5DHKbMA1pqirdueMccRBEeOccgzuoEWifN71
         2VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OyyK0iMN0zrtwD8ueN0whglwDEUuQKYsF/12IovrSoM=;
        b=YOe5DlKk2paUYmf0UuDUCus2dNuJDLE+NIlRMZGnEyW8tOSDgivO2rVs+2C58bIknM
         VWlb/sMPYLBTBKiUE6BRD5hTIA3rUCHNioY+KeM2qYBQgVLZFNb59Ho5hfg4LKpufr9s
         94n5TKt3qVpThm5J0O9vbrABDYfY10Sd9GD/aZCzNs4fWe379EMp+oHpBniUSZzWQaVO
         d1rKNq51jNB1/1yAV8yJRud1VZ7dHGFqLKxmHTeJiRJwV/42tOymgsnhfTNUzovNY3SE
         zJHQHNz8XKNv1DpT/dHsDMgD0EKlLi9/eX6h1T5AD1pvKudR92+fDemNBi7Qi/VfOyHs
         RHpw==
X-Gm-Message-State: AOAM531vDsuZIhuh1HiAT4rctD+V5aBjvpBVenrd2AUfOgZBHk4LHhB1
        GlhiKRPDILKy5OPIqAAcXKcN8KGXNN2qmg==
X-Google-Smtp-Source: ABdhPJwh79rNGkkHjlyivJoAh/RFxSdV0It7WUtH6jxj2V019IfZt8BT95eKliO+F4fIs9HrVUBAYw==
X-Received: by 2002:a7b:c1c9:: with SMTP id a9mr3988620wmj.145.1615393150663;
        Wed, 10 Mar 2021 08:19:10 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z1sm30152196wru.95.2021.03.10.08.19.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Mar 2021 08:19:10 -0800 (PST)
Subject: Re: [PATCH 1/3] nvmem: core: Add functions to make number reading
 easy
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
 <8e274cc7-0c9e-b983-7dd9-c501c159e95a@linaro.org>
 <CAD=FV=WU1-5gtgBz1SNdS7Vkf8QLivrVdH4O2p1Vn-X57g3-dw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6f567b9b-fb67-6bcc-1970-99f96eded929@linaro.org>
Date:   Wed, 10 Mar 2021 16:19:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WU1-5gtgBz1SNdS7Vkf8QLivrVdH4O2p1Vn-X57g3-dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2021 15:50, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 10, 2021 at 2:37 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 06/03/2021 00:26, Douglas Anderson wrote:
>>> Sometimes the clients of nvmem just want to get a number out of
>>> nvmem. They don't want to think about exactly how many bytes the nvmem
>>> cell took up. They just want the number. Let's make it easy.
>>>
>>> In general this concept is useful because nvmem space is precious and
>>> usually the fewest bits are allocated that will hold a given value on
>>> a given system. However, even though small numbers might be fine on
>>> one system that doesn't mean that logically the number couldn't be
>>> bigger. Imagine nvmem containing a max frequency for a component. On
>>> one system perhaps that fits in 16 bits. On another system it might
>>> fit in 32 bits. The code reading this number doesn't care--it just
>>> wants the number.
>>>
>>> We'll provide two functions: nvmem_cell_read_variable_le_u32() and
>>> nvmem_cell_read_variable_le_u64().
>>>
>>> Comparing these to the existing functions like nvmem_cell_read_u32():
>>> * These new functions have no problems if the value was stored in
>>>     nvmem in fewer bytes. It's OK to use these function as long as the
>>>     value stored will fit in 32-bits (or 64-bits).
>>> * These functions avoid problems that the earlier APIs had with bit
>>>     offsets. For instance, you can't use nvmem_cell_read_u32() to read a
>>>     value has nbits=32 and bit_offset=4 because the nvmem cell must be
>>>     at least 5 bytes big to hold this value. The new API accounts for
>>>     this and works fine.
>>> * These functions make it very explicit that they assume that the
>>>     number was stored in little endian format. The old functions made
>>>     this assumption whenever bit_offset was non-zero (see
>>>     nvmem_shift_read_buffer_in_place()) but didn't whenever the
>>>     bit_offset was zero.
>>>
>>> NOTE: it's assumed that we don't need an 8-bit or 16-bit version of
>>> this function. The 32-bit version of the function can be used to read
>>> 8-bit or 16-bit data.
>>>
>>> At the moment, I'm only adding the "unsigned" versions of these
>>> functions, but if it ends up being useful someone could add a "signed"
>>> version that did 2's complement sign extension.
>>>
>>> At the moment, I'm only adding the "little endian" versions of these
>>> functions. Adding the "big endian" version would require adding "big
>>> endian" support to nvmem_shift_read_buffer_in_place().
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>> This is a logical follow-up to:
>>>     https://lore.kernel.org/r/20210227002603.3260599-1-dianders@chromium.org/
>>> ...but since it doesn't really share any of the same patches I'm not
>>> marking it as a v2.
>>>
>>>    drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++++
>>>    include/linux/nvmem-consumer.h |  4 ++
>>>    2 files changed, 99 insertions(+)
>>>
>>
>> This patch as it is LGTM.
>>
>> If you plan to take this via other trees, here is
>>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Thanks! I think none of this is terribly urgent, though. Unless
> someone has a different opinion, my thought would be:
> 
> * This patch lands in your tree for 5.13.
> 
> * I'll snooze the email for 2 months and poke patch #2 and #3 once
> 5.13-rc1 is out.
> 
> Does that sound OK to you?
That works for me!

Applied thanks!

--srini
> 
> -Doug
> 
