Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D724397A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhFASse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:48:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhFASsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:48:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DC56D;
        Tue,  1 Jun 2021 11:46:51 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B59C3F774;
        Tue,  1 Jun 2021 11:46:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in
 dma_contiguous_reserve
To:     Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518112857.1198415-1-aisheng.dong@nxp.com>
 <CAA+hA=SSeRrnBRGeqVxJ71Cv0uxydidWoKmG6b0bYzoEdcgqOQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4a7922c0-7696-b4f7-f212-6710f4b2720d@arm.com>
Date:   Tue, 1 Jun 2021 19:46:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAA+hA=SSeRrnBRGeqVxJ71Cv0uxydidWoKmG6b0bYzoEdcgqOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-31 10:21, Dong Aisheng wrote:
> On Tue, May 18, 2021 at 7:29 PM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>>
>> dma_contiguous_reserve() aims to support cmdline case for CMA memory
>> reserve. But if users define reserved memory in DT,
>> 'dma_contiguous_default_area' will not be 0, then it's meaningless
>> to continue to run dma_contiguous_reserve(). So we return early
>> if detect 'dma_contiguous_default_area' is unzero.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Gently ping

The commit message is still wrong, and I still think the change doesn't 
achieve anything meaningful. This code is hard to make sense of either 
way because the crucial interplay between size_cmdline and 
dma_contiguous_default_area is hidden somewhere else entirely, and it 
would take a much more significant refactoring to clear that up.

Robin.

> 
> Regards
> Aisheng
> 
>> ---
>>   kernel/dma/contiguous.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 3d63d91cba5c..ebade9f43eff 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>>          phys_addr_t selected_limit = limit;
>>          bool fixed = false;
>>
>> +       if (dma_contiguous_default_area)
>> +               return;
>> +
>>          pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>>
>>          if (size_cmdline != -1) {
>> @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>>   #endif
>>          }
>>
>> -       if (selected_size && !dma_contiguous_default_area) {
>> +       if (selected_size) {
>>                  pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>>                           (unsigned long)selected_size / SZ_1M);
>>
>> --
>> 2.25.1
>>
