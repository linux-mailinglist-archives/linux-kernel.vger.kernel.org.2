Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519CF33A190
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhCMWGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234385AbhCMWGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615673172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iseltM4LgjyIVgTiWfZZkXhoKEkeLJmibBx74YIpNhQ=;
        b=NSh1PK1aeov5/zVSgf1KikZd80RxyAqbW1U/LoIgO0FrZVdcWsCa6U7uEaBbT2dDcl1lUy
        /Rz3FS1OxeXpaLwSV/FeU9Sohrz4wkPZ1CmXU5DFT0SRfZYxyqD1ko2WTPhfoe/YmTKzmN
        7jeuzbswVxIFCfytCGtpRxe9IWCt2J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-FbnAbQokORC1jNEJI87OEA-1; Sat, 13 Mar 2021 17:06:09 -0500
X-MC-Unique: FbnAbQokORC1jNEJI87OEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05CDF91178;
        Sat, 13 Mar 2021 22:06:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7819810016FB;
        Sat, 13 Mar 2021 22:06:06 +0000 (UTC)
Date:   Sat, 13 Mar 2021 23:06:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YE03TdSyQz5jXaNA@krava>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEtawFnompBDKpK0@krava>
 <45BCAC33-1626-42D1-A170-92DC8D7BAAF8@fb.com>
 <B7934C3F-4414-45AA-BE39-8FE3C64B7E7D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7934C3F-4414-45AA-BE39-8FE3C64B7E7D@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 04:09:53PM +0000, Song Liu wrote:
> 
> 
> > On Mar 12, 2021, at 7:45 AM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > 
> > 
> >> On Mar 12, 2021, at 4:12 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >> 
> >> On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
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
> >>> 
> >>> bperf tries to reduce such wastes by allowing multiple perf_events of
> >>> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> >>> of having each perf-stat session to read its own perf_events, bperf uses
> >>> BPF programs to read the perf_events and aggregate readings to BPF maps.
> >>> Then, the perf-stat session(s) reads the values from these BPF maps.
> >>> 
> >>> Please refer to the comment before the definition of bperf_ops for the
> >>> description of bperf architecture.
> >>> 
> >>> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> >>> bperf uses a BPF hashmap to share information about BPF programs and maps
> >>> used by bperf. This map is pinned to bpffs. The default address is
> >>> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> >>> --attr-map.
> >> 
> >> nice, I recall the presentation about that and was wondering
> >> when this will come up ;-)
> > 
> > The progress is slower than I expected. But I finished some dependencies of 
> > this in the last year: 
> > 
> >  1. BPF_PROG_TEST_RUN for raw_tp event;
> >  2. perf-stat -b, which introduced skeleton and bpf_counter;
> >  3. BPF task local storage, I didn't use it in this version, but it could,
> >     help optimize bperf in the future. 
> > 
> >> 
> >>> 
> >>> ---
> >>> Known limitations:
> >>> 1. Do not support per cgroup events;
> >>> 2. Do not support monitoring of BPF program (perf-stat -b);
> >>> 3. Do not support event groups.
> >>> 
> >>> The following commands have been tested:
> >>> 
> >>>  perf stat --use-bpf -e cycles -a
> >>>  perf stat --use-bpf -e cycles -C 1,3,4
> >>>  perf stat --use-bpf -e cycles -p 123
> >>>  perf stat --use-bpf -e cycles -t 100,101
> >> 
> >> I assume the output is same as standard perf?
> 
> Btw, please give it a try. :) 
> 
> It worked pretty well in my tests. If it doesn't work for some combination 
> of options, please let me know. 

heya, can't compile

  CLANG    /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
util/bpf_skel/bperf_follower.bpf.c:8:10: fatal error: 'bperf_u.h' file not found
#include "bperf_u.h"
         ^~~~~~~~~~~

jirka

