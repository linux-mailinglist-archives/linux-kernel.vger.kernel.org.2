Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8984D4149C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhIVMzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:55:31 -0400
Received: from foss.arm.com ([217.140.110.172]:48624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhIVMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:55:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7138F11B3;
        Wed, 22 Sep 2021 05:53:59 -0700 (PDT)
Received: from [10.57.50.100] (unknown [10.57.50.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA1C3F40C;
        Wed, 22 Sep 2021 05:53:58 -0700 (PDT)
Subject: Re: [PATCH] coresight: Don't immediately close events that are run on
 invalid CPU/sink combos
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210921130231.386095-1-james.clark@arm.com>
 <ff78b350-f899-0515-ef54-16a3e89ae9d2@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <859c5009-a050-2832-7e1b-e88c5d2acd12@arm.com>
Date:   Wed, 22 Sep 2021 13:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ff78b350-f899-0515-ef54-16a3e89ae9d2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 10:24, Suzuki K Poulose wrote:
> On 21/09/2021 14:02, James Clark wrote:
[...]
>> -    event->hw.state = 0;
>> -
>>       /* Finally enable the tracer */
>>       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>>           goto fail_disable_path;
>>   +out:
>> +    /* Tell the perf core the event is alive */
>> +    event->hw.state = 0;
>>       /* Save the event_data for this ETM */
>>       ctxt->event_data = event_data;
>> -out:
>>       return;
> 
> Hi James,
> 
> I think this problematic. The "out" label is reached from the "failed"
> path. So, we would reset the STOPPED state. I think we should simply
> return when we reach the "fail" label.
> 
> Please could you resend this patch with the changes.
> 
> Kind regards
> Suzuki
> 

Oops yes I missed that, I've resubmitted. It probably would have just about
worked because from my testing it seems like the event isn't re-enabled
if perf_aux_output_end() is called from start regardless of the STOPPED/RUNNING
state.

Thanks
James
