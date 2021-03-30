Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFA34EC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhC3PbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhC3Pan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D125F619AB;
        Tue, 30 Mar 2021 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118243;
        bh=T6HRF4MkN1JTbhxzKjNpUF0eJ6YQtW5OY/mJQ6Hzggk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aT2+FlGS4DuweSJh1LWKX/MUyeNmqYPP2kBRyQLhJhsPW8G9N8oZXqZZQ9XFM7RUN
         TdyTmMqBmeWebPP8h4rf+DALR21UR/yYWdzGhHTFANOqOSfD5Wx0hZOOEOndMp/HWU
         JC1PtkEH1xH/RDPALGDmsWib68La5wQY/66BSwJQYeLFfa70+mVetLDl/cI6bLZ6DD
         6NP5gjFvRLWaqqf7lGnGKB9MobOzR7Jr08SsNesjZ3C7RzOrynS3yuNMzxF+qZhn1c
         qh7lxEWiggOMUt5cUtaaJg29q8gAVGcg56foCgO4UIVA7WRgsuzRn2/Nd+XTDJxyVR
         gkmxmHqnL1f7g==
Date:   Tue, 30 Mar 2021 16:30:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] arm64: pmu: Add function implementation to
 update event index in userpage
Message-ID: <20210330153036.GA6567@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311000837.3630499-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:08:28PM -0700, Rob Herring wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> In order to be able to access the counter directly for userspace,
> we need to provide the index of the counter using the userpage.
> We thus need to override the event_idx function to retrieve and
> convert the perf_event index to armv8 hardware index.
> 
> Since the arm_pmu driver can be used by any implementation, even
> if not armv8, two components play a role into making sure the
> behaviour is correct and consistent with the PMU capabilities:
> 
> * the ARMPMU_EL0_RD_CNTR flag which denotes the capability to access
> counter from userspace.
> * the event_idx call back, which is implemented and initialized by
> the PMU implementation: if no callback is provided, the default
> behaviour applies, returning 0 as index value.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/perf_event.c | 18 ++++++++++++++++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  2 files changed, 20 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
