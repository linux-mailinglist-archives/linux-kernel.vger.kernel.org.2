Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67036860E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbhDVRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:36:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B99C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:36:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so41905883wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lotpi9GZ6JPdTYF1Tc1mMLoIS8x4dJMlm5P+JRko4p8=;
        b=AgoaZjOtQNYI7lUJtuStVyjbesyoyrqqI+zShNKzhAMh8oF5XgldyIbG/kfLkrvwJC
         NLftfnuiw6//Rgtiw86Sj/PX8iIXPcv17Baz//qx4hfyEEMzjS8zg9OHd00uQYUhdJuo
         91BWRwLoEsxbM1Egb3IweWo0w4aHzfdaHI0OYqPeHDDIo27wZc6BaFM/l2eQFbXXcXuz
         4IB6EJfWOdb3XeYxubnipkBPWYfUb4OE/BDmu36+6NiOlmHHG0g6FSmxwOoopO5QKohj
         yCyId28HId4hlFw0BItvVEWerJHo2O35SEU8XIwicwYzsrJfTh2LxlUTNxGp1lGXcIbt
         3z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lotpi9GZ6JPdTYF1Tc1mMLoIS8x4dJMlm5P+JRko4p8=;
        b=sSaqGAul5Wwd7f6WY92DQC+ny1DHkIcaGBPO2FCGPmK4+q8pe6i4yFPb2LzID6VOAB
         M1IbSr1wcrDy5NjON+xT5//nc9fFKo20fylF1ewnBlrVdnd9jX2dtA2HVKiSHRCMylxB
         gKQy3OeghRC69XIqOcZz8fIJqNtTKd7jNA0qz//j+zRBRqjgdk2Cn/CPrjL1ZK03bLrW
         +y9YOHmOUt1oxe7fHu9q5j8S2RlcBgpBFbKKIo3J5/iNppR+hR7rNQCfc+9Hy+6H47HP
         uk1rwad4l2JETobaYP/aSC688c0rV8/ee4ns0VoEHg9yXNnKeS8rP7xFb2SpKvPK5mEd
         3+Xw==
X-Gm-Message-State: AOAM531FiSKO9J/yD3tXewxzjaMPbCAAA+AdaSLkI0jnvcXfZUzu7JqY
        ATuedd1JTwsnnAhEblX6KRBxKA==
X-Google-Smtp-Source: ABdhPJy8u4KI0OFaLA6S5XbhWmAj908iIkYI0KnP3Dm8Gix4lwslvIHx39tv5X/FZoadDyiLxDCX0g==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr5501813wrq.95.1619112964609;
        Thu, 22 Apr 2021 10:36:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9? ([2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9])
        by smtp.googlemail.com with ESMTPSA id i4sm4997426wrx.56.2021.04.22.10.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:36:04 -0700 (PDT)
Subject: Re: [PATCH 0/3] Thermal governors improvements and a fix
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210422153624.6074-1-lukasz.luba@arm.com>
 <25ceedef-f3eb-0187-7397-9d4ca30fcb93@linaro.org>
 <d783748d-105d-5919-6550-442229dd612a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <12a5ba3b-9822-30a1-5d23-2b67197a69ad@linaro.org>
Date:   Thu, 22 Apr 2021 19:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d783748d-105d-5919-6550-442229dd612a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 19:33, Lukasz Luba wrote:
> 
> 
> On 4/22/21 6:31 PM, Daniel Lezcano wrote:
>> On 22/04/2021 17:36, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The patch set introduces one fix (patch 1/3) and two improvements, which
>>> are possible thanks to the new helper function [1].
>>> The patch 1/3 with a fix for fair share thermal governor is also sent
>>> CC'ed stable, but it's hard to point a particular commit, which back
>>> then was for fair_share.c.
>>>
>>> The patch set should apply on top of [1].
>>>
>>> Regards,
>>> Lukasz
>>>
>>> [1]
>>> https://lore.kernel.org/linux-pm/20210422114308.29684-2-lukasz.luba@arm.com/
>>>
>>>
>>> Lukasz Luba (3):
>>>    thermal: fair share: lock thermal zone while looping over instances
>>>    thermal: fair share: use __thermal_cdev_update()
>>>    thermal: power allocator: use __thermal_cdev_update()
>>>
>>>   drivers/thermal/gov_fair_share.c      | 11 +++++++----
>>>   drivers/thermal/gov_power_allocator.c |  3 +--
>>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> Applied, thanks
> 
> thanks!
> 
>>
>> Two users left of thermal_cdev_update ;)
>>
>>
> 
> True, I didn't dare to touch them, since that would require more
> work and understandings :)

Yeah I agree. The changes are no trivial ...




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
