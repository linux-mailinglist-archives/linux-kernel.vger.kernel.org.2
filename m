Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745593189F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBKL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbhBKLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613043645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUoDjptBfW2j+T80yjumKevzhFB51qnZmG+ldDF5KQQ=;
        b=ibhHYvpILB6LeTcPw3dmVnXrdfk++X8cftMyToVlsjV0BhuilM1+cIDJKRpGhJDBxOBOrM
        uJW0wkApzkV2n69S8rkb07ndBdYnydlrqYlvVz5LNTFndLYyT6glVbZxI+mXx2kR2aG1S2
        KYd/j5DazWTBADZhAYWFo271SyiAvQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-jA-X_cteNgqQURcGYrtNkg-1; Thu, 11 Feb 2021 06:40:43 -0500
X-MC-Unique: jA-X_cteNgqQURcGYrtNkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 501C21936B60;
        Thu, 11 Feb 2021 11:40:41 +0000 (UTC)
Received: from krava (unknown [10.40.195.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71078100164C;
        Thu, 11 Feb 2021 11:40:38 +0000 (UTC)
Date:   Thu, 11 Feb 2021 12:40:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
Message-ID: <YCUXte/CMEQlCq4f@krava>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:24:57AM -0800, kan.liang@linux.intel.com wrote:

SNIP

> Jin Yao (24):
>   perf jevents: Support unit value "cpu_core" and "cpu_atom"
>   perf util: Save pmu name to struct perf_pmu_alias
>   perf pmu: Save detected hybrid pmus to a global pmu list
>   perf pmu: Add hybrid helper functions
>   perf list: Support --cputype option to list hybrid pmu events
>   perf stat: Hybrid evsel uses its own cpus
>   perf header: Support HYBRID_TOPOLOGY feature
>   perf header: Support hybrid CPU_PMU_CAPS
>   tools headers uapi: Update tools's copy of linux/perf_event.h
>   perf parse-events: Create two hybrid hardware events
>   perf parse-events: Create two hybrid cache events
>   perf parse-events: Support hardware events inside PMU
>   perf list: Display pmu prefix for partially supported hybrid cache
>     events
>   perf parse-events: Support hybrid raw events
>   perf stat: Support --cputype option for hybrid events
>   perf stat: Support metrics with hybrid events
>   perf evlist: Create two hybrid 'cycles' events by default
>   perf stat: Add default hybrid events
>   perf stat: Uniquify hybrid event name
>   perf stat: Merge event counts from all hybrid PMUs
>   perf stat: Filter out unmatched aggregation for hybrid event
>   perf evlist: Warn as events from different hybrid PMUs in a group
>   perf Documentation: Document intel-hybrid support
>   perf evsel: Adjust hybrid event and global event mixed group
> 
> Kan Liang (22):
>   perf/x86/intel: Hybrid PMU support for perf capabilities
>   perf/x86: Hybrid PMU support for intel_ctrl
>   perf/x86: Hybrid PMU support for counters
>   perf/x86: Hybrid PMU support for unconstrained
>   perf/x86: Hybrid PMU support for hardware cache event
>   perf/x86: Hybrid PMU support for event constraints
>   perf/x86: Hybrid PMU support for extra_regs
>   perf/x86/intel: Factor out intel_pmu_check_num_counters
>   perf/x86/intel: Factor out intel_pmu_check_event_constraints
>   perf/x86/intel: Factor out intel_pmu_check_extra_regs
>   perf/x86: Expose check_hw_exists
>   perf/x86: Remove temporary pmu assignment in event_init
>   perf/x86: Factor out x86_pmu_show_pmu_cap
>   perf/x86: Register hybrid PMUs
>   perf/x86: Add structures for the attributes of Hybrid PMUs
>   perf/x86/intel: Add attr_update for Hybrid PMUs
>   perf/x86: Support filter_match callback
>   perf/x86/intel: Add Alder Lake Hybrid support
>   perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
>   perf/x86/intel/uncore: Add Alder Lake support
>   perf/x86/msr: Add Alder Lake CPU support
>   perf/x86/cstate: Add Alder Lake CPU support
> 
> Ricardo Neri (2):
>   x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
>   x86/cpu: Describe hybrid CPUs in cpuinfo_x86
> 
> Zhang Rui (1):
>   perf/x86/rapl: Add support for Intel Alder Lake

hi,
would you have git branch with all this somewhere?

thanks,
jirka

