Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAF3B3426
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhFXQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:48:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:48:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23092ED1;
        Thu, 24 Jun 2021 09:46:36 -0700 (PDT)
Received: from [10.57.13.86] (unknown [10.57.13.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88E03F719;
        Thu, 24 Jun 2021 09:46:33 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] perf cs-etm: Remove callback
 cs_etm_find_snapshot()
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-4-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <4aa2cfcc-0dc2-4884-2ae4-7e977d3c60ad@arm.com>
Date:   Thu, 24 Jun 2021 17:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528161552.654907-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/05/2021 17:15, Leo Yan wrote:
> The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
> main purpose is to find the correct AUX trace data and returns "head"
> and "old" (we can call "old" as "old head") to the caller, the caller
> __auxtrace_mmap__read() uses these two pointers to decide the AUX trace
> data size.
> > cs_etm_find_snapshot() should be removed with below reasons:
> 
> - The first thing in cs_etm_find_snapshot() is to check if the head has
>   wrapped around, if it is not, directly bails out.  The checking is
>   pointless, this is because the "head" and "old" pointers both are
>   monotonical increasing so they never wrap around.
> 
For patch 3:

Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>

I think it's a good simplification and it also fixes the duplicate buffers
issue. And I agree with the reasoning about the pointer increasing monotonically.

