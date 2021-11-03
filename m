Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99119444BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 00:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhKCXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:31:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166ACC06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 16:29:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z206so4928474iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=00Ph1RIe7dliYWMsNE/hFQwPiMqxs2OeRSQXpZ5W7h4=;
        b=pCbREHWXbNxJDeBtD2rIwLFRqFnpfunVkUoLBfvd6YiXdrndZ8m7SAlXCM5gTO4MDu
         yjZNrIhG96fj0kROGTe4Y+K9NP2JD1EgkzNblPX0539quIIQBa+9psgdJ+4odyAtvOC4
         +Hs442EdmZATy+6R4W4m4akltzj5FYp0shjviCN+IpPv+KGeoWKOJXfx/gQIyWDr3UZV
         /eL5Y5LiYlaxQm6ddQNHpzinDLoddPn/o6x7d+eGNv0nyrhzXzUokDBEhcXGFCVSr7Pi
         LnvrvH5Z7qnUnMCXM/2Iquocah23zRhlBlDW6CE/dX+ulyI83XTu8cTIXsYEM1ohKTrE
         BEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00Ph1RIe7dliYWMsNE/hFQwPiMqxs2OeRSQXpZ5W7h4=;
        b=oSm6aXhr6mMQXBaXZuRH1eRCU7LciSFovFC0JLbqJcJx9ozfT638J8fbNcGWjppY+v
         HHdmWatWKIgR9wJtiL09CYtqnCAT2/m/NV2J/kERkto89yDfwQcdQHK+SyOwGBFlwhbt
         BeYOJM4r9lKwVTzwQc89JOYHEHNst6KXQmtmPPN7T4SMG71UoBcz5pwsJGTunDEPSiju
         lwrYPfb4bDpcANCNoHSxjZCq2quMHqDq7HYkqDgh9iLRyd4Ehz0PvP+iZz17FIk7FIzu
         xNz24YDe79A29Py5P/hNKz8B44mca6+NP7a3E1BHf5Jg3BMDdfJvUz9CN4sJtDZn1t4R
         pmTw==
X-Gm-Message-State: AOAM530nWqgRHpIaSn0tJmh0RJpRIvlFT/y7piNj7fQQruD8VWPzdosc
        3xN6+uxYZO4Tp6diNCFubBp/4xDdbMYXrw==
X-Google-Smtp-Source: ABdhPJyLL7UqJLBR33fQ7oBe8HyKz2mnfXazTYoYI/DPMTEKwmue6fBHG3ahKxGMLk3vpQ1OeDaKSA==
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr23087131iow.10.1635982145355;
        Wed, 03 Nov 2021 16:29:05 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f5sm1757713ioo.34.2021.11.03.16.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 16:29:05 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-block@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
 <20211103195411.GA3156469@roeck-us.net>
 <ef74ff48-6d9c-f39c-aff2-8a820440c953@kernel.dk>
 <20211103214113.GA3354463@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f261885-9aae-79fc-02b0-689ffb9e444b@kernel.dk>
Date:   Wed, 3 Nov 2021 17:29:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103214113.GA3354463@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 3:41 PM, Guenter Roeck wrote:
> On Wed, Nov 03, 2021 at 01:56:29PM -0600, Jens Axboe wrote:
>> On 11/3/21 1:54 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
>>>> There's a hole here we can use, and it's faster to set this earlier
>>>> rather than need to check q->elevator multiple times.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> This patch results in a warning backtrace with one of my qemu
>>> boot tests.
>>
>> Should be fixed in the current tree, will go out soonish. If you
>> have time, can you pull in:
>>
>> git://git.kernel.dk/linux-block for-next
>>
>> into -git and see if it fixes it for you?
>>
> 
> Yes, it looks like the problem has been fixed in your for-next branch.

Great, thanks for testing.

-- 
Jens Axboe

