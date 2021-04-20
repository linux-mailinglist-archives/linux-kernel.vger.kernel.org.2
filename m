Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE23366155
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhDTVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhDTVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:04:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81DDC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:03:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u187so1514788wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cYO7vDLb7H/qv4a9RNyxrlFATbtEeCCZCwBxKW65aeo=;
        b=JE085+pENUR7PR+GqZ3uXiaYYzXrmijd1JyQ3UZO+fYJ/8QPehjKala4j7i1j38cYX
         DZSW7iTRUowG+G5Kcd8F6R56g4iPqGaPJ4558ZiRNz3SIv+AgMh/Xqvcv84vxjd3AUXD
         KMgz5glBpz/r2b6RMFyGaOKvTXAiTby2X75vfTeDVps4K9jZ6QgEtCNOdWVm+Eam7DAc
         5E1pxoIAH5kuHc1jsideHWIvZ+6rPWhqqE0l9F5QVk+AtjnwzqMA2iGaH2BbtYNkm0Pv
         l3CkD822F3RdzaLI26EUiHBfNzG16JnErLKqGROW4wtpu0qhvWs2QWbhnpo7NjJzMwch
         8GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYO7vDLb7H/qv4a9RNyxrlFATbtEeCCZCwBxKW65aeo=;
        b=FWH2pfe4Cv8g1/BJNkriUx0TIDJEa8uM9f+MpOGJOaTEsNySieM6aeLUYqF6zjoMJI
         x2OuLli7iZ2faxFO5VAtxBAcfIFu/zzu55bIgAtZOF1a8UnN8nP3WQE1u/o2bUw1xBFY
         BKmUSfKMy3X4Dyh6TsPhLlmCZuZTosajtjsgMezWac+bf80WScZjl8nld2wWxUkJnvRv
         L9d2pY7WjXlhssMhOwtlNVRG77C1bRoHfnGmzyRKs1RLAvCXZc6cYzFYi1o9iZSBLxxW
         nC9PfTAmmKKR2NdRb+VmZZcaAFv0JBg4cykh/bN3PWkPi/5QRB2oEdpzekFuVjbud+h3
         tBIg==
X-Gm-Message-State: AOAM5315Ns7bNQIUVW8rSSdmT+dH1tu18tHnPAquBsg4ZP6iC8g10BW+
        i797qLBmGaty3bCSAJRCf9MXKg==
X-Google-Smtp-Source: ABdhPJyQNNfsTPUtfWhpL3X/uKMBsYrGknMy/3pmGkwXUDA12lae3ABqctafsGfSLN8n9+E8CtWZoA==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr6163003wmh.40.1618952628224;
        Tue, 20 Apr 2021 14:03:48 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d985:3a3b:ec32:bdfe? ([2a01:e34:ed2f:f020:d985:3a3b:ec32:bdfe])
        by smtp.googlemail.com with ESMTPSA id z14sm189426wrs.96.2021.04.20.14.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:03:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: power_allocator: update once cooling
 devices when temp is low
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210419084536.25000-1-lukasz.luba@arm.com>
 <20210419084536.25000-3-lukasz.luba@arm.com>
 <c69e2ba0-b382-01a0-292f-019fffd365e0@linaro.org>
 <55943d6f-0f72-215d-1dd4-bf3996092df7@arm.com>
 <91411c9c-d78e-8ba6-1cd3-da6879bc5ceb@linaro.org>
 <0fc57590-cc7c-9e04-16bc-13b7b787ad2f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6ca7915a-9d31-10bd-4f9b-2f815a41df05@linaro.org>
Date:   Tue, 20 Apr 2021 23:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fc57590-cc7c-9e04-16bc-13b7b787ad2f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 22:01, Lukasz Luba wrote:
> 
> 
> On 4/20/21 4:24 PM, Daniel Lezcano wrote:
>> On 20/04/2021 16:21, Lukasz Luba wrote:
>>> Hi Daniel,
>>>
>>> On 4/20/21 2:30 PM, Daniel Lezcano wrote:
>>>> On 19/04/2021 10:45, Lukasz Luba wrote:
>>>
>>> [snip]

[ ... ]

> 
> That new approach should work. I can test your patch with this new
> functions and re-base my work on top of it.
> Or you like me to write such patch and send it?

At your convenience. I'm pretty busy ATM with more patches to review, so
if you can handle that change that will be nice. Otherwise, I can take
care of it but later.

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
