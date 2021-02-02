Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13530CFA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhBBXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:07:27 -0500
Received: from foss.arm.com ([217.140.110.172]:59676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234260AbhBBXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:07:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DD231B;
        Tue,  2 Feb 2021 15:06:33 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793E63F694;
        Tue,  2 Feb 2021 15:06:29 -0800 (PST)
Subject: Re: [PATCH v2 2/7] coresight: etm-perf: Support PID tracing for
 kernel at EL2
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3c0a0641-a375-c7c3-d72d-e1d626e60ad6@arm.com>
Date:   Tue, 2 Feb 2021 23:06:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202163842.134734-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 4:38 PM, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
> So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
> Thus we should trace the VMID with VMIDOPT set to trace CONTEXTIDR_EL2
> instead of CONTEXTIDR_EL1.  Given that we have an existing config
> option "contextid" and this will be useful for tracing virtual machines
> (when we get to support virtualization).
> 
> So instead, this patch extends option CTXTID with an extra bit
> ETM_OPT_CTXTID2 (bit 15), thus on an EL2 kernel, we will have another
> bit available for the perf tool: ETM_OPT_CTXTID is for kernel running in
> EL1, ETM_OPT_CTXTID2 is used when kernel runs in EL2 with VHE enabled.
> 
> The tool must be backward compatible for users, i.e, "contextid" today
> traces PID and that should remain the same; for this purpose, the perf
> tool is updated to automatically set corresponding bit for the
> "contextid" config, therefore, the user doesn't have to bother which EL
> the kernel is running.
> 
>    i.e, perf record -e cs_etm/contextid/u --
> 
> will always do the "pid" tracing, independent of the kernel EL.
> 
> The driver parses the format "contextid", which traces CONTEXTIDR_EL1
> for ETM_OPT_CTXTID (on EL1 kernel) and traces CONTEXTIDR_EL2 for
> ETM_OPT_CTXTID2 (on EL2 kernel).
> 
> Besides the enhancement for format "contexid", extra two formats are
> introduced: "contextid1" and "contextid2".  This considers to support
> tracing both CONTEXTIDR_EL1 and CONTEXTIDR_EL2 when the kernel is
> running at EL2.  Finally, the PMU formats are defined as follow:
> 
>    "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
>                  kernel is running at EL1, "contextid1" enables the PID
> 		tracing; when the kernel is running at EL2, this enables
> 		tracing the PID of guest applications.
> 
>    "contextid2": Only usable when the kernel is running at EL2.  When
>                  selected, enables PID tracing on EL2 kernel.
> 
>    "contextid":  Will be an alias for the option that enables PID
>                  tracing.  I.e,
>                  contextid == contextid1, on EL1 kernel.
>                  contextid == contextid2, on EL2 kernel.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

You may add the following line here :

[ Added two config formats: contextid1, contextid2 ]

> Signed-off-by: Leo Yan <leo.yan@linaro.org>

The patch as such looks good to me.

Suzuki
