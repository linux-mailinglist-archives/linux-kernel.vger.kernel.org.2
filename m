Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B97346445
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhCWQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhCWQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:00:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09FC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:00:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c8so8410758wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rb30UVZ55q+aHE7qbQlMjCU87RYU/feR0BvSjXj15jE=;
        b=JmxgIGE10nYdq/DMa3kCiNQbxHtH70ncg6bXCwk0YMqewDHglakJLZn1qYN02PIpxB
         aCrKE79jIib34rb0LhfZRHjDguFtzkpcuIC/6pqUy3kBtb0MpLhNQ6JiShzLya5+rQhg
         pDP90KMknf2Kq1gpzlOuQIu9IwN9qoepciCK50JOEA5hOl0/FYtdvfDjzqE2/S1CoP75
         90H04TEHgt0hDyhu+uyMNEvSd4W1Pu4VTegMlI/IwXEDyyOlh7fKel40BKDKMkbO+fgw
         n0YckGGw7RhRIHLzjmT6OXUiUIxJz0ACW7kLiz7MTWh8D1sxGkziRczuE3ayKu3wi/YP
         tVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rb30UVZ55q+aHE7qbQlMjCU87RYU/feR0BvSjXj15jE=;
        b=ZE7ERnut3UPLujdAQIYCJZxI9nDw25I/Y0PpVFpm+WWN+pmoLQVE95BoYeZ67UIik2
         uw7wROx3ekiDcETTvpX/AV2kw0d/pa4y75dcm1p+T4E43k9KdKDEXQGkdhDDTi+qF1SL
         1BldlsnUaFAE+34eC7T65SxKEWgVP3Lqr51NeuSh9HJMSFWhJd+viqQ9Yz2YgAzQ8oe7
         drqqtg3Cr9S2Ot+5+iTfvDoZMtuN7PYKm2Ac0R0DRx4vtqNTjy5Z5Lg0LI0z5VMFL29Y
         jCiKR/2DOwmxP99H15TEROW1cpyIXXwLMsIYPIM1OGRWzz/pSY4Abqm8uKhqnAUb3EVb
         3pnw==
X-Gm-Message-State: AOAM530TYrwUn4UOBTYe0UGUKGuFhNczABZbeZcf19V+Tkx6IyQcEa3t
        lzXJ7oZswPFDCCzgwrvDuiFz+g==
X-Google-Smtp-Source: ABdhPJwXtBkoS3nmkQWlQig8N9oIHyerRJ4rSGpnzIwtMaPrqpU5f5wrHG5Gdix8saYvn1lJ8GO4xg==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr4643829wrs.86.1616515244301;
        Tue, 23 Mar 2021 09:00:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a? ([2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a])
        by smtp.googlemail.com with ESMTPSA id v3sm2935532wmj.25.2021.03.23.09.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:00:43 -0700 (PDT)
Subject: Re: [PATCH] powercap/drivers/dtpm: Add dtpm devfreq with energy model
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     cwchoi00@gmail.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20210319162836.9364-1-daniel.lezcano@linaro.org>
 <9a9931f4-ece5-4fe9-5f88-871a2e759200@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <06c5bbfc-29dd-2883-97de-3523cf235776@linaro.org>
Date:   Tue, 23 Mar 2021 17:00:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a9931f4-ece5-4fe9-5f88-871a2e759200@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 16:56, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 3/19/21 4:28 PM, Daniel Lezcano wrote:
>> Currently the dtpm supports the CPUs via cpufreq and the energy
>> model. This change provides the same for the device which supports
>> devfreq.
>>
>> Each device supporting devfreq and having an energy model can register
>> themselves in the list of supported devices.
>>
>> The concept is the same as the cpufreq dtpm support: the QoS is used
>> to aggregate the requests and the energy model gives the value of the
>> instantaneous power consumption ponderated by the load of the device.
>>
> 
> 
> I've just started the review, but I have a blocking question:
> 
> Why there is no unregister function (like 'dtmp_unregister_devfreq')?
> Do you consider any devfreq drivers to be modules?
> 
> The code looks like an API that it's going to be called directly in
> e.g. GPU driver in it's probe function. In that case probably the
> module unloading should call dtmp unregister.
> 
> Could you explain this to me please? So I can continue the review.

BTW, thanks for taking the time to review the patch.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
