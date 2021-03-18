Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDD73406EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCRNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhCRNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:33:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:33:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so2267879iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vXZ+Ewk3h6WQoE1dpSc6RxoUarL55TFRk0svxaHjcA=;
        b=tTtSWzIEpbhkosQ+izZbQgCdo6jsD7PlI1BJcJCR0vGK3DcF02paQyZXJ49Ev+QXbs
         LSAtWX5Kj2T2io/LmIUV7vM7Lkvv1dtmGc8e/tm+mgem0xhdOWiaRJhp7oNsVFdgWKB2
         aHnYYUJGgbShTty1/UwgJDCm9CnfiCueqhHZQcBpergKTZWCgtDOviWcxVLFGAPsOmsG
         jC+zEJxvVfpdIDAK9TPfMyz+WeOcDP1bTFlzPmdrHQv3ACD8DzXrzfaziXqc+uH4MBQ/
         SVqAktd3+fcn/v4uAAfc5MYCNo9buMNGQFvvmT0NeWxr1C1D2mIMVVfJ9wA9xh4VNEY8
         Yp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vXZ+Ewk3h6WQoE1dpSc6RxoUarL55TFRk0svxaHjcA=;
        b=p5K70loiD4IPfg87PpHepoZOCG+EeFyJNu+EpTt20hFYbfXGIQOVYCbwGc/vkm7h5h
         d+zDuNGbP2omc1tajC/d/ZjnYMAvlee2liirHJVGUbDBJLvi1ySH8zgJU0Otk1Jq3e6O
         7iUkR+V7Kal221ZcYiTu1IdMk1X8C1DbnTj2lpZp46Vf6UYvK8efg7/I3/MD7Jt9bYhP
         XhUWPjY6gNxz+xCTijvxb+Ixz8iO/0p1L5ZEN0l6p5gm7pgfhiR3anryVjDm1UiWZKkp
         EaQIEhE+1ElOVXUiF5zNtlnwBPPK1y96cJOIc0iWoMxkZu4g8UBlE55Qziw9d4zb/nSi
         qzYw==
X-Gm-Message-State: AOAM532wwXykQ47LcUe9mDJ1+905E5t+00Sgfkah7N0KUbLwa8qetG1M
        +1OOP6fdIqPGusbBTZ8fzwQ7d+yUqaLnDmwV
X-Google-Smtp-Source: ABdhPJyfdR7y0YUEJuPHSd/qhkfAAU8dj/2B1byFgsMpH8dN7BgJoj9P7a8TvBwAFtnZt6J7A1P8Bw==
X-Received: by 2002:a02:b890:: with SMTP id p16mr6760602jam.138.1616074416669;
        Thu, 18 Mar 2021 06:33:36 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d2sm1143893ilm.7.2021.03.18.06.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 06:33:36 -0700 (PDT)
Subject: Re: [PATCH net-next 2/4] net: ipa: introduce dma_addr_high32()
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Alex Elder <elder@ieee.org>, davem@davemloft.net,
        kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317222946.118125-1-elder@linaro.org>
 <20210317222946.118125-3-elder@linaro.org>
 <36b9977b-32b1-eb4a-0056-4f742e3fe4d6@gmail.com>
 <60106d7b-ad70-01fa-9f90-fe384cc428f8@ieee.org>
 <f0215cf7-3a62-421c-28bf-17aa4e197b9b@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <6afe045d-7157-2b7f-1dcc-0eddcf77d8a1@linaro.org>
Date:   Thu, 18 Mar 2021 08:33:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f0215cf7-3a62-421c-28bf-17aa4e197b9b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 6:00 PM, Florian Fainelli wrote:
> 
> 
> On 3/17/2021 3:49 PM, Alex Elder wrote:
>> On 3/17/21 5:47 PM, Florian Fainelli wrote:
>>>> +/* Encapsulate extracting high-order 32 bits of DMA address */
>>>> +static u32 dma_addr_high32(dma_addr_t addr)
>>>> +{
>>>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>> +    return (u32)(addr >> 32);
>>> You can probably use upper_32bits() here...
>>
>> Where is that defined?  I'd be glad to use it.    -Alex
> 
> include/linux/kernel.h, and it is upper_32_bits() and lower_32_bits()
> sorry about the missing space.

That's nice.  I'll still use a separate commit (and will
credit you with the suggestion) but it will be much smaller.

Thanks.  I'll post v2 shortly.

					-Alex

