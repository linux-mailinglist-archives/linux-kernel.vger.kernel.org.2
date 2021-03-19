Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA2341D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCSMkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhCSMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:40:23 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:40:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n21so5910540ioa.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQM+TnnK73mIR8dvkMWkIKwG/G6WwhfgXEfohLbUjJI=;
        b=ifk76JjCf1aax6E7GBeDbL+c93oGjTB60QK5ee14RCT5+APXZhPJKUXYgFou/CV7+e
         ItZVjc2cbgTDr8qFVBp4AJDeMheQJnZ6BO3PN297hH96BTowylsx5KatfLI775EmigrK
         8vulGRAobwKCQjkN1SYFOQGmz+bINmo1jJV0naR7O42Lt4z345kZAZWJUXu1iEqP96F+
         ltvePRzZFfIFvqvzsfV5YUDEn76aWqbacJ0olJm9NYBxtkYjdHHNY0kL1YZ5pEYR3P86
         roJLy+CIfZIzTxPGoukdK01y7JxS8XzTilo9PXr4bgIq4lqURg9vMCHjCeVxxBhbOfOY
         vqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQM+TnnK73mIR8dvkMWkIKwG/G6WwhfgXEfohLbUjJI=;
        b=taaiS0uRtq0EGfif0faPPe9e4d0lnDG1vJXdOZv6B+GDCXxYe1UXhkZGVeAFTDjR4u
         1LCX1VsrkvsyR83hkOLM+AX6LID4r1JZXfZi2pW7WYQ463Bz+u3/49UKcn7UBYDFIJRp
         HKA92J73mGdpUMRl9CUVo3a1a06wQq7nYnJzjuy84kc8gQ4mlCnghcEdUotk7G69LNQl
         ixN9LNETNDnqTTrJJUv45mNtu3LO/hVqBSlsFBS97zbhalAnvfAuwz378WgLcv6l621D
         znM9pw0mWKa1+DMdhuWu5dXa8lkvgz8YsSKnEuNrGlTADgumNhQCRVx37SjUSaLWMoWT
         smTQ==
X-Gm-Message-State: AOAM530CBvwMUCHdXjQMGlXVECVoOIye5OlZFHiMQDPieNJ489RZiIX5
        czZfSasGZvCxc8l8RPSj4GwH9WJcI/KUsS0F
X-Google-Smtp-Source: ABdhPJxUaPsJMhQF3ZM9WmIYgUIzJEiLmwI9x1gBSK0PmZoRWH5sp5ky8unYoOay+2JTMX7fH1KXhQ==
X-Received: by 2002:a02:77d0:: with SMTP id g199mr1135829jac.118.1616157622494;
        Fri, 19 Mar 2021 05:40:22 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x6sm2479363ioh.19.2021.03.19.05.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 05:40:22 -0700 (PDT)
Subject: Re: [PATCH net-next 4/4] net: ipa: activate some commented assertions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319042923.1584593-1-elder@linaro.org>
 <20210319042923.1584593-5-elder@linaro.org> <YFQwAYL15nEkfNf7@unreal>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7520639c-f08b-cb25-1a62-7e3d69981f95@linaro.org>
Date:   Fri, 19 Mar 2021 07:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFQwAYL15nEkfNf7@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 12:00 AM, Leon Romanovsky wrote:
> On Thu, Mar 18, 2021 at 11:29:23PM -0500, Alex Elder wrote:
>> Convert some commented assertion statements into real calls to
>> ipa_assert().  If the IPA device pointer is available, provide it,
>> otherwise pass NULL for that.
>>
>> There are lots more places to convert, but this serves as an initial
>> verification of the new mechanism.  The assertions here implement
>> both runtime and build-time assertions, both with and without the
>> device pointer.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   drivers/net/ipa/ipa_reg.h   | 7 ++++---
>>   drivers/net/ipa/ipa_table.c | 5 ++++-
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
>> index 732e691e9aa62..d0de85de9f08d 100644
>> --- a/drivers/net/ipa/ipa_reg.h
>> +++ b/drivers/net/ipa/ipa_reg.h
>> @@ -9,6 +9,7 @@
>>   #include <linux/bitfield.h>
>>   
>>   #include "ipa_version.h"
>> +#include "ipa_assert.h"
>>   
>>   struct ipa;
>>   
>> @@ -212,7 +213,7 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
>>   			BCR_HOLB_DROP_L2_IRQ_FMASK |
>>   			BCR_DUAL_TX_FMASK;
>>   
>> -	/* assert(version != IPA_VERSION_4_5); */
>> +	ipa_assert(NULL, version != IPA_VERSION_4_5);
> 
> This assert will fire for IPA_VERSION_4_2, I doubt that this is
> something you want.

No, it will only fail if version == IPA_VERSION_4_5.
The logic of an assertion is the opposite of BUG_ON().
It fails only if the asserted condition yields false.

					-Alex

> 
> Thanks
> 

