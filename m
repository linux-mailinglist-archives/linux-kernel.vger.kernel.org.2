Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9006B3BB6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGEFnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:43:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15992 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhGEFnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:43:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625463674; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+oDSSXyT2xhBvBFnw/v2pl9Ou/LSQG1wXgB0Sra79+Y=; b=lflq6XzWAmxzwsvgNA7UsQe5B+fOVgDYxsG2jtMS3rCXX6Fbjlh5BUPhO6XmSC2FJyoyJFQ/
 YD+ywcEobFqteBg7rcW1tMNv/XLWG5ie9GYaOGZcM/1dI+4tHs8LKUpLdSFhEwq05BhbB9oi
 y2xn0C+raUY9ZbnMJySFaJeH/ww=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60e29b702a2a9a9761abe395 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Jul 2021 05:41:04
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39643C433F1; Mon,  5 Jul 2021 05:41:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.50.35.89] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41505C433D3;
        Mon,  5 Jul 2021 05:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41505C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Use corner in power_off
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210703005416.2668319-1-bjorn.andersson@linaro.org>
 <20210703005416.2668319-2-bjorn.andersson@linaro.org>
 <cacd1a1f-01c8-b913-23e5-538a772cd118@codeaurora.org>
 <CAOCOHw4sufqC3=ixNud8Oz7vO0_ZcO8u5mqNQTKLZX4LGe9aow@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c4440f5e-592c-b849-3ca7-57e812de2df5@codeaurora.org>
Date:   Mon, 5 Jul 2021 11:10:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOCOHw4sufqC3=ixNud8Oz7vO0_ZcO8u5mqNQTKLZX4LGe9aow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2021 10:36 AM, Bjorn Andersson wrote:
> On Sun, Jul 4, 2021 at 11:27 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>>
>>
>> On 7/3/2021 6:24 AM, Bjorn Andersson wrote:
>>> rpmhpd_aggregate_corner() takes a corner as parameter, but in
>>> rpmhpd_power_off() the code requests the level of the first corner
>>> instead.
>>>
>>> In all (known) current cases the first corner has level 0, so this
>>> change should be a nop, but in case that there's a power domain with a
>>> non-zero lowest level this makes sure that rpmhpd_power_off() actually
>>> requests the lowest level - which is the closest to "power off" we can
>>> get.
>>>
>>> While touching the code, also skip the unnecessary zero-initialization
>>> of "ret".
>>>
>>> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>    drivers/soc/qcom/rpmhpd.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>>> index 2daa17ba54a3..fa209b479ab3 100644
>>> --- a/drivers/soc/qcom/rpmhpd.c
>>> +++ b/drivers/soc/qcom/rpmhpd.c
>>> @@ -403,12 +403,11 @@ static int rpmhpd_power_on(struct generic_pm_domain *domain)
>>>    static int rpmhpd_power_off(struct generic_pm_domain *domain)
>>>    {
>>>        struct rpmhpd *pd = domain_to_rpmhpd(domain);
>>> -     int ret = 0;
>>> +     int ret;
>>>
>>>        mutex_lock(&rpmhpd_lock);
>>>
>>> -     ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
>>> -
>>> +     ret = rpmhpd_aggregate_corner(pd, 0);
>>
>> This won't work for cases where pd->level[0] != 0, rpmh would just ignore this and keep the
>> resource at whatever corner it was previously at.
>> (unless command DB tells you a 0 is 'valid' for a resource, sending a 0 is a nop)
>> The right thing to do is to send in whatever command DB tells you is the lowest level that's valid,
>> which is pd->level[0].
>>
> 
> I'm afraid this doesn't make sense to me.
> 
> In rpmh_power_on() if cmd-db tells us that we have [0, 64, ...] and we
> request 64 we rpmhpd_aggregate_corner(pd, 1); but in power off, if
> cmd-db would provide [64, ...] we would end up sending
> rpmhpd_aggregate_corner(pd, 64);
> So in power_on we request the corner (i.e. index in the array provided
> in cmd-db) and in power-off the same function takes the level?

ah that's right, I did not read the commit log properly and got confused.
Looks like this bug existed from the day this driver for merged :/, thanks
for catching it.
Does it make sense to also mark this fix for stable?

> 
> Can you please help me understand what the actual number we're
> supposed to send to the RPMh is? Is it numbers in the range [0-15] or
> is it numbers such as {0, 64, 128, ...}?
> 
> Afaict it's the prior (i.e. [0-15]), as this is what we currently do
> in both power_on and set_performance_state, and it happens to be what
> we send in power_off as long as the first level from cmd-db is 0.
> 
> Regards,
> Bjorn
> 
>>
>>>        if (!ret)
>>>                pd->enabled = false;
>>>
>>>
>>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
