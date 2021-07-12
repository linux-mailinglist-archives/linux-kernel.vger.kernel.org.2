Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA723C5B70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhGLLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:21:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238594AbhGLLT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:19:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A336D;
        Mon, 12 Jul 2021 04:17:07 -0700 (PDT)
Received: from [10.57.35.32] (unknown [10.57.35.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DFE53F694;
        Mon, 12 Jul 2021 04:17:06 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: tmc-etr: Speed up for bounce buffer in flat
 mode
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210710070115.462674-1-leo.yan@linaro.org>
 <f17065d6-5083-74c9-d9ca-a467b640aed3@arm.com>
 <20210712110916.GB704210@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5f3148bf-3efa-5866-b426-8bab4eb40282@arm.com>
Date:   Mon, 12 Jul 2021 12:17:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712110916.GB704210@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2021 12:09, Leo Yan wrote:
> Hi Suzuki,
> 
> On Mon, Jul 12, 2021 at 10:55:32AM +0100, Suzuki Kuruppassery Poulose wrote:
> 
> [...]
> 
>>>    static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>>>    {
>>> +	struct etr_flat_buf *flat_buf = etr_buf->private;
>>> +	struct device *real_dev = flat_buf->dev->parent;
>>> +
>>>    	/*
>>>    	 * Adjust the buffer to point to the beginning of the trace data
>>>    	 * and update the available trace data.
>>> @@ -648,6 +668,28 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>>>    		etr_buf->len = etr_buf->size;
>>>    	else
>>>    		etr_buf->len = rwp - rrp;
>>> +
>>> +	if (etr_buf->offset + etr_buf->len > etr_buf->size) {
>>> +		int len1, len2;
>>> +
>>> +		/*
>>> +		 * If trace data is wrapped around, sync AUX bounce buffer
>>> +		 * for two chunks: "len1" is for the trace date length at
>>> +		 * the tail of bounce buffer, and "len2" is the length from
>>> +		 * the start of the buffer after wrapping around.
>>> +		 */
>>> +		len1 = etr_buf->size - etr_buf->offset;
>>> +		len2 = etr_buf->len - len1;
>>> +		dma_sync_single_for_cpu(real_dev,
>>> +					flat_buf->daddr + etr_buf->offset,
>>> +					len1, DMA_FROM_DEVICE);
>>> +		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
>>> +					len2, DMA_FROM_DEVICE);
>>
>> We always start tracing at the beginning of the buffer and the only reason
>> why we would get a wrap around, is when the buffer is full.
>> So you could as well sync the entire buffer in one go
>>
>> 		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
>> 					etr_buf->len, DMA_FROM_DEVICE);
> 
> I am doubt why you conclude "always start tracing at the beginning of
> the buffer"?  I read the driver but cannot find any code in the driver
> to reset rrp and rwp after fetching the trace data, or there have any
> implict operation to reset pointers?

The ETR is always programmed with the base address of the "ETR" buffer,
which is *not the same* as the perf ring buffer, since we always do
double buffering. We do not program the RRP/RWP of the ETR (except
for the SoC-600, where it is mandatory and we set them to the base
address). Thus there is no context associated with the ETR buffer.
But at the end of the run, we do read the RRP/ RWP to figure out
where the ETR has reached.

As for reseting the RRP / RWP, at the beginning of a session, is
done implicitly for the ETR (except for SoC-600 ETRs as explained
above) by the hardware to the base address.

Suzuki
