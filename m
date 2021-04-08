Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFC3582DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDHMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhDHMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617883609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1ksmh0ZYVbZk0BfBh8hLJNAW3D6nuEpsDYgFrymK3Q=;
        b=bk6hZZ23ZiEj67TIBS3qZsotCSPpMzFbrnP3zRnqukHfwF2pHsP63m8rmTXXyQnkLguE47
        B02AkvmbxbaZk2YGCbQxWvn5gIflXnfJPkgyiC/HB+C/3a4L8qp1rkPo91dcdVkIwL8epI
        1kNSpUZkRlDkJggqJV44ELolOtjeFrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-4oluOfOBN_qKqg-bGXcWMQ-1; Thu, 08 Apr 2021 08:06:45 -0400
X-MC-Unique: 4oluOfOBN_qKqg-bGXcWMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A82189C441;
        Thu,  8 Apr 2021 12:06:42 +0000 (UTC)
Received: from krava (unknown [10.40.195.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48DF560636;
        Thu,  8 Apr 2021 12:06:38 +0000 (UTC)
Date:   Thu, 8 Apr 2021 14:06:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, linuxarm@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, pc@us.ibm.com
Subject: Re: [PATCH v3 0/6] perf arm64 metricgroup support
Message-ID: <YG7xzXjFzIr9lQlz@krava>
References: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:32:44PM +0800, John Garry wrote:
> This series contains support to get basic metricgroups working for
> arm64 CPUs.
> 
> Initial support is added for HiSilicon hip08 platform.
> 
> Some sample usage on Huawei D06 board:
> 
>  $ ./perf list metric    
> 
> List of pre-defined events (to be used in -e): 
> 
> Metrics:     
> 
>   bp_misp_flush
>        [BP misp flush L3 topdown metric]
>   branch_mispredicts
>        [Branch mispredicts L2 topdown metric]
>   core_bound
>        [Core bound L2 topdown metric]
>   divider
>        [Divider L3 topdown metric]
>   exe_ports_util
>        [EXE ports util L3 topdown metric]
>   fetch_bandwidth_bound
>        [Fetch bandwidth bound L2 topdown metric]
>   fetch_latency_bound
>        [Fetch latency bound L2 topdown metric]
>   fsu_stall
>        [FSU stall L3 topdown metric]
>   idle_by_icache_miss
> 
> $ sudo ./perf stat -v -M core_bound sleep 1
> Using CPUID 0x00000000480fd010
> metric expr (exe_stall_cycle - (mem_stall_anyload + armv8_pmuv3_0@event\=0x7005@)) / cpu_cycles for core_bound
> found event cpu_cycles
> found event armv8_pmuv3_0/event=0x7005/
> found event exe_stall_cycle
> found event mem_stall_anyload
> adding {cpu_cycles -> armv8_pmuv3_0/event=0x7001/
> mem_stall_anyload -> armv8_pmuv3_0/event=0x7004/
> Control descriptor is not initialized
> cpu_cycles: 989433 385050 385050
> armv8_pmuv3_0/event=0x7005/: 19207 385050 385050
> exe_stall_cycle: 900825 385050 385050
> mem_stall_anyload: 253516 385050 385050
> 
> Performance counter stats for 'sleep':
> 
> 989,433      cpu_cycles      #     0.63 core_bound
>   19,207      armv8_pmuv3_0/event=0x7005/
>  900,825      exe_stall_cycle
>  253,516      mem_stall_anyload
> 
>        0.000805809 seconds time elapsed
> 
>        0.000875000 seconds user
>        0.000000000 seconds sys
>        
> perf stat --topdown is not supported, as this requires the CPU PMU to
> expose (alias) events for the TopDown L1 metrics from sysfs, which arm 
> does not do. To get that to work, we probably need to make perf use the
> pmu-events cpumap to learn about those alias events.
> 
> Metric reuse support is added for pmu-events parse metric testcase.
> This had been broken on power9 recently:
> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/ 
> 
> Differences to v2:
> - Add TB and RB tags (Thanks!)
> - Rename metricgroup__find_metric() from metricgroup_find_metric()
> - Change resolve_metric_simple() to rescan after any insert

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

