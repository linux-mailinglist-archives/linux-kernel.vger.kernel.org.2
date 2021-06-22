Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B953B0763
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhFVOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:31:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhFVOby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:31:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DAE31B;
        Tue, 22 Jun 2021 07:29:38 -0700 (PDT)
Received: from [10.57.13.57] (unknown [10.57.13.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B1C3F694;
        Tue, 22 Jun 2021 07:29:36 -0700 (PDT)
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
Message-ID: <05442998-05f6-c41c-5a78-3f6723558825@arm.com>
Date:   Tue, 22 Jun 2021 15:29:35 +0100
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
> 
> cs_etm_find_snapshot() should be removed with below reasons:

Hi Leo,

I came across this other comment in coresight-tmc-etr.c that should probably
be fixed up if we remove cs_etm_find_snapshot(). The same is duplicated in a
few other files:

	/*
	 * In snapshot mode we simply increment the head by the number of byte
	 * that were written.  User space function  cs_etm_find_snapshot() will
	 * figure out how many bytes to get from the AUX buffer based on the
	 * position of the head.
	 */
	if (etr_perf->snapshot)
		handle->head += size;

I'm still reviewing patch 1 and 2 as well.

James

