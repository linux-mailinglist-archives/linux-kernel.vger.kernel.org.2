Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B5328050
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhCAOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:09:03 -0500
Received: from foss.arm.com ([217.140.110.172]:58562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236211AbhCAOGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:06:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B32381042;
        Mon,  1 Mar 2021 06:05:27 -0800 (PST)
Received: from [10.57.52.215] (unknown [10.57.52.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD1763F70D;
        Mon,  1 Mar 2021 06:05:24 -0800 (PST)
Subject: Re: [PATCH 0/7] Split Coresight decode by aux records
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210224161319.GA3495326@xps15>
From:   James Clark <james.clark@arm.com>
Message-ID: <c188d25f-971b-b643-320a-925ba1672cdb@arm.com>
Date:   Mon, 1 Mar 2021 16:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210224161319.GA3495326@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/02/2021 18:13, Mathieu Poirier wrote:
> Good day James,
> 
> I have received your patchset and added it to my queue.  On the flip side it
> will be 3 to 4 weeks (from today) before I get a chance to look at it.  As such
> I suggest you don't wait on me before addressing the issues found by Leo.
> 

Ok, thanks Mathieu. I found that it's only working in --per-thread mode by
coincidence of my input file. So I would suggest to not look too thoroughly
until I have submitted v2. It should also probably still be an RFC rather than PATCH.

Thanks
James

> Thanks,
> Mathieu
> 
> On Fri, Feb 12, 2021 at 04:45:06PM +0200, James Clark wrote:
>> Hi All,
>>
>> Since my previous RFC, I've fixed --per-thread mode and solved
>> most of the open questions. I've also changed --dump-raw-trace
>> to use the same code path so it's also working now.
>>
>> I think the only open questions are:
>>   * General approach
>>   * If aux records need to be saved, or if they can be pulled
>>     from elsewhere.
>>
>> I've also tested perf inject which is now working with troublesome
>> files.
>>
>> Thanks
>> James
>>
>> James Clark (7):
>>   perf cs-etm: Split up etm queue setup function
>>   perf cs-etm: Only search timestamp in current sample's queue.
>>   perf cs-etm: Save aux records in each etm queue
>>   perf cs-etm: don't process queues until cs_etm__flush_events
>>   perf cs-etm: split decode by aux records.
>>   perf cs-etm: Use existing decode code path for --dump-raw-trace
>>   perf cs-etm: Suppress printing when resetting decoder
>>
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  10 +-
>>  tools/perf/util/cs-etm.c                      | 300 ++++++++++--------
>>  2 files changed, 168 insertions(+), 142 deletions(-)
>>
>> -- 
>> 2.28.0
>>
