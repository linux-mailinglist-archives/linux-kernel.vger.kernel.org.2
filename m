Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3F31F1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBRWA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:00:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:00:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so2303202pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=64rDDh4SwE3XHexhzXLBkyrNAIk1OIDiGQXhmKbervM=;
        b=nR90bQsbPs93+ZJdKKlcfq/gk5/Zx7n4RHCBUrBw1LWZoKFpKiO5vBV75uKnalgnkH
         z4+XrzaoeM4VpR+c7hx5HHK6LZpPdH1D0XIpnHM9sPXWXNTvWWRSQuYvd+HXwP2toDwm
         4fXmRiGL6ISzEATxgd/r/5H77cZdtS/pmy1JAcMIUNrbcU+HoYFXqNC9cV11uYu6k+P4
         RROAoWISukdcFfJM6Wd6RlBCHk8gcLVjTSydBHOn7ZNs4lQ5Vyin0p/L51W5PX+PlIdc
         d3LC1X3twujFy13/6KaJSm+ApsGdgrcQmEXesMdkHtdIx9mDjaCfNJ5TP8K3ghq1fWQl
         G5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=64rDDh4SwE3XHexhzXLBkyrNAIk1OIDiGQXhmKbervM=;
        b=TXXotm1x1seb14suEYKBwkRISjA+VAlTUve/TOfcc3zOZ5YIv+wJ3hBbEJflV6rHox
         XWyL7hRXUP/LakUbAVHMWPhgQnPjTkr+YG3/VDjOB6vbybtG9lSUO1wEgBNtFMX6pOoQ
         YOfSBngjQyOpQpkY0BLx0wyT5cSthLJ6MRTEpJo6fxW7FVCbBv5eP1bZmeP/76g+p+L4
         ehGpAIb7P52tbNXVEV8HTSlfO26hbx1MGM+MKBBFZEq8xdO7oKdCVhYAPQ2Z5UsUvItP
         +ZkbtQ4EPH/+V7FxIg516BePuim2MSRX/QfuzPaw2dip0Xj4d3oK7yfEU1M5tQIUwz+U
         q/mg==
X-Gm-Message-State: AOAM533s+GkXG/pBgUR3d+gqQ5QQxw8QQvg8dBrYSGB5+ODRPXOdORQE
        rq6YKDRflIvZVJZZmdABrfo=
X-Google-Smtp-Source: ABdhPJy7wshfiVW3Tab6/S+m2wfgyaX4Dv17AXeR8rbgRIVgHDvdAWKYQ8T9xBoFCQZTCGdilGCc0g==
X-Received: by 2002:a62:6106:0:b029:1ec:c566:5a5b with SMTP id v6-20020a6261060000b02901ecc5665a5bmr6443823pfb.32.1613685610771;
        Thu, 18 Feb 2021 14:00:10 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p11sm11467434pjb.3.2021.02.18.14.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:00:10 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Sasha Levin <sashal@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com> <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu> <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
 <20210218213925.GD2013@sasha-vm>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <aaceef21-a38c-8fe2-88f9-a1caa32c3b37@gmail.com>
Date:   Thu, 18 Feb 2021 14:00:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218213925.GD2013@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 1:39 PM, Sasha Levin wrote:
> On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
>> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
>>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
>>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
>>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>>>>>> As a company, we are most likely shooting ourselves in the foot by
>>>>>> not
>>>>>> having a point of coordination with the Linux Foundation and key
>>>>>> people
>>>>>> like you, Greg and other participants in the stable kernel.
>>>>>
>>>>> What does the LF have to do with this?
>>>>>
>>>>> We are here, on the mailing lists, working with everyone.  Just
>>>>> test the
>>>>> -rc releases we make and let us know if they work or not for you, it's
>>>>> not a lot of "coordination" needed at all.
>>>>>
>>>>> Otherwise, if no one is saying that they are going to need these for 6
>>>>> years and are willing to use it in their project (i.e. and test it),
>>>>> there's no need for us to maintain it for that long, right?
>>>>
>>>> Greg, please remember I expressed I really need them for slightly
>>>> more than
>>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time
>>>> permits if
>>>> this saves me from having to take over these kernels after you, like
>>>> in the
>>>> past, but I cannot engage on the regularity of my availability.
>>>
>>> Ok, great!
>>>
>>> That's one person/company saying they can help out (along with what CIP
>>> has been stating.)
>>>
>>> What about others?  Broadcom started this conversation, odd that they
>>> don't seem to want to help out :)
>> Greg, I'm sorry but I'm not in a position to provide such a commitment.
>>
>> My original question arose because the 5.10 kernel is declared as 2
>> years LTS while older LTS kernels are now 6 years.
>> One problem this has created is requests to provide silicon support in
>> an older kernel version (for a new project) rather than starting from
>> a newer kernel version that more properly supports the (silicon and
>> non-silicon) features.
> 
> So this sounds like you have boatloads of out-of-tree code and need a
> stable kernel to avoid having to rebase that code. This is not why the
> LTS trees are around.
> 
> For new projects, the easiest route is to upstream your stuff and ship
> the latest kernel.

Agreed, however no matter how good you are at upstreaming your changes,
there is always a delta that you keep accumulating, it is just the
reality of things be it because a specific piece of code was just harder
to upstream you missed multiple kernel versions, or it was not suitable,
or it changed, or anything. Not everything goes upstream even if that
gets closer and closer to zero if you do a good job at it.

> 
>> If all LTS kernels were declared as 3.5-4 years as Willy commented
>> this would solve a few issues.
>> 6 year LTS kernels would only have a maximum 1 year lifespan over the
>> latest declared LTS kernel.
>> Also, many products take a year or more to develop, there isn't any
>> life left in an LTS kernel if it is only 2 years.
> 
> Products are supposed to upgrade their kernel. If you released something
> with, for example, a 5.4 kernel, doesn't mean you're forever stuck on a
> 5.4 kernel for that product.

The are lots of Android devices manufacturers that launch using of the 3
kernel versions supported by the given Android release they targeted and
they do not update the kernel version ever after that.

> 
>> After 1-3 years of kernel age the relevant parties that want to invest
>> and care about supporting specific kernel versions longer should
>> become apparent and could commit to longer support.  Perhaps you move
>> the burden of 6 years LTS elsewhere to longer term projects.  But, I'm
>> sure many are happy because you continue doing such a great job in a
>> central location, especially those whose product lifespan is around 6
>> years.
> 
> But this is exactly what's happening now: we support LTS kernels for two
> years, and after that interested parties can figure it out on their own
> if it's worth it for them to keep going.
> 

-- 
Florian
