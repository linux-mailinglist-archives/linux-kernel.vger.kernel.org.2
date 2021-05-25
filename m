Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E23038FFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEYLGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:06:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEYLGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:06:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FBF0D6E;
        Tue, 25 May 2021 04:05:00 -0700 (PDT)
Received: from [10.57.0.41] (unknown [10.57.0.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBF9D3F719;
        Tue, 25 May 2021 04:04:47 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKzETaPD/Flnz+dz@google.com>
 <20210525094601.GB369979@e124901.cambridge.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f8a2bbde-47c4-bd7d-96fa-228c9d9e2779@arm.com>
Date:   Tue, 25 May 2021 12:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210525094601.GB369979@e124901.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/21 10:46 AM, Vincent Donnefort wrote:
> On Tue, May 25, 2021 at 09:33:01AM +0000, Quentin Perret wrote:
>> On Friday 21 May 2021 at 17:54:24 (+0100), Vincent Donnefort wrote:
>>> @@ -161,6 +162,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>>>   		table[i].cost = div64_u64(fmax * table[i].power,
>>>   					  table[i].frequency);
>>>   		if (table[i].cost >= prev_cost) {
>>> +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
>>> +			pd->flags |= EM_PERF_DOMAIN_INEFFICIENCIES;
>>
>> If we're looking for micro-optimizations, then perhaps you could store
>> the index of the next efficient OPP (which would be 'i' if the current
>> OPP is already efficient), so you can jump to it directly when doing the
>> search.
> 
> Wouldn't add any new field compared to this version so yeah might be an
> interesting improvement.
> 

That's a few more instructions to parse the 'flags' filed. I'm not sure
if that brings speed improvements vs. if we not parse and have bool
filed with a simple looping. The out-of-order core might even suffer
from this parsing and loop index manipulations...
