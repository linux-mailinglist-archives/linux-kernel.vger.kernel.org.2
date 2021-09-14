Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A540A65F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhINGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239359AbhINGBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:01:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B64E1FB;
        Mon, 13 Sep 2021 23:00:27 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CC63F5A1;
        Mon, 13 Sep 2021 23:00:25 -0700 (PDT)
Subject: Re: [PATCH v4] coresight: tmc-etr: Speed up for bounce buffer in flat
 mode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210905032144.966766-1-leo.yan@linaro.org>
 <20210913175635.GA1676953@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2a2ba78b-5a03-ccf3-00d8-b0e1b02dc293@arm.com>
Date:   Tue, 14 Sep 2021 07:00:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913175635.GA1676953@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2021 18:56, Mathieu Poirier wrote:
> On Sun, Sep 05, 2021 at 11:21:44AM +0800, Leo Yan wrote:
>> The AUX bounce buffer is allocated with API dma_alloc_coherent(), in the
>> low level's architecture code, e.g. for Arm64, it maps the memory with
>> the attribution "Normal non-cacheable"; this can be concluded from the
>> definition for pgprot_dmacoherent() in arch/arm64/include/asm/pgtable.h.
>>
>> Later when access the AUX bounce buffer, since the memory mapping is
>> non-cacheable, it's low efficiency due to every load instruction must
>> reach out DRAM.
>>
>> This patch changes to allocate pages with dma_alloc_noncoherent(), the
>> driver can access the memory via cacheable mapping; therefore, load
>> instructions can fetch data from cache lines rather than always read
>> data from DRAM, the driver can boost memory performance.  After using
>> the cacheable mapping, the driver uses dma_sync_single_for_cpu() to
>> invalidate cacheline prior to read bounce buffer so can avoid read stale
>> trace data.
>>
>> By measurement the duration for function tmc_update_etr_buffer() with
>> ftrace function_graph tracer, it shows the performance significant
>> improvement for copying 4MiB data from bounce buffer:
>>
>>    # echo tmc_etr_get_data_flat_buf > set_graph_notrace // avoid noise
>>    # echo tmc_update_etr_buffer > set_graph_function
>>    # echo function_graph > current_tracer
>>
>>    before:
>>
>>    # CPU  DURATION                  FUNCTION CALLS
>>    # |     |   |                     |   |   |   |
>>    2)               |    tmc_update_etr_buffer() {
>>    ...
>>    2) # 8148.320 us |    }
>>
>>    after:
>>
>>    # CPU  DURATION                  FUNCTION CALLS
>>    # |     |   |                     |   |   |   |
>>    2)               |  tmc_update_etr_buffer() {
>>    ...
>>    2) # 2525.420 us |  }
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>
>> Changes from v3:
>> Refined change to use dma_alloc_noncoherent()/dma_free_noncoherent()
>> (Robin Murphy);
>> Retested functionality and performance on Juno-r2 board.
>>
>> Changes from v2:
>> Sync the entire buffer in one go when the tracing is wrap around
>> (Suzuki);
>> Add Suzuki's review tage.
>>
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 26 ++++++++++++++++---
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index acdb59e0e661..a049b525a274 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -609,8 +609,9 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>>   	if (!flat_buf)
>>   		return -ENOMEM;
>>   
>> -	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
>> -					     &flat_buf->daddr, GFP_KERNEL);
>> +	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
>> +						&flat_buf->daddr,
>> +						DMA_FROM_DEVICE, GFP_KERNEL);
> 
> Suzuki and Robin - are you guys good with this new revision?

Yes, fine by me.

Suzuki
