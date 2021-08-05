Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6663E1539
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhHENAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:00:08 -0400
Received: from foss.arm.com ([217.140.110.172]:45002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238277AbhHENAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:00:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E5211042;
        Thu,  5 Aug 2021 05:59:53 -0700 (PDT)
Received: from [10.57.40.41] (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04AB73F719;
        Thu,  5 Aug 2021 05:59:50 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
 <20210802154145.GC148327@leoy-ThinkPad-X240s> <YQlDefz+g45dqFsP@kernel.org>
 <20210803140122.GC247709@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <b03f9794-ff84-c869-0370-e8f13c577ed5@arm.com>
Date:   Thu, 5 Aug 2021 13:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803140122.GC247709@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2021 15:01, Leo Yan wrote:
>> one can also use debuginfod-client, which, as time passes, probably will
>> be the main way of finding DSOs now that we have build-ids in
>> PERF_RECORD_MMAP2 and debuginfod servers such as:
>>
>> export DEBUGINFOD_URLS=https://debuginfod.fedoraproject.org/
> If so, maybe should use more general description for missing DSO.
> 
>> https://fedoraproject.org/wiki/Debuginfod
>>  
>>> With this improvement, the patch looks good to me:
>>>
>>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>> Does this apply to the other 5 patches in this series?
> I finished to reivew patches 01, 04, 05, 06/06, so my review tag can
> apply on these patches.  Current patch 06/06 needs James to improve for
> the comments.

Thanks for the reviews, I've submitted v2.

I also had a play around with debuginfod, it looks promising.
Especially if it's integrated with perf report, which I assume is the plan?

Thanks
James
