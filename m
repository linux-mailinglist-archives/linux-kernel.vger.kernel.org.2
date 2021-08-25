Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0893F72C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhHYKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:15:11 -0400
Received: from foss.arm.com ([217.140.110.172]:47702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239525AbhHYKPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:15:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E060931B;
        Wed, 25 Aug 2021 03:14:23 -0700 (PDT)
Received: from [10.57.42.52] (unknown [10.57.42.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E12623F66F;
        Wed, 25 Aug 2021 03:14:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Support ETE decoding
To:     Leo Yan <leo.yan@linaro.org>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210824084720.GG204566@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <77fe6cd4-3e2e-aa60-9aa4-8fa03d08e640@arm.com>
Date:   Wed, 25 Aug 2021 11:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824084720.GG204566@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2021 09:47, Leo Yan wrote:
> Hi Mathieu, Suzuki, Mike,
> 
> On Fri, Aug 06, 2021 at 02:41:00PM +0100, James Clark wrote:
>> Changes since v1:
>>  * Re-implement with a new magic number instead of piggybacking on ETMv4
>>  * Improve comments and function name around cs_etm_decoder__get_etmv4_arch_ver()
>>  * Add a warning for unrecognised magic numbers
>>  * Split typo fix into new commit
>>  * Add Leo's reviewed-by tags
>>  * Create a new struct for ETE config (cs_ete_trace_params) instead of re-using ETMv4 config
>>
>> Applies to perf/core f3c33cbd922
>> Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-ete-v2
> 
> I have finished the review for this patch series and it's good form for
> me.  Since this patch series is to enable new feature for ETE, it's
> good if any of you could review as well before merging.
> 

Thanks for the reviews Leo!

> Thanks,
> Leo
> 
