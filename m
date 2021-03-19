Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4B341F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCSOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:11:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B40C061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:11:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 94so6805492qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n05/sUnctT8JNpCXRuTVFYfsWiFecSrOrifRVD4fRAo=;
        b=uQjDbyQuWf0O/YJbUTQbMaXA4pFNWX0tz2Myqmvcmf6G9Cd6FKUqO3gptczGs80b7/
         Yh1P5BwMoIJck3kcZWF5mxExv5Qy+AOmFXD6Q8XkIqzbsrR3JveJEi0dlxcOiQoebzyP
         04xz+97zEDc4qCB/lYqCVYKU2uUbv0ZXw+Y1EBzHVke3bIUuQjsz/8gcIS5sTb+iSIEZ
         MGJJGhgUGCOxg85n5n6k7anttmwhcIRcxMsBogTCeZfujc7DzJ/vpwE79a06Mo/RbBiQ
         u8MC2gI+FJeUzhSr7GLLUpAAQIeKFb0GRRQ3NCGKx75z2LF0Dt1S5tuqmHpmlzuBM3ZX
         ao4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n05/sUnctT8JNpCXRuTVFYfsWiFecSrOrifRVD4fRAo=;
        b=sUPjVN86aDdTluOC7PNLm7oEYFoWWDZZI/bH9aGmIzbJDu4fH+ELAXDce4LJd35Xg3
         AFOziKyBEaUPoo6RdmNQnpVcG9CBPwWdgQ4rh5wwHbLWGJ/ZoOWbVplp4cUDfbKV+ZL1
         MbwY+LU9x4JHArflf0NDs6FgoUIOc9WuTFF8jykzPH0DudEGsTJc/P0iRmmgsxsV8oS1
         TZTZC7DPH1am3unoO+fRRLfhAY1h61l9k+e9qeAr+qN0lQfK8Whl+LWx+vWQ4mAhNqxx
         Jg91YUWlGKn2njEbNQ9ZOOL1Y/5+9UxyMCRe5YQGhV0WcbiZd8B/cUfbvimXWl4UiFoG
         XHwA==
X-Gm-Message-State: AOAM530NIjr3obvZrhul+iidBWWouBJoowGdIJOQXBfW4ucCWDZnXIsM
        o5h6DOrTC23p9NkU3WuN1BdR+MKl08iZOg==
X-Google-Smtp-Source: ABdhPJwVohUpLTVKBQsZX8ZJ3mo/T8pKdNPg5RWYYQxr3M9rJmhdKyY6tuj7lSeJjc2dRHuYtN1goQ==
X-Received: by 2002:aed:31e2:: with SMTP id 89mr8577216qth.272.1616163083298;
        Fri, 19 Mar 2021 07:11:23 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id g6sm4496940qkd.62.2021.03.19.07.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 07:11:22 -0700 (PDT)
Subject: Re: [PATCH v11 1/9] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
 <20210319005228.1250-2-ansuelsmth@gmail.com>
 <7c38ea02-d957-6f63-ccce-1c35dd5d04de@linaro.org>
 <YFSm5rz3ivnzxoJ4@Ansuel-xps.localdomain>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <8850c559-45cb-45cd-9d39-287b8c041c79@linaro.org>
Date:   Fri, 19 Mar 2021 10:11:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFSm5rz3ivnzxoJ4@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 9:28 AM, Ansuel Smith wrote:
> On Fri, Mar 19, 2021 at 09:11:38AM -0400, Thara Gopinath wrote:
>>
>>
>> On 3/18/21 8:52 PM, Ansuel Smith wrote:
>>> VER_0 is used to describe device based on tsens version before v0.1.
>>> These device are devices based on msm8960 for example apq8064 or
>>> ipq806x.
>>
>> Hi Ansuel,
>>
>> There are still checkpatch check warnings in this patch. Please run
>> checkpatch.pl --strict and fix them. Once that is done, you can add
>>
>> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
>>
>> Warm Regards
>> Thara
>>
> 
> Hi,
> thanks a lot for the review. The only warning I have is a line ending
> with ( that i think I can't fix or I will go over the max char for line.
> Do you have something more?

I see two warning for line ending with (. The max char limit is 100.

-- 
Warm Regards
Thara
