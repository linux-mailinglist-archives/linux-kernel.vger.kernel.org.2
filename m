Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8B344C75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhCVQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:58:10 -0400
Received: from foss.arm.com ([217.140.110.172]:35458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhCVQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:57:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505921063;
        Mon, 22 Mar 2021 09:57:47 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B123F719;
        Mon, 22 Mar 2021 09:57:46 -0700 (PDT)
Subject: Re: [PATCH v4 17/19] coresight: core: Add support for dedicated
 percpu sinks
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-18-suzuki.poulose@arm.com>
 <CAJ9a7VgWop-ifXgEoofGOJrKUWuSSK2VxD+6nchQiBxOOg3m3Q@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4fe2cce5-74b5-7ced-1a16-1dde90b920e2@arm.com>
Date:   Mon, 22 Mar 2021 16:57:45 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VgWop-ifXgEoofGOJrKUWuSSK2VxD+6nchQiBxOOg3m3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 08/03/2021 17:26, Mike Leach wrote:

> Hi,
> 
> On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
>> TRBE). To allow quicker access to the sink for a given CPU bound source,
>> keep a percpu array of the sink devices. Also, add support for building
>> a path to the CPU local sink from the ETM.
>>
>> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
>> This new sink type is exclusively available and can only work with percpu
>> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PROC.
>>
> 
> Minor nit:  FEAT_TRBE architecturally guarantees a compatible
> architectural FEAT_ETE source.
> However _all_ CPU sources have CORESIGHT_DEV_SUBTYPE_SOURCE_PROC set,
> ETMv3.x, PTM, ETM4.x and ETE alike.
> In the code that follows - coresight_is_percpu_source() checks it is
> any type of CPU source, not the FEAT_ETE type, which is fine as we
> then check the cpu and if it has TRBE.

Agreed. But we would like to keep this CoreSight generic code away from 
the specifics of underlying "source", which is why we used the generic 
notion of a per-CPU source.

> So the simplifications to the code from the first couple of patch sets
> make this explanation slightly misleading. Could do to adjust if
> re-spinning set.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>

Thanks
Suzuki

