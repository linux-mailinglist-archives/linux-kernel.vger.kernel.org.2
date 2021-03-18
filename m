Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004A2340F99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhCRVPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233149AbhCRVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616102081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icwCuj2M4SyK4w9YvvG8G3EGcPjLUbArXWUr95szJzE=;
        b=V0RoA1deh6jpGR4qI7uAfcpEPPJo4s6X5KzN52dmJYxZ0AkwXDL+KF6mRGIZ4ZX37mOAUz
        lXMd8KQlYfxI7MkaMBLU8P9/mVE32bxO6Q8E1Hx56HAFqYakjI+RvAAstTj6rTqboagQKQ
        uInJFazY88rv4J6mTtdHIBZoa4LXFDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-0s4PakATMwSujQUR_vPfBA-1; Thu, 18 Mar 2021 17:14:38 -0400
X-MC-Unique: 0s4PakATMwSujQUR_vPfBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 720FC101371C;
        Thu, 18 Mar 2021 21:14:37 +0000 (UTC)
Received: from krava (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1A955D72E;
        Thu, 18 Mar 2021 21:14:35 +0000 (UTC)
Date:   Thu, 18 Mar 2021 22:14:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Message-ID: <YFPCul51MjrlY65P@krava>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org>
 <7D48A756-C253-48DE-B536-826314778404@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D48A756-C253-48DE-B536-826314778404@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
> 
> 
> > On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
> >> Hi Song,
> >> 
> >> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
> >>> 
> >>> perf uses performance monitoring counters (PMCs) to monitor system
> >>> performance. The PMCs are limited hardware resources. For example,
> >>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >>> 
> >>> Modern data center systems use these PMCs in many different ways:
> >>> system level monitoring, (maybe nested) container level monitoring, per
> >>> process monitoring, profiling (in sample mode), etc. In some cases,
> >>> there are more active perf_events than available hardware PMCs. To allow
> >>> all perf_events to have a chance to run, it is necessary to do expensive
> >>> time multiplexing of events.
> >>> 
> >>> On the other hand, many monitoring tools count the common metrics (cycles,
> >>> instructions). It is a waste to have multiple tools create multiple
> >>> perf_events of "cycles" and occupy multiple PMCs.
> >> 
> >> Right, it'd be really helpful when the PMCs are frequently or mostly shared.
> >> But it'd also increase the overhead for uncontended cases as BPF programs
> >> need to run on every context switch.  Depending on the workload, it may
> >> cause a non-negligible performance impact.  So users should be aware of it.
> > 
> > Would be interesting to, humm, measure both cases to have a firm number
> > of the impact, how many instructions are added when sharing using
> > --bpf-counters?
> > 
> > I.e. compare the "expensive time multiplexing of events" with its
> > avoidance by using --bpf-counters.
> > 
> > Song, have you perfmormed such measurements?
> 
> I have got some measurements with perf-bench-sched-messaging:
> 
> The system: x86_64 with 23 cores (46 HT)
> 
> The perf-stat command:
> perf stat -e cycles,cycles,instructions,instructions,ref-cycles,ref-cycles <target, etc.>
> 
> The benchmark command and output:
> ./perf bench sched messaging -g 40 -l 50000 -t
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver threads per group
> # 40 groups == 1600 threads run
>      Total time: 10X.XXX [sec]
> 
> 
> I use the "Total time" as measurement, so smaller number is better. 
> 
> For each condition, I run the command 5 times, and took the median of 
> "Total time". 
> 
> Baseline (no perf-stat)			104.873 [sec]
> # global
> perf stat -a				107.887 [sec]
> perf stat -a --bpf-counters		106.071 [sec]
> # per task
> perf stat 				106.314 [sec]
> perf stat --bpf-counters 		105.965 [sec]
> # per cpu
> perf stat -C 1,3,5 			107.063 [sec]
> perf stat -C 1,3,5 --bpf-counters 	106.406 [sec]

I can't see why it's actualy faster than normal perf ;-)
would be worth to find out

jirka

> 
> From the data, --bpf-counters is slightly better than the regular event
> for all targets. I noticed that the results are not very stable. There 
> are a couple 108.xx runs in some of the conditions (w/ and w/o 
> --bpf-counters).
> 
> 
> I also measured the average runtime of the BPF programs, with 
> 
> 	sysctl kernel.bpf_stats_enabled=1
> 
> For each event, if we have one leader and two followers, the total run 
> time is about 340ns. IOW, 340ns for two perf-stat reading instructions, 
> 340ns for two perf-stat reading cycles, etc. 
> 
> Thanks,
> Song
> 

