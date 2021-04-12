Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D830E35BB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhDLHzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:55:47 -0400
Received: from foss.arm.com ([217.140.110.172]:40154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236808AbhDLHzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:55:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CF931B;
        Mon, 12 Apr 2021 00:55:25 -0700 (PDT)
Received: from [10.57.25.103] (unknown [10.57.25.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBAF3F73B;
        Mon, 12 Apr 2021 00:55:24 -0700 (PDT)
Subject: Re: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
To:     Javi Merino <javi.merino@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, thara.gopinath@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210217115908.22547-1-lukasz.luba@arm.com>
 <20210218041812.o2yksgbfdvbgtwc4@vireshk-i7>
 <e3208461-f4ec-8c88-8af4-67c777f9382a@arm.com>
 <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org> <YHGL5MDcOnXPRL+0@tesla>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <24197c4e-4f66-2373-4461-4b4938ba2a84@arm.com>
Date:   Mon, 12 Apr 2021 08:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YHGL5MDcOnXPRL+0@tesla>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/21 12:28 PM, Javi Merino wrote:
> On Fri, Apr 02, 2021 at 12:53:08PM +0200, Daniel Lezcano wrote:
>> On 02/04/2021 12:25, Lukasz Luba wrote:
>>> Hi Viresh, Daniel
>>>
>>> On 2/18/21 4:18 AM, Viresh Kumar wrote:
>>>> On 17-02-21, 11:59, Lukasz Luba wrote:
>>>>> Update maintainers responsible for CPU cooling on Arm side.
>>>>>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>> Hi Daniel,
>>>>>
>>>>> Please ignore the previous email and that this change with 'R'.
>>>>> Javi will ack it later.
>>>>>
>>>>> Regards,
>>>>> Lukasz
>>>>>
>>>>>    MAINTAINERS | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index f32ebcff37d2..fe34f56acb0f 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
>>>>>    M:    Amit Daniel Kachhap <amit.kachhap@gmail.com>
>>>>>    M:    Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>    M:    Viresh Kumar <viresh.kumar@linaro.org>
>>>>> -M:    Javi Merino <javi.merino@kernel.org>
>>>>> +R:    Lukasz Luba <lukasz.luba@arm.com>
>>>>>    L:    linux-pm@vger.kernel.org
>>>>>    S:    Supported
>>>>>    F:    Documentation/driver-api/thermal/cpu-cooling-api.rst
>>>>
>>>> Good that we have one more reviewer for this :)
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>
>>>
>>> I believe it has lost somewhere in people mailboxes.
>>>
>>> Thank you Viresh for the ACK.
>>>
>>> Could you Daniel (or you Viresh) take this patch, please?
>>
>> I was expecting Javi to ack it.
> 
> I did, but it looks like my replies never made it to the mailing
> list.  Anyway, here it is:
> 
> Acked-by: Javi Merino <javi.merino@kernel.org>
> 

Thank you Javi!

Lukasz
