Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA5352A10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhDBLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:08:25 -0400
Received: from foss.arm.com ([217.140.110.172]:34856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234981AbhDBLIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:08:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F3CD6E;
        Fri,  2 Apr 2021 04:08:20 -0700 (PDT)
Received: from [10.57.24.15] (unknown [10.57.24.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 991E83F694;
        Fri,  2 Apr 2021 04:08:18 -0700 (PDT)
Subject: Re: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        thara.gopinath@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        Javi Merino Cacho <Javi.MerinoCacho@arm.com>
References: <20210217115908.22547-1-lukasz.luba@arm.com>
 <20210218041812.o2yksgbfdvbgtwc4@vireshk-i7>
 <e3208461-f4ec-8c88-8af4-67c777f9382a@arm.com>
 <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d2a59a36-6bf5-5f18-8467-adcb54075c8f@arm.com>
Date:   Fri, 2 Apr 2021 12:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC Javi (on his Arm email)

On 4/2/21 11:53 AM, Daniel Lezcano wrote:
> On 02/04/2021 12:25, Lukasz Luba wrote:
>> Hi Viresh, Daniel
>>
>> On 2/18/21 4:18 AM, Viresh Kumar wrote:
>>> On 17-02-21, 11:59, Lukasz Luba wrote:
>>>> Update maintainers responsible for CPU cooling on Arm side.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>> Hi Daniel,
>>>>
>>>> Please ignore the previous email and that this change with 'R'.
>>>> Javi will ack it later.
>>>>
>>>> Regards,
>>>> Lukasz
>>>>
>>>>    MAINTAINERS | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index f32ebcff37d2..fe34f56acb0f 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
>>>>    M:    Amit Daniel Kachhap <amit.kachhap@gmail.com>
>>>>    M:    Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>    M:    Viresh Kumar <viresh.kumar@linaro.org>
>>>> -M:    Javi Merino <javi.merino@kernel.org>
>>>> +R:    Lukasz Luba <lukasz.luba@arm.com>
>>>>    L:    linux-pm@vger.kernel.org
>>>>    S:    Supported
>>>>    F:    Documentation/driver-api/thermal/cpu-cooling-api.rst
>>>
>>> Good that we have one more reviewer for this :)
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>
>> I believe it has lost somewhere in people mailboxes.
>>
>> Thank you Viresh for the ACK.
>>
>> Could you Daniel (or you Viresh) take this patch, please?
> 
> I was expecting Javi to ack it.
> 
> 

Probably he missed that resend version in his kernel.org
mailbox.
I've discussed with him this change. He suggested it.

Regards,
Lukasz

